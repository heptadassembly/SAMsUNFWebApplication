using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SAMsUNFWebApplication.Models;
using MySql.Data.MySqlClient;
using System.Configuration;
using SAMsUNFWebApplication.Models.DataAccess;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

namespace SAMsUNFWebApplication.Controllers.Dashboard
{
    public class DashboardController : Controller
    {
        // GET: Dashboard
        public ActionResult Index()
        {
            return View();
        }

       



        public ActionResult ExportToExcel(Student model)
        {
            GridView gv = new GridView();
            gv.DataSource = Session["Students"];
            gv.DataBind();

            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=test.xlsx");

            Response.ContentType = "application/vnd.ms-excel";

            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            gv.RenderControl(htw);

            byte[] byteArray = Encoding.ASCII.GetBytes(sw.ToString());

            MemoryStream s = new MemoryStream(byteArray);

            StreamReader sr = new StreamReader(s, Encoding.ASCII);



            Response.Write(sr.ReadToEnd());

            Response.End();
            return new JavaScriptResult();
        }

        public async System.Threading.Tasks.Task<ActionResult> Dashboard()
        {


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