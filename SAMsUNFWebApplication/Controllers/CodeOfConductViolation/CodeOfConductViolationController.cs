﻿using System;
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
                    return Redirect("CodeOfConductViolation/CodeOfConductViolation");
                }
                else
                {
                    //do something else here.
                    return Redirect("CodeOfConductViolation/CodeOfConductViolation");
                }
            }
        }



    }
}