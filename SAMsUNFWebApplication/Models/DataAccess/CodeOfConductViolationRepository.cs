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

namespace SAMsUNFWebApplication.Models.DataAccess
{
    public class CodeOfConductViolationRepository
    {
        private MySqlConnection _openConnection;


        public CodeOfConductViolationRepository(MySqlConnection openConnection)
        {
            this._openConnection = openConnection;
        }


        public async Task<IEnumerable<CodeOfConductViolation>> GetCodeOfConductViolations()
        {
            // Read the user by their username in the database. 
            IEnumerable<CodeOfConductViolation> result = await this._openConnection.QueryAsync<CodeOfConductViolation>(@" SELECT * FROM  samsjacksonville.vw_code_of_conduct_violation where code_of_conduct_violation_id > 0 order by name");
            return result;
        }

        public string CreateCodeOfConductViolation(string TxtId, string TxtCode, string TxtName)
        {
            //To do Items
            //Get Current Logged on User and put into variable.
            //Get Current Date/Time and put into variable.
            //Get Current School Year Selection and put into variable.
            try
            {
                var current_user = HttpContext.Current.User.Identity.Name;
                var queryString = @"INSERT INTO samsjacksonville.code_of_conduct_violation (duval_violation_code, short_code, school_year_id, name, create_contact_id, create_dt, last_update_contact_id, last_update_dt) VALUES ('" + TxtId + "','" + TxtCode + "', samsjacksonville.fn_getSchoolYear(1), '" + TxtName + "', samsjacksonville.fn_getContactID('" + current_user + "'), now(), samsjacksonville.fn_getContactID('" + current_user + "'), now());";
                _openConnection.Execute(queryString);
                return "success";
            }
            catch (Exception ex)
            {
                //Handle Exception;
                return "error";
            }
        }
    }
}

