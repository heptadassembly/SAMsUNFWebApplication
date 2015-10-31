﻿using System;
using System.Collections.Generic;
using MySql.Data.MySqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using SAMsUNFWebApplication.Models;

namespace SAMsUNFWebApplication.Models.DataAccess
{

    public class UserRepository
    {
        private MySqlConnection _openConnection;


        public UserRepository(MySqlConnection openConnection)
        {
            this._openConnection = openConnection;
        }


        public async Task<Profile> LoginValidation(string userID, string password)
        {
            // Read the user by their username in the database. 
            var results = await this._openConnection.QueryAsync<Profile>(@" SELECT * FROM  profile 
                     WHERE user_name = @UserID AND password = @Password",
                    new { UserID  = userID, Password = password });

            var result = results.FirstOrDefault();
            return result;
        }
    }
    
    public class StudentRepository
    {
        private MySqlConnection _openConnection;


        public StudentRepository(MySqlConnection openConnection)
        {
            this._openConnection = openConnection;
        }


        public async Task<IEnumerable<Student>> GetStudents()
        {
            // Read the user by their username in the database. 
            IEnumerable<Student> result = await this._openConnection.QueryAsync<Student>(@" SELECT * FROM  student");
            return result;
        }


    }

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
            IEnumerable<CodeOfConductViolation> result = await this._openConnection.QueryAsync<CodeOfConductViolation>(@" SELECT * FROM  code_of_conduct_violation");
            return result;
        }
    }
}