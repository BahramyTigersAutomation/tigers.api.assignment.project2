@smoke
Feature: Generate Token, Create New Account, Add Address, Add phone Number, Add Car to the account.

  Scenario: End to End Api Testing.
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "supervisor", "password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    * def generatedToken = response.token
    And print GeneratedToken
    * def generator = Java.type("tiger.api.testing.assignment.data.DataGeneratorForAssignment")
    * def email = generator.getEmail()
    * def firstName = generator.getFirstName()
    * def lastName = generator.getLastName()
    * def DOB = generator.getDOB()
    * def Job = generator.getJob()
    Given path "/api/accounts/add-primary-account"
    And request
      """
           {
           "email": "#(email)",
           "title": "Mr.",
           "firstName": "#(firstName)",
           "lastName": "#(lastName)",
           "gender": "MALE",
           "maritalStatus": "MARRIED",
           "employmentStatus": "student",
           "dateOfBirth": "1987-01-01"
           }
      """
    And header Authorization = "Bearer" + generatedToken
    When method post
    Then status 201
    * def ID = response.id
    And print response
    * def generator = Java.type("tiger.api.testing.assignment.data.DataGeneratorForAssignment")
    * def country = generator.getCountry()
    * def city = generator.getCity()
    * def zipCode = generator.getZipCode()
    * def state = generator.getState()
    * def street = generator.getStreetAdd()
    * def CountryCode = generator.getCountryCode()
    Given path "/api/accounts/add-account-address"
    And header Authorization = "Bearer " + generatedToken
    And param primaryPersonId = ID
    And request
      """
      {
       "addressType": "Home",
       "addressLine1": "#(street)",
       "city": "#(city)",
       "state": "#(state)",
       "postalCode": "#(zipCode)",
       "countryCode": "#(CountryCode)",
       "current": true
      }
      """
    When method post
    Then status 201
    And print response
    * def generator = Java.type("tiger.api.testing.assignment.data.DataGeneratorForAssignment")
    * def phoneNumber = generator.getPhone()
    * def phoneExtension = generator.getPhoneExtension()
    Given path "/api/accounts/add-account-phone"
    And header Authorization = "Bearer " + generatedToken
    And param primaryPersonId = ID
    And request
      """
      {
      "phoneNumber": "#(phoneNumber)",
      "phoneExtension": "#(phoneExtension)",
      "phoneTime": "Morning",
      "phoneType": "Work"
      }
      """
    When method post
    Then status 201
    And print response
    Given path "/api/accounts/add-account-car"
    And header Authorization = "Bearer " + generatedToken
    And param primaryPersonId = ID
    And request
      """
      {
      "make": "Lexus",
      "model": "NX300",
      "year": "2019",
      "licensePlate": "RFB-573"
      }
      """
    When method post
    Then status 201
    And print response
