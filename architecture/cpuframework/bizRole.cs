using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace cpuframework
{
    public class bizRole : bizObject
    {
        public enum RoleEnum { External = 1, Internal = 2, Admin = 3, None }
        public enum FieldEnum { iRoleId, vchRoleName }
        public bizRole() : base("Role")
        {

        }

        public int Role
        {
            get
            {
                return this.GetFieldValueAsInt(FieldEnum.iRoleId.ToString());
            }

        }
        public string RoleName
        {
            get { return this.GetFieldValueAsString(FieldEnum.vchRoleName.ToString()); }
        }

    }
}
            