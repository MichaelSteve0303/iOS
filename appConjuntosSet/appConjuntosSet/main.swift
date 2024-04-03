//
//  main.swift
//  appConjuntosSet
//
//  Created by Michael Steve Espinoza Perez on 07/05/23.
//

// Crear un conjunto vacío
var miSet: Set<String> = []

// Agregar elementos al conjunto
miSet.insert("Manzana")
miSet.insert("Banana")
miSet.insert("Pera")

// Mostrar el contenido del conjunto
print("El conjunto contiene \(miSet.count) elementos:")
for fruta in miSet {
    print(fruta)
}

// Comprobar si un elemento está en el conjunto
let contieneManzana = miSet.contains("Manzana")
print("El conjunto \(contieneManzana ? "sí" : "no") contiene Manzana")

// Eliminar un elemento del conjunto
miSet.remove("Banana")

// Mostrar el contenido del conjunto actualizado
print("Después de eliminar Banana, el conjunto contiene \(miSet.count) elementos:")
for fruta in miSet {
    print(fruta)
}


