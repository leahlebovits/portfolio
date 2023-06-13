using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace cpuframework
{
    public static class CPUWebUtility
    {
        public const string KeyUserId = "key_userid";
        public const string KeyUserName = "key_username";
        public const string KeyRoleValue = "key_rolevalue";

        public static bool IsAuthorized(bizRole.RoleEnum RoleValue)
        {
            bool auth = false;

            if (HttpContext.Current.Session[CPUWebUtility.KeyRoleValue] != null)
            {
                bizRole.RoleEnum n = (bizRole.RoleEnum)HttpContext.Current.Session[CPUWebUtility.KeyRoleValue];
                if (n >= RoleValue)
                {
                    auth = true;
                }
            }
            return auth;
        }
        public static void CheckAuthorized(bizRole.RoleEnum RoleValue)
        {
            bool auth = IsAuthorized(RoleValue);

            if (auth == false)
            {
                RedirectToLogin();
            }
        }
        private static void RedirectToLogin()
        {
            HttpContext.Current.Response.Redirect("~/User/Index");
        }
    }
}
