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

namespace SAMsUNFWebApplication.Controllers.Student
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

        public System.Web.Mvc.RedirectResult AddContact(string TxtId, string TxtFirst, string TxtLast, string TxtPosition, string TxtClassRoom, string TxtRoomNumber, string TxtRoomExtension, string schoolselectlist, string TxtEmailAddress, string TxtCellPhone)
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                var result = new ContactRepository(connection).AddPerson(TxtId, TxtFirst, TxtLast, TxtPosition, TxtClassRoom, TxtRoomNumber, TxtRoomExtension, schoolselectlist, TxtEmailAddress, TxtCellPhone);
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

        [HttpGet]
        public ActionResult AddContact()
        {
            return View("AddContact");
        }

        public System.Web.Mvc.RedirectResult EditPerson(string TxtID, string TxtFirstName, string TxtLastName, string TxtPosition, string TxtClassroom, string TxtRoomNumber, string TxtRoomExtension, string schoolselectlist, string TxtEmailAddress, string TxtCellPhone)
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                var result = new ContactRepository(connection).EditPerson(TxtID, TxtFirstName, TxtLastName, TxtPosition, TxtClassroom, TxtRoomNumber, TxtRoomExtension, schoolselectlist, TxtEmailAddress, TxtCellPhone);
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

        public System.Web.Mvc.RedirectResult AddPerson(string TxtID, string TxtFirstName, string TxtLastName, string TxtPosition, string TxtClassRoom, string TxtRoomNumber, string TxtRoomExtension, string schoolselectlist, string TxtEmailAddress, string TxtCellPhone)
        {
            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                var result = new ContactRepository(connection).AddPerson(TxtID, TxtFirstName, TxtLastName, TxtPosition, TxtClassRoom, TxtRoomNumber, TxtRoomExtension, schoolselectlist, TxtEmailAddress, TxtCellPhone);
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
    }
}