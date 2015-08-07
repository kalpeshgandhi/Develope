public with sharing class ConvertToLowerCaseAndPrint {
    /**
     * Method that accepts the String and 
     * Converts the Lower Case to Upper Case Apex Programming.
     */
        public String convertToLower(String givenString)
        {
        // Instantiate the list of Integer
        List<Integer> indexCharArray=new List<Integer>();
        // Extract Single element in Character Array
        indexCharArray=givenString.getchars();
        // Instantiate the list of Integer
        List<Integer> listToLower=new List<Integer>();
        // for loop Starts
        for(integer i=0;i<indexCharArray.size();i++)
         { 
             if(indexCharArray.get(i)==32)
             {
                // If Space found add space
                listToLower.add(32);
             }
             else if(indexCharArray.get(i) > 96 && indexCharArray.get(i) < 123)
             {
                 listToLower.add(indexCharArray.get(i));
             }
             else
             {
                 // Add 32 as A=65 and a=97
                 listToLower.add(indexCharArray.get(i)+32);
              }
         }
         // Extract the Char from Char Array
         String LowerCaseString=String.fromCharArray(listToLower);
         System.debug(LowerCaseString);
         return LowerCaseString;
    }
    /**
    * ConvertToLowerCaseAndPrint stringInstance=new ConvertToLowerCaseAndPrint();
    * stringInstance.convertToLower('WELCOME TO APEX PROGRAMMING');
    */
}