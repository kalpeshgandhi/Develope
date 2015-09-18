/**
 * This is a class that handels the functionality of depended picklist for country and city.
 * Whenever the country is selcted the related city are displayed.
 */
public with sharing class SelectCityAndCountryPickListDependancy
{
    // It is a getter and setter used to save/retrive select contry value
    public String selectedOption {get;set;}
    
    // It is a getter and setter used to save/retrive select city value
    public String selectedcityOption {get;set;}
    
    // It is a getter and setter used for saving/retriving city List
    public List<SelectOption> cityList{get;set;}
    
    // It is a getter and setter used for saving/retriving country List
    public List<SelectOption> countryList{get;set;}
    
   /**
    * It is a counstructor that will call the method country pick list.
    * and it will add the values before the page is loaded.
    */
    public SelectCityAndCountryPickListDependancy()
    {
        
        // Inititalize the list
        cityList = new List<SelectOption>();
        
        // Inititalize the list
        countryList = new List<SelectOption>();
        
        // It calls the method that puts the value in country picklist  
        coutryListPicklist();
    }
    
   /**
    * This is a method that will add values of the picklist.
    * and it is displayed in the picklist.
    */
    public List<SelectOption> coutryListPicklist() 
    {
        
        // Intialize the country list. 
        countryList = new List<SelectOption>();
        
        // Add the values to the country list
        countryList.add(new SelectOption('', '-- Select One --'));       
 
        // Save all the present countries in the map
        Map<String, Country__c> mapWithCountryNameAndCountryDetails = Country__c.getAll();
       
        // Iterate over all the countries
        for (String countryNameInstance : mapWithCountryNameAndCountryDetails.keySet()) 
        {
            
            // Fetch the related country information
            Country__c countryInstance = 
                mapWithCountryNameAndCountryDetails.get(countryNameInstance);
            
            // Add values to the select option list
            countryList.add(new SelectOption(countryInstance.Name, countryInstance.Name));
        }
        
        // Return the list of the country
        return countryList;
    }
   
   /**
    * This is a method that will add values of the city picklist.
    * and it is displayed in the picklist.
    */
    public List<SelectOption> getselectedCityList() 
    {
        
        // Intialize the country list. 
        cityList = new List<SelectOption>();
       
        // Save all the present city in the map
        Map<String, City__c> mapWithAllCityNameAndAllCityDetails = City__c.getAll();
        
        // Intialize the map
        Map<String, City__c> mapWithCityNameAndCityDetails = new Map<String, City__c>();
        
        // Iterate over all the values of the city
        for(City__c cityInstance : mapWithAllCityNameAndAllCityDetails.values()) 
        {
            
            // Check if the country matches to the selected country
            if (cityInstance.Country__c == selectedOption) 
            {
                
                // Add values of the city to the map
                mapWithCityNameAndCityDetails.put(cityInstance.name, cityInstance);
            }
        }
        
        // Iterate over the values of the city stored in the map
        for (String cityNameInstance : mapWithCityNameAndCityDetails.keySet()) 
        {
            
            // Create the instance of the city
            City__c cityInstance = mapWithCityNameAndCityDetails.get(cityNameInstance);
            
            // Add values of the city to the list.
            cityList.add(new SelectOption(cityInstance.Name, cityInstance.Name));
        }
        
        // Return the list
        return cityList;
    }
}