
CREATE TABLE categorias (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT
);

CREATE TABLE productos (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    categoria_id BIGINT REFERENCES categorias(id),
    nombre VARCHAR(150) NOT NULL,
    precio NUMERIC(10,2) NOT NULL CHECK (precio >= 0),
    stock INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0)
);

CREATE TABLE clientes (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    telefono VARCHAR(20),
    direccion TEXT,
    fecha_registro TIMESTAMP DEFAULT NOW()
);

CREATE TABLE fiados (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    cliente_id BIGINT NOT NULL REFERENCES clientes(id),
    monto NUMERIC(10,2) NOT NULL CHECK (monto > 0),
    fecha TIMESTAMP DEFAULT NOW(),
    descripcion TEXT,
    estado VARCHAR(20) DEFAULT 'pendiente'
        CHECK (estado IN ('pendiente', 'pagado', 'parcial'))
);

CREATE TABLE registros (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    accion VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha TIMESTAMP DEFAULT NOW()
);

INSERT INTO categorias (nombre, descripcion) VALUES
('Bebidas', 'Refrescos y jugos'),
('Golosinas', 'Confites y chocolates'),
('Lacteos', 'Leche y derivados'),
('Abarrotes', 'Productos básicos');

INSERT INTO productos (categoria_id, nombre, precio, stock) VALUES
(1, 'Coca Cola 600ml', 900, 20),
(1, 'Jugo de naranja', 750, 15),
(2, 'Chocolate', 500, 30),
(3, 'Leche 1L', 1200, 10),
(4, 'Arroz 1kg', 850, 25);

INSERT INTO clientes (nombre, telefono, direccion) VALUES
('Juan Perez', '88881111', 'Barrio Centro'),
('Maria Rodriguez', '88882222', 'Barrio Norte'),
('Carlos Lopez', '88883333', 'Barrio Sur');

INSERT INTO fiados (cliente_id, monto, fecha, descripcion)
VALUES
(1, 2000, CURRENT_DATE, 'Compra de productos varios'),
(1, 1500, CURRENT_DATE + INTERVAL '1 day', 'Otra compra fiada'),
(2, 3000, CURRENT_DATE, 'Compra de abarrotes');

INSERT INTO registros (accion, descripcion) VALUES
('CREACION', 'Se creó la base de datos de la pulpería'),
('INSERT', 'Se agregaron los datos iniciales');

SELECT *
FROM fiados
WHERE cliente_id = 1
ORDER BY fecha DESC;
Select * From productos
