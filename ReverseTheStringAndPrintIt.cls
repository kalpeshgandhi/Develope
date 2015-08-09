public with sharing class ReverseTheStringAndPrintIt {
      /** 
       * Method that accepts the String and 
       * Print the Reverse of the String.
       */
 
 public String reverseString(String givenString)
       {
      
         // Instantiate the list of Integer
         List<Integer> indexCharArray=new List<Integer>();
         // Instantiate the list of Integer
         List<Integer> reverseIndexCharArray=new List<Integer>();
         // Extract Single element in Character Array
         indexCharArray=givenString.getchars();
         // Start for loop
         for(integer i=indexCharArray.size()-1;i>=0;i--)
         {
             // Add Integer in reverse order in the list
             reverseIndexCharArray.add(indexCharArray.get(i));
         }
         // Extract char from List.
         String reverseString=String.fromCharArray(reverseIndexCharArray);
         system.debug('Reverse of string is :'+reverseString);
         return reverseString;
       }
        /**
        * ReverseTheStringAndPrintIt StringInstance=new ReverseTheStringAndPrintIt();
        * StringInstance.reverseString('Welcome to Apex Programming');
        */
}