public with sharing class CountOfOccurances {
      /**
       * Accept a string as a parameter And 
       * count the occurrence of every character in it
       */
    public void countOfOccuranceOfWord(String givenString)
      {
       // Copy Given String in the New String
       String stringInstance = givenString;
       // Using Split the String And save It in the String Array 
       String[] stringArray=stringInstance.split('');
       // Instantiate The New Map
       Map<String,Integer> mapOccuranceInstacne = new map<String,Integer>();
       // Start of for loop
       for(Integer i=1; i<=stringInstance.length();i++)
       {
           // Checks the map Doesnt Contains the key
           if(!mapOccuranceInstacne.containsKey(stringArray[i]))
           {
               // Add the element if first time Occured
               mapOccuranceInstacne.put(stringArray[i],1);
           }
           // For second time occurance
           else
           {
               // Increment the No of Instances.
               mapOccuranceInstacne.put(stringArray[i], mapOccuranceInstacne.get(stringArray[i])+1);
           }
       }
       system.debug(mapOccuranceInstacne);
   }
}