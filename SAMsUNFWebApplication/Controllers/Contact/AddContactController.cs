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
    public class AddContactContoller : Controller
    {
        // GET: AddOfficeVisit
        public async System.Threading.Tasks.Task<ActionResult> AddContact()
        {

            ContactCollection coll = new ContactCollection();

            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                await connection.OpenAsync();

                var result2 = new ContactRepository(connection).GetContacts();

                coll.allContacts = (IEnumerable<Models.Contact>)result2.Result.ToArray();
            }

            return View(coll);
        }

        public ActionResult AddPerson(ContactCollection model, string actionRequest)
        {

            return RedirectToAction("Contact", "Contact");
        }
    }
}