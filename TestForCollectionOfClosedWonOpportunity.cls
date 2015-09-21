/** 
 * This is a test class that will notify primary contact associated with an account all the 
 * closed won opportunities for his account per day.
 */
@isTest
public with sharing class TestForCollectionOfClosedWonOpportunity 
{
    /**
     * This is a test Method in which Primary contact associated with an account needs to 
     * know which all are the closed won opportunities for his account per day. Create a process 
     * which will run everyday in the midnight & collect all the Closed won opportunities of that 
     * account in a day & send an email to Primary Contact. 
     * The email body should contain the Opportunity Name & it's respective amount with the 
     * aggregated amount in the end. 
     */
     static testMethod void testForClosedOpportunityTotalAmount() 
     {
         
         // Create the List of the Account
         List<Account> accountList = new List<Account>();
            
         // Create the List of Opportunity
         List<Opportunity> opportunityList = new List<Opportunity>();
            
         // Iterate Over the 5 Records
         for(Integer i = 0 ; i < 5; i++)
         {
             
            // Creatre the Account tupe of record 
            Account testAccount = new Account(
                Primary_ContactEmail__c = 'test' + i + '@eternussolutions.com',
                Name = 'test'+ i,
                Email_ID__c = 'test' + i + '@eternussolutions.com'
            );
            
            // Add the Record to the List
            accountList.add(testAccount);
            
         }// End of the For Loop
            
         // Fetch all account records
         List<Account> checkAccountList = 
            [
                SELECT 
                    Id
                FROM 
                    Account 
            ];
                
         // Check for the list size
         System.assertEquals(0,checkAccountList.size());
            
         // Insert the Account List
         insert accountList;
            
         // Fetch all account records 
         checkAccountList = 
            [
                SELECT 
                    Id
                FROM 
                    Account 
                WHERE 
                    Name LIKE : 'test%'
                ];
                
            // Check for the list size
            System.assertEquals(5,checkAccountList.size());
            
            // Iterate Over the 5 Records
            for(Integer i = 0; i < 5; i++)
            {  
                
                // Create the record of Type Opportunity
                Opportunity testOpportunityData = new Opportunity
                    (
                        Amount = 30,
                        Name = 'testOpportunity' + i , 
                        CloseDate = (Date)Date.today() , 
                        AccountId = accountList[0].Id,
                        StageName  = 'Closed Won'
                );
                                        
                // Add the Elements to the opportuntiy List
                opportunityList.add(testOpportunityData);
                 
            }// End of the For Loop
            
            // Fetch all opportunity records
            List<Opportunity> checkOpportunityList = 
                [
                    SELECT 
                        Id
                    FROM 
                        Opportunity 
                    WHERE
                       Name LIKE 'testOpportunity%' 
                ];
                
            // Check for the list size
            System.assertEquals(0,checkOpportunityList.size());
            
            // Insert  the opportuntiy List
            insert opportunityList;
            
            // Fetch all opportunity records
            checkOpportunityList = 
                [
                    SELECT 
                        Id,
                        Amount
                    FROM 
                        Opportunity 
                    WHERE
                        Name LIKE 'testOpportunity%'
                ];
                
            // Check for the list size
            System.assertEquals(5,opportunityList.size());
            
            Decimal testAmountOpportunity = 0;
            
            for(Opportunity opportunityInstance : checkOpportunityList)
            {
                
                 testAmountOpportunity = testAmountOpportunity + opportunityInstance.Amount;
            }
            
            // Create an instance of the batch
            CollectionOfClosedWonOpportunities  batchInstance = 
                new CollectionOfClosedWonOpportunities();

            // Start the test
            Test.startTest();
            
            // Execute the Batch
            Database.executeBatch(batchInstance,10); 
             
            // Stop Test
            Test.stopTest();
        
            // Check the final amount of the opportunities  
            System.assertEquals(testAmountOpportunity, 
                CollectionOfClosedWonOpportunities.totalAmount);
     }
     
    /**
     * This is a test method to check if the opportunity stage is open.
     *
     */
     static testMethod void testForOpenOpportunity() 
     {
         
         // Create the List of the Account
         List<Account> accountList = new List<Account>();
            
         // Create the List of Opportunity
         List<Opportunity> opportunityList = new List<Opportunity>();
            
         // Iterate Over the 5 Records
         for(Integer i = 0 ; i < 5; i++)
         {
             
            // Creatre the Account tupe of record 
            Account testAccount = new Account(
                Primary_ContactEmail__c = 'test' + i + '@eternussolutions.com',
                Name = 'test'+ i,
                Email_ID__c = 'test' + i + '@eternussolutions.com'
            );
            
            // Add the Record to the List
            accountList.add(testAccount);
            
         }// End of the For Loop
            
         // Fetch all account records
         List<Account> checkAccountList = 
            [
                SELECT 
                    Id
                FROM 
                    Account 
            ];
                
         // Check for the list size
         System.assertEquals(0,checkAccountList.size());
            
         // Insert the Account List
         insert accountList;
            
         // Fetch all account records 
         checkAccountList = 
            [
                SELECT 
                    Id
                FROM 
                    Account 
                WHERE 
                    Name LIKE : 'test%'
                ];
                
            // Check for the list size
            System.assertEquals(5,checkAccountList.size());
            
            // Iterate Over the 5 Records
            for(Integer i = 0; i < 5; i++)
            {  
                
                // Create the record of Type Opportunity
                Opportunity testOpportunityData = new Opportunity
                    (
                        Amount = 30,
                        Name = 'testOpportunity' + i , 
                        CloseDate = (Date)Date.today() , 
                        AccountId = accountList[i].Id,
                        StageName  = 'Open'
                );
                                        
                // Add the Elements to the opportuntiy List
                opportunityList.add(testOpportunityData);
                 
            }// End of the For Loop
            
            // Fetch all opportunity records
            List<Opportunity> checkOpportunityList = 
                [
                    SELECT 
                        Id
                    FROM 
                        Opportunity 
                    WHERE
                       Name LIKE 'testOpportunity%' 
                ];
                
            // Check for the list size
            System.assertEquals(0,checkOpportunityList.size());
            
            // Insert  the opportuntiy List
            insert opportunityList;
            
            // Fetch all opportunity records
            checkOpportunityList = 
                [
                    SELECT 
                        Id,
                        Amount
                    FROM 
                        Opportunity 
                    WHERE
                        Name LIKE 'testOpportunity%'
                ];
                
            // Check for the list size
            System.assertEquals(5,opportunityList.size());
            
            Decimal testAmountOpportunity = 0;
            
            for(Opportunity opportunityInstance : checkOpportunityList)
            {
                
                 testAmountOpportunity = testAmountOpportunity + opportunityInstance.Amount;
            }
            
            // Create an instance of the batch
            CollectionOfClosedWonOpportunities  batchInstance = 
                new CollectionOfClosedWonOpportunities();

            // Start the test
            Test.startTest();
            
            // Execute the Batch
            Database.executeBatch(batchInstance,10); 
             
            // Stop Test
            Test.stopTest();
        
            // Check the final amount of the opportunities  
            System.assertNotEquals(testAmountOpportunity, 
                CollectionOfClosedWonOpportunities.totalAmount);
     }
     
     /**
     * This is a test method to check if the opportunity stage is open.
     *
     */
     static testMethod void testForClosedOpportunityWithNoPrimaryContact() 
     {
         
         // Create the List of the Account
         List<Account> accountList = new List<Account>();
            
         // Create the List of Opportunity
         List<Opportunity> opportunityList = new List<Opportunity>();
            
         // Iterate Over the 5 Records
         for(Integer i = 0 ; i < 5; i++)
         {
             
            // Creatre the Account tupe of record 
            Account testAccount = new Account(
                Name = 'test'+ i,
                Email_ID__c = 'test' + i + '@eternussolutions.com'
            );
            
            // Add the Record to the List
            accountList.add(testAccount);
            
         }// End of the For Loop
            
         // Fetch all account records
         List<Account> checkAccountList = 
            [
                SELECT 
                    Id
                FROM 
                    Account 
            ];
                
         // Check for the list size
         System.assertEquals(0,checkAccountList.size());
            
         // Insert the Account List
         insert accountList;
            
         // Fetch all account records 
         checkAccountList = 
            [
                SELECT 
                    Id
                FROM 
                    Account 
                WHERE 
                    Name LIKE : 'test%'
                ];
                
            // Check for the list size
            System.assertEquals(5,checkAccountList.size());
            
            // Iterate Over the 5 Records
            for(Integer i = 0; i < 5; i++)
            {  
                
                // Create the record of Type Opportunity
                Opportunity testOpportunityData = new Opportunity
                    (
                        Amount = 30,
                        Name = 'testOpportunity' + i , 
                        CloseDate = (Date)Date.today() , 
                        AccountId = accountList[i].Id,
                        StageName  = 'Open'
                );
                                        
                // Add the Elements to the opportuntiy List
                opportunityList.add(testOpportunityData);
                 
            }// End of the For Loop
            
            // Fetch all opportunity records
            List<Opportunity> checkOpportunityList = 
                [
                    SELECT 
                        Id
                    FROM 
                        Opportunity 
                    WHERE
                       Name LIKE 'testOpportunity%' 
                ];
                
            // Check for the list size
            System.assertEquals(0,checkOpportunityList.size());
            
            // Insert  the opportuntiy List
            insert opportunityList;
            
            // Fetch all opportunity records
            checkOpportunityList = 
                [
                    SELECT 
                        Id,
                        Amount
                    FROM 
                        Opportunity 
                    WHERE
                        Name LIKE 'testOpportunity%'
                ];
                
            // Check for the list size
            System.assertEquals(5,opportunityList.size());
            
            Decimal testAmountOpportunity = 0;
            
            for(Opportunity opportunityInstance : checkOpportunityList)
            {
                
                 testAmountOpportunity = testAmountOpportunity + opportunityInstance.Amount;
            }
            
            // Create an instance of the batch
            CollectionOfClosedWonOpportunities  batchInstance = 
                new CollectionOfClosedWonOpportunities();

            // Start the test
            Test.startTest();
            
            // Execute the Batch
            Database.executeBatch(batchInstance,10); 
             
            // Stop Test
            Test.stopTest();
        
            // Check the final amount of the opportunities  
            System.assertNotEquals(testAmountOpportunity, 
                CollectionOfClosedWonOpportunities.totalAmount);
     }
}