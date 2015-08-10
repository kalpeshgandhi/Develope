@isTest
private class TestOnStudentForm {
   
   /**
    * This is a Test Method that saves Records to the database.
    */
   public static testMethod void testToGetRecordSave()
    {   
        // Creates the Refrence to the Studen Registration Form. 
        PageReference studentVfPage = Page.StudentRegistrationForm;
        // Set the Current Page As Student Registration.
        Test.setCurrentPage(studentVfPage);
        // Create an Instance of the Student
        Student__c studentInstance = new Student__c();
        // Insert the Stdent Data
        studentInstance.name='testStudentData';
        // Create the Refrence of the current student page.
        ApexPages.StandardController scinstance = new ApexPages.StandardController(studentInstance);
        // Create an Instance of the Controller.
        ChangeLanguageExtesion  controllerInstance = new ChangeLanguageExtesion(scinstance);
        // Calls the Method of the Controller.
        controllerInstance.Save();
        // Creates an instance of the Student List
        List<Student__c> listStudentInstance = new List<Student__c>();
        // Fetch All the records of the Student where name is TestStudent Data.
        listStudentInstance = [Select id 
                              From Student__c 
                              where Name = 'testStudentData'];
        // Check the actual Value and expected Value. 
        system.assertEquals(1,listStudentInstance.size());
    }
    
    /**
     * This is a Test Method that Fetches all the language in the Picklist.
     */
    public static testMethod void testgetlanguageOptionList()
    {
          // Creates the Refrence to the Studen Registration Form. 
          PageReference studentVfPage = Page.StudentRegistrationForm;
          // Set the Current Page As Student Registration.
          Test.setCurrentPage(studentVfPage);
          // Insert the Stdent Data
          Student__c studentInstance = new Student__c();
          // Create the Refrence of the current student page.
          studentInstance.name='testStudentData';
          // Create the Refrence of the current student page.
          ApexPAges.StandardController scinstance = new ApexPages.StandardController(studentInstance);
          // Create an Instance of the Controller.
          ChangeLanguageExtesion  controllerInstance = new ChangeLanguageExtesion(scinstance);
          // Create a List of Select Options
          List<SelectOption> selectOptionInstance = new List<SelectOption>();
          // Calls the Method of the Controller.
          selectOptionInstance = controllerInstance.getlanguageList();
          // Checks the Asserts
          System.assertEquals(3,selectOptionInstance.size()); 
    }
}