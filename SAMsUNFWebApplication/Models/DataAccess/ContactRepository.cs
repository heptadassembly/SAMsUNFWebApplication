using System;
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
    public class ContactRepository
    {

        private MySqlConnection _openConnection;


        public ContactRepository(MySqlConnection openConnection)
        {
            this._openConnection = openConnection;
        }

        public async Task<IEnumerable<Contact>> GetContacts()
        {
            // Read the user by their username in the database. 
            IEnumerable<Contact> result = await this._openConnection.QueryAsync<Contact>(@" SELECT * FROM  samsjacksonville.vw_contact where contact_id > 0 order by last_name");
            return result;
        }

        public async Task<IEnumerable<Contact>> GetContact(int id)
        {
            // Read the user by their username in the database. 
            IEnumerable<Contact> result = await this._openConnection.QueryAsync<Contact>(@" SELECT * FROM  samsjacksonville.vw_contact where contact_id = " + id + ";");
            return result;
        }

        public bool ImportContacts(List<CSVContacts> csvContacts)
        {
            bool success = false;

            var queryString = @"INSERT INTO etl.contact values(@lastname,@firstname,@position,@classroom,@school,@room,@roomextension,@email,@cell)";

            try
            {
                this._openConnection.Execute(queryString, csvContacts);
                var newString = @"CALL samsjacksonville.import_contact();";
                this._openConnection.Execute(newString);
                success = true;
            }
            catch (Exception ex)
            {
                throw (ex);
            }
            return success;
        }

        public string EditContct(string ContactID, string ContactFirstName, string ContactLastName, string ContactPosition, string ContactClassRoom, string ContactRoomNumber, string ContactRoomExtension, string schoolselectlist, string ContactEmailAddress, string ContactCellPhone)
        {
            var queryString = @"update samsjacksonville.contact set first_name = '" + ContactFirstName + "', last_name = '" + ContactLastName + "', `position` = '" + ContactPosition + "', classroom = '" + ContactClassRoom + "', room_number = '" + ContactRoomNumber + "', room_extension = '" + ContactRoomExtension + "', school_id = " + schoolselectlist + ", email_address = '" + ContactEmailAddress + "', cell_phone = '" + ContactCellPhone + "' where contact_id = " + ContactID + ";";
            _openConnection.Execute(queryString);
            return "success";
        }

        public string AddContct(string ContactFirstName, string ContactLastName, string ContactPosition, string ContactClassRoom, string ContactRoomNumber, string ContactRoomeExtension, string schoolselectlist, string ContactEmailAddress, string ContactCellPhone)
        {
            var queryString = @"insert into samsjacksonville.contact (school_year_id, first_name, last_name, `position`, classroom, room_number, room_extension, school_id, email_address, cell_phone) VALUES (samsjacksonville.fn_getSchoolYear(1), '" + ContactFirstName + "','" + ContactLastName + "','" + ContactPosition + "','" + ContactClassRoom + "','" + ContactRoomNumber + "','" + ContactRoomeExtension + "'," + schoolselectlist + ",'" + ContactEmailAddress + "','" + ContactCellPhone + "');";
            _openConnection.Execute(queryString);
            return "success";
        }

        public bool CreateContact(string ContactID, string ContactFirstName, string ContactLastName, string ContactPosition, string ContactClassRoom, string ContactRoomNumber, string ContactRoomeExtension, string schoolselectlist, string ContactEmailAddress, string ContactCellPhone)
        {
            var queryString = @"insert into samsjacksonville.contact (school_year_id, first_name, last_name, `position`, classroom, room_number, room_extension, school_id, email_address, cell_phone) VALUES (samsjacksonville.fn_getSchoolYear(1), '" + ContactFirstName + "','" + ContactLastName + "','" + ContactPosition + "','" + ContactClassRoom + "','" + ContactRoomNumber + "','" + ContactRoomeExtension + "'," + schoolselectlist + ",'" + ContactEmailAddress + "','" + ContactCellPhone + "');";
            _openConnection.Execute(queryString);
            return true;
        }

    }
}