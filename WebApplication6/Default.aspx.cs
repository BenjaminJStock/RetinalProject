using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Data;
using Ionic.Zip;
using System.Drawing;
using System.Drawing.Imaging;
using System.Runtime.InteropServices;
using AForge;
using AForge.Imaging;
using AForge.Math;



//TODO - add time and date to database when uploading.

//TODO - requires dot net zip to run.

namespace WebApplication6
{
    public partial class _Default : Page
    {
        Int32 temp = 0;
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


            //Image Algorithm

            System.Threading.Thread.Sleep(10000); //wait 25 seconds for images to be uploaded so that the algorithm can find the correct files and start working on it.
                                                  //read GS
                                                  //read Im
                                                  //read mask


            //Deletes the _manual1 prefix, files are left with 01,02,03 - Easy for looping
            //DirectoryInfo d = new DirectoryInfo(Server.MapPath("~/UnZipFiles/1st_manual"));
            //FileInfo[] infos = d.GetFiles();
            //foreach (FileInfo f in infos)
            //{
            //    File.Move(f.FullName, f.FullName.ToString().Replace("_manual1", ""));
            //}

            string Folderpath = Server.MapPath("~/UnZipFiles/");
            string[] files = Directory.GetFiles(Folderpath);
            int i = 0;
            foreach (string file in files)
            {
                string path = file.Substring(0, file.LastIndexOf('\\'));
                File.Move(file, path + "\\image" + i + ".gif");
                i++;
            }



            
            int imageNumber = 0; // after each image is renamed, I need it to loop

            string mainImagePath = Server.MapPath("~/UnZipFiles/image" + imageNumber + ".gif");
            Bitmap mainImage = AForge.Imaging.Image.FromFile(mainImagePath);

            string maskImagePath = Server.MapPath("~/Masks/01_test_mask.gif");
            Bitmap MaskImage = AForge.Imaging.Image.FromFile(maskImagePath);


            string GoldStandardPath = Server.MapPath("~/GoldStandard/1st_manualGS/01_manual1.gif"); //I set this to image 2 as i need a different base image to analyse as the unzip im using is the test drive
            Bitmap GSImage = AForge.Imaging.Image.FromFile(GoldStandardPath);

            //gather statistics 
            ImageStatistics statIM = new ImageStatistics(mainImage);
            ImageStatistics statmask = new ImageStatistics(MaskImage);
            ImageStatistics statGS = new ImageStatistics(GSImage);

            float IM = statIM.PixelsCount;
            float UserImagePixelWhite = statIM.PixelsCountWithoutBlack;
            float UserImageAllPixels = statIM.PixelsCount;

            float Mask = statmask.PixelsCount;
            float MaskPixelWhite = statmask.PixelsCountWithoutBlack;
            float MaskAllPixels = statmask.PixelsCount;

            float GS = statGS.PixelsCount;
            float GSWhiteOnly = statGS.PixelsCountWithoutBlack;
            float GSAllPixels = statGS.PixelsCount;

            //    % TP : True Positive; Correct Foreground
            //    % FP : False Positive; Incorrect Foreground
            //    % TN : True Negative; Coreect Background
            //    % FN : False Negative; Incorrect Background

            float noPxlGT = GSWhiteOnly; //% = TP + FN

            float notIM = UserImageAllPixels - UserImagePixelWhite; //Leaves with black pixels of image
            float notGS = GSAllPixels - GSWhiteOnly; //Leaves with black pixels of image

            //    % Count pixels in the Segment map
            float noPxlSM = UserImagePixelWhite; //% = TP + FP

            float TP = MaskPixelWhite + UserImagePixelWhite + GSWhiteOnly; //TP = mask & Im & GS;
            float FN = MaskPixelWhite + notIM +GSWhiteOnly;                //FN = mask & ~Im & GS;
            float TN = MaskPixelWhite + notIM + notGS;                     //TN = mask & ~Im & ~GS;                                    
            float FP = MaskPixelWhite + UserImagePixelWhite;               //FP = mask & Im & ~GS;

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


            float[] Results = new float[] { GSWhiteOnly, UserImagePixelWhite, noTP, noFP, noTN, noFN, FPFN, Sensitivity, Specificity, Precision, JaccardCoefficient, AndrewFailer, Accuracy, TPRate, FPRate, DiceCoeff };

            string[] ResultsString = new string[] { "GSWhiteOnly", "UserImagePixelWhite", "noTP", "noFP", "noTN", "noFN", "FPFN", "Sensitivity", "Specificity", "Precision", "JaccardCoefficient", "AndrewFailer", "Accuracy", "TPRate", "FPRate", "DiceCoeff" };


            float[] Results0 = new float[] { Sensitivity, Specificity, Precision, Accuracy, kappa };

            string[] ResultsString0 = new string[] { "Sensitivity", "Specificity", "Precision", "Accuracy", "kappa" };



            ResultsLabel.Text = string.Join(", ", Results.Cast<float>());

            LabelResults.Text = string.Join(", ", ResultsString.Cast<string>());

            ResultsLabel0.Text = string.Join(", ", Results0.Cast<float>());

            LabelResults0.Text = string.Join(", ", ResultsString0.Cast<string>());

            string ResultName = LabelResults0.Text;
            Session["ResultsName"] = ResultName;

            string ResultScore = ResultsLabel0.Text;
            Session["ResultsScore"] = ResultScore;


            //Making Sure the PixelCountWithoutBlack is Correct. IT IS!

            ///////////////////////////////////////////
            //int MaskTotal1 = Mask - MaskPixelWhite;
            //int ImageTotal1 = IM - UserImagePixelWhite;
            //int GSTotal1 = GS - GSWhiteOnly;

            //MaskTotal.Text = MaskTotal1.ToString();
            //ImageTotal.Text = ImageTotal1.ToString();
            //GSTotal.Text = GSTotal1.ToString();
            //////////////////////////////////////////



            //foreach (Result info in Results)
            //{
            //    var mycommand = new SqlCommand("INSERT INTO RSS2 VALUES(@Date, @Templow, @Temphigh)", myConnection);
            //    mycommand.Parameters.AddWithValue("@Date", info.Date);
            //    mycommand.Parameters.AddWithValue("@Templow", info.TempLow);
            //    mycommand.Parameters.AddWithValue("@Temphigh", info.TempHigh);
            //    mycommand.ExecuteNonQuery();
            //}


            System.Threading.Thread.Sleep(10000);

            Response.Redirect("UploadSucc.aspx");
        }
        
    }

}
