public with sharing class CircuitController {
    @AuraEnabled(cacheable=true scope='global')
    public static String getAllCircuits() {
        //As JSON
        List<Circuit__c> circuits = [SELECT
                                        Id,
                                        Name,
                                        Location__c,
                                        Length__c,
                                        Turns__c,
                                        Surface__c,
                                        Shape__c
                                    FROM Circuit__c
                                    WITH SECURITY_ENFORCED
                                    ORDER BY Name
                                    LIMIT 6];
    
        List<Map<String, Object>> circuitsJsonList = new List<Map<String, Object>>();

        for (Circuit__c circuit : circuits) {
            Map<String, Object> circuitsJson = new Map<String, Object>{
                'Id' => circuit.Id,
                'Name' => circuit.Name,
                'Location__c' => circuit.Location__c,
                'Length__c' => circuit.Length__c,
                'Turns__c' => circuit.Turns__c,
                'Surface__c' => circuit.Surface__c,
                'Shape__c' => circuit.Shape__c
            };


            circuitsJsonList.add(circuitsJson);
        }
    
        return JSON.serialize(circuitsJsonList);
    }
    

    @AuraEnabled(cacheable=true scope='global')
    public static String searchCircuit(String searchTerm) {
        // Return all circuits when no search term
        searchTerm = searchTerm.trim();
        if (searchTerm == '') {
            return getAllCircuits();
        }
        
        // Prepare query parameters
        searchTerm = '%' + searchTerm + '%';
        
        // Execute search query
        List<Circuit__c> searchResults = [SELECT
                                            Id,
                                            Name,
                                            Location__c,
                                            Length__c,
                                            Turns__c,
                                            Surface__c,
                                            Shape__c
                                        FROM Circuit__c
                                        WHERE Name LIKE :searchTerm
                                        WITH SECURITY_ENFORCED
                                        ORDER BY Name
                                        LIMIT 50];
        
        return JSON.serialize(searchResults);
    }
    
}