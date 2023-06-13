update DevSubSection
set vchProgrammingCode = '
    public class CPUException: Exception
    {
        public CPUException(string ErrorMessage): base(ErrorMessage)
        {

        }
    }
'
where vchDevSubSectionCode = 'cpuexception'