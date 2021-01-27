using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace mvc.Models
{
    public class ProjectListViewModel
    {
        public int Id { get; set; }
       
        public string Name { get; set; }
        public string Department { get; set; }
       
        public string DOB { get; set; }

        public decimal Salary { get; set; }
       
    }
}