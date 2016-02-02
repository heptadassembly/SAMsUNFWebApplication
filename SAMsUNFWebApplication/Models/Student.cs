using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace SAMsUNFWebApplication.Models
{
    public class Student
    {
        [Required]
        public int student_id { get; set; }
        [Required]
        public string student_id_nk { get; set; }
        [Required]
        public string first_name { get; set; }
        [Required]
        public string last_name { get; set; }
        [Required]
        public int school_year_id { get; set; }
        [Required]
        public int school_id { get; set; }
        public string gender { get; set; } 
        public int homeroom_id { get; set; }
        [Required]
        public string grade_id { get; set; }
        public int create_contact_id { get; set; }
        [DataType(DataType.Date)]
        public DateTime create_dt { get; set; }
        public int last_update_contact_id { get; set; }
        [DataType(DataType.Date)]
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
        [Required]
        public string StudentID { get; set; }
        [Required]
        public string Last { get; set; }
        [Required]
        public string First { get; set; }
        [Required]
        public string Grade { get; set; }
        [Required]
        public string School { get; set; }
        [Required]
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

    public class StudentCollection
    {
        public Student student { get; set; }
        public IEnumerable<Grade> allGrades { get; set; }
        public IEnumerable<School> allSchools { get; set; }
        public IEnumerable<Gender> allGenders { get; set; }
        public IEnumerable<HomeRoom> allHomeRooms { get; set; }

    }
}