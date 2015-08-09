public with sharing class ReplaceAtTheRateWithAAndPrintString {
   /**
    * Method that accepts the String and 
    * Replaces @ with A.
    */
   
   public String replaceAtTheRateWithA(String givenString)
    {
        // Instantiate the list of Integer
        List<Integer> indexCharArray=new List<Integer>();
        // Extract Single element in Character Array
        indexCharArray=givenString.getchars();
        // Instantiate the list of Integer
        List<Integer> replaceIndexOfA=new List<Integer>();
        // Start for loop
        for(integer i=0;i<indexCharArray.size();i++)
         {
             // Check Ascii Value is 64 as @ has ASCII Value as 64
             if(indexCharArray.get(i)==64) 
             {
                 // Add A istead of @in the list.
                 replaceIndexOfA.add(65);
             }
             else
             {
                 // Add ith Integer to the list
                 replaceIndexOfA.add(indexCharArray.get(i));
             }
         }
         // Extract char from List.
         String replaceA=String.fromCharArray(replaceIndexOfA);
         System.debug(replaceA);
         return replaceA;
    }
    /**
    * ReplaceAtTheRateWithAAndPrintString StringInstance=new ReplaceAtTheRateWithAAndPrintString();
    * StringInstance.replaceAtTheRateWithA('Welcome to @pex Programming');
    */
}