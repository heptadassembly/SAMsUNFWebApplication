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
    public class EditProfileController : Controller
    {
        // GET: AddOfficeVisit
        public async System.Threading.Tasks.Task<ActionResult> EditProfile(int id)
        {

            ProfileCollection coll = new ProfileCollection();

            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                await connection.OpenAsync();
                var result = new ProfileRepository(connection).GetProfile(id);
                var result2 = new ProfileRepository(connection).GetProfiles();
                var result3 = new ContactRepository(connection).GetSortedContacts(result.Result.First().contact_id.ToString());

                coll.singleProfile = (IEnumerable<Models.ProfileModel>)result.Result.ToArray();
                coll.allProfiles = (IEnumerable<Models.ProfileModel>)result2.Result.ToArray();
                coll.profilecontactselectlist = new SelectList(result3.Result.ToList(), "contact_id", "contact_name", new { id = "TxtContact", @required = "required" });
            }

            return View(coll);
        }

        public ActionResult EditProfl(ProfileCollection model, string actionRequest)
        {
            return RedirectToAction("Profile", "Profile");
        }

    }
}