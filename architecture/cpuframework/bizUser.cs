using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.ComponentModel.DataAnnotations;

namespace cpuframework
{
    public class bizUser : bizObject
    {
        public enum FieldEnum { iUserId, vchUserName, vchPassword, iRole, vchEmail, vchFirstName, vchLastName }
        public bizUser() : base("User",true,true,false)
        {

        }
        public string UserName
        {
            get
            { return this.GetFieldValueAsString(FieldEnum.vchUserName.ToString()); }
            set
            { this.SetFieldValueAsString(FieldEnum.vchUserName.ToString(), value); }
        }

        public string Password
        { get; set; }

        public bizRole.RoleEnum Role { get { return (bizRole.RoleEnum)this.GetFieldValueAsInt(FieldEnum.iRole.ToString()); } }

        public void Login(string UserNameVal, string Passwordval)
        {
            using (SqlCommand cmd = SQLUtility.GetCommand("UserLoginGet"))
            {
                cmd.Parameters["@vchUserName"].Value = UserNameVal;
                cmd.Parameters["@vchPassword"].Value = Passwordval;
                DataTable dt = SQLUtility.GetDataTable(cmd);
                this.Load((int)dt.Rows[0]["iUserId"]);
       
            }
        }
        public string FirstName
        {
            get
            {
                return this.GetFieldValueAsString(FieldEnum.vchFirstName.ToString());
            }
            set
            {
                TableObject.Rows[0][FieldEnum.vchFirstName.ToString()] = value;
            }
        }
        public string LastName
        {
            get
            {
                return this.GetFieldValueAsString(FieldEnum.vchLastName.ToString());
            }
            set
            {
                TableObject.Rows[0][FieldEnum.vchLastName.ToString()] = value;
            }
        }
        public string Email
        {
            get
            {
                return this.GetFieldValueAsString(FieldEnum.vchEmail.ToString());
            }
            set
            {
                TableObject.Rows[0][FieldEnum.vchEmail.ToString()] = value;
            }
        }
    }
}
