﻿using MySql.Data.MySqlClient;
using SAMsUNFWebApplication.Models;
using SAMsUNFWebApplication.Models.DataAccess;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SAMsUNFWebApplication.Controllers.OfficeVisit
{
    [Authorize]
    public class OfficeVisitController : Controller
    {
        // GET: OfficeVisit
        public async System.Threading.Tasks.Task<ActionResult> OfficeVisit()
        {
            ViewBag.SuccessAdd = (Session["SuccessAdd"] == null)?false:true;

            if (ViewBag.SuccessAdd)
            {
                ModelState.AddModelError(string.Empty, "Office Visit has been successully been updated.");
                Session["SuccessAdd"] = null;
            }
            Session["OfficeVisits"] = null;
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                await connection.OpenAsync();
                var result = await new OfficeVisitRepository(connection).GetALLOfficeVisits();
                Session["OfficeVisits"] = result;
                return View(result);
            }
        }

        public void ExportToExcel()
        {

         
            //Genarate the excel data
            Byte[] fileBytes = Utilities.OfficeVisitExcelGenerator.GenerateXLS((List<Models.OfficeVisit>)Session["OfficeVisits"]);

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
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + "\"OfficeVisits" + DateTime.Now.ToString("MMddyyyyhhmmss") + ".xlsx\"");
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

            //Write it back to the client for downloading
            Response.BinaryWrite(fileBytes);
            Response.End();
        }


        public  ActionResult AddOfficeVisit()
        {

            return View("AddOfficeVisit");
            
        }

        public ActionResult EditOfficeVisit()
        {

            return View("EditOfficeVisit");

        }
    }
    

}