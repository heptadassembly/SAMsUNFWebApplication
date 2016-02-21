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
    public class EditContactController : Controller
    {
        // GET: AddOfficeVisit
        public async System.Threading.Tasks.Task<ActionResult> EditContact(int id)
        {

            ContactCollection coll = new ContactCollection();

            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                await connection.OpenAsync();
                var result = new ContactRepository(connection).GetContact(id);
                var result2 = new ContactRepository(connection).GetContacts();
                var result3 = new SchoolRepository(connection).GetSortedSchools(result.Result.First().school_id.ToString());

                coll.singleContact = (IEnumerable<Models.Contact>)result.Result.ToArray();
                coll.allContacts = (IEnumerable<Models.Contact>)result2.Result.ToArray();
                coll.schoolselectlist = new SelectList(result3.Result.ToList(), "school_id", "name", new { id = "TxtSchool", @required = "required" });
            }

            return View(coll);
        }

        public ActionResult EditContct(ContactCollection model, string actionRequest)
        {
            return RedirectToAction("Contact", "Contact");
        }

    }
}