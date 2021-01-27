using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using mvc.Models;

namespace mvc.ConnectionLogic
{
    public class ProjectDataLogic
    {
        private SqlConnection con;
        private void Connection()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["Name"].ToString();
            con = new SqlConnection(connectionString);
        }

        
        public List<Project> GetPro()
        {
            try
            {
                List<Project> pro = new List<Project>();
                Connection();

                SqlCommand sqlcmd = new SqlCommand("GetEmp", con);
                sqlcmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter sqlda = new SqlDataAdapter(sqlcmd);
                DataTable dtbl = new DataTable();
                con.Open();
                sqlda.Fill(dtbl);
                con.Close();

                foreach (DataRow dr in dtbl.Rows)
                {
                    pro.Add(
                        new Project()
                        {
                            Id = Convert.ToInt32(dr["Id"].ToString()),
                            Name = Convert.ToString(dr["Name"]),
                            Department = Convert.ToString(dr["Department"]),
                            DOB = Convert.ToDateTime(dr["DOB"]),
                            Age = Convert.ToString(dr["Age"])
                        }
                        );
                }
                return pro;
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }


        
        public bool SavePro(Project pro)
        {
            try
            {
                Connection();
                con.Open();
                if (pro.Id == 0)
                {
                    SqlCommand sqlcmd = new SqlCommand("Emp_insert", con);
                    sqlcmd.CommandType = CommandType.StoredProcedure;
                    sqlcmd.Parameters.AddWithValue("@Name", pro.Name);
                    sqlcmd.Parameters.AddWithValue("@Department", pro.Department);
                    sqlcmd.Parameters.AddWithValue("@DOB", pro.DOB);
                    int i = sqlcmd.ExecuteNonQuery();
                    if (i >= 1)
                        return true;
                    else
                        return false;
                }
                else
                {
                    SqlCommand sqlcmd = new SqlCommand("Emp_Update", con);
                    sqlcmd.CommandType = CommandType.StoredProcedure;
                    sqlcmd.Parameters.AddWithValue("@Id", pro.Id);
                    sqlcmd.Parameters.AddWithValue("@Name", pro.Name);
                    sqlcmd.Parameters.AddWithValue("@Department", pro.Department);
                    sqlcmd.Parameters.AddWithValue("@DOB", pro.DOB);
                    int i = sqlcmd.ExecuteNonQuery();
                    if (i >= 1)
                        return true;
                    else
                        return false;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

       
        public bool DeletePro(int id)
        {
            try
            {
                Connection();
                SqlCommand sqlcmd = new SqlCommand("Emp_Delete", con);
                sqlcmd.CommandType = CommandType.StoredProcedure;
                sqlcmd.Parameters.AddWithValue("@ID", id);
                con.Open();
                int i = sqlcmd.ExecuteNonQuery();
                if (i >= 1)
                    return true;
                else
                    return false;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public bool AddSalary(int id, int Salary)
        {
            try
            {
                Connection();
                SqlCommand sqlcmd = new SqlCommand("Emp_salary_insert", con);
                sqlcmd.CommandType = CommandType.StoredProcedure;
                sqlcmd.Parameters.AddWithValue("@ID", id);
                sqlcmd.Parameters.AddWithValue("@salary", Salary);
                con.Open();
                int i = sqlcmd.ExecuteNonQuery();
                if (i >= 1)
                    return true;
                else
                    return false;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public List<ProjectListViewModel> EmpSearch(string sFromDate, string sToDate, string sEmployeeName)
        {
            try
            {
                List<ProjectListViewModel> pro = new List<ProjectListViewModel>();
                Connection();

                SqlCommand sqlcmd = new SqlCommand("Emp_Search", con);
                sqlcmd.CommandType = CommandType.StoredProcedure;
                sqlcmd.Parameters.AddWithValue("@FromDate", sFromDate);
                sqlcmd.Parameters.AddWithValue("@Todate", sToDate);
                sqlcmd.Parameters.AddWithValue("@EmployeeName", sEmployeeName);
                SqlDataAdapter sqlda = new SqlDataAdapter(sqlcmd);
                DataTable dtbl = new DataTable();
                con.Open();
                sqlda.Fill(dtbl);
                con.Close();

                foreach (DataRow dr in dtbl.Rows)
                {
                    pro.Add(
                        new ProjectListViewModel()
                        {
                            Id = Convert.ToInt32(dr["Id"].ToString()),
                            Name = Convert.ToString(dr["Name"]),
                            Department = Convert.ToString(dr["Department"]),
                            DOB = Convert.ToString(dr["DOB"]),
                            Salary = Convert.ToDecimal(dr["Salary"])
                        }
                        );
                }
                return pro;
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }

        public DataTable GetEmployeeName()
        {
            try
            {

                Connection();

                SqlCommand sqlcmd = new SqlCommand("Emp_Get", con);
                sqlcmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter sqlda = new SqlDataAdapter(sqlcmd);
                DataTable dtbl = new DataTable();
                con.Open();
                sqlda.Fill(dtbl);
                con.Close();

                return dtbl;
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }
    }
}