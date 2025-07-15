//
//  MockSearchJSON.swift
//  Search
//
//  Created by Baher Tamer on 13/07/2025.
//

struct MockSearchJSON {
    static let validData = """
    {
        "count": \(count),
        "next": "https://api.example.com/articles/?limit=\(limit)&offset=\(offset)",
        "results": [
            {
                "id": 1,
                "title": "Test Article 1",
                "imageUrl": "https://example.com/image1.jpg"
            },
            {
                "id": 2,
                "title": "Test Article 2",
                "imageUrl": "https://example.com/image2.jpg"
            },
            {
                "id": 3,
                "title": "Test Article 3",
                "imageUrl": "https://example.com/image3.jpg"
            }
        ]
    }    
    """
    
    static let nullableData = """
    {
        "count": \(count),
        "next": "https://api.example.com/articles/?limit=\(limit)&offset=\(offset)",
        "results": [
            {
                "id": null,
                "title": null,
                "imageUrl": null
            }
        ]
    }    
    """
    
    static let emptyData = """
    {
        "count": \(count),
        "next": "https://api.example.com/articles/?limit=\(limit)&offset=\(offset)",
        "results": []
    }
    """
    
    static let invalidData = """
    {
        "count": \(count),
        "next": "https://api.example.com/articles/?limit=\(limit)&offset=\(offset)",
        "results": [
            {
                "id": "",
                "title": -1,
                "imageUrl": -1
            }
        ]
    }   
    """
}

// MARK: - Private Helpers
extension MockSearchJSON {
    private static let limit = 10
    private static let offset = 20
    private static let count = 100
}
