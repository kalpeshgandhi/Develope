public with sharing class SplitTheStringUsingSpaceAndPrint 
{
   public void splitTheString(String givenString)
    {
        /**
        * Method that accepts the String and 
        * Split the String And Print the String.
        */
        //Instantiate the list of Integer
        List<Integer> indexCharArray=new List<Integer>();
        //Extract Single element in Character Array
        indexCharArray=givenString.getchars();
        //Instantiate the list of Integer
        List<Integer> splitIndexChar=new List<Integer>();
        //For loop Starts
        for(integer i=0;i<indexCharArray.size();i++)
         {
             //Add ith Integer to the list
             splitIndexChar.add(indexCharArray.get(i));
             //32 is a Representation of the WhiteSpace.
             splitIndexChar.add(32);
         }
         String SplitString=String.fromCharArray(splitIndexChar);
         //Extract char from List.
         System.debug(SplitString);
    }
    /**
    * StringOperations StringInstance=new StringOperations();
    * StringInstance.splitTheString('Welcome to @pex Programming');
    */
    
    public String splitTheStringTrial(String givenString)
    {
        /**
        * Method that accepts the String and 
        * Split the String And Print the String.
        */
        //Instantiate the list of Integer
        List<Integer> indexCharArray=new List<Integer>();
        //Extract Single element in Character Array
        indexCharArray=givenString.getchars();
        //Instantiate the list of Integer
        List<Integer> splitIndexChar=new List<Integer>();
        for(integer i=0;i<indexCharArray.size();i++)
         {   //Ascii value 32 returns Space
             if(indexCharArray.get(i)<>32)
             {
                 //Add ith Integer to the list
                 splitIndexChar.add(indexCharArray.get(i));
             }
             else
             {
                 //Ascii value 10 returns new Line
                 splitIndexChar.add(10);
             }
         }
         //Extract char from List.
         String SplitString=String.fromCharArray(splitIndexChar);
         System.debug(SplitString);
         return SplitString;
    }
    /**
    * SplitTheStringUsingSpaceAndPrint stringInstance=new SplitTheStringUsingSpaceAndPrint();
    * stringInstance.splitTheStringTrial('Welcome to Apex Programming');
    */
}