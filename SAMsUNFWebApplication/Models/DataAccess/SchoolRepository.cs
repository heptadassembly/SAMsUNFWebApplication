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
    public class SchoolRepository
    {
        private MySqlConnection _openConnection;

        public SchoolRepository(MySqlConnection openConnection)
        {
            this._openConnection = openConnection;
        }

        public async Task<IEnumerable<School>> GetSchools()
        {
            // Read the user by their username in the database. 
            IEnumerable<School> result = await this._openConnection.QueryAsync<School>(@" SELECT * FROM vw_school");
            return result;
        }
    }
}