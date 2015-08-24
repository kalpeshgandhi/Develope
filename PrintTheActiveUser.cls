/**
 * This is a class that will print the active user. It prepares a map 
 * of user Id as a key and User record as a value.
 */
public with sharing class PrintTheActiveUser 
{
   /**
    * Method that query to retrieve/print all active Users. 
    * Prepare a map having user Id as key and user record as value.
    */
    public Map<Id,User> printAllActiveUsers()
    {
        // Queries on user to find the list of users that are active 
        List<User> listOfUser = 
            [
                SELECT 
                    u.Name, 
                    u.Id 
                FROM 
                    User u 
                WHERE 
                    IsActive = true
            ];

        // Instance of a map with Id as a key and user as a value
        Map<Id,User> userMapWithIdAndUser = new map<Id,User>();

        // Iterate over the user
        for(User userInstance : listOfUser )
        {
            // Put the user in the map
            userMapWithIdAndUser.put(userInstance.Id,userInstance);
        }

        // Print the map
        system.debug(userMapWithIdAndUser);
        
        return userMapWithIdAndUser;
    }
}