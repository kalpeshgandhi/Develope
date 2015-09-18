
global with sharing class ScheduleEventEveryThreemins implements Schedulable
{  
    public Integer timer;
       global ScheduleEventEveryThreeMins (Integer timer)
                        {
                            this.timer= timer;
                        }
    global void execute(SchedulableContext schedulableInstance) 
    {
           Datetime sysTime = System.now().addminutes( timer );      
           String chronExpression = '' + sysTime.second() + ' ' + sysTime.minute() + ' ' + sysTime.hour() + ' ' + sysTime.day() + ' ' + sysTime.month() + ' ? ' + sysTime.year();
           System.schedule( 'SelfSchedule ' + sysTime, chronExpression, new ScheduleEventEveryThreeMins (timer) );
           EventObjectThatStoresAllSobject eventInstance=new EventObjectThatStoresAllSobject();
           Database.executeBatch(eventInstance);
           System.abortJob(schedulableInstance.getTriggerId());
    }
}