//
//  JsonModel.swift
//  JsonPlaceholder
//
//  Created by 湯芯瑜 on 2017/11/1.
//  Copyright © 2017年 Hsin-Yu Tang. All rights reserved.
//

import Foundation

class JsonModel: Codable {

    let userId: Int
    let id: Int
    let title: String
    let body: String
    
    init(userId: Int, id: Int, title: String, body: String) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }

    private enum CodingKeys: CodingKey {
        case userId
        case id
        case title
        case body
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            self.userId = try container.decode(Int.self, forKey: .userId)
            self.id = try container.decode(Int.self, forKey: .id)
            self.title = try container.decode(String.self, forKey: .title)
            self.body = try container.decode(String.self, forKey: .body)
        } catch {
            print("[JsonModel] Decode Error: \(error.localizedDescription)")
            throw error
        }
    }
}

/*
 {
 "userId": 1,
 "id": 1,
 "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
 "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
 }
 */
