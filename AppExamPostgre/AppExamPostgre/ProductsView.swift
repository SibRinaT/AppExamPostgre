//
//  ProductsView.swift
//  AppExamPostgre
//
//  Created by Ainur on 07.03.2024.
//

import SwiftUI
import PostgresClientKit

struct ProductListView: View {
    // Массив товаров для отображения
    @State var products: [Product] = []
    
    var body: some View {
        NavigationView {
            List(products, id: \.id) { product in
                VStack(alignment: .leading) {
                    Text(product.name)
                        .font(.headline)
                    Text("Цена: \(product.price)")
                        .foregroundColor(.gray)
                }
            }
            .navigationBarTitle("Товары")
            .onAppear {
                fetchProducts()
            }
        }
    }
    
    // Функция для выполнения запроса к базе данных и получения списка товаров
    func fetchProducts() {
        do {
            // Установка соединения с базой данных PostgreSQL
            let connection = try PostgresConnection(configuration: PostgresClientKit.ConnectionConfiguration(
                host: "your_host",
                database: "your_database",
                user: "your_username",
                password: "your_password"
            ))
            
            // Выполнение SQL-запроса для получения списка товаров
            let query = "SELECT id, name, price FROM Products"
            let statement = try connection.prepareStatement(text: query)
            defer { try? statement.close() }
            let result = try statement.execute()
            
            // Извлечение данных о товарах из результата запроса
            var fetchedProducts: [Product] = []
            while let row = try result.next() {
                let id = try row.decode(column: "id", type: Int.self)
                let name = try row.decode(column: "name", type: String.self)
                let price = try row.decode(column: "price", type: Double.self)
                fetchedProducts.append(Product(id: id, name: name, price: price))
            }
            
            // Обновление списка товаров в пользовательском интерфейсе
            DispatchQueue.main.async {
                self.products = fetchedProducts
            }
        } catch {
            print("Error fetching products: \(error.localizedDescription)")
        }
    }
}

// Пример использования:
// Создание экземпляра ProductListView для отображения списка товаров
#Preview  {
    ProductListView()
}
