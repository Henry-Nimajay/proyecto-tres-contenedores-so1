CREATE TABLE contactos (
    id SERIAL PRIMARY KEY,
    nombre TEXT,
    telefono TEXT
);

INSERT INTO contactos (nombre, telefono) VALUES ('Juan Perez', '5544-3322');
