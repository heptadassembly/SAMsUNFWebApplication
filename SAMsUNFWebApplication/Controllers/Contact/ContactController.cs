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
                return View(result);
            }
        }

        public async System.Threading.Tasks.Task<ActionResult> GetContact(int id)
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                await connection.OpenAsync();
                var result = await new ContactRepository(connection).GetContact(id);
                return View(result);
            }
        }

        public System.Web.Mvc.RedirectResult EditContct(string ContactID, string ContactFirstName, string ContactLastName, string ContactPosition, string ContactClassRoom, string ContactRoomNumber, string ContactRoomExtension, string schoolselectlist, string ContactEmailAddress, string ContactCellPhone)
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                var result = new ContactRepository(connection).EditContct(ContactID, ContactFirstName, ContactLastName, ContactPosition, ContactClassRoom, ContactRoomNumber, ContactRoomExtension, schoolselectlist, ContactEmailAddress, ContactCellPhone);
                if (result == "success")
                {
                    return Redirect("Contact/Contact/?error=fileloaded");
                }
                else
                {
                    //do something else here.
                    return Redirect("Contact/Contact/?error=invalidfile");
                }
            }
        }

        public System.Web.Mvc.RedirectResult AddContct(string ContactFirstName, string ContactLastName, string ContactPosition, string ContactClassRoom, string ContactRoomNumber, string ContactRoomExtension, string schoolselectlist, string ContactEmailAddress, string ContactCellPhone)
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                var result = new ContactRepository(connection).AddContct(ContactFirstName, ContactLastName, ContactPosition, ContactClassRoom, ContactRoomNumber, ContactRoomExtension, schoolselectlist, ContactEmailAddress, ContactCellPhone);
                if (result == "success")
                {
                    return Redirect("Contact/Contact/?error=fileloaded");
                }
                else
                {
                    //do something else here.
                    return Redirect("Contact/Contact/?error=invalidfile");
                }
            }
        }
    }
}