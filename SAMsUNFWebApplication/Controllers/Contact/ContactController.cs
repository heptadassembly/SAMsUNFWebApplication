using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CsvHelper;
using SAMsUNFWebApplication.Models;
using System.IO;

namespace SAMsUNFWebApplication.Controllers.Contact
{
    public class ContactController : Controller
    {
        // GET: Contact
        public ActionResult Contact()
        {
            return View();
        }

        [HttpPost]
        public ActionResult ImportContact(HttpPostedFileBase file)
        {
            string path = null;
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
                        reader.Configuration.Delimiter = ",";
                        var records = reader.GetRecords<CSVContacts>().ToList();

                        return View(records);
                    }
                }
            }
            catch
            {
                return View();
            }

            return View();

        }
        [HttpPost]
        public ActionResult ImportStudent(HttpPostedFileBase file)
        {
            string path = null;
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

                        return View(records);
                    }
                }
            }
            catch
            {
                return View();
            }

            return View();

        }
        
    }
}