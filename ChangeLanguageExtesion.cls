public with sharing class ChangeLanguageExtesion 
{
    // This is a Private Variable that Creats a Instance of the Student.
    private Student__c StudentInstance{get;set;}
    // This is a Public Variable that Saves the Selected Language.
    public String selectedLanguageOption{get;set;}
    // This is a List that Adds the Language to a Picklist.
    public List<SelectOption> languageList;
   
    // This is a Constructer that creates a instance of the Student.
    public ChangeLanguageExtesion(ApexPages.StandardController StandardControllerExtension) 
    {
        this.StudentInstance = (Student__c)StandardControllerExtension.getRecord();
    }
    /*
    * This is a getter for a list that will add elements to the Picklist.
    */     
    public List<SelectOption> getlanguageList()
    {
                  // Intantiate the List of Select Options.
                  List<SelectOption> listLanguageInstance = new List<SelectOption>();
                  // Adds the languages to the List.
                  listLanguageInstance.add(new SelectOption('en_US','English'));
                  listLanguageInstance.add(new SelectOption('fr','French'));
                  listLanguageInstance.add(new SelectOption('es','Spanish'));
                  // Returns the list
                  return listLanguageInstance;
    }
    
    /*
     * This method is used to Override the Save Method and to pop up with the message.
     */
    public PageReference Save()
    {
             // Insert the Student Instance
             insert StudentInstance;
             // Add a message  that  will show that the Record is been Saved.
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.info, System.Label.MessageErrorLabel));
             return Null;
    }
}