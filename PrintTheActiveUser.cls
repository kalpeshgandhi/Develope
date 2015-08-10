public with sharing class PrintTheActiveUser {

 /**
    * Method that querys to retrieve/print all active Users. 
    * Prepare a Map having User Id as key and User record as value.
    */
      public void printAllActiveUsers()
      {
         // Queries On User To find the List of Users That Are Active 
         List<User> userOfList =[Select u.Name, u.Id 
                                 From User u 
                                 where IsActive=true];
         // Instance of a Map With Id as a key and user as a Value
         Map<Id,User> userMap= new map<Id,User>();
         // Iterate over the User
           for(User userInstance:userOfList )
           {
               // Put the user in the Map
               userMap.put(userInstance.id,userInstance);
           }
           // Print the Map
            system.debug(userMap);
                  /**
                   * SimpleSOQLQuery soqlInstance=new SimpleSOQLQuery();
                   * soqlInstance.printAllActiveUsers();
                   */
    }
    
}