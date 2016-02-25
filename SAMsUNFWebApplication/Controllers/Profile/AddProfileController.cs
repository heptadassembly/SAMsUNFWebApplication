using MySql.Data.MySqlClient;
using SAMsUNFWebApplication.Models;
using SAMsUNFWebApplication.Models.DataAccess;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SAMsUNFWebApplication.Controllers.Profile
{
    public class AddProfileController : Controller
    {
        // GET: AddContact
        public ActionResult Index()
        {
            return View();
        }

        public async System.Threading.Tasks.Task<ActionResult> AddProfile()
        {

            ProfileCollection coll = new ProfileCollection();

            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                await connection.OpenAsync();

                var result = new ContactRepository(connection).GetContacts();
                coll.allContacts = (IEnumerable<Models.Contact>)result.Result.ToArray();
                coll.profilecontactselectlist = new SelectList(result.Result.ToList(), "contact_id", "contact_name", new { @required = "required" });
            }

            return View(coll);
        }

        public ActionResult AddProfl(ProfileCollection model, string actionRequest)
        {

            return RedirectToAction("Profile", "Profile");
        }
    }
}