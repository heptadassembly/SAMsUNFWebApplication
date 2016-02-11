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
            
            Byte[] fileBytes =  Utilities.DashboardExcelGenerator.GenerateXLS((DashboardCollection)Session["Dashboard"]);
           
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
            Response.AppendHeader("Content-Disposition", "attachment; filename=" +"\"dashboard" + DateTime.Now.ToString("MMddyyyyhhmmss") + ".xlsx\""); 
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

            //Write it back to the client for downloading
            Response.BinaryWrite(fileBytes);
            Response.End();           
        }
        public async System.Threading.Tasks.Task<ActionResult> Dashboard()
        {
            DashboardCollection coll = new DashboardCollection();

            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                await connection.OpenAsync();
                
                var result = new OfficeVisitRepository(connection).GetOfficeVisitsByHomeroom();
                var result2 = new OfficeVisitRepository(connection).GetOfficeVisitsByOffenseType();
                var result3 = new OfficeVisitRepository(connection).GetOfficeVisitsByTeacher();
                var result4 = new OfficeVisitRepository(connection).GetOfficeVisitsCountByWeek();

                coll.Homerooms = (IEnumerable<OfficeVisitsByHomeroom>)result.Result.ToArray();
                coll.OffenseTypes = (IEnumerable<OfficeVisitsByOffenseType>)result2.Result.ToArray();
                coll.Teachers = (IEnumerable<OfficeVisitsByTeacher>)result3.Result.ToArray();
                coll.ByWeek = (IEnumerable<OfficeVisitsCountsByWeek>)result4.Result.ToArray();
                Session["Dashboard"] = coll;

                return View(coll);
            }
        }


        public ActionResult addOfficeVisit()
        {
            return View();
        }
    }
}