//
//  NewsModel.swift
//  Quotex
//
//  Created by Ravil on 19.10.2023.
//

import Foundation

struct ArticleResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: URL
    let urlToImage: String?
    let publishedAt: Date
    let content: String?
}

struct Source: Codable {
    let id: String?
    let name: String
}
