using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SAMsUNFWebApplication.Models
{
    public class ProfileModel
    {

        public int profile_id { get; set; }
        public int contact_id { get; set; }
        public string user_name { get; set; }
        public string password { get; set; }
        public string first_name { get; set; }
        public string last_name { get; set; }
        public int school_year_id { set; get; }
        public int create_contact_id { get; set; }
        public string create_dt { get; set; }
        public int last_update_contact_id { get; set; }
        public DateTime last_update_dt { get; set; }
        public Boolean is_deleted { get; set; }
        public string secretanswer { get; set; }
        public Boolean resetpassword { get; set; }
        public string reenterpassword { get; set; }
        public string newsecretanswer { get; set; }
    }

    public class ProfileCollection
    {
        public ProfileModel profile { get; set; }
        public IEnumerable<ProfileModel> allProfiles { get; set; }
        public IEnumerable<ProfileModel> singleProfile { get; set; }
        public IEnumerable<Contact> singleContact { get; set; }
        public IEnumerable<Contact> allContacts { get; set; }
        public SelectList profilecontactselectlist { get; set; }
    }
}