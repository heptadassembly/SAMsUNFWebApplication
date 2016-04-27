﻿using System;
using System.Collections.Generic;
using MySql.Data.MySqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using SAMsUNFWebApplication.Models;
using System.Web;
using System.Configuration;
using System.Web.Mvc;

namespace SAMsUNFWebApplication.Models.DataAccess
{
    public class RemedialActionRepository
    {

        private MySqlConnection _openConnection;


        public RemedialActionRepository(MySqlConnection openConnection)
        {
            this._openConnection = openConnection;
        }

        public async Task<IEnumerable<RemedialAction>> GetRemedialActions()
        {
            // Read the user by their username in the database. 
            IEnumerable<RemedialAction> result = await this._openConnection.QueryAsync<RemedialAction>(@" SELECT * FROM  samsjacksonville.vw_remedial_action where remedial_action_id > 0 order by name");
            return result;
        }

        public async Task<IEnumerable<RemedialAction>> GetRemedialAction(string id)
        {
            // Read the user by their username in the database. 
            IEnumerable<RemedialAction> result = await this._openConnection.QueryAsync<RemedialAction>(@" SELECT * FROM  samsjacksonville.vw_remedial_action where remedial_action_id = " + id + ";");
            return result;
        }

        public string EditRemedialAction(string RemedialActionID, string RemedialActionName)
        {
            try
            {
                var current_user = HttpContext.Current.User.Identity.Name;
                var queryString = @"update samsjacksonville.remedial_action set name = '" + RemedialActionName + "', last_update_contact_id = samsjacksonville.fn_getContactID('" + current_user + "'), last_update_dt = now() where remedial_action_id = " + RemedialActionID;
                _openConnection.Execute(queryString);
                return "success";
            }
            catch (Exception ex)
            {
                return "error";
            }
        }

        public string CreateRemedialAction(string RemedialActionName)
        {
            try
            {
                var current_user = HttpContext.Current.User.Identity.Name;
                var queryString = @"insert into samsjacksonville.remedial_action (school_year_id, name,create_contact_id,create_dt,last_update_contact_id,last_update_dt) VALUES (samsjacksonville.fn_getSchoolYear(1), '" + RemedialActionName + "', samsjacksonville.fn_getContactID('" + current_user + "'), now(), samsjacksonville.fn_getContactID('" + current_user + "'), now());";
                _openConnection.Execute(queryString);
                return "success";
            }
            catch (Exception ex)
            {
                return "error";
            }
        }

    }
}