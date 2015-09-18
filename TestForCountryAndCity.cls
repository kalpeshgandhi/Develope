/**
 * This is a test method that will test the functionality that when ever a country is selected 
 * related city is selected.
 */
@isTest
private class TestForCountryAndCity 
{
   /**
    * This is a test method that will show cities that are to be displayed
    * in the picklist on the page.
    */
     public static testmethod void testForCountryOptions()
     {
         // Creates a new list of country. 
         List<Country__c> countryList = new List<Country__c>();
         
         // Create test country data. 
         Country__c countryInstance = new Country__c(Name= 'India');
         Country__c countryInstance2 = new Country__c(Name= 'USA');
         Country__c countryInstance3 = new Country__c(Name= 'Pakistan');
         
         // Add the elements to the list.
         countryList.add(countryInstance);
         countryList.add(countryInstance2);
         countryList.add(countryInstance3);
         
         // Check the list size.
         System.assertEquals(3,countryList.size()); 
         
         // Fetch the list of all the country
         List<Country__c> checkCountryList = 
            [
                SELECT
                    Id
                FROM
                    Country__c
            ];
         
                  
         // Check the list size.
         System.assertEquals(0,checkCountryList.size()); 
         
         // Insert the country.
         insert countryList;
         
         // Fetch the list of all the country
         checkCountryList = 
            [
                SELECT
                    Id
                FROM
                    Country__c
            ];
         
                  
         // Check the list size.
         System.assertEquals(3,checkCountryList.size()); 
         
         // Create the new instance of the controller.
         SelectCityAndCountryPickListDependancy standardcontroller = 
            new SelectCityAndCountryPickListDependancy();
         
         // Create a new list of the select option
         List<SelectOption> optionList = new List<SelectOption>();
                  
         // Start the test
         Test.startTest();
         
         // Store the value that are returned From The function.
         optionList = standardcontroller.coutryListPicklist();
         
         // Stop the test
         Test.stopTest();
         
         // Check the actual size and the expected size.
         System.assertEquals(4,optionList.size()); 
    }
    
   /**
    * This is a method that will assign city according to the country it belongs.
    */
    public static testmethod void testForCityOptions()
    {
         // Creates a new list of country. 
         List<Country__c> countryList = new List<Country__c>();
         
         // Create test country data.
         Country__c countryInstance = new Country__c(Name= 'India');
         Country__c countryInstance2 = new Country__c(Name= 'USA');
         Country__c countryInstance3 = new Country__c(Name= 'Mexico');
         
         // Add the elements to the List.
         countryList.add(countryInstance);
         countryList.add(countryInstance2);
         countryList.add(countryInstance3);
         
         // Check the list size.
         System.assertEquals(3,countryList.size()); 
         
         // Fetch the list of all the country__c
         List<Country__c> checkCountryList = 
            [
                SELECT
                    Id
                FROM
                    Country__c
            ];
         
                  
         // Check the list size.
         System.assertEquals(0,checkCountryList.size()); 
         
         // Insert the country.
         insert countryList;
         
         // Fetch the list of all the country__c
         checkCountryList = 
            [
                SELECT
                    Id
                FROM
                    Country__c
            ];
         
                  
         // Check the list size.
         System.assertEquals(3,checkCountryList.size()); 
         
         // Creates a new list of city.
         List<City__c> cityList = new List<City__c>();
         
          // Create test city data.
         City__c city1 = new City__c(Name= 'Banglore',Country__c='India');
         City__c city2 = new City__c(Name= 'Pune',Country__c='India' );
         
         // Add the elements to the List.
         cityList.add(city1);
         cityList.add(city2);
         
         // Fetch the list of all the city
         List<City__c> checkCityList = 
            [
                SELECT
                    Id
                FROM
                    City__c
            ];
                  
         // Check the list size.
         System.assertEquals(0,checkCityList.size()); 
         
         // Insert the city.
         insert cityList;
         
         // Fetch the list of all the city
         checkCityList = 
            [
                SELECT
                    Id
                FROM
                    City__c
            ];
                  
         // Check the list size.
         System.assertEquals(2,checkCityList.size()); 
         
          // Create the new instance of the controller.
         SelectCityAndCountryPickListDependancy standardcontroller = 
            new SelectCityAndCountryPickListDependancy();
            
         // Select the option from the picklist.
         standardcontroller.selectedOption = 'India';
         
         // Start the test
         Test.startTest();
         
         // Give call To The function.
         standardcontroller.getselectedCityList();
         
         // Stop the test
         Test.stopTest();
         
         // Check the actual size and the expected size.
         System.assertEquals(2,standardcontroller.cityList.size()); 
    }

   /**
    * This is a method that will assign no city if no country is selected.
    */
    public static testmethod void testForNoCountrySelected()
    {
         // Creates a new list of country. 
         List<Country__c> countryList = new List<Country__c>();
         
         // Create test country data.
         Country__c countryInstance = new Country__c(Name= 'India');
         Country__c countryInstance2 = new Country__c(Name= 'USA');
         Country__c countryInstance3 = new Country__c(Name= 'Mexico');
         
         // Add the elements to the list.
         countryList.add(countryInstance);
         countryList.add(countryInstance2);
         countryList.add(countryInstance3);
         
         // Check the list size.
         System.assertEquals(3,countryList.size()); 
         
         // Fetch the list of all the country__c
         List<Country__c> checkCountryList = 
            [
                SELECT
                    Id
                FROM
                    Country__c
            ];
                  
         // Check the list size.
         System.assertEquals(0,checkCountryList.size()); 
         
         // Insert the country.
         insert countryList;
         
         // Fetch the list of all the country
         checkCountryList = 
            [
                SELECT
                    Id
                FROM
                    Country__c
            ];
         
                  
         // Check the list size.
         System.assertEquals(3,checkCountryList.size()); 
         
         // Creates a new list of city.
         List<City__c> cityList = new List<City__c>();
         
          // Create test city data.
         City__c city1 = new City__c(Name= 'Banglore',Country__c='India');
         City__c city2 = new City__c(Name= 'Pune',Country__c='India' );
         
         // Add the elements to the List.
         cityList.add(city1);
         cityList.add(city2);
         
         // Fetch the list of all the c
         List<City__c> checkCityList = 
            [
                SELECT
                    Id
                FROM
                    City__c
            ];
         
                  
         // Check the list size.
         System.assertEquals(0,checkCityList.size()); 
         
         // Insert the City.
         insert cityList;
         
         // Fetch the list of all the c
         checkCityList = 
            [
                SELECT
                    Id
                FROM
                    City__c
            ];
                  
         // Check the list size.
         System.assertEquals(2,checkCityList.size()); 
         
          // Create the new instance of the controller.
         SelectCityAndCountryPickListDependancy standardcontroller = 
            new SelectCityAndCountryPickListDependancy();
            
         // Select the option from the picklist.
         standardcontroller.selectedOption = '-- Select One --';
         
         // Start the test
         Test.startTest();
         
         // Give call to the function.
         standardcontroller.getselectedCityList();
         
         // Stop the test
         Test.stopTest();
         
         // Check the actual size and the expected size.
         System.assertEquals(0,standardcontroller.cityList.size()); 
    }
}