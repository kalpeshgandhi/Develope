public with sharing class SelectCityAndCountryPickListDependancy
{
    // It is a getter And Setter used to save/retrive select Contry value
    public String selectedOption {get;set;}
    // It is a getter And Setter used to save/retrive select City value
    public String selectedcityOption {get;set;}
    // It is a getter And Setter used for Saving/Retriving city List
    public List<SelectOption> cityList{get;set;}
    // It is a getter And Setter used for Saving/Retriving country List
    public List<SelectOption> countryList{get;set;}
    // It is a Constructer.
   /**
    * It is a counstructor that will call the method Country Pick list.
    * And it will Add the values Before the page is loaded.
    */
    public SelectCityAndCountryPickListDependancy()
    {
        // It calls the method that puts the value in country picklist  
        coutryListPicklist();
    }
   /**
    * This is a Method that will Add values of the picklist.
    * And it is displayed in the picklist.
    */
    public List<SelectOption> coutryListPicklist()
    {
       // ReIntialize the Country list. 
       countryList = new List<selectOption>();
       // Iterate over All the Country Values.
       for (Country__c countryListInstance : Country__c.getAll().values())
       {
            // Add the Values to the Country list
            countryList .add(new SelectOption(countryListInstance.Name,countryListInstance.Name));
       }// End of the For Loop
       return countryList;
    }
    public void cityChange()
    {
        // ReIntialize the City list. 
        cityList=new  List<SelectOption>();
        // Iterate over the list of the cities that belong to a Perticular Country.
        for (City__c cityListInstance :[Select Name
                                      from City__c 
                                      where Country__c= :selectedOption])
        {
            // Add the Values to the City list
            cityList.add(new SelectOption(cityListInstance.Name,cityListInstance.Name));
        }// End of the For Loop
         
    }
}