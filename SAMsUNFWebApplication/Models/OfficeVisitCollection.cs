using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SAMsUNFWebApplication.Models
{
    public class OfficeVisitCollection
    {

        public IEnumerable<Student> AllStudents { get; set; }
        public IEnumerable<Contact> AllContacts { get; set; }
        public IEnumerable<ContentCourse> AllLocations { get; set; }
        public IEnumerable<CodeOfConductViolation> AllCodeViolations { get; set; }

    }
}