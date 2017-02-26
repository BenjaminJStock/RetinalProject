using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;


namespace WebApplication6
{
    public partial class _Default : Page
    {
        Int32 temp = 0;
        private string time;

        //= DateTime.Now.ToString("MM-dd-yyyy h:mmtt");
        //Int32 zipsize = 104857600;
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
            
        

            try
            {

                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
                conn.Open();
                string insertQuery = "insert into [Table] (Full_Name, Email_Address, Institution, ZipFileLocation) values (@name, @email, @institution, @ziplocation)";
                SqlCommand com = new SqlCommand(insertQuery, conn);
                com.Parameters.AddWithValue("@name", NameBox.Text);
                com.Parameters.AddWithValue("@email", EmaiBox.Text);
                com.Parameters.AddWithValue("@institution", InstitutionBox.Text);
                com.Parameters.AddWithValue("@ziplocation", fileName); //chjange this to path
                com.Parameters.AddWithValue("@TimeNDate", DateTime.Now.ToString("yyyyMMddHHmmss"));

                com.ExecuteNonQuery();
                //Response.Redirect("Default.aspx");
                //Response.Write("Upload Successful");


                
                if (FileUpload1.PostedFile != null && FileUpload1.PostedFile.ContentLength > 0)
                {

                    //TODO - Make Zip Only, add time and date to database when uploading.

                    //string fileName = Path.GetFileName(FileUpload1.PostedFile.FileName); 
                    //string folder = Server.MapPath("~/files/");
                    Directory.CreateDirectory(folder);
                    FileUpload1.PostedFile.SaveAs(Path.Combine(folder, fileName));
                    try
                    {
                        StatusLabel.Text = "Success,images saved";
                        Response.Write("Uploaded: " + fileName);
                    }
                    catch
                    {
                        StatusLabel.Text = "Operation Failed!!!";
                    }
                }



                //if (FileUpload1.HasFile)
                //{
                //    try
                //    {
                //        string filename = Path.GetFileName(FileUpload1.FileName);
                //        FileUpload1.SaveAs(Server.MapPath("~") + filename);
                //        StatusLabel.Text = "Upload status: File uploaded!";

                //    }
                //    catch (Exception ex)
                //    {
                //        StatusLabel.Text = "Upload status: The file could not be uploaded. The following error occured: " + ex.Message;
                //    }
                //}


                conn.Close();
            }
            catch (Exception ex)
            {
                Response.Write("Error:" + ex.ToString());
            }

            Response.Redirect("Default.aspx");
            Response.Write("Upload Successful");

            //if (FileUpload1.HasFile)
            //    {
            //        try
            //        {

            //            if (FileUpload1.PostedFile.ContentType == "application/octet-stream")
            //            {
            //                if (FileUpload1.PostedFile.ContentLength < 104857600) // change zip size int to have larger files.
            //                {
            //                    string filename = Path.GetFileName(FileUpload1.FileName);
            //                    //var filePath = Path.Combine(HttpContext.Current.Server.MapPath("~/App_Data/stored"), FileUpload1.FileName + ".zip");
            //                    FileUpload1.SaveAs(Server.MapPath("~/Uploads") + filename);
            //                    StatusLabel.Text = "Upload status: File uploaded!";
            //                }
            //                else
            //                    StatusLabel.Text = "Upload status: File has to be less than 100mb!";
            //           }
            //            else
            //                StatusLabel.Text = "Only ZipFiles accepted!";
            //        }
            //        catch(Exception ex)
            //        {
            //            StatusLabel.Text = "Upload status: The file could not be uploaded. The following error occured: " + ex.Message;
            //        }



            //   }

        }

        
    }
}
