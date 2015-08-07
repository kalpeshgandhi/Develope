public class GetAccountRecordsAccordingEnrollmentYear
{
       /**
        * Method that Gets all the Account Record that have Enrolled in Year
        * 1)2010
        * 2)2013,2014 Checks account Enrollment Year in 2010,2013,2014
        */
      public void CheckEnrollmentYear() 
       {
        // This is a List that fetches the Account Records Having Enrollment Year 2010.
        List<Account> accountList =[Select a.Name, a.Id, a.Enrollment_Year__c 
                                    From Account a 
                                    where Enrollment_Year__c 
                                    INCLUDES('2010')]; 
        // This is a List that fetches the Account Records Having Enrollment Year 2013 or 2014.
        List<Account> accountListForTwoYears=[Select a.Name, a.Id, a.Enrollment_Year__c 
                                              From Account a 
                                              where Enrollment_Year__c 
                                              INCLUDES ('2013','2014')];
         
        System.debug(accountList);
        System.debug(accountListForTwoYears);
    }
}