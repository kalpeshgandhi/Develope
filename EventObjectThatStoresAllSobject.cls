/**
 * This is a class that will generate generic records. The third party system will create events 
 * in a system to create any Sobject’s records. 
 */
public with sharing class EventObjectThatStoresAllSobject implements Database.Batchable<sObject>
,Database.Stateful
{
    
    // Declare the string type of variable query
    public String query = '';
        
    // Create an instance of list of sobject 
    List<Sobject> sobjectList = new List<Sobject>();
        
    // Create an instance of map with string as a key and object as a value
    Map<String, Object> MapOfFieldAndObject = new Map<String, Object>();
        
   /**
    * This is a constructor that is used to fetch the records 
    */
    public EventObjectThatStoresAllSobject()
    {
        
        // Fetches the record from the event object 
        query = 
            'SELECT '
           +'    e.Json_Record__c,'
           +'    e.ObjectType__c,'
           +'    e.Process_Status__c ' 
           +'FROM ' 
           +    'Event__c e ' 
           +'WHERE'
           +    ' e.Process_Status__c = false';
            
    }
        
   /**
    * This is the start method which returns the query.
    */
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
        
        return Database.getQueryLocator(query);
    }
        
   /**
    * This is an execute method where we convert the json object into any sobject type
    * and insert the data.
    */
    public void execute(Database.BatchableContext BC, List<Event__c> eventListInstance)
    {
        
        // Iterate over the instance of the event object.
        for(Event__c eventInstance : eventListInstance)
        {
            
            if((MapOfFieldAndObject = 
                    ( Map<String, Object> )JSON.deserializeUntyped(eventInstance.Json_Record__c)) 
                        != null
            ) 
            {
                
                // Deserializing JSON to get the object in the form of fieldname => value pairs. 
                MapOfFieldAndObject = 
                    (Map<String, Object>)JSON.deserializeUntyped(eventInstance.Json_Record__c); 
                
                // Assign the name of the object to a string.
                String objectName = eventInstance.ObjectType__c;
                
                // Creates an instance of the SObjectType.
                Schema.SObjectType convertInstance = Schema.getGlobalDescribe().get(objectName);
                
                // Create the instance of SObject and type Cast it to desired Object. 
                Sobject genericObject = convertInstance.newSObject();
                
                // Iterate over the key set of map
                for(String fieldInstance : MapOfFieldAndObject.keyset())
                {
    
                    // Add the fields and there values.
                    genericObject.put(fieldInstance,MapOfFieldAndObject.get(fieldInstance));
                
                }// End of for loop
                
                // Add the elements to a list of Sobject.
                sobjectList.add(genericObject);
            
            }// end of if loop
    
        }// End of for Loop
                
        // Save the List using database.insert
        Database.SaveResult[] srList = Database.insert(sobjectList, false);
        
        // Interate over the list of saved results.
        for(Integer i = 0; i < srList.size(); i++)
        {
    
            // Check the instance if successful
            if(srList[i].isSuccess())
            {
    
                // Make the checkBox true
                eventListInstance[i].Process_Status__c = true;
        
            }// End of if loop
        
        }//End of for loop
        
        // Check if the event list is empty or not
        if(!eventListInstance.isEmpty())
        {   
            // Update the event list
            update eventListInstance;
        }
    }
    
   /**
    * This is a Finish method
    */
    public void finish(Database.BatchableContext BC)
    {
        System.debug('Record Saved');
    }
}
