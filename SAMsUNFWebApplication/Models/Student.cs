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
        public int school_id { get; set; }
        public string gender { get; set; } 
        public int homeroom_id { get; set; }
        public string grade_id { get; set; }
        public int create_contact_id { get; set; }
        public DateTime create_dt { get; set; }
        public int last_update_contact_id { get; set; }
        public DateTime last_update_dt { get; set; }
        public Boolean is_deleted { get; set; }
        public string student_name
        {
            get {
                if (last_name != null)
                {
                    return last_name + ", " + first_name;
                }

                return null;
            }
        }
    }

    public class CSVStudent
    {
        public string StudentID { get; set; }
        public string Last { get; set; }
        public string First { get; set; }
        public string Grade { get; set; }
        public string School { get; set; }
        public string Gender { get; set; }
        public bool Empty
        {
            get
            {
                return (string.IsNullOrWhiteSpace(First) &&
                        string.IsNullOrWhiteSpace(Last) &&
                        string.IsNullOrWhiteSpace(School) &&
                        string.IsNullOrWhiteSpace(Grade)
                        );
                }
        }
    }
}