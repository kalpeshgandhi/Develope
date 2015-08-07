public class TrialStatic2{
    /**
     * This Method calls the static method of a class.
     * And also it calls the non static method of other class.
     */
    public void Statictry()
    {
         // Print this is a Non static Method
         System.debug('this is called from non static class');
         // Calls a Static method
         TrialStatic.trial();
         // Create a Instance of Class
         TrialStatic instanceTrial=new TrialStatic();
         // Calls a Non Static Method.
         instanceTrial.trial2();
    }
}