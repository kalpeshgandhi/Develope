@isTest
private class TestForCountryAndCity {
    
   /**
    * This is a Test method that will show cities that are to be displayed
    * in the picklist on the page.
    */
     public static testmethod void testgetcountryoptions()
     {
         // Creates a new list of Country. 
         List<Country__c> country = new List<Country__c>();
         // Create Test Country Data. 
         Country__c countryInstance = new Country__c(Name= 'India');
         Country__c countryInstance2 = new Country__c(Name= 'USA');
         Country__c countryInstance3 = new Country__c(Name= 'Pakistan');
         // Add the Elements to the List.
         country.add(countryInstance);
         country.add(countryInstance2);
         country.add(countryInstance3);
        // Start The Test
         Test.startTest();
         // Insert the Country.
         insert country;
         // Stop the test
         Test.stopTest();
         // Create the new Instance of the Controller.
         SelectCityAndCountryPickListDependancy standardcontroller = new SelectCityAndCountryPickListDependancy();
         // Create a New List of the Select Option
         List<SelectOption> optionList = new List<SelectOption>();
         // Store the Value That Are Returned From The Function.
         optionList = standardcontroller.coutryListPicklist();
         // Check the Actual Size and the Expected Size.
         System.assertEquals(3,optionList.size()); 
    }
    
   /**
    * This is a Method That will Assign city according to the Country it belongs.
    */
    public static testmethod void testgetcityoptions()
    {
         // Creates a new list of Country. 
         List<Country__c> country = new List<Country__c>();
         // Create Test Country Data.
         Country__c countryInstance = new Country__c(Name= 'India');
         Country__c countryInstance2 = new Country__c(Name= 'USA');
         Country__c countryInstance3 = new Country__c(Name= 'Mexico');
         // Add the Elements to the List.
         country.add(countryInstance);
         country.add(countryInstance2);
         country.add(countryInstance3);
         // Creates a new list of City.
         List<City__c> cities = new List<City__c>();
          // Create Test City Data.
         City__c city1 = new City__c(Name= 'Banglore',Country__c='India');
         City__c city2 = new City__c(Name= 'Pune',Country__c='India' );
         // Add the Elements to the List.
         cities.add(city1);
         cities.add(city2);
         // Start The Test
         Test.startTest();
         // Insert the Country.
         insert country;
         // Insert the City.
         insert cities;
          // Stop the test
         Test.stopTest();
          // Create the new Instance of the Controller.
         SelectCityAndCountryPickListDependancy standardcontroller = new SelectCityAndCountryPickListDependancy();
         // Select The Option from the Picklist.
         standardcontroller.selectedOption = 'India';
         // Give Call To The Function.
         standardcontroller.cityChange();
         // Check the Actual Size and the Expected Size.
         System.assertEquals(2,standardcontroller.cityList.size()); 
    }
}