/**
 * This is a method that will search a record from multiple objects and 
 * multiple fields using the sosl query. 
 *
 */
public with sharing class DynamicSoslClass
{
    // Get all the information about the objects in the Map
    Map<String, Schema.SObjectType> mapOfObject = Schema.getGlobalDescribe();

    // This is a List of string used to save the selected object
    public String selectedObject {get; set;}

    // This is a string variable used to save the selected fields
    public List<String> orderbyselectedField {get; set;}

    // This is a string variable used to save the selected fields
    public List<String> selectedField {get; set;}

    // This is a string variable used to save the selected fields
    public List<String> multiSelected {get; set;}

    // List of select option used to save the fields
    public List<SelectOption> nameOfFields {get; set;}

    // List of select option used to save the fields
    public List<SelectOption> listOfOrderByFields {get; set;}

    // List of select option used to save the fields
    public List<SelectOption> multiSelectdFields {get; set;}

    // Set of strings used to save the field name
    public Set<String> nameOfSelectedFields {get; set;}

    // Set of strings used to save the field name
    public Set<String> orderBySetFields {get; set;}

    // Set of strings used to save the field name
    public Set<String> nameOfMultiSelectedFields {get;set;}

    // Used to set the radio button for order
    public String selectedRadio {get; set;}

    // Used for accepting the input String
    public String inputSearch {get; set;}

    // Set the limit of the query
    public String selectedNumber {get; set;}

    // This is a string that stores the query
    public String dynamicQuery {get; set;}

    // Saves the result fetched from sosl query
    public List<List<SObject>> searchList {get; set;}

    // Create the map of string as a key and a set of string as value
    public Map<String,Set<String>> mapWithObjectAndSelectedField {get; set;}

    // Create the map of schema.sobjecttype as a key and a wrapper as value
    public Map<Schema.SObjectType , WrapperForObjectNameFieldListAndRecords> mapWithObjectAndWrapper {get; set;}

    // This is a boolean variable which is used to render the page message
    public Boolean renderValue {get; set;}

    // This is a boolean variable which is used to render the buttons
    public Boolean renderaddValue {get; set;}

    //****** public List<wrapperForSearchResult> searchResultsInstance{get;set;}

    // This is a list of wrapper
    public List<WrapperForObjectNameFieldListAndRecords> searchResultsInstance {get; set;}

    // This is a list that will display the field name.
    public List<String> fieldName {get; set;}

   /**
    * This is a Constructor that will be called when ever the page is reloaded
    */
    public  DynamicSoslClass()
    {
        // Set the default value as Ascending
        selectedRadio = 'ASC';

        // Set the default value as 500
        selectedNumber = '500';

        // Set the default value as none
        selectedObject ='None';

        // Create the instance of list of string
        selectedField = new List<String>();

        // Create the instance of list of list of sobject
        searchList = new List<List<SObject>>();

        // Create the instance of list of string
        multiSelected = new List<String>();

        // Create the instance of list of string
        orderbyselectedField = new List<String>();

        // Create the instance of set of string
        nameOfMultiSelectedFields = new Set<String>();

        // Create the instance of set of string
        nameOfSelectedFields = new Set<String>();

        // Create the instance of set of string
        orderBySetFields = new Set<String>();

        // Create the instance the set of string
        nameOfMultiSelectedFields = new Set<String>();

        // Create the instance the set of string
        multiSelectdFields = new List<SelectOption>();

        // Create the instance the set of string
        nameOfFields = new List<SelectOption>();

        // mapWithObjectAndSelectedField= new Map<String,Set<String>>();

        // Create the instance the list of string
        fieldName = new List<String>();

        // Create the instance of the map with sobjectType as a key and wrapper as a key.
        mapWithObjectAndWrapper = 
            new Map<Schema.SObjectType , WrapperForObjectNameFieldListAndRecords>();

        // Create the instance of list of wrapper
        searchResultsInstance = new List<WrapperForObjectNameFieldListAndRecords>();

        // Make the default value as false
        renderValue = false;

        // Make the default value as true
        renderaddValue = true;

        // Create the instance of the wrapper
        WrapperForObjectNameFieldListAndRecords wrapperQueryInstance = 
                new WrapperForObjectNameFieldListAndRecords();

        // Create the instance of the list of select option
        listOfOrderByFields = new List<SelectOption>();
    }

   /**
    * This is a getter that will fetch all the objects and returns the list of the objects.
    */
    public List<SelectOption> getListOfObject()
    {
        // Create the instance of the List of select option
        List<SelectOption> objectList = new List<SelectOption>();

        // Copy all the object from a keyset of map into a list
        List<String> objectNames = new List<String>();

        for(String objectNameInstance : mapOfObject.keySet())
        {
           if(mapOfObject.get(objectNameInstance).getDescribe().isSearchable() == true)
           {
               //objectNames.add(mapOfObject.get(objectNameInstance).getDescribe().getLabel());
               objectNames.add(objectNameInstance);
           }
        }// End of for loop

        // Sort the List
        objectNames.sort();

        // Add by default None Value
        objectList.add(new SelectOption('None','None'));

        // Iterate over the object list
        for(String objectnameInstance : objectNames)
        {
            // Add the elements to the list
            objectList.add(new SelectOption(objectnameInstance,objectnameInstance));
        }// End of for loop

        // Return the list of object 
        return objectList;
    }

    /**
    * This is a getter that will fetch all the fields and save it in a set
    */
    public void getObjectFields() 
    {
        // Clear the list 
        listOfOrderByFields.clear();
        
        // Clear the list 
        nameOfFields.clear();

        // Clear the list 
        multiSelectdFields.clear();

        // Clear the list 
        nameOfSelectedFields.clear();

        // Clear the list 
        nameOfMultiSelectedFields.clear();

        // Check the selected object is none
        if(selectedObject != 'None')
        {
            // Save the list of all the fields in the map 
            Map<String, Schema.SObjectField> mapOfField = 
                mapOfObject.get(selectedObject).getDescribe().fields.getMap();

            // Add all the fields to the set
            nameOfSelectedFields.addAll(mapOfField.keySet());

            // Iterate over the set of the fields
            for (String orderByInstance : nameOfSelectedFields) 
            {

                // Check if the fields are sortable
                if(mapOfField.get(orderByInstance).getDescribe().isSortable() == true)
                {
                    // Add the fields to the list used to order by. 
                    listOfOrderByFields.add(new SelectOption(orderByInstance,orderByInstance));

                    // Sort the list 
                    listOfOrderByFields.sort();
                }
            }// End of for loop

            // Iterate over the set of the fields
            for (String fieldName : nameOfSelectedFields) 
            {  
                // If field is 'name' dont add to the displayed field list
                if(fieldName != 'name')
                {
                    // Add the fields to the displayed list
                    nameOfFields.add(new SelectOption(fieldName,fieldName));
                } 
            }// End of the for loop

        }
        else
        {
            // Clear the list
            nameOfFields.clear();

            // Clear the list
            multiSelectdFields.clear();

            // Clear the list
            nameOfSelectedFields.clear();

            // Clear the list
            nameOfMultiSelectedFields.clear();
        }
    }
   
   /**
    * This is a getter that will add the elements in the displayed field list
    */
    public List<SelectOption> getSelectedList() 
    {
        // Clear the list
        nameOfFields.clear();

        // Iterate over the list of the fields
        for (String fieldName : nameOfSelectedFields) 
        {    
             // If field is 'name' dont add to the displayed field list
             if(fieldName != 'name')
             {
                nameOfFields.add(new SelectOption(fieldName,fieldName)); 
             }
        }

        // Sort the list
        nameOfFields.sort();

        // return the list
        return nameOfFields;
    }

    /**
    * This is a getter that will add the elements in the selected field list
    */
    public List<SelectOption> getMultiSelectedList() 
    {
        // Clear the list
        multiSelectdFields.clear();

        // Iterate over the selected field list 
        for (String fieldName : nameOfMultiSelectedFields) 
        {  
             // Add the fields to be displayed in selected list
             multiSelectdFields.add(new SelectOption(fieldName,fieldName)); 
        }// End of the for loop

        // return the list
        return multiSelectdFields;
    }

   /**
    * This is a method that will add the fields in the selected list
    */
    public void addMultiSelectFields() 
    { 
        // Iterate over the selected list 
        for (String selectFields : selectedField)
        {
            // Add files to the selected field list
            nameOfMultiSelectedFields.add(selectFields);

            // Remove the fields from the displayed list
            nameOfSelectedFields.remove(selectFields);
        }// End of the for loop
    }

    /**
    * This is a method that will remove the fields in the selected list
    */
    public void removeMultiSelectFields() 
    {
        // Iterate over the selected list 
        for (String selectmultiFields : multiSelected)
        {
            // Add files to the displayed field list
            nameOfSelectedFields.add(selectmultiFields);

            // Remove the fields from the selected list
            nameOfMultiSelectedFields.remove(selectmultiFields);
        }// End of the for loop
    }
    
   /**
    * This is a method that will display the radio buttons for showing ascending/descending sort. 
    */
    public list<SelectOption> getSort()
    {
        // Create the instance of list of select option
        List<SelectOption> options = new List<SelectOption>();

        // Add the elements of select options
        options.add(new SelectOption('ASC' , 'Ascending'));

        // Add the elements of select options
        options.add(new SelectOption('DESC' , 'Descending'));

        // return the option list
        return options;
    }

   /**
    * This is a method that will add the new object. 
    */
    public void addNewObjectToQuery()
    {
        // Call the method which will save the values in the wrapper
        saveValuesInTheWrappper();

        // Clear the string
        selectedObject = '';

        // Make the radio option as ASC default
        selectedRadio = 'ASC';

        // Clear the list
        nameOfFields.clear();

        // Clear the list
        multiSelectdFields.clear();

        // Clear the list
        nameOfSelectedFields.clear();

        // Clear the list        
        nameOfMultiSelectedFields.clear();

        // Clear the list
        selectedField.clear();

        // Clear the list
        listOfOrderByFields.clear();

        // Clear the list
        multiSelected.clear();

        // Clear the list
        orderbyselectedField.clear();
    }

   /**
    * This is a method that will add the elements to the list of limit
    */
    public list<SelectOption> getAddNumber()
    {
        // Create the instance of the list of selectoptions
        List<SelectOption> addNumberOfRecords = new List<SelectOption>();

        // Add the elements to the list
        addNumberOfRecords.add(new SelectOption('' + 500,'' + 500));

        // Add the elements to the list
        addNumberOfRecords.add(new SelectOption('' + 1000,'' + 1000));

        // Add the elements to the list
        addNumberOfRecords.add(new SelectOption('' + 2000,'' + 2000));

        // return the list
        return addNumberOfRecords;
    }
    
   /**
    * This is a method that will save the values in the wrapper 
    */
    public void saveValuesInTheWrappper()
    {
        // Check if the value of the search is blank
        if(String.isNotBlank(inputSearch) && multiSelectdFields.size() != 0 
           && inputSearch.length() > 3)
        {
            // Create the instance of the wrapper
            WrapperForObjectNameFieldListAndRecords wrapperInstance = 
            new WrapperForObjectNameFieldListAndRecords();

            // Assign the object name 
            wrapperInstance.sObjectTypeName = selectedObject;

            // Assign the order
            wrapperInstance.orderByName = selectedRadio;

            // Iterate over the list of selected fields
            for (String fieldInstance : nameOfMultiSelectedFields)
            {
                // Add the fields in the list of fields of wrapper class
                wrapperInstance.fieldName.add(fieldInstance);
            }// End of for loop

            // Iterate over the list of order by list
            for (String orderbyfieldInstance : orderbyselectedField)
            {
                // Add the fields in the list of orderby fields of wrapper class
                wrapperInstance.orderbyFieldlist.add(orderbyfieldInstance);
            }// End of for loop

            // Add the object name as a key and wrapper instance as a value
            mapWithObjectAndWrapper.put(mapOfObject.get(selectedObject), wrapperInstance);
        }
        else
        {
            // Render the page message block as true
            renderValue = true;

            // Add the page message
            ApexPages.addmessage(new ApexPages.message(
                                          ApexPages.severity.error,
                                         'Please Provide the value to Search'));
        }
    }
        
    public void query()
    {
        // Check if the value of the search is blank
        if(String.isNotBlank(inputSearch) && multiSelectdFields.size() != 0 
           && inputSearch.length() > 3)
        {
            // Call the method that will save the values in the wrapper
            saveValuesInTheWrappper();

            // Set the value of a string as Find
            String findkeyword = 'FIND';

            // Set the value of a string as inputString
            String inputSearchValue = inputSearch;

            // Set the value of a string as blank
            String objectAndField = '';

            // Iterate over the objects
            for(Schema.SObjectType objectNameInstance : mapWithObjectAndWrapper.keySet())
            {
                // Create the instance of wrapper
                WrapperForObjectNameFieldListAndRecords wrapperInstance = 
                    mapWithObjectAndWrapper.get(objectNameInstance);

                // Add the object in the query
                objectAndField += ' ' + wrapperInstance.sObjectTypeName + '(';

                // Create the instance of set of string
                Set<String> setOfFeilds = new Set<String>();

                // Add the values of the field from the wrapper to the set
                setOfFeilds.addall(wrapperInstance.fieldName);

                // Iterate over the set of fields 
                for (String nameOfField : setOfFeilds) 
                {
                    // Add the fields to the query
                    objectAndField += ' ' + nameOfField + ' ,';
                }// End of for loop

                // Explicitly fetch name field as required to redirect to detail page
                objectAndField += ' ' + 'Name' + ' ,';

                // Remove extra , added
                objectAndField  = objectAndField.removeEnd(',');

                // Add the orderby keyword
                objectAndField +=' ' + 'ORDER BY';

                // Create the instance of the list od string
                List<String> listofOrderBy = new List<String>();

                // Add the values of the field from the wrapper to the list 
                listofOrderBy.addall(wrapperInstance.orderbyFieldlist);

                // Iterate over the list of orderby fields 
                for (String orderByInstance : listofOrderBy) 
                {
                    // Add all the order by fields 
                    objectAndField += ' ' + orderByInstance+ ' ,';
                }// End of for loop

                // Remove extra , added
                objectAndField=objectAndField.removeEnd(',');

                // Add the order ascending or descending
                objectAndField += ' ' + wrapperInstance.orderByName ;

                // Add the )
                objectAndField += ' ),';
        }
        // Remove the extra ,
        objectAndField=objectAndField.removeEnd(',');

        // Set the string as field returning
        String returningFields = 'FIELDS RETURNING';

        // Form the query
        dynamicQuery = (findkeyword + ' {'+inputSearchValue +'} ' + ' ' + 'IN' + ' ' + 'ALL' + ' '
             + returningFields + ' ' + objectAndField + 'LIMIT' + ' ' + selectedNumber);
        
        system.debug('dynamicQuery+++++++++'+dynamicQuery);
        // Execute the query
        searchList = search.query(dynamicQuery);

        // Disable button
        renderaddValue= false;
        }
        else
        {
            // Show page message
            renderValue = true;

            // Add the page message
            ApexPages.addmessage(
                                 new ApexPages.message
                                    (
                                     ApexPages.severity.info,
                              'Please Provide Atleast One Field/Atleast One Object/Value to Search'
                                    )
                                );
        }
        
    }

    /**
     * This is a method that will print the result of list of list of sobject
     */
     public List<WrapperForObjectNameFieldListAndRecords> getsearchResultsOfQuery()
     {
         // Check if the list of result is not empty 
         if((searchList != null) && (searchList.isEmpty() != true)) 
         {
            // Iterate over the list of list of sobject
            for(List<SObject> listInstance : searchList) 
            {
                // Fetch the name of the object from the List of sobject
                String sObjectTypeName = listInstance.getSObjectType().getDescribe().getLabel();

                // Create the instance of the wrapper
                WrapperForObjectNameFieldListAndRecords wrapperQueryInstance = 
                    new WrapperForObjectNameFieldListAndRecords();

                // Save the wrapper instance 
                wrapperQueryInstance = 
                    mapWithObjectAndWrapper.get(mapOfObject.get(sObjectTypeName));

                // Add all the records to the wrapper
                wrapperQueryInstance.recordObject.addAll(new List<SObject>(listInstance));

                // Update the values of the wrapper in the map
                mapWithObjectAndWrapper.put(mapOfObject.get(sObjectTypeName),wrapperQueryInstance);

                // Add the wrapper instance to the list of wrapper 
                searchResultsInstance.add(wrapperQueryInstance);
            }// End of for loop
         }

         // return the list
         return searchResultsInstance;
     }

    /**
     * This is the method that will clear all the lists 
     */
     public void clearProperties()
     {
        // Set the default value to ASC
        selectedRadio = 'ASC';

        // Set the default value as 500
        selectedNumber = '500';

        // Set the default value as none
        selectedObject = 'None';

        // Clear the list 
        selectedField.clear();

        // Clear the list
        searchList.clear();

        // Clear the list
        multiSelected.clear(); 

        // Clear the list
        nameOfMultiSelectedFields.clear();

        // Clear the list
        nameOfSelectedFields.clear();

        // Clear the list
        nameOfMultiSelectedFields.clear();
 
        // Clear the list
        multiSelectdFields.clear();

        // Clear the list
        nameOfFields.clear();

        // Clear the list
        fieldName.clear();

        inputSearch = '';

        // Clear the list
        mapWithObjectAndWrapper.clear();

        dynamicQuery = '';
        // Clear the list
        searchResultsInstance.clear();

        // Clear the list
        orderbyselectedField.clear();

        // Clear the list
        listOfOrderByFields.clear();

        // Set the render value to true
        renderaddValue = true;
     }

    /**
     * This is a inner class that will save the values of the object name, records and the fields.
     */
     public class WrapperForObjectNameFieldListAndRecords
     {
         // Declare the instance of string the object name
         public String sObjectTypeName {get ; set;}

         // Declare the instance of string for the order by 
         public String orderByName {get ; set;}

         // Declare the instance of list of sobject 
         public List<SObject> recordObject {get ; set;}

         // Declare the instance of list of string 
         public List<String> orderbyFieldlist {get ; set;}

         // Declare the instance of list of string 
         public List<String> fieldName {get ; set;}

        /**
         * This is a constructor that will instantiate the wrapper class
         */
         public WrapperForObjectNameFieldListAndRecords()
         {
             // Set the objectname as blank
             sObjectTypeName = '';

             // Set the order by string as blank
             orderByName = 'ASC';

             // Create the instance of the list of sobject 
             recordObject = new List<SObject>();

             // Create the instance of the list of string
             fieldName = new List<String>();

             // Create the instance of the list of string
             orderbyFieldlist = new List<String>();
        }
     }
}