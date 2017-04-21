    using System;
    using System.Web.UI;
    using System.Data.SqlClient;
    using System.Configuration;
    using System.IO;
    using System.Data;
    using Ionic.Zip;
    using System.Drawing;
    using System.Collections.Generic;
    using System.Net.Mail;
    using AForge.Imaging;

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
                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["RegistrationConnectionString"].ConnectionString);

                conn.Open();
                SqlConnection conn1 = new SqlConnection(ConfigurationManager.ConnectionStrings["RegistrationConnectionString"].ConnectionString);
                
                string checkuser = "select count(*) from [Table] where First_Name ='" + NameBox.Text + "' ";
                //string checkuser1 = "select count(*) from [ResultsDatabase] where Full_Name ='" + NameBox.Text + "' ";


                SqlCommand com = new SqlCommand(checkuser, conn);
                //SqlCommand com1 = new SqlCommand(checkuser1, conn);

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
            string folder = Server.MapPath("~/Uploads/");
            string extractPath = Server.MapPath("~/VesselSegmentation/");

            int imageNumber = 1; // after each image is renamed, I need it to loop
            int loopcount = 0;



            string[] files123 = Directory.GetFiles(extractPath);
            foreach (string file in files123)
            {
                File.Delete(file);
            }

            try
            {

                //System.IO.Directory.Delete();
                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["RegistrationConnectionString"].ConnectionString);
                conn.Open();
                string insertQuery = "insert into [Table] (First_Name, Last_Name, Email_Address, Institution, ZipFileLocation, Dataset, FOV) values (@name, @Lastname, @email, @institution, @ziplocation, @Dataset, @FOV)";
                SqlCommand com = new SqlCommand(insertQuery, conn);

                com.Parameters.AddWithValue("@name", NameBox.Text);
                com.Parameters.AddWithValue("@Lastname", NameBox1.Text);
                com.Parameters.AddWithValue("@email", EmaiBox.Text);
                com.Parameters.AddWithValue("@institution", InstitutionBox.Text);
                com.Parameters.AddWithValue("@ziplocation", fileName);
                com.Parameters.AddWithValue("@Dataset", DropDownList2.SelectedItem.Text);
                com.Parameters.AddWithValue("@FOV", DropDownList2.SelectedItem.Value);

                com.ExecuteNonQuery();

                //conn.Close();
                //Response.Redirect("Default.aspx");
                //Response.Write("Upload Successful");

                if (FileUpload1.PostedFile != null && FileUpload1.PostedFile.ContentLength > 0)
                {
                    //string fileName = Path.GetFileName(FileUpload1.PostedFile.FileName); 
                    //string folder = Server.MapPath("~/files/");
                    Directory.CreateDirectory(folder);
                    FileUpload1.PostedFile.SaveAs(Path.Combine(folder, fileName));

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
            string Folderpath = Server.MapPath("~/VesselSegmentation/");
            string[] files = Directory.GetFiles(Folderpath);
            int p = 1;
            foreach (string file in files)
            {
                string path = file.Substring(0, file.LastIndexOf('\\'));
                File.Move(file, path + "\\image" + p + ".gif");
                p++;
            }
            int count = files.Length;
            //int imageNumber = 1; // after each image is renamed, I need it to loop
            //int loopcount = 0;

            float SensitivityAvg = 0;
            float SpecificityAvg = 0;
            float PrecisionAvg = 0;
            float AccuracyAvg = 0;
            float kappaAvg = 1;


            int maskused = int.Parse(DropDownList2.SelectedValue);

            while (loopcount <= files.Length - 1)
            {


                int TP1 = 0;
                int FP1 = 0;
                int TN1 = 0;
                int FN1 = 0;


                //if DRIVE use mask

                if (maskused == 1)
                {
                    string mainImagePath = Server.MapPath("~/VesselSegmentation/image" + imageNumber + ".gif");
                    Bitmap mainImage = AForge.Imaging.Image.FromFile(mainImagePath);
                    int pixelcount = mainImage.Height * mainImage.Width;

                    string GoldStandardPath = Server.MapPath("~/GoldStandard/Drive/test/1st_manual/image" + imageNumber + ".gif"); //I set this to image 2 as i need a different base image to analyse as the unzip im using is the test drive 
                    Bitmap GSImage = AForge.Imaging.Image.FromFile(GoldStandardPath);

                    string maskImagePath = Server.MapPath("~/GoldStandard/Drive/test/mask/" + imageNumber + "_test_mask.png");
                    Bitmap MaskImage = AForge.Imaging.Image.FromFile(maskImagePath);


                    for (int y = 0; y < mainImage.Height; y++)
                    {
                        for (int x = 0; x < mainImage.Width; x++)
                        {
                            Color gspixel = GSImage.GetPixel(x, y);
                            Color imagepixel = mainImage.GetPixel(x, y);
                            Color maskpixel = MaskImage.GetPixel(x, y);
                            Color White = Color.FromArgb(255, 255, 255);
                            Color Black = Color.FromArgb(0, 0, 0);
                            //if FOV == 1 do the calculations with mask
                            //    else
                            //    end
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
                }

                //if (maskused == 0)
                //{
                //    string mainImagePath = Server.MapPath("~/VesselSegmentation/image" + imageNumber + ".gif");
                //    Bitmap mainImage = AForge.Imaging.Image.FromFile(mainImagePath);
                //    int pixelcount = mainImage.Height * mainImage.Width;

                //    string GoldStandardPath = Server.MapPath("~/GoldStandard/Stare/test/1st_manual/image" + imageNumber + ".gif");
                //    Bitmap GSImage = AForge.Imaging.Image.FromFile(GoldStandardPath);

                //    for (int y = 0; y < mainImage.Height; y++)
                //    {
                //        for (int x = 0; x < mainImage.Width; x++)
                //        {
                //            Color gspixel = GSImage.GetPixel(x, y);
                //            Color imagepixel = mainImage.GetPixel(x, y);

                //            Color White = Color.FromArgb(255, 255, 255);
                //            Color Black = Color.FromArgb(0, 0, 0);
                            
                //            if (gspixel == White && imagepixel == White)
                //            {
                //                TP1++;
                //            }
                //            else if (gspixel == White && imagepixel == Black)
                //            {
                //                FN1++;
                //            }
                //            else if (gspixel == Black && imagepixel == White)
                //            {
                //                FP1++;
                //            }
                //            else if (gspixel == Black && imagepixel == Black)
                //            {
                //                TN1++;
                //            }
                //        }
                //    }
                //}

                ////    % TP : True Positive; Correct Foreground
                ////    % FP : False Positive; Incorrect Foreground
                ////    % TN : True Negative; Coreect Background
                ////    % FN : False Negative; Incorrect Background

                float noPxlGT = TN1 + FN1; //% = TP + FN

                ////    % Count pixels in the Segment map
                float noPxlSM = TP1 + FP1; //% = TP + FP

                float TP = TP1;     //TP = mask & Im & GS;
                float FN = FN1;     //FN = mask & ~Im & GS;
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
                float kappa = (Accuracy - randomAccuracy) / (1 - randomAccuracy);
                float DiceCoeff = (2 * noTP) / (2 * noTP + noFP + noFN);

                //    %Result = [Sensitivity Specificity Accuracy kappa];
                //var Results1 = [noPxlGT noPxlSM noTP noFP noTN noFN FPFN Sensitivity Specificity Precision JaccardCoefficient AndrewFailer Accuracy kappa TPRate FPRate, DiceCoeff];

                float[] Results = new float[] { noTP, noFP, noTN, noFN, FPFN, Sensitivity, Specificity, Precision, JaccardCoefficient, AndrewFailer, Accuracy, kappa, TPRate, FPRate, DiceCoeff };

                string[] ResultsString = new string[] { "noTP", "noFP", "noTN", "noFN", "FPFN", "Sensitivity", "Specificity", "Precision", "JaccardCoefficient", "AndrewFailer", "Accuracy", "Kappa", "TPRate", "FPRate", "DiceCoeff" };


                float[] Results0 = new float[] { Sensitivity, Specificity, Precision, Accuracy, kappa };

                string[] ResultsString0 = new string[] { "Sensitivity", "Specificity", "Precision", "Accuracy", "kappa" };

                SensitivityList.Add(Sensitivity);
                SpecificityList.Add(Specificity);
                PrecisionList.Add(Precision);
                AccuracyList.Add(Accuracy);
                kappaList.Add(kappa);
                ImageNumber.Add(imageNumber);

                loopcount++;

                imageNumber++;

                SensitivityAvg = +SensitivityAvg + Sensitivity;
                SpecificityAvg = +SpecificityAvg + Specificity;
                PrecisionAvg = +PrecisionAvg + Precision;
                AccuracyAvg = +AccuracyAvg + Accuracy;
                kappaAvg = +kappaAvg + kappa;

                float SensPercent = Sensitivity * 100;
                float SpecPercent = Specificity * 100;

            }

            float RowAdd = imageNumber;
            float MeanAvg = imageNumber; //used as divide by 20 for mean, as it starts on 0

            float SensitivityMean = 0;
            float SpecificityMean = 0;
            float PrecisionMean = 0;
            float AccuracyMean = 0;
            float kappaMean = 0;

            SensitivityMean = SensitivityAvg / MeanAvg;
            SpecificityMean = SpecificityAvg / MeanAvg;
            PrecisionMean = PrecisionAvg / MeanAvg;
            AccuracyMean = AccuracyAvg / MeanAvg;
            kappaMean = kappaAvg / MeanAvg;




            //foreach (var title in AccuracyList)
            //{
            //    Label11.Text += title + "<br />"; /*it just shows the last 'title' in 'titles', I want it to start at the first, and go to the next title every time the event occurs (frontPageToolStripMenuItem_Click)*/
            //}

            DataTable dt = new DataTable();
            //dt = (DataTable)Session["ss"];

            dt.Columns.Add("ImageNumber", typeof(int));
            dt.Columns.Add("Sensitivity", typeof(float));

            dt.Columns.Add("Specificity", typeof(float));
            dt.Columns.Add("Precision", typeof(float));
            dt.Columns.Add("Accuracy", typeof(float));
            dt.Columns.Add("kappa", typeof(float));

            ImageNumber.Add(imageNumber);
            SensitivityList.Add(SensitivityMean);
            SpecificityList.Add(SpecificityMean);
            PrecisionList.Add(PrecisionMean);
            AccuracyList.Add(AccuracyMean);
            kappaList.Add(kappaMean);

            for (int i = 0; i < SensitivityList.Count; i++)
            {
                dt.Rows.Add(ImageNumber[i], SensitivityList[i], SpecificityList[i], PrecisionList[i], AccuracyList[i], kappaList[i]);

            }
            int countsql = 1;




            ////dt.Rows.Add(0000 , SensitivityMean, SpecificityMean, PrecisionMean, AccuracyMean, kappaMean);
            //int rowcount = dt.Rows.Count - 1;
            //dt.Rows[rowcount][0] = DBNull.Value;
            //GridView1.DataSource = dt;
            //GridView1.DataBind();   
            int ImgNoTake1 = imageNumber - 1;

            //try
            //{

            //    SqlConnection conn1 = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            //    conn1.Open();
            //    string insertQueryResults = "insert into [ResultsDataBase] (Name, ImgNumber, Sensitivity, Specificity, Precision, Accuracy, kappa, Dataset) values (@name, @imgnum, @sens, @spec, @prec, @acc, @kapp, @Dataset)";
            //    SqlCommand com1 = new SqlCommand(insertQueryResults, conn1);
            //    com1.Parameters.AddWithValue("@name", NameBox.Text);
            //    com1.Parameters.AddWithValue("@imgnum", ImgNoTake1);
            //    com1.Parameters.AddWithValue("@sens", SensitivityMean);
            //    com1.Parameters.AddWithValue("@spec", SpecificityMean);
            //    com1.Parameters.AddWithValue("@prec", PrecisionMean);
            //    com1.Parameters.AddWithValue("@acc", AccuracyMean);
            //    com1.Parameters.AddWithValue("@kapp", kappaMean);
            //    com1.Parameters.AddWithValue("@Dataset", DropDownList2.SelectedItem.Value);
            //    com1.ExecuteNonQuery();


            //    conn1.Close();
            //}
            //catch (Exception ex)
            //{
            //    Response.Write("Error:" + ex.ToString());
            //}

            while (countsql < ImgNoTake1)
            {
                SqlConnection conn3 = new SqlConnection(ConfigurationManager.ConnectionStrings["RegistrationConnectionString"].ConnectionString);
                conn3.Open();
                string insertResults = "insert into [AllResults] (ImgNumber, Sensitivity, Specificity, Precision, Accuracy, kappa) values (@imgnum1, @sens1, @spec1, @prec1, @acc1, @kappa1)";
                SqlCommand com2 = new SqlCommand(insertResults, conn3);
                com2.Parameters.AddWithValue("@imgnum1", countsql);
                com2.Parameters.AddWithValue("@sens1", SensitivityList[countsql]);
                com2.Parameters.AddWithValue("@spec1", SpecificityList[countsql]);
                com2.Parameters.AddWithValue("@prec1", PrecisionList[countsql]);
                com2.Parameters.AddWithValue("@acc1", AccuracyList[countsql]);
                com2.Parameters.AddWithValue("@kappa1", kappaList[countsql]);
                com2.ExecuteNonQuery();
                conn3.Close();

                countsql++;

            }




          





            System.Threading.Thread.Sleep(1000);


            Response.Redirect("~/Results.aspx");

        }



    }
}