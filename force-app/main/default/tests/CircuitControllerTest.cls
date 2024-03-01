@isTest
public class CircuitControllerTest {
    @isTest
    public static void testGetAllCircuits() {
        Test.startTest();

        // Insert test data
        List<Circuit__c> circuits = new List<Circuit__c>();
        circuits.add(new Circuit__c(Name = 'Test Circuit 1', Location__c = 'Test Location 1', Length__c = 5.0, Turns__c = 10, Surface__c = 'Test Surface', Shape__c = 'Test Shape', Start_Year__c = '2000',  Latitude__c = '232342323423424234234', Longitude__c = '2342312421513412341234'));
        circuits.add(new Circuit__c(Name = 'Test Circuit 2', Location__c = 'Test Location 2', Length__c = 6.0, Turns__c = 12, Surface__c = 'Test Surface', Shape__c = 'Test Shape', Start_Year__c = '2005',  Latitude__c = '23234234234234', Longitude__c = '2342313412341234'));
        insert circuits;

        // Call the controller method
        String result = CircuitController.getAllCircuits();

        // Verify results
        List<Object> circuitsList = (List<Object>)JSON.deserializeUntyped(result);
        System.assertNotEquals(null, circuitsList, 'The circuit list should not be null');
        System.assertEquals(2, circuitsList.size(), 'Expecting two circuits in the list');

        Test.stopTest();
    }

	@isTest
    public static void testSearchCircuit() {
        // Test for searching circuits
        Test.startTest();
        // Insert test data
        Circuit__c circuit1 = new Circuit__c(Name = 'Test Circuit 1', Location__c = 'Test Location 1', Length__c = 5.0, Turns__c = 10, Surface__c = 'Test Surface', Shape__c = 'Test Shape', Start_Year__c = '2000', Latitude__c = '23234234234234', Longitude__c = '2342313412341234');
        Circuit__c circuit2 = new Circuit__c(Name = 'Test Circuit 2', Location__c = 'Test Location 2', Length__c = 6.0, Turns__c = 12, Surface__c = 'Test Surface', Shape__c = 'Test Shape', Start_Year__c = '2005', Latitude__c = '23234234234234', Longitude__c = '2342313412341234');
        insert new List<Circuit__c>{circuit1, circuit2};

        // Test valid search term
        String result = CircuitController.searchCircuit('Test Circuit 1');
        List<Circuit__c> searchResults = (List<Circuit__c>)JSON.deserializeStrict(result, List<Circuit__c>.class);
        System.assertEquals(1, searchResults.size(), 'One circuit should match the search term');

        // Test empty search term
        result = CircuitController.searchCircuit('');
        searchResults = (List<Circuit__c>)JSON.deserializeStrict(result, List<Circuit__c>.class);
        System.assertEquals(2, searchResults.size(), 'All circuits should be returned');

        // Test no search results
        result = CircuitController.searchCircuit('Nonexistent Circuit');
        searchResults = (List<Circuit__c>)JSON.deserializeStrict(result, List<Circuit__c>.class);
        System.assertEquals(0, searchResults.size(), 'No circuits should match the search term');

        // Test if all fields are returned
        List<Map<String, Object>> circuitList = new List<Map<String, Object>>();
        for (Object obj : (List<Object>)JSON.deserializeUntyped(result)) {
            circuitList.add((Map<String, Object>)obj);
        }
        Set<String> expectedFields = new Set<String>{'Id', 'Name', 'Location__c', 'Length__c', 'Turns__c', 'Surface__c', 'Shape__c', 'Start_Year__c', 'Latitude__c', 'Longitude__c'};
        for (Map<String, Object> circuit : circuitList) {
            for (String field : expectedFields) {
                System.assert(circuit.containsKey(field), 'Returned JSON should contain ' + field);
            }
        }
      

        Test.stopTest();
    }


}
