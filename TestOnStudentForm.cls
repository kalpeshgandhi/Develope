/**
 * This is a class that will test the functionality of change in language will change the labels in 
 * that language respectively.
 */
@isTest
private class TestOnStudentForm 
{
   /**
    * This is a test method that saves records to the database.
    */
    public static testMethod void testForSavingRecord()
    {   
        
        // Creates the refrence to the student registration form. 
        PageReference studentVfPage = Page.StudentRegistrationForm;
        
        // Set the current page as student registration.
        Test.setCurrentPage(studentVfPage);
        
        // Create an instance of the student
        Student__c studentInstance = new Student__c();
        
        // Insert the student data
        studentInstance.name='testStudentData';
        
        // Create the refrence of the current student page.
        ApexPages.StandardController standardControllerInstance = 
            new ApexPages.StandardController(studentInstance);
        
        // Create an Instance of the controller.
        ChangeLanguageExtesion  controllerInstance = 
            new ChangeLanguageExtesion(standardControllerInstance);
        
        // Start the test
        Test.StartTest();
        
        // Calls the method of the controller.
        controllerInstance.Save();
        
        // Stop the test
        Test.StopTest();
        
        // Creates an instance of the student list
        List<Student__c> listStudentInstance = new List<Student__c>();
        
        // Fetch All the records of the student where name is testStudent data.
        listStudentInstance = 
            [
                SELECT 
                    Id 
                FROM 
                    Student__c 
                WHERE 
                    Name = 'testStudentData'
             ];
        
        // Check the actual value and expected value. 
        System.assertEquals(1,listStudentInstance.size());
    }
    
   /**
    * This is a test method that fetches all the language in the picklist.
    */
    public static testMethod void testgetlanguageOptionList()
    {
        
        // Creates the refrence to the student registration form. 
        PageReference studentVfPage = Page.StudentRegistrationForm;
          
        // Set the current page as student registration.
        Test.setCurrentPage(studentVfPage);
          
        // Insert the student data
        Student__c studentInstance = new Student__c();
        
        // Intantiate the list of language
        List<Language__c> listLanguageInstance = new List<Language__c>();
        
        // Create test language data. 
        Language__c languageInstance = new Language__c(Name= 'English',Code__c = 'en_US');
        Language__c languageInstance2 = new Language__c(Name= 'French',Code__c = 'fr');
        Language__c languageInstance3 = new Language__c(Name= 'Spanish',Code__c = 'es');
         
         // Add the elements to the list.
         listLanguageInstance.add(languageInstance);
         listLanguageInstance.add(languageInstance2);
         listLanguageInstance.add(languageInstance3);
         
         // Fetch the list of all the country
         List<Language__c> checkLanguageList = 
            [
                SELECT
                    Id
                FROM
                    Language__c
            ];
         
                  
         // Check the list size.
         System.assertEquals(0,checkLanguageList.size()); 

         insert listLanguageInstance;
        
         // Fetch the list of all the country
         checkLanguageList = 
            [
                SELECT
                    Id
                FROM
                    Language__c
            ];
         
         // Check the list size.
         System.assertEquals(3,checkLanguageList.size()); 
         
        // Create the refrence of the current student page.
        studentInstance.name='testStudentData';
        
        // Create the refrence of the current student page.
        ApexPAges.StandardController standardControllerInstance = 
            new ApexPages.StandardController(studentInstance);
        
        // Create an instance of the controller.
        ChangeLanguageExtesion  controllerInstance = 
            new ChangeLanguageExtesion(standardControllerInstance);
        
        // Create a list of select options
        List<SelectOption> selectOptionInstance = new List<SelectOption>();
        
        // Start the test
        Test.startTest();
        
        // Calls the method of the controller.
        selectOptionInstance = controllerInstance.getlanguageList();
        
        // Stop the test
        Test.stopTest();
        
        // Checks the asserts
        System.assertEquals(3,selectOptionInstance.size()); 
    }
}