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

namespace SAMsUNFWebApplication.Controllers.CodeOfConductViolation
{
    public class SchoolYearController : Controller
    {
        // GET: SchoolYear
        public async System.Threading.Tasks.Task<ActionResult> SchoolYear()
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                await connection.OpenAsync();
                var result = await new SchoolYearRepository(connection).GetSchoolYear();
                return View(result);
            }
        }

    }
}