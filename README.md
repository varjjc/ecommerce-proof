# 🛍️ Ecommerce App

Este proyecto es una **prueba técnica** de una aplicación e-commerce desarrollada en Flutter utilizando **arquitectura limpia** (Clean Architecture de Uncle Bob), **Bloc para gestión de estado**, y **GoRouter para navegación**.

---

## 📱 Funcionalidades implementadas

- ✅ Pantalla de **categorías** en grilla (desde API).
- ✅ Pantalla de **productos por categoría** (API dinámica).
- ✅ **Carrito de compras** con posibilidad de aumentar y disminuir productos.
- ✅ **Modo express** activado con switch global.
  - Carrito independiente.
  - Botón visual de modo express (al lado del carrito).
  - Cambio de comportamiento en la ProductCard.
- ✅ Visualización de contador de productos en el icono del carrito.
- ✅ Navegación entre pantallas con GoRouter.
- ✅ Estado del carrito persistente al navegar.
- ✅ Arquitectura limpia aplicada.

---

## 🧠 Arquitectura usada

Se usó **Clean Architecture**, dividiendo el proyecto en:

lib/
│
├── core/
│
├── features/
│ └── shop/
│ ├── data/
│ ├── domain/
│ └── presentation/
│
├── cart/ → manejador de carritos y estados
│
└── main.dart


Gestión de estado:
- 🟡 Bloc: para la lógica de negocio (Categorías, Productos, Carrito y Carrito Express).
- 🔵 Cubit: para el switch de modo express (más simple).

---

## 🧪 Tecnologías

- 🐦 Flutter 3.x
- 🧱 Bloc + flutter_bloc
- 🧭 GoRouter
- 🌐 API: [FakeStoreAPI](https://fakestoreapi.com)
- 🧼 Clean Architecture

---

## ▶️ Cómo correr la app

1. Clona el repositorio:
   ```bash
   git clone https://github.com/varjjc/ecommerce-proof.git

2. Instala dependencias:
    flutter pub get

3. Corre la app:
    flutter run

Notas técnicas

-Todo el flujo Funciona con las categorías "electronics" y "jewelery". Se recomienda probar con estas ya que "Men´s Clothing" y "Women's Clothing" siguen en fase de prueba.

- El modo express se representa con un switcher en la parte superior derecha de la pantalla de productos y cambia la funcionalidad del botón a “Comprar”.

- El contador de productos funciona por modo, lo que significa que cada producto puede tener cantidad distinta según el modo (normal o express) y también se diferencia entre el carrito del modo express (contador color azul) y el modo normal (contador color rojo).

- El botón de retroceso usa GoRouter (context.go('/')) para garantizar funcionamiento estable.