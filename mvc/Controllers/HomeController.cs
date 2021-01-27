using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using mvc.ConnectionLogic;
using mvc.Models;
using System.Data;
using Newtonsoft.Json;

namespace mvc.Controllers
{
    public class HomeController : Controller
    {
        [HttpGet]
        public ActionResult Index(int? id)
        {
            try
            {
                ProjectDataLogic data = new ProjectDataLogic();
                List<Project> pro = data.GetPro();
                return View(pro);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        [HttpGet]
        public ActionResult Project(int? id)
        {
            try
            {
                if (id > 0)
                {
                    ProjectDataLogic data = new ProjectDataLogic();
                    List<Project> pro = data.GetPro();
                    Project prod = pro.Find(T => T.Id == id);
                    return View(prod);
                }
                else
                {
                    return View(new Project() { DOB = DateTime.Now });
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        [HttpPost]
        public ActionResult Project(Project pro)
        {
            try
            {
                ProjectDataLogic data = new ProjectDataLogic();
                data.SavePro(pro);
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }

        [HttpGet]
        public ActionResult DeletePro(int id)
        {
            try
            {
                ProjectDataLogic data = new ProjectDataLogic();
                data.DeletePro(id);
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }

        [HttpPost]
        public ActionResult AddSalary(int id, int Salary)
        {
            try
            {
                ProjectDataLogic data = new ProjectDataLogic();
                data.AddSalary(id, Salary);
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }


        [HttpGet]
        public ActionResult Search()
        {
            try
            {
                ProjectDataLogic data = new ProjectDataLogic();
                DataTable dtbl = data.GetEmployeeName();
                ViewBag.ddlEmployee = new SelectList(dtbl.AsDataView(), "NAME", "NAME");
                return View("Search");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [HttpPost]
        public JsonResult EmpSearch(string sFromDate, string sToDate, string sEmployeeName)
        {
            try
            {
                ProjectDataLogic data = new ProjectDataLogic();
                List<ProjectListViewModel> pro = new List<ProjectListViewModel>();
                pro = data.EmpSearch(sFromDate, sToDate, sEmployeeName);
                return Json(new { data = pro }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}