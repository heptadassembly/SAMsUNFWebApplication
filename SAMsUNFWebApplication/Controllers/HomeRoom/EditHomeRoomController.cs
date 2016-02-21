using MySql.Data.MySqlClient;
using SAMsUNFWebApplication.Models;
using SAMsUNFWebApplication.Models.DataAccess;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SAMsUNFWebApplication.Controllers.Student
{
    public class EditHomeRoomController : Controller
    {
        // GET: AddOfficeVisit
        public async System.Threading.Tasks.Task<ActionResult> EditHomeRoom(string id)
        {

            HomeRoomCollection coll = new HomeRoomCollection();

            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                await connection.OpenAsync();
                var result = new HomeRoomRepository(connection).GetHomeRoom(id);

                //get all possible values
                var result1 = new StudentRepository(connection).GetStudent(id);
                var result2 = new SchoolRepository(connection).GetSortedSchools(result.Result.First().school_id.ToString());

                coll.singleHomeRoom = (IEnumerable<Models.HomeRoom>)result.Result.ToArray();
                coll.allSchools = (IEnumerable<Models.School>)result2.Result.ToArray();

                coll.schoolselectlist = new SelectList(result2.Result.ToList(), "school_id", "name", new { id = "TxtSchool", @required = "required" });

            }
            return View(coll);
        }


        public ActionResult EditHomeRm(HomeRoomCollection model, string actionRequest)
        {

            return RedirectToAction("HomeRoom", "HomeRoom");
        }
    }
}