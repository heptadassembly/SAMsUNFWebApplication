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
using CsvHelper;

namespace SAMsUNFWebApplication.Controllers.Contact
{
    public class ImportController : Controller
    {
        // GET: Contact
        public ActionResult Import()
        {
            return View();
        }

        [HttpGet]
        public ActionResult ImportContacts()
        {
            return View();
        }

        [HttpPost]
        public ActionResult ImportContacts(HttpPostedFileBase file)
        {
            string path = null;
            string url = null;
            List<CSVContacts> ContactsToDisplay = new List<CSVContacts>();

            try
            {
                if (file.ContentLength > 0)
                {
                    var fileName = Path.GetFileName(file.FileName);
                    path = AppDomain.CurrentDomain.BaseDirectory + "upload\\" + fileName;
                    file.SaveAs(path);

                    using (var sr = new StreamReader(path))
                    {
                        var reader = new CsvReader(sr);
                        reader.Configuration.Delimiter = "\t";
                        reader.Configuration.IgnoreHeaderWhiteSpace = true;
                        var records = reader.GetRecords<CSVContacts>().ToList();

                        var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString);
                        ContactRepository snm = new ContactRepository(connection);
                        snm.ImportContacts(records);

                        url = this.Request.UrlReferrer.AbsolutePath + "/?error=fileloaded";
                        return Redirect(url);
                    }
                }
            }
            catch
            {
                url = this.Request.UrlReferrer.AbsolutePath + "/?error=invalidfile";
                return Redirect(url);
            }

            url = this.Request.UrlReferrer.AbsolutePath + "/?error=fileloaded";
            return Redirect(url);

        }


        [HttpPost]
        public ActionResult ImportStudents(HttpPostedFileBase file)
        {
            string path = null;
            string url = null;
            List<CSVStudent> StudentsToDisplay = new List<CSVStudent>();

            try
            {
                if (file.ContentLength > 0)
                {
                    var fileName = Path.GetFileName(file.FileName);

                    path = AppDomain.CurrentDomain.BaseDirectory + "upload\\" + fileName;
                    file.SaveAs(path);

                    using (var sr = new StreamReader(path))
                    {
                        var reader = new CsvReader(sr);
                        reader.Configuration.Delimiter = "\t";
                        reader.Configuration.IgnoreHeaderWhiteSpace = true;
                        var records = reader.GetRecords<CSVStudent>().ToList();


                        //move data to the database etl.student
                        //then run the stored procedure that copies data from etl.student to samsjacksonville.student
                        var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString);
                        StudentRepository snm = new StudentRepository(connection);
                        snm.ImportStudents(records);

                        url = this.Request.UrlReferrer.AbsolutePath + "/?error=fileloaded";
                        return Redirect(url);
                    }
                }
            }
            catch
            {
                url = this.Request.UrlReferrer.AbsolutePath + "/?error=invalidfile";
                return Redirect(url);
            }

            url = this.Request.UrlReferrer.AbsolutePath + "/?error=fileloaded";
            return Redirect(url);

        }


    }


}