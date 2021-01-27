using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace mvc.Models
{
    public class Project
    {
        public int Id  { get; set; }
        [Required(ErrorMessage = "Enter the name.")]
        public string Name { get; set; }
        public string Department { get; set; }
        [Required(ErrorMessage = "Enter the date.")]
        [DataType(DataType.Date)]
        [DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:MM/dd/yyyy}")]
        public DateTime DOB { get; set; }

        public string Age { get; set; }
    }
    
}
