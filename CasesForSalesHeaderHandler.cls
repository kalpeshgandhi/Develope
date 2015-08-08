public with sharing class CasesForSalesHeaderHandler {
    /**
    * Create the Case Whenever the Following conditions are met
    * On Insert or update of a SalesHeader__c, if 
    * SalesHeader__c.Status__c = “Open”
    * SalesHeader__c.Pick_Status__c = “Open”
    * SalesHeader__c.Total_Amount__c > 300
    * create a case when this condition are met
    * SalesHeader__c.Bill_to_Street__c <> SalesHeader__c.Ship_to_Street__c, OR  
    * SalesHeader__c.Bill_to_City__c <> SalesHeader__c.Ship_to_City__c; OR
    * SalesHeader__c.Bill_to_Postal_Code__c <> SalesHeader__c.Ship_to_Postal_Code__c; OR
    * SalesHeader__c.Bill_to_State__c <> SalesHeader__c.Ship_to_State__c )
    */
     public static void createCase(List<Sales__c> salesheaderListInstance)
     {
        // Create a Instance of New List of type Case 
        List<Case> caseInstance =new List<Case>();
        // Iterate over the List of SalesHeader(Trigger.New)   
        for(Sales__c salesheaderList :salesheaderListInstance)
          {
            // Check for all the condition Specified in the Question
            if(salesheaderList.Status__c == 'Open' && salesheaderList.Pick_status__c == 'Open' &&  salesheaderList.Total_Amount__c> 300 && (salesheaderList.Bill_to_Street__c <> salesheaderList.Ship_to_Street__c || salesheaderList.Bill_to_City__c <>salesheaderList.Ship_to_City__c ||
                salesheaderList.Bill_to_PostCode__c <> salesheaderList.Ship_to_PostalCode__c ||
                salesheaderList.Bill_to_State__c <> salesheaderList.Ship_to_State__c ))
                 {
                    // Create a New Instance of case object
                    Case caseObjects= new Case();
                    // Assign A Account Id Using the Bill_to_Customer__c field
                    caseObjects.AccountId = salesheaderList.Bill_to_Customer__c;
                    // Assign A Contact Id Using the Customer__c field
                    caseObjects.ContactId = salesheaderList.Customer__c;     
                    //caseObjects.RecordTypeName = 'Assignment';
                    // Assign a Origin Value to web
                    caseObjects.Origin = 'Web'; 
                    //cs.OwnerId = '00G28000000ZPDu';
                    // Assigns the Reason as Feedback
                    caseObjects.Reason = 'Feadback'; 
                    // Assigns the Priority as Medium
                    caseObjects.Priority = 'Medium';
                    // Assign the Status as New
                   caseObjects.Status = 'New'; 
                   //caseObject.Type='Mechanical';
                   //caseObjects.Subject= cs.Account.Name + ' ' + cs.Type;
                    //cs.Open_Sales_Order__c= Sales__c.Id;
                    //cs.Transaction_Status__c=T.Transaction_Status__c;
                   // cs.Sales_Order_Name__c= Sales__c.Name;
                   // Add the values to the list of the case Object. 
                    caseInstance.add(caseObjects); 
                  }// End of if loop
            }// End of For Loop
       // Insert The list of the Case.
       insert caseInstance;
    }
    
}