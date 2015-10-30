using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SAMsUNFWebApplication.Models;
using MySql.Data.MySqlClient;
using System.Configuration;
using SAMsUNFWebApplication.Models.DataAccess;

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

    }
}