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
        Int32 zipsize = 104857600;
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

            try
            {

                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
                conn.Open();
                string insertQuery = "insert into [Table] (Full_Name, Email_Address, Institution, ZipFileLocation) values (@name, @email, @institution, @ziplocation)";
                SqlCommand com = new SqlCommand(insertQuery, conn);
                com.Parameters.AddWithValue("@name", NameBox.Text);
                com.Parameters.AddWithValue("@email", EmaiBox.Text);
                com.Parameters.AddWithValue("@institution", InstitutionBox.Text);
                com.Parameters.AddWithValue("@ziplocation", FileUpload1.PostedFile.ToString());

                com.ExecuteNonQuery();
                Response.Redirect("Default.aspx");
                Response.Write("Upload Successful");


                conn.Close();
            }
            catch (Exception ex)
            {
                Response.Write("Error:" + ex.ToString());
            }
        

        if (FileUpload1.HasFile)
            {
                try
                {

                    if (FileUpload1.PostedFile.ContentType == "application/x-zip-compressed")
                    {
                        if (FileUpload1.PostedFile.ContentLength < zipsize) // change zip size int to have larger files.
                        {
                            string filename = Path.GetFileName(FileUpload1.FileName);
                            FileUpload1.SaveAs(Server.MapPath("UploadedFiles") + filename);
                            StatusLabel.Text = "Upload status: File uploaded!";
                        }
                        else
                            StatusLabel.Text = "Upload status: File has to be less than 100mb!";
                    }
                    else
                        StatusLabel.Text = "Only ZipFiles accepted!";
                }
                catch(Exception ex)
                {
                    StatusLabel.Text = "Upload status: The file could not be uploaded. The following error occured: " + ex.Message;
                }



            }

        }
    }
}
