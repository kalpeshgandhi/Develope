/**
 * This is a class that will change the labels of the form as per the language selected.
 */
public with sharing class ChangeLanguageExtesion 
{
    
    // This is a private variable that creats a instance of the student.
    private Student__c studentInstance{get;set;}
    
    // This is a public variable that saves the selected language.
    public String selectedLanguageOption{get;set;}
    
    // This is a list that adds the language to a picklist.
    public List<SelectOption> languageList;
   
    // This is a constructer that creates a instance of the student.
    public ChangeLanguageExtesion(ApexPages.StandardController StandardControllerExtension) 
    {
        
        this.studentInstance = (Student__c)StandardControllerExtension.getRecord();
    }
    
   /**
    * This is a getter for a list that will add elements to the picklist.
    */     
    public List<SelectOption> getlanguageList()
    {
        // Intantiate the list of select options.
        List<SelectOption> listLanguageInstance = new List<SelectOption>();

        // Adds the languages to the list.
        for (Language__c languageInstance : Language__c.getAll().Values()) 
        {
            listLanguageInstance.add(new SelectOption(
                languageInstance.Code__c, languageInstance.Name)
            );
        }
        
        // Sort the list
        listLanguageInstance.sort();
        
        // Return the list
        return listLanguageInstance;
    }
    
   /**
    * This method is used to override the save method and to pop up with the message.
    */
    public PageReference Save()
    {
        try
        {
            
            // Insert the student instance
            insert studentInstance;
        }
        catch(Exception e)
        {
            
            System.debug(e);
        }
        
        // Add a message  that  will show that the record is been saved.
        ApexPages.addmessage(new ApexPages.message(
            ApexPages.severity.info, System.Label.MessageErrorLabel)
        );
        
        studentInstance.clear();
        
        return null;
    }
}