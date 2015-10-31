using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SAMsUNFWebApplication.Models
{
    public class Student
    {
        public int student_id { get; set; }
        public string first_name { get; set; }
        public string last_name { get; set; }
        public int school_year_id { get; set; }
        public int homeroom_id { get; set; }
        public string grade_id { get; set; }
        public string create_user { get; set; }
        public DateTime create_dt { get; set; }
        public string last_update_user { get; set; }
        public DateTime last_update_dt { get; set; }
        public Boolean is_deleted { get; set; }
    }
}