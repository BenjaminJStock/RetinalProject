﻿using System;
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



//TODO - Make Zip Only, add time and date to database when uploading.
//TODO - Change IIS settings?
//TODO - requires dot net zip to run.

namespace WebApplication6
{
    public partial class _Default : Page
    {
        Int32 temp = 0;
        private int pixelsWithoutBlack;

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




            System.Threading.Thread.Sleep(25000); //wait 25 seconds for images to be uploaded so that the algorithm can find the correct files and start working on it.
                                                  //read GS
                                                  //read Im

            string mainImagePath = Server.MapPath("~/UnZipFiles/1st_manual/01_manual1.gif");
            Bitmap mainImage = AForge.Imaging.Image.FromFile(mainImagePath);

            string maskImagePath = Server.MapPath("~/UnZipFiles/mask/01_test_mask.gif");
            Bitmap MaskImage = AForge.Imaging.Image.FromFile(maskImagePath);

            //gather statistics 
            ImageStatistics statIM = new ImageStatistics(mainImage);
            ImageStatistics statmask = new ImageStatistics(MaskImage);

            int UserImagePixel = statIM.PixelsCount;
            int UserImagePixelWhite = statIM.PixelsCountWithoutBlack;


            int MaskPixel = statmask.PixelsCount;
            int MaskPixelWhite = statmask.PixelsCountWithoutBlack;

            
            IMPixel.Text = UserImagePixel.ToString();
            IMPixelWhite.Text = UserImagePixelWhite.ToString();

            MaskAll.Text = MaskPixel.ToString();
            MaskWhite.Text = MaskPixelWhite.ToString();

            int MaskTotal1 = MaskPixel - MaskPixelWhite;
            int ImageTotal1 = UserImagePixel - UserImagePixelWhite;

            MaskTotal.Text = MaskTotal1.ToString();
            ImageTotal.Text = ImageTotal1.ToString();
            

            






        //Response.Redirect("UploadSucc.aspx");


    }
    }
}