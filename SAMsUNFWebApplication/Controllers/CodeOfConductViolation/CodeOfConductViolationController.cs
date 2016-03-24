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
    public class CodeOfConductViolationController : Controller
    {
        // GET: CodeOfConductViolation
        public async System.Threading.Tasks.Task<ActionResult> CodeOfConductViolation()
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                await connection.OpenAsync();
                var result = await new CodeOfConductViolationRepository(connection).GetCodeOfConductViolations();
                return View(result);
            }
        }

        public System.Web.Mvc.RedirectResult CreateCodeOfConductViolation(string TxtId, string TxtCode, string TxtName)
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                var result = new CodeOfConductViolationRepository(connection).CreateCodeOfConductViolation(TxtId, TxtCode, TxtName);

                if (result == "success")
                {
                    //ViewBag.SQLEror = "Code of Conduct Violation successfully created.";
                    return Redirect("CodeOfConductViolation/CodeOfConductViolation/?error=fileloaded");
                }
                else
                {
                    //do something else here.
                    //ViewBag.SQLError = "Code of Conduct Violation not inserted due to error.";
                    return Redirect("CodeOfConductViolation/CodeOfConductViolation/?error=invalidfile");
                }
            }
        }
    }
}