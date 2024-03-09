//
//  Model.swift
//  AppExamPostgre
//
//  Created by Ainur on 07.03.2024.
//

import Foundation

// Модель для товаров
struct Product {
    var id: UUID // Уникальный идентификатор
    var name: String // Название товара
    var price: Double // Цена товара
    // Другие свойства товара, такие как количество на складе, описание и т.д.
}

// Модель для заказов
struct Order {
    var id: UUID // Уникальный идентификатор
    var customerName: String // Имя заказчика
    var products: [Product] // Товары в заказе
    var orderDate: Date // Дата заказа
    // Другие свойства заказа, такие как статус заказа и т.д.
}

// Модель для поставок
struct Shipment {
    var id: UUID // Уникальный идентификатор
    var supplierName: String // Название поставщика
    var products: [Product] // Товары в поставке
    var shipmentDate: Date // Дата поставки
    // Другие свойства поставки, такие как статус поставки и т.д.
}

// Модель для сотрудников
struct Employee {
    var id: UUID // Уникальный идентификатор
    var name: String // Имя сотрудника
    var position: String // Должность сотрудника
    // Другие свойства сотрудника, такие как логин и пароль для аутентификации, права доступа и т.д.
}
