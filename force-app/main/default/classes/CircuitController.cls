public with sharing class CircuitController {
    @AuraEnabled(cacheable=true scope='global')
    public static String getAllCircuits() {
        //CIRCUITS QUERY
        List<Circuit__c> circuits = [SELECT
                                        Id,
                                        Name,
                                        Location__c,
                                        Length__c,
                                        Turns__c,
                                        Surface__c,
                                        Shape__c,
                                        Start_Year__c,
                                        Latitude__c,
                                        Longitude__c
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
                'Shape__c' => circuit.Shape__c,
                'Start_Year__c' => circuit.Start_Year__c,
                'Latitude__c' => circuit.Latitude__c,
                'Longitude__c' => circuit.Longitude__c
            };


            circuitsJsonList.add(circuitsJson);
        }
    
        return JSON.serialize(circuitsJsonList);
    }
    
    //RETURN QUERY GIVEN A SEARCH TERM
    @AuraEnabled(cacheable=true scope='global')
    public static String searchCircuit(String searchTerm) {

        searchTerm = searchTerm.trim();
        if (searchTerm == '') {
            return getAllCircuits();
        }
        
        searchTerm = '%' + searchTerm + '%';
        
        List<Circuit__c> searchResults = [SELECT
                                            Id,
                                            Name,
                                            Location__c,
                                            Length__c,
                                            Turns__c,
                                            Surface__c,
                                            Shape__c,
                                            Start_Year__c,
                                            Latitude__c,
                                            Longitude__c
                                        FROM Circuit__c
                                        WHERE Name LIKE :searchTerm
                                        WITH SECURITY_ENFORCED
                                        ORDER BY Name
                                        LIMIT 30];

                                        
    List<Map<String, Object>> searchResultsMapList = new List<Map<String, Object>>();
    for (Circuit__c circuit : searchResults) {
        Map<String, Object> circuitMap = new Map<String, Object>{
            'Id' => circuit.Id,
            'Name' => circuit.Name,
            'Location__c' => circuit.Location__c,
            'Length__c' => circuit.Length__c,
            'Turns__c' => circuit.Turns__c,
            'Surface__c' => circuit.Surface__c,
            'Shape__c' => circuit.Shape__c,
            'Start_Year__c' => circuit.Start_Year__c,
            'Latitude__c' => circuit.Latitude__c,
            'Longitude__c' => circuit.Longitude__c
        };
        searchResultsMapList.add(circuitMap);
    }

        return JSON.serialize(searchResultsMapList);   
    } 
}