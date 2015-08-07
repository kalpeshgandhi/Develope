public with sharing class PrintTheFibonacciSeries {

    /**
     * Method that accepts the Integr as a Parameter and 
     * prints the fibonasi series.
     */
 public void fibonasi(Integer n)
     {
        // Creating a Instance Of Array Of Integer 
        Integer[] fibonasiInteger=new Integer[n];
        // Initialize first element to 0.
        fibonasiInteger[0]=0;
        // Initialize first element to 1.
        fibonasiInteger[1]=1;
        // Eterate Over The fibonasiInteger to calculate Fibonasi Series
        for(Integer i=2;i<n;i++)
        {
            fibonasiInteger[i]=fibonasiInteger[i-1]+fibonasiInteger[i-2];
        }
        // End of for loop
        // Start for loop to Print the Array.
        for(Integer i=0;i<n;i++)
        {
            System.debug(fibonasiInteger[i]);// Print the Fibonasi series
        }
    }
     /**
     * PrintTheFibonacciSeries StringInstance=new PrintTheFibonacciSeries();
     * StringInstance.fibonasi(15);
     */
     
}