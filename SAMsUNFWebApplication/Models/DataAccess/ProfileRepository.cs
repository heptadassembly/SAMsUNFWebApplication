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
    public class ProfileRepository
    {

        private MySqlConnection _openConnection;


        public ProfileRepository(MySqlConnection openConnection)
        {
            this._openConnection = openConnection;
        }

        public async Task<IEnumerable<ProfileModel>> GetProfiles()
        {
            // Read the user by their username in the database. 
            IEnumerable<ProfileModel> result = await this._openConnection.QueryAsync<ProfileModel>(@" SELECT * FROM  samsjacksonville.vw_profile where profile_id > 0 order by last_name");
            return result;
        }

        public async Task<IEnumerable<ProfileModel>> GetProfile(int id)
        {
            // Read the user by their username in the database. 
            IEnumerable<ProfileModel> result = await this._openConnection.QueryAsync<ProfileModel>(@" SELECT * FROM  samsjacksonville.vw_profile where profile_id = " + id + ";");
            return result;
        }

        public string EditProfl(string ProfileID, string ProfileUserName, string ProfilePassword, string profilecontactselectlist)
        {
            try
            {
                var current_user = HttpContext.Current.User.Identity.Name;
                var queryString = @"update samsjacksonville.profile set contact_id = " + profilecontactselectlist + ", user_name = '" + ProfileUserName + "', `password` = '" + ProfilePassword + "', last_update_contact_id = samsjacksonville.fn_getContactID('" + current_user + "'), last_update_dt = now() where profile_id = " + ProfileID;
                _openConnection.Execute(queryString);
                return "success";
            }
            catch (Exception ex)
            {
                return "error";
            }
        }

        public string AddProfl(string ProfileUserName, string ProfilePassword, string profilecontactselectlist)
        {
            try
            {
                var current_user = HttpContext.Current.User.Identity.Name;
                var queryString = @"insert into samsjacksonville.profile (school_year_id, user_name, contact_id, password,create_contact_id,create_dt,last_update_contact_id,last_update_dt) VALUES (samsjacksonville.fn_getSchoolYear(1), '" + ProfileUserName + "'," + profilecontactselectlist + ",'" + ProfilePassword + "', samsjacksonville.fn_getContactID('" + current_user + "'), now(), samsjacksonville.fn_getContactID('" + current_user + "'), now());";
                _openConnection.Execute(queryString);
                return "success";
            }
            catch (Exception ex)
            {
                return "error";
            }
        }

        public string CreateProfile(string ProfileUserName, string ProfilePassword, string profilecontactselectlist)
        {
            try
            {
                var current_user = HttpContext.Current.User.Identity.Name;
                var queryString = @"insert into samsjacksonville.profile (school_year_id, user_name, contact_id, password,create_contact_id,create_dt,last_update_contact_id,last_update_dt) VALUES (samsjacksonville.fn_getSchoolYear(1), '" + ProfileUserName + "'," + profilecontactselectlist + ",'" + ProfilePassword + "', samsjacksonville.fn_getContactID('" + current_user + "'), now(), samsjacksonville.fn_getContactID('" + current_user + "'), now());";
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