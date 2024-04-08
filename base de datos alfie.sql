CREATE DATABASE IF NOT EXISTS ALKEWALLET;

/*++++++++PROYECTO ALKEWALLET++++++++++*/



/* Crear la tabla Usuario 
Restriciones para mantener la integridad de los datos usamos:
 NOT NULL: no pueden contener valores nulos.
 UNIQUE: la columna correoElectronico tendrá esta restricción que garantiza que no puede haber valores duplicados en esta columna.
 CHECK : usamos esta restricción para validar la longitud de la contraseña	*/

CREATE TABLE Usuario (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100) NOT NULL, 
    correoElectronico VARCHAR(100) NOT NULL UNIQUE,
    contrasena VARCHAR(15) NOT NULL,
    saldo DECIMAL(10,2) NOT NULL,
    CHECK (LENGTH(contrasena) >= 6 AND LENGTH(contrasena) <= 15)
);

 /* Crear la tabla Moneda */
CREATE TABLE Moneda (
  currency_id INT PRIMARY KEY AUTO_INCREMENT,
  currency_name VARCHAR(100) NOT NULL,
  currency_symbol VARCHAR(10)NOT NULL 
);   

/* Crear la tabla Transaccion */
CREATE TABLE Transaccion (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    importe DECIMAL(10, 2) NOT NULL,
    transaction_date DATE NOT NULL,
    sender_user_id INT NOT NULL,
    receiver_user_id INT NOT NULL,
    currency_id INT NOT NULL,
    FOREIGN KEY (sender_user_id) REFERENCES Usuario (user_id),
    FOREIGN KEY (receiver_user_id) REFERENCES Usuario (user_id),
    FOREIGN KEY (currency_id) REFERENCES Moneda(currency_id)
);
/* Usuario usa diferentes divisas se crea tabla que une tabla moneda(divisa) con la tabla usuario 
es una relacion de un uno a muchas un usuario puede tener diferentes divisas(moneda) en su billetera  varios tipos de cambio*/
CREATE TABLE Billetera_de_Monedas (
  billetera_id INT PRIMARY KEY AUTO_INCREMENT,
    userBill_id INT NOT NULL,
    moneda_id INT NOT NULL, 
    FOREIGN KEY (userBill_id) REFERENCES Usuario(user_id),
    FOREIGN KEY (moneda_id) REFERENCES Moneda(currency_id)
);

-- Insertamos valores en la tabla Usuario
INSERT INTO Usuario (user_id,Nombre,correoElectronico,contrasena,saldo)
VALUES  (1,'Hugo','hugo@example.com','123456',100500.00),
    (2,'Paco','paco@example.com','654321',18000.00),
        (3,'Luis','luis@example.com','0000007',7000.00),
        (4,'Donald','donald@example.com','66669999',20000.00),
    (5,'Mickey','mickey@example.com','246810',500000.00);

 INSERT INTO Usuario (user_id,Nombre,correoElectronico,contrasena,saldo)
VALUES  (6,'Mario','mario@example.com','888888',20100.00),       
        (7,'Luigi','luigi@example.com','777777',31000.00), 
        (8,'Zelda','zelda@example.com','555555',1200.00), 
        (9,'Pacman','pacman@example.com','444444',32000000.00), 
        (10,'Donkey','donkey@example.com','111111',100.00);

 -- Insertamos valores en la tabla Moneda
INSERT INTO Moneda (currency_id,currency_name, currency_symbol)
VALUES  (1,'Peso chileno','$'),
    (2,'Dolar','$'),
    (3,'Euro','€');

INSERT INTO Moneda (currency_id,currency_name, currency_symbol)
VALUES  (4,'Libra esterlina','£'),
        (5,'Franco suizo','₣'),
    (6,'Yen japonés','¥'),
    (7,'Rublo ruso','р.'),
        (8,'Yuan chino','¥'); 

 -- Insertamos valores en la tabla Transaccion
INSERT INTO Transaccion (importe, transaction_date, sender_user_id, receiver_user_id, currency_id)
VALUES  (100.00, '2024-04-01', 1, 2, 2),
      (500.00, '2024-04-01', 3, 4, 2),
        (50.00, '2024-03-02', 3, 1, 3),
        (200.00, '2024-04-01', 2, 4, 2), 
        (5000.00, '2024-04-02', 5, 3, 1),
        (800.00, '2024-04-03', 4, 5, 3), 
        (560.00, '2024-04-04', 5, 1, 1),
        (730.00, '2024-04-04', 2, 3, 3);


 -- Insertamos valores en la tabla Billetera_de_Monedas
INSERT INTO Billetera_de_Monedas (billetera_id, userBill_id, moneda_id)
VALUES (1, 5, 1),   -- Asigna el usuario 5 Mickey con la moneda 1 peso chileno  a la billetera con ID 1
       (2, 2, 3),   -- Asigna el usuario 2 con la moneda 3 a la billetera con ID 2
       (3, 5, 2),   -- Asigna el usuario 5 con la moneda 2 a la billetera con ID 3
       (4, 2, 1),   -- Asigna el usuario 2 con la moneda 1 a la billetera con ID 4
       (5, 4, 2),   -- Asigna el usuario 4 con la moneda 2 a la billetera con ID 5
       (6, 4, 3),   -- Asigna el usuario 4 con la moneda 3 a la billetera con ID 6
       (7, 1, 2),   -- Asigna el usuario 1 con la moneda 2 a la billetera con ID 7
       (8, 1, 3),   -- Asigna el usuario 1 con la moneda 3 a la billetera con ID 8
       (9, 3, 2),   -- Asigna el usuario 3 con la moneda 2 a la billetera con ID 9
       (10, 5, 3),  -- Asigna el usuario 5 con la moneda 3 a la billetera con ID 10
       (11, 3, 1),  -- Asigna el usuario 3 con la moneda 1 a la billetera con ID 11
       (12, 2, 2),  -- Asigna el usuario 2 con la moneda 2 a la billetera con ID 12
       (13, 3, 3),  -- Asigna el usuario 3 con la moneda 3 a la billetera con ID 13
       (14, 4, 1),  -- Asigna el usuario 4 con la moneda 1 a la billetera con ID 14
       (15, 1, 1);  -- Asigna el usuario 1 con la moneda 1 a la billetera con ID 15

 INSERT INTO Billetera_de_Monedas (userBill_id, moneda_id)
