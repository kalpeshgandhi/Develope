/**
 * This is a shedular class that will schedule the batch class for generating the sobject 
 * whenever the event record is inserted.
 */
global with sharing class ScheduleEventEveryThreemins implements Schedulable
{  
    // Create a instance of the integer
    public Integer timer;
    
    /**
     * This is a construtor that will assign the timer value.
     */    
    global ScheduleEventEveryThreeMins (Integer timer)
        {
            this.timer = timer;
        }
    /**
    * This is a execute method that will execute the batch every minute 
    */    
    global void execute(SchedulableContext schedulableInstance) 
    {
        // Create the instance of the time
        Datetime sysTime = System.now().addminutes( timer );      
        
        // Create the crom expression
           String chronExpression = '' + sysTime.second() + ' ' 
               + sysTime.minute() + ' ' + sysTime.hour() + ' ' + sysTime.day() + ' ' 
               + sysTime.month() + ' ? ' + sysTime.year();
        
        // Schedule the batch
        System.schedule( 'SelfSchedule ' + sysTime, chronExpression, 
            new ScheduleEventEveryThreeMins (timer) );
        
        // Create the instance of the class
        EventObjectThatStoresAllSobject eventInstance = new EventObjectThatStoresAllSobject();
        
        // Execute the batch
        Database.executeBatch(eventInstance);
        
        // Abort the batch
        System.abortJob(schedulableInstance.getTriggerId());
    }
}
