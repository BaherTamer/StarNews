//
//  MockArticleDetailsJSON.swift
//  ArticleDetails
//
//  Created by Baher Tamer on 14/07/2025.
//

struct MockArticleDetailsJSON {
    static let validData = """
    {
        "id": 20,
        "title": "Test Article",
        "url": "https://example.com/article",
        "imageUrl": "https://example.com/image.jpg",
        "newsSite": "Example News",
        "summary": "This is a test article summary",
        "publishedAt": "2025-07-14T10:30:00Z",
        "authors": [
            { "name": "Test Author 1" },
            { "name": "Test Author 2" }
        ]
    }    
    """
    
    static let nullableData = """
    {
        "id": null,
        "title": null,
        "url": null,
        "imageUrl": null,
        "newsSite": null,
        "summary": null,
        "publishedAt": null,
        "authors": null
    }    
    """
    
    static let invalidData = """
    {
        "id": "",
        "title": -1,
        "url": -1,
        "imageUrl": -1,
        "newsSite": -1,
        "summary": -1,
        "publishedAt": -1,
        "authors": []
    }    
    """
}
