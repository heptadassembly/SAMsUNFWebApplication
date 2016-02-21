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
using Dapper;

namespace SAMsUNFWebApplication.Controllers.Grade
{
    public class GradeController : Controller
    {
        // GET: Student
        public async System.Threading.Tasks.Task<ActionResult> Grade()
        {
            Session["Grades"] = null;
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                await connection.OpenAsync();
                var result = await new GradeRepository(connection).GetGrades();
                Session["Grades"] = result;
                return View(result);
            }
        }
    }
}