VALUES   ( 6, 5),   (7, 7),  (8, 5),  (9,7),  ( 10, 5),  ( 7, 5), 
         ( 2, 6),  (5, 6),  (7, 8),  ( 8, 8); 


 /* CONSULTAS*/

-- a. Consulta para obtener el nombre de la moneda elegida por un usuario especifico (ejemplo Hugo id=1) 

SELECT U.Nombre AS Nombre_Usuario, M.currency_name AS Nombre_Moneda, T.importe, T.transaction_date
FROM Usuario U
JOIN Billetera_de_Monedas B ON U.user_id = B.userBill_id
JOIN Moneda M ON B.moneda_id = M.currency_id
LEFT JOIN Transaccion T ON (U.user_id = T.sender_user_id OR U.user_id = T.receiver_user_id)
WHERE U.user_id = 1;


-- b. Consulta para obtener todas las transacciones realizadas (enviadas y recibidas) por un usuario especifico   (ejemplo Paco id= 2)      

SELECT t.transaction_id, t.importe, t.transaction_date,
       u_sender.Nombre AS sender_name, u_receiver.Nombre AS receiver_name,
       t.currency_id
FROM Transaccion t
JOIN Usuario u_sender ON t.sender_user_id = u_sender.user_id
JOIN Usuario u_receiver ON t.receiver_user_id = u_receiver.user_id
WHERE t.sender_user_id = 2 OR t.receiver_user_id = 2;


-- c. Consulta para obtener todos los usuarios registrados

SELECT *
FROM Usuario;   -- consulta de todos los usuarios con sus transacciones

SELECT Nombre
FROM Usuario;   -- muestra solo los nombres de usuarios registrados en la tabla "Usuario"


-- d. Consulta para obtener todas las monedas registradas

SELECT *
FROM Moneda;   -- consulta la tabla moneda con sus datos

SELECT currency_name 
FROM Moneda;   -- consulta solo las monedas especificamente

-- e. Consulta para obtener todas las transacciones registradas

SELECT *
FROM Transaccion;

-- Consulta para obtener todas las transacciones registradas incluyendo los nombres de usuarios que hicieron las operaciones 
SELECT 
    T.transaction_id,
    T.importe,
    T.transaction_date,
    U_sender.Nombre AS sender_name,
    U_receiver.Nombre AS receiver_name,
    M.currency_name
FROM 
    Transaccion T
INNER JOIN 
    Usuario U_sender ON T.sender_user_id = U_sender.user_id
INNER JOIN 
    Usuario U_receiver ON T.receiver_user_id = U_receiver.user_id
INNER JOIN 
    Moneda M ON T.currency_id = M.currency_id;


-- Consulta para obtener todas las divisas de los usuarios en sus billeteras digitales registradas
SELECT DISTINCT m.currency_id, m.currency_name, m.currency_symbol
FROM Billetera_de_Monedas b
JOIN Moneda m ON b.moneda_id = m.currency_id;


-- f. Consulta para obtener todas las transacciones realizadas (enviadas) por un usuario específico: ejemplo (Mickey, id= 5)

SELECT 
    T.transaction_id,
    T.importe,
    T.transaction_date,
    U_sender.Nombre AS emisor,
    U_receiver.Nombre AS receptor,
    M.currency_name
FROM 
    Transaccion T
INNER JOIN 
    Usuario U_sender ON T.sender_user_id = U_sender.user_id
INNER JOIN 
    Usuario U_receiver ON T.receiver_user_id = U_receiver.user_id
INNER JOIN 
    Moneda M ON T.currency_id = M.currency_id
WHERE 
    U_sender.user_id = 5;



-- g. Consulta para obtener todas las transacciones recibidas por un usuario específico: ejemplo (Donald, id= 4)

SELECT 
    T.transaction_id,
    T.importe,
    T.transaction_date,
    U_receiver.Nombre AS receptor,
    U_sender.Nombre AS emisor,
    M.currency_name
FROM 
    Transaccion T
INNER JOIN 
    Usuario U_receiver ON T.receiver_user_id = U_receiver.user_id
INNER JOIN 
    Usuario U_sender ON T.sender_user_id = U_sender.user_id
INNER JOIN 
    Moneda M ON T.currency_id = M.currency_id
WHERE 																																										
    U_receiver.user_id = 3
ORDER BY T.transaction_date DESC;

-- h. Sentencia DML para modificar el campo correo electrónico de un usuario específico:(ejemplo donald  = 'donald@example.com')

UPDATE Usuario
SET correoElectronico = 'donaldydaisy@example.com'
WHERE user_id = 4;
ROLLBACK;
-- j. Sentencia para eliminar los datos de una transacción (eliminado de la fila completa) (ejemplo (1,100.00, '2024-04-01', 1, 2, 2))

DELETE FROM Transaccion
WHERE transaction_id = 1; 

-- k. Sentencia para DDL modificar el nombre de la columna correoElectronico por email

ALTER TABLE Usuario
CHANGE COLUMN  correoElectronico 
email  VARCHAR (100) NOT NULL;
