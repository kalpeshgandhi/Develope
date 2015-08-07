public class TrialStatic 
{
   
    //This is a Static Variale.
    public static integer TrialStaticVariable=2;
    //This is a Non Static Variable.
    public integer TrialVariabel=2;
    //This is a Static Method
   /**
    * This is a Static Method that Prints a 
    * static variable,Method and a normal method
    */ 
     public static void trial()
     {
         System.debug('This is a static method');
         System.debug(TrialStaticVariable);
     }
    /**
     * This is a non static Method and 
     * Prints that it is a Non Static Method. 
     */
     public void trial2()
     {
        System.debug('This is a Non static method');
     }
}
/*TrialStatic2 t=new TrialStatic2();
t.Statictry();
*/