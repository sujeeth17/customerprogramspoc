using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace RunExecutable
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "fnGetExceptionDetails", "fnGetExceptionDetails()", true);
            }
            tbConfig.Text = "";
            GetShortName();
            GetCustomerProgramDetails();
            GetExceptionDetails();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "fnGetCustomerProgramDetails", "fnGetCustomerProgramDetails()", true);                       
        }

        private void GetExceptionDetails()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("ApplicationName");
            dt.Columns.Add("ApplicationMessage");
            dt.Columns.Add("StackTrace");
            using (var context = new TestEntities())
            {
                var data = (from a in context.APPLICATION_LOG
                            where a.IsError==1
                            select
                             a).Distinct();

                foreach (var row in data)
                {
                    DataRow dr = dt.NewRow();
                    dr["ApplicationName"] = row.ApplicationName;
                    dr["ApplicationMessage"] = row.ApplicationMessage;
                    dr["StackTrace"] = row.StackTrace;
                    dt.Rows.Add(dr);
                }
            }

            lvExceptionDetails.DataSource = dt;
            lvExceptionDetails.DataBind();
        }

        private void GetShortName()
        {
            DataTable dtShortName = new DataTable();
            dtShortName.Columns.Add("ShortName");
            using (var context = new TestEntities())
            {
                var data = (from a in context.tCustomerEmails
                            where !a.ShortName.Contains("No")
                            select a.ShortName).Distinct();

                foreach (var row in data)
                {
                    DataRow dr = dtShortName.NewRow();
                    dr["ShortName"] = row.ToString();
                    dtShortName.Rows.Add(dr);
                }
            }

            dlCustomerProgramname.DataSource = dtShortName;
            dlCustomerProgramname.DataTextField = "ShortName";
            dlCustomerProgramname.DataValueField = "ShortName";
            dlCustomerProgramname.DataBind();

            ddlProgramList.DataSource = dtShortName;
            ddlProgramList.DataTextField = "ShortName";
            ddlProgramList.DataValueField = "ShortName";
            ddlProgramList.DataBind();

            ddlProgramListConfig.DataSource = dtShortName;
            ddlProgramListConfig.DataTextField = "ShortName";
            ddlProgramListConfig.DataValueField = "ShortName";
            ddlProgramListConfig.DataBind();
        }

        private void GetCustomerProgramDetails()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("Customer_ID");
            dt.Columns.Add("Customer_Name");
            dt.Columns.Add("Program_RunTime");
            dt.Columns.Add("POC");
            dt.Columns.Add("Executable_Path");
            dt.Columns.Add("OutputFiles_Path");
            dt.Columns.Add("Comments");
            using (var context = new TestEntities())
            {
                var data = (from a in context.Customer_Programs
                            select
                             a).Distinct();

                foreach (var row in data)
                {
                    DataRow dr = dt.NewRow();
                    dr["Customer_ID"] = row.Customer_ID.Value;
                    dr["Customer_Name"] = row.Customer_Name;
                    dr["Program_RunTime"] = row.Program_RunTime;
                    dr["POC"] = row.POC;
                    dr["Executable_Path"] = row.Executable_Path;
                    dr["OutputFiles_Path"] = row.OutputFiles_Path;
                    dr["Comments"] = row.Comments;
                    dt.Rows.Add(dr);
                }
            }

            lvFolderFileNames.DataSource = dt;
            lvFolderFileNames.DataBind();

        }

        protected void btnExceptionDetails_Click(object sender, EventArgs e)
        {
            GetExceptionDetails();
            Page.ClientScript.RegisterStartupScript(this.GetType(), "fnGetExceptionDetails", "fnGetExceptionDetails()", true);
        }

        protected void btnRunProgram_Click(object sender, EventArgs e)
        {
            string runJob = @"\\qahveisweb1\Run_Tasks\GoodYearCOWD\Run_GoodYearCOWD.bat";
            System.Diagnostics.Process.Start(runJob);
            Page.ClientScript.RegisterStartupScript(this.GetType(), "fnRunCustomerProgram", "fnRunCustomerProgram()", true);
        }

        protected void btnViewConfig_Click(object sender, EventArgs e)
        {
            string path = @"C:\UBARS\Main\Source\CustomerFiles\GoodyearCOWD\GoodyearCOWD\App - Copy.config";
            XmlDocument doc = new XmlDocument();
            doc.Load(path);

            tbConfig.Text = File.ReadAllText(path);
            Page.ClientScript.RegisterStartupScript(this.GetType(), "fnViewConfig", "fnViewConfig()", true);
        }
    }
}