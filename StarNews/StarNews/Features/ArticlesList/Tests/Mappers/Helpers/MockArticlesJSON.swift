//
//  MockArticlesJSON.swift
//  ArticlesList
//
//  Created by Baher Tamer on 13/07/2025.
//

struct MockArticlesJSON {
    static let validData = """
    {
        "count": \(count),
        "next": "https://api.example.com/articles/?limit=\(limit)&offset=\(offset)",
        "results": [
            {
                "id": 1,
                "title": "Test Article 1",
                "url": "https://example.com/article1",
                "imageUrl": "https://example.com/image1.jpg",
                "newsSite": "Test Site 1"
            },
            {
                "id": 2,
                "title": "Test Article 2",
                "url": "https://example.com/article2",
                "imageUrl": "https://example.com/image2.jpg",
                "newsSite": "Test Site 2"
            },
            {
                "id": 3,
                "title": "Test Article 3",
                "url": "https://example.com/article3",
                "imageUrl": "https://example.com/image3.jpg",
                "newsSite": "Test Site 3"
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
                "url": null,
                "imageUrl": null,
                "newsSite": null
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
                "url": -1,
                "imageUrl": -1,
                "newsSite": -1
            }
        ]
    }   
    """
}

// MARK: - Private Helpers
extension MockArticlesJSON {
    private static let limit = 10
    private static let offset = 20
    private static let count = 100
}
