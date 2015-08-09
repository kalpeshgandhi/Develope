public with sharing class PrintTheSustringApexProgramming 
{
       /**
        * Method that accepts the String and 
        * Print the SubString Apex Programming.
        */
    public void printThesubString(String givenString)
    {
        List<Integer> indexCharArray=new List<Integer>();
        // Extract Single element in Character Array.
        indexCharArray=givenString.getchars();
        // Instantiate the list of Integer.
        List<Integer> SubstringIndexChar=new List<Integer>();
        // Instantiate the list of Integer.
        List<Integer> AddIndexChar=new List<Integer>();
        // Given Substring.
        String Substring='Apex Programming';
        // Extract Single element in Character Array.
        SubstringIndexChar=Substring.getchars();
       /* // Start For Loop
        for(Integer j=1;j<SubstringIndexChar.size();j++)
        {
            // Start Other For Loop
            for(integer i=1;i<indexCharArray.size();i++)
            {
              // Checks for Avaibility of the subString in the given String 
              if(indexCharArray.get(i-1)==SubstringIndexChar.get(j-1) && 
                 indexCharArray.get(i)==SubstringIndexChar.get(j))
                 {
                     // Add the Substring Elements
                  AddIndexChar.add(SubstringIndexChar.get(j-1));
                 }
                 // End of if loop
            }
            // End of inner for loop
        }
        // End of outer for loop*/
        // Intialize the i,jth Values to 0.
        Integer j=0,i=0;
        // Iterate Till the Size of the Given String And SubString.
        while(j<SubstringIndexChar.size() && i<indexCharArray.size())
          {
              // Check for each Character In the List if True Add it to the List.
              if(SubstringIndexChar.get(j)== indexCharArray.get(i))
               {
                     // Add Elements to the Result List.
                      AddIndexChar.add(SubstringIndexChar.get(j));
                      // Increment the jth Value.
                      j++;
                      // Increment the ith Value.
                      i++;
               }// End of if Loop
               else if(i==indexCharArray.size())
               {
                    // Clear the List if Given string is traversed till the last Element.
                     AddIndexChar.clear();
                     // Break the loop.
                     break;
               }
               else
               {
                      AddIndexChar.clear();
                      // Initialize to the first element of Substring.
                      j=0;
                      // Increment to the next Element.
                      i++;
               } // End of else.
          }// End of while loop.
          // Check Whether the SubString is equal to the Added String.
          if(SubstringIndexChar.size()== AddIndexChar.size())
          {
              //Extract char from List.
                String subStringAnswer=String.fromCharArray(AddIndexChar);
                // Print the String.
                System.debug(subStringAnswer);
          }
    } 
    /*
    * PrintTheSustringApexProgramming StringInstance=new PrintTheSustringApexProgramming();
    * StringInstance.printThesubString('Welcome to Apex Programming');
    */
}