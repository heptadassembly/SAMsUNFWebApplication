using MySql.Data.MySqlClient;
using SAMsUNFWebApplication.Models;
using SAMsUNFWebApplication.Models.DataAccess;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SAMsUNFWebApplication.Controllers.Contact
{
    public class AddContactController : Controller
    {
        // GET: AddContact
        public ActionResult Index()
        {
            return View();
        }

        public async System.Threading.Tasks.Task<ActionResult> AddContact()
        {

            ContactCollection coll = new ContactCollection();

            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                await connection.OpenAsync();

                var result2 = new SchoolRepository(connection).GetSchools();
                coll.allSchools = (IEnumerable<Models.School>)result2.Result.ToArray();
                coll.schoolselectlist = new SelectList(result2.Result.ToList(), "school_id", "name", new { @required = "required" });
            }

            return View(coll);
        }

        public ActionResult AddContct(ContactCollection model, string actionRequest)
        {

            return RedirectToAction("Contact", "Contact");
        }
    }
}