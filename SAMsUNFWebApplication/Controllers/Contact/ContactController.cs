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

namespace SAMsUNFWebApplication.Controllers.Contact
{
    public class ContactController : Controller
    {
        // GET: Student
        public async System.Threading.Tasks.Task<ActionResult> Contact()
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                await connection.OpenAsync();
                var result = await new ContactRepository(connection).GetContacts();
                //var result2 = await new SchoolRepository(connection).GetSchools();
                return View(result);
            }
        }

        public System.Web.Mvc.RedirectResult CreateContact(string ContactID, string ContactFirstName, string ContactLastName, string ContactPosition, string ContactClassRoom, string ContactRoomNumber, string ContactRoomExtension, string schoolselectlist, string ContactEmailAddress, string ContactCellPhone)
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                var result = new ContactRepository(connection).CreateContact(ContactID, ContactFirstName, ContactLastName, ContactPosition, ContactClassRoom, ContactRoomNumber, ContactRoomExtension, schoolselectlist, ContactEmailAddress, ContactCellPhone);
                if (result == true)
                {
                    return Redirect("Contact/Contact");
                }
                else
                {
                    //do something else here.
                    return Redirect("Contact/Contact");
                }
            }
        }

        public System.Web.Mvc.RedirectResult EditContct(string ContactID, string ContactFirstName, string ContactLastName, string ContactPosition, string ContactClassRoom, string ContactRoomNumber, string ContactRoomExtension, string schoolselectlist, string ContactEmailAddress, string ContactCellPhone)
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                var result = new ContactRepository(connection).EditContct(ContactID, ContactFirstName, ContactLastName, ContactPosition, ContactClassRoom, ContactRoomNumber, ContactRoomExtension, schoolselectlist, ContactEmailAddress, ContactCellPhone);
                if (result == "success")
                {
                    return Redirect("Contact/Contact");
                }
                else
                {
                    //do something else here.
                    return Redirect("Contact/Contact");
                }
            }
        }

        public ActionResult AddContact()
        {
            return View("AddContact");
        }

        public ActionResult EditContact()
        {
            return View("EditContact");
        }

        public System.Web.Mvc.RedirectResult AddContct(string ContactFirstName, string ContactLastName, string ContactPosition, string ContactClassRoom, string ContactRoomNumber, string ContactRoomExtension, string schoolselectlist, string ContactEmailAddress, string ContactCellPhone)
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                var result = new ContactRepository(connection).AddContct(ContactFirstName, ContactLastName, ContactPosition, ContactClassRoom, ContactRoomNumber, ContactRoomExtension, schoolselectlist, ContactEmailAddress, ContactCellPhone);
                if (result == "success")
                {
                    return Redirect("Contact/Contact");
                }
                else
                {
                    //do something else here.
                    return Redirect("Contact/Contact");
                }
            }
        }
    }
}