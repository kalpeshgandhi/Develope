@isTest
private class TestOnCreatingACaseForSalesHeader 
{
        /**
         * This is a Test Method that will give the positive results which will create the data for 
         * the Salesheader and inserts the cases automatically.
         */
        static testMethod void creatingACaseForSalesheaderValidData() 
        {
            // This Creats the Test Data of the Account
            Account accountInstance=new Account(Name='TestAccountData');
            // This Creats the Test Data of the Contact
            Contact contactInstance=new Contact(LastName='TestContactData');
            // Insert The Account Instance.
            insert accountInstance;
            // Insert The Contact Instance.
            insert contactInstance;
            // Inititalize the List of the Sales Header
            List<Sales__c> ListOfSalesHeaderRecord=new  List<Sales__c>();
            // Iterate for 200 Records.
            for(Integer i=0;i<200;i++)
            {
                // Add the elements in the list.
                ListOfSalesHeaderRecord.add(new Sales__c(Status__c = 'Open',Pick_status__c = 'Open',Total_Amount__c= 350,Bill_to_Street__c='Open',Ship_to_Street__c='Close',Bill_to_Customer__c=accountInstance.id,Customer__c=contactInstance.id));
            }
            // Start the Test
            Test.StartTest();
            // Insert The list of Sales header
            insert ListOfSalesHeaderRecord;
            // Stop the Test
            Test.StopTest();
            // Fetch the list of cases where account id and contacts id are equal.
            List<Case> CaseListInstanceAfter=[Select Id 
                                              From Case
                                              Where Accountid= :accountInstance.id AND Contactid= :contactInstance.id];
            // Compare the list size and 200 records
            system.assertequals(200,CaseListInstanceAfter.size());
        }
        
        /**
         * This is a Test Method that will give the Negative results which will create the data for 
         * the Salesheader record but the condition fails thus insert of the cases fails.
         */
        static testMethod void creatingACaseForSalesheaderInValidData() 
        {
            // This Creats the Test Data of the Account
            Account accountInstance=new Account(Name='TestAccountData');
             // This Creats the Test Data of the Contact
            Contact contactInstance=new Contact(LastName='TestContactData');
            // Insert The Account Instance.
            insert accountInstance;
            // Insert The Contact Instance.
            insert contactInstance;
             // Inititalize the List of the Sales Header
            List<Sales__c> ListOfSalesHeaderRecord=new  List<Sales__c>();
             // Iterate for 200 Records.
            for(Integer i=0;i<200;i++)
            {
                 // Add the elements in the list.
                 ListOfSalesHeaderRecord.add(new Sales__c(Status__c = 'Close',Pick_status__c = 'Open',Total_Amount__c= 350,Bill_to_Street__c='Open',Ship_to_Street__c='Close',Bill_to_Customer__c=accountInstance.id,Customer__c=contactInstance.id));
            }
            // Start the Test
            Test.StartTest();
            // Insert The list of Sales header
            insert ListOfSalesHeaderRecord;
            // Stop the Test
            Test.StopTest();
          // Fetch the list of cases where account id and contacts id are equal.
            List<Case> CaseListInstanceAfter=[Select Id 
                                              From Case
                                              Where Accountid= :accountInstance.id AND Contactid= :contactInstance.id];
            // Compare the list size and 0 records
            system.assertequals(0,CaseListInstanceAfter.size());
    }
        
        /**
         * This is a Test Method that will give the Negative results which will create the data for 
         * the Salesheader record but the condition fails thus insert of the cases fails.
         */
        static testMethod void creatingACaseForSalesheaderInValidFieldData() 
        {
            // This Creats the Test Data of the Account
            Account accountInstance=new Account(Name='TestAccountData');
            // This Creats the Test Data of the Contact
            Contact contactInstance=new Contact(LastName='TestContactData');
            // Insert The Account Instance.
            insert accountInstance;
             // Insert The Contact Instance.
            insert contactInstance;
             // Inititalize the List of the Sales Header
            List<Sales__c> ListOfSalesHeaderRecord=new  List<Sales__c>();
            // Iterate for 200 Records.
            for(Integer i=0;i<200;i++)
            {
                // Add the elements in the list.
                ListOfSalesHeaderRecord.add(new Sales__c(Status__c = 'Close',Pick_status__c = 'Open',Total_Amount__c= 350,Bill_to_Street__c='Open',Ship_to_Street__c='Open',Bill_to_Customer__c=accountInstance.id,Customer__c=contactInstance.id));
            }
            // Start the Test
            Test.StartTest();
            // Insert The list of Sales header
            insert ListOfSalesHeaderRecord;
            // Stop the Test
            Test.StopTest();
             // Fetch the list of cases where account id and contacts id are equal.
            List<Case> CaseListInstanceAfter=[Select Id 
                                              From Case
                                              Where Accountid= :accountInstance.id AND Contactid= :contactInstance.id];
             // Compare the list size and 0 records
            system.assertequals(0,CaseListInstanceAfter.size());
    }


}