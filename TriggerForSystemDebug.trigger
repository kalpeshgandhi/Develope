trigger TriggerForSystemDebug on A__c (after delete, after insert, after undelete, 
after update, before delete, before insert, before update) {
	if(trigger.isBefore )
	{      if(trigger.isInsert)
	       {
		      system.debug('This is a trigeer Fired before insert ');
		      system.debug('Triger.New'+trigger.new);
		      system.debug('Triger.old'+trigger.old);
		      system.debug('Triger.NewMap'+trigger.Newmap);
		      system.debug('Triger.OldMap'+trigger.Oldmap);
	       }
	}
	if(trigger.isAfter)
	{
	     if(trigger.isInsert)
           {
		          system.debug('This is a trigeer Fired After insert ');
		          system.debug('Triger.New'+trigger.new);
		          system.debug('Triger.old'+trigger.old);
	              system.debug('Triger.NewMap'+trigger.Newmap);
		          system.debug('Triger.OldMap'+trigger.Oldmap);
	       }
	}
	if(trigger.isbefore)
	{
	       if( trigger.isUpdate)
	       {
		          system.debug('This is a trigeer Fired before Update ');
		          system.debug('Triger.New'+trigger.new);
		          system.debug('Triger.old'+trigger.old);
		          system.debug('Triger.NewMap'+trigger.Newmap);
		          system.debug('Triger.OldMap'+trigger.Oldmap);
	       }
	}
	if(trigger.isAfter)
	{
	        if(trigger.isUpdate) 
	        {
		          system.debug('This is a trigeer Fired After Update ');
		          system.debug('Triger.New'+trigger.new);
		          system.debug('Triger.old'+trigger.old);
		          system.debug('Triger.NewMap'+trigger.Newmap);
		          system.debug('Triger.OldMap'+trigger.Oldmap);
		    }
	}	    
	if(trigger.isbefore)
	{
	       if(trigger.isdelete)
	       {
		          system.debug('This is a trigeer Fired before delete ');
		          system.debug('Triger.New'+trigger.new);
		          system.debug('Triger.old'+trigger.old);
		          system.debug('Triger.NewMap'+trigger.Newmap);
		          system.debug('Triger.OldMap'+trigger.Oldmap);
	       }
	}
	if(trigger.isAfter)
	{
	       if(trigger.isdelete)
	       {
		      system.debug('This is a trigeer Fired After delete ');
		      system.debug('Triger.New'+trigger.new);
		      system.debug('Triger.old'+trigger.old);
		      system.debug('Triger.NewMap'+trigger.Newmap);
	          system.debug('Triger.OldMap'+trigger.Oldmap);
		      system.debug(trigger.new);
	       }
	}
	if(trigger.isAfter)
	{
	       if(trigger.isUndelete)
	       {
		          system.debug('This is a trigeer Fired After Undelete ');
		          system.debug('Triger.New'+trigger.new);
		          system.debug('Triger.old'+trigger.old);
		          system.debug('Triger.NewMap'+trigger.Newmap);
		          system.debug('Triger.OldMap'+trigger.Oldmap);
		          system.debug(trigger.new);
	       }
	}
}