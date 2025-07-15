//
//  MockSuggestionsJSON.swift
//  Search
//
//  Created by Baher Tamer on 15/07/2025.
//

struct MockSuggestionsJSON {
    static let validData = """
    {
        "results": [
            {
                "id": 1,
                "title": "Test Article 1"
            },
            {
                "id": 2,
                "title": "Test Article 2"
            },
            {
                "id": 3,
                "title": "Test Article 3"
            }
        ]
    }    
    """
    
    static let nullableData = """
    {
        "results": [
            {
                "id": null,
                "title": null
            }
        ]
    }    
    """
    
    static let emptyData = """
    {
        "results": []
    }
    """
    
    static let invalidData = """
    {
        "results": [
            {
                "id": "",
                "title": -1
            }
        ]
    }   
    """
}
