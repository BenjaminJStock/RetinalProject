using System;
using System.Linq;
using System.Web.UI;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Data;
using Ionic.Zip;
using System.Drawing;
using System.Collections.Generic;
using System.ComponentModel;



//TODO - add time and date to database when uploading.

//TODO - requires dot net zip to run.

//TODO  - Change how ive set the algorithm up to work with the new loop

namespace WebApplication6
{
    public partial class _Default : Page
    {
        Int32 temp = 0;
        List<float> SensitivityList = new List<float>();
        List<float> SpecificityList = new List<float>();
        List<float> PrecisionList = new List<float>();
        List<float> AccuracyList = new List<float>();
        List<float> kappaList = new List<float>();
        List<int> ImageNumber = new List<int>();



        protected void Page_Load(object sender, EventArgs e)
        {


            if (IsPostBack)
            {
                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
                conn.Open();
                string checkuser = "select count(*) from [Table] where Full_Name ='" + NameBox.Text + "' ";
                SqlCommand com = new SqlCommand(checkuser, conn);
                temp = Convert.ToInt32(com.ExecuteScalar().ToString());
                if (temp == 1)
                {
                    Response.Write("Details Already Added.");
                }
                conn.Close();
            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            string fileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
            string folder = Server.MapPath("~/files/");
            string extractPath = Server.MapPath("~/UnZipFiles/");

            try
            {
                System.IO.Directory.Delete(extractPath, true);
                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
                conn.Open();
                string insertQuery = "insert into [Table] (Full_Name, Email_Address, Institution, ZipFileLocation) values (@name, @email, @institution, @ziplocation)";
                SqlCommand com = new SqlCommand(insertQuery, conn);
                com.Parameters.AddWithValue("@name", NameBox.Text);
                com.Parameters.AddWithValue("@email", EmaiBox.Text);
                com.Parameters.AddWithValue("@institution", InstitutionBox.Text);
                com.Parameters.AddWithValue("@ziplocation", fileName); //chjange this to path
                com.ExecuteNonQuery();
                //Response.Redirect("Default.aspx");
                //Response.Write("Upload Successful");

                if (FileUpload1.PostedFile != null && FileUpload1.PostedFile.ContentLength > 0)
                {
                    //string fileName = Path.GetFileName(FileUpload1.PostedFile.FileName); 
                    //string folder = Server.MapPath("~/files/");
                    Directory.CreateDirectory(folder);
                    FileUpload1.PostedFile.SaveAs(Path.Combine(folder, fileName));
                    try
                    {
                        StatusLabel.Text = "Success, images saved and analysis is running";
                        Response.Write("Uploaded: " + fileName);
                    }

                    catch
                    {
                        StatusLabel.Text = "Operation Failed!!!";
                    }
                    using (ZipFile zip = ZipFile.Read(FileUpload1.PostedFile.InputStream))
                    {
                        zip.ExtractAll(extractPath, ExtractExistingFileAction.DoNotOverwrite);
                    }
                }

                conn.Close();
            }
            catch (Exception ex)
            {
                Response.Write("Error:" + ex.ToString());
            }

            System.Threading.Thread.Sleep(10000); //wait 25 seconds for images to be uploaded so that the algorithm can find the correct files and start working on it.
                                                  //read GS
                                                  //read Im
                                                  //read mask


            string Folderpath = Server.MapPath("~/UnZipFiles/");
            string[] files = Directory.GetFiles(Folderpath);
            int p = 0;
            foreach (string file in files)
            {
                string path = file.Substring(0, file.LastIndexOf('\\'));
                File.Move(file, path + "\\image" + p + ".gif");
                p++;
            }
            int count = files.Length;



            int imageNumber = 0; // after each image is renamed, I need it to loop



            int loopcount = 0;




            while (loopcount <= 19)
            {

                string mainImagePath = Server.MapPath("~/UnZipFiles/image" + imageNumber + ".gif");
                Bitmap mainImage = AForge.Imaging.Image.FromFile(mainImagePath);

                string maskImagePath = Server.MapPath("~/Masks/01_test_mask.gif");
                Bitmap MaskImage = AForge.Imaging.Image.FromFile(maskImagePath);

                string GoldStandardPath = Server.MapPath("~/GoldStandard/1st_manualGS/image" + 0 + ".gif"); //I set this to image 2 as i need a different base image to analyse as the unzip im using is the test drive 
                Bitmap GSImage = AForge.Imaging.Image.FromFile(GoldStandardPath);


                int TP1 = 0;
                int FP1 = 0;
                int TN1 = 0;
                int FN1 = 0;

                int columnCount = mainImage.Height;
                int rowCount = mainImage.Width;

                int N = mainImage.Width - 1;
                int M = mainImage.Height - 1;

                heightlabel.Text = columnCount.ToString();
                widthlabel.Text = rowCount.ToString();




                for (int y = 0; y < mainImage.Height; y++)
                {
                    for (int x = 0; x < mainImage.Width; x++)
                    {
                        Color gspixel = GSImage.GetPixel(x, y);
                        Color imagepixel = mainImage.GetPixel(x, y);
                        Color White = Color.FromArgb(255, 255, 255);
                        Color Black = Color.FromArgb(0, 0, 0);

                        //var gsColor = gspixel.ToKnownColor();
                        // var imColor = imagepixel.ToKnownColor();

                        if (gspixel == White && imagepixel == White)
                        {
                            TP1++;
                        }
                        else if (gspixel == White && imagepixel == Black)
                        {
                            FN1++;
                        }
                        else if (gspixel == Black && imagepixel == White)
                        {
                            FP1++;
                        }
                        else if (gspixel == Black && imagepixel == Black)
                        {
                            TN1++;
                        }
                    }
                }






                LabelFN.Text = FN1.ToString();
                LabelTP.Text = TP1.ToString();
                LabelFP.Text = FP1.ToString();
                LabelTN.Text = TN1.ToString();




                ////    % TP : True Positive; Correct Foreground
                ////    % FP : False Positive; Incorrect Foreground
                ////    % TN : True Negative; Coreect Background
                ////    % FN : False Negative; Incorrect Background

                float noPxlGT = TN1 + FN1; //% = TP + FN

                ////    % Count pixels in the Segment map
                float noPxlSM = TP1 + FP1; //% = TP + FP

                float TP = TP1; //TP = mask & Im & GS;
                float FN = FN1;//FN = mask & ~Im & GS;
                float TN = TN1;                     //TN = mask & ~Im & ~GS;                                    
                float FP = FP1;               //FP = mask & Im & ~GS;

                float noTP = TP;              // noTP = sum(TP(:));    
                float noFP = FP;              // noFP = sum(FP(:) );
                float noTN = TN;              // noTN = sum(TN(:) );
                float noFN = FN;              // noFN = sum(FN(:) );

                float TPFP = noTP + noFP; //%positiveResponse(TP+FP)
                float TPFN = noTP + noFN; //%positiveReference(TP+FN)
                float FPTN = noFP + noTN; //% negativeReference(FP + TN)
                float FNTN = noFN + noTN; //% negativeResponse(FN + TN)
                float FPFN = noFP + noFN; //% Error(FP + FN)
                float TPTN = noTP + noTN; //% Correct(TP + TN)
                float Total = noTP + noTN + noFP + noFN;

                float Sensitivity = noTP / TPFN;
                float Specificity = noTN / FPTN;
                float Precision = noTP / TPFP;
                float JaccardCoefficient = noTP / (noTP + noFP + noFN);
                float AndrewFailer = noFP / TPFN;
                float Accuracy = TPTN / Total;
                float TPRate = noTP / TPFN;
                float FPRate = noFP / FPTN;

                float referenceLikelihood = TPFN / Total;
                float responseLikelihood = TPFP / Total;
                float randomAccuracy = referenceLikelihood * responseLikelihood + (1 - referenceLikelihood) * (1 - responseLikelihood);
                float kappa = (Accuracy - randomAccuracy) / (1 - randomAccuracy); //%(p - e) / (1 - e) 
                float DiceCoeff = (2 * noTP) / (2 * noTP + noFP + noFN);

                //    %Result = [Sensitivity Specificity Accuracy kappa];
                //var Results1 = [noPxlGT noPxlSM noTP noFP noTN noFN FPFN Sensitivity Specificity Precision JaccardCoefficient AndrewFailer Accuracy kappa TPRate FPRate, DiceCoeff];


                float[] Results = new float[] { noTP, noFP, noTN, noFN, FPFN, Sensitivity, Specificity, Precision, JaccardCoefficient, AndrewFailer, Accuracy, TPRate, FPRate, DiceCoeff };

                string[] ResultsString = new string[] { "noTP", "noFP", "noTN", "noFN", "FPFN", "Sensitivity", "Specificity", "Precision", "JaccardCoefficient", "AndrewFailer", "Accuracy", "TPRate", "FPRate", "DiceCoeff" };


                float[] Results0 = new float[] { Sensitivity, Specificity, Precision, Accuracy, kappa };

                string[] ResultsString0 = new string[] { "Sensitivity", "Specificity", "Precision", "Accuracy", "kappa" };



                ResultsLabel.Text = string.Join(", ", Results.Cast<float>());

                LabelResults.Text = string.Join(", ", ResultsString.Cast<string>());

                ResultsLabel0.Text = string.Join(", ", Results0.Cast<float>());

                LabelResults0.Text = string.Join(", ", ResultsString0.Cast<string>());

                //string ResultName = LabelResults0.Text;
                //Session["ResultsName"] = ResultName;

                //string ResultScore = ResultsLabel0.Text;
                //Session["ResultsScore"] = ResultScore;


               
                
                SensitivityList.Add(Sensitivity);
                SpecificityList.Add(Specificity);
                PrecisionList.Add(Precision);
                AccuracyList.Add(Accuracy);
                kappaList.Add(kappa);
                ImageNumber.Add(imageNumber);


                loopcount++;
                imageNumber++;
            }

            //foreach (var title in AccuracyList)
            //{
            //    Label11.Text += title + "<br />"; /*it just shows the last 'title' in 'titles', I want it to start at the first, and go to the next title every time the event occurs (frontPageToolStripMenuItem_Click)*/
            //}




            DataTable dt = new DataTable();
            dt.Columns.Add("ImageNumber", typeof(int));
            dt.Columns.Add("Sensitivity", typeof(float));
            dt.Columns.Add("Specificity", typeof(float));
            dt.Columns.Add("Precision", typeof(float));
            dt.Columns.Add("Accuracy", typeof(float));
            dt.Columns.Add("kappa", typeof(float));

            for (int i = 0; i < SensitivityList.Count; i++)
            {
                dt.Rows.Add(ImageNumber[i],SensitivityList[i], SpecificityList[i], PrecisionList[i], AccuracyList[i], kappaList[i]); 

            }

           

            GridView1.DataSource = dt;
            GridView1.DataBind();
            

            
           

            //System.Threading.Thread.Sleep(10000);

            //Response.Redirect("UploadSucc.aspx");
        }
    }
}


        
