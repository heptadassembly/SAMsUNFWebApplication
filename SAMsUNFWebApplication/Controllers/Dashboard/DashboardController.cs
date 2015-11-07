using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SAMsUNFWebApplication.Models;
using MySql.Data.MySqlClient;
using System.Configuration;
using SAMsUNFWebApplication.Models.DataAccess;
using System.Net.Http;
using System.Net;
using System.Threading.Tasks;
using System.IO;
using System.Net.Http.Headers;
namespace SAMsUNFWebApplication.Utilities.Dashboard
{
    public class DashboardController : Controller
    {
        // GET: Dashboard
        public ActionResult Index()
        {
            return View();
        }


        public void ExportToExcel()
        {
           
           //Get the Session data  
           List<Student> students = (List<Student>)Session["Students"];
           
            //Genarate the excel data
           Byte[] fileBytes =  Utilities.ExcelGenerator.GenerateXLS(students);
           
            //Clear the response
            Response.Clear();
            Response.ClearContent();
            Response.ClearHeaders();
            Response.Cookies.Clear();

            //  Build a proper repsonse header so no warning occurs on download
            Response.Cache.SetCacheability(HttpCacheability.Private);
            Response.CacheControl = "private";
            Response.Charset = System.Text.UTF8Encoding.UTF8.WebName;
            Response.ContentEncoding = System.Text.UTF8Encoding.UTF8;
            Response.AppendHeader("Content-Length", fileBytes.Length.ToString());
            Response.AppendHeader("Pragma", "cache");
            Response.AppendHeader("Expires", "60");
            Response.AppendHeader("Content-Disposition", "attachment; filename=" +"\"Student" + DateTime.Now.ToString("MMddyyyyhhmmss") + ".xlsx\""); 
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

            //Write it back to the client for downloading
            Response.BinaryWrite(fileBytes);
            Response.End();           
        }
        public async System.Threading.Tasks.Task<ActionResult> Dashboard()
        {

            Session["Students"] = null;
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                await connection.OpenAsync();
                var result = await new StudentRepository(connection).GetStudents();
                Session["Students"] = result;         
                return View(result);
            }

        }
    }
}