using MySql.Data.MySqlClient;
using SAMsUNFWebApplication.Models;
using SAMsUNFWebApplication.Models.DataAccess;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SAMsUNFWebApplication.Controllers.School
{
    public class EditRemedialActionController : Controller
    {
        // GET: EditSchool
        public ActionResult Index()
        {
            return View();
        }
        public async System.Threading.Tasks.Task<ActionResult> EditRemedialAction(string id)
        {

            RemedialActionCollection coll = new RemedialActionCollection();

            using (var connection = new MySqlConnection(ConfigurationManager.ConnectionStrings[Constants.ConnectionStringName].ConnectionString))
            {
                await connection.OpenAsync();
                var result = new RemedialActionRepository(connection).GetRemedialAction(id);
                var result2 = new RemedialActionRepository(connection).GetRemedialActions();

                coll.singleRemedialAction = (IEnumerable<Models.RemedialAction>)result.Result.ToArray();
                coll.allRemedialActions = (IEnumerable<Models.RemedialAction>)result2.Result.ToArray();
                coll.remedialactionselectlist = new SelectList(result2.Result.ToList(), "remedial_action_id", "name", new { id = "RemedialActionID", @required = "required" });
            }

            return View(coll);
        }
    }
}