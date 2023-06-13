using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace cpuframework
{
    public class CPUException: Exception
    {
        public CPUException(string ErrorMessage): base(ErrorMessage)
        {

        }
    }
}
