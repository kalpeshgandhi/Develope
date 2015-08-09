public with sharing class ConvertTheStringToUpperCaseAndPrint {
    /**
     * Method that accepts the String and 
     * Converts the Upper Case to lower Case Apex Programming.
     */
    
    public String convertToUpper(String givenString)
    {
        // Instantiate the list of Integer
        List<Integer> indexCharArray=new List<Integer>();
        // Extract Single element in Character Array
        indexCharArray=givenString.getchars();
        // Instantiate the list of Integer
        List<Integer> listToUpper=new List<Integer>();
        // for loop Starts
        for(integer i=0;i<indexCharArray.size();i++)
         {
             if(indexCharArray.get(i)-32 == 0 )
             {
               //If Space found add space
                listToUpper.add(32);
             }
             else if(indexCharArray.get(i)>65 && indexCharArray.get(i)<91 )
             {
                 listToUpper.add(indexCharArray.get(i));
             }
             else
             {
                 // Substract 32 as A=65 and a=97
                 listToUpper.add(indexCharArray.get(i)-32);
             }
            
         }
         // Extract the Char from Char Array
         String UpperCaseString=String.fromCharArray(listToUpper);
         System.debug(UpperCaseString);
         return UpperCaseString;
    }
  /**
  * ConvertTheStringToUpperCaseAndPrint StringInstance=new ConvertTheStringToUpperCaseAndPrint();
  * StringInstance.convertToUpper('welcome to apex programming');
  *
  */
}