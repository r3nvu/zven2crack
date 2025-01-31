Aquí tienes todo el contenido en formato Markdown, sin detalles fuera:

# zven2crack

**zven2crack** es una herramienta de línea de comandos para realizar ataques de diccionario a archivos `.7z` y `.zip` protegidos por contraseña. Utiliza un archivo de diccionario de contraseñas y prueba cada entrada hasta encontrar la correcta.

## Requisitos

- **Rust**: Instalar desde [rust-lang.org](https://www.rust-lang.org/).
- **7-Zip (p7zip)**: Requerido para archivos `.7z`. Instalar con:

  ```bash
  sudo apt install p7zip-full  # Debian/Ubuntu
  brew install p7zip           # macOS

Instalación
	1.	Clona el repositorio:

git clone https://github.com/tu_usuario/zven2crack.git
cd zven2crack


	2.	Compila el proyecto:

cargo build --release



Uso

Sintaxis

cargo run <archivo_comprimido> <diccionario>

	•	<archivo_comprimido>: Ruta al archivo .7z o .zip.
	•	<diccionario>: Ruta al archivo de diccionario de contraseñas.

Ejemplo

cargo run ./targetz/test_target.7z ./dictionaries/10k-worst-passwords.txt

Estructura del Proyecto

zven2crack/
├── dictionaries/             # Contiene los diccionarios de contraseñas.
├── src/                      # Código fuente de la aplicación.
│   ├── main.rs               # Entrada principal del programa.
│   ├── zip_attack.rs         # Funciones para ataque a archivos ZIP.
│   └── sevenz_attack.rs      # Funciones para ataque a archivos 7z.
├── targetz/                  # Archivos comprimidos a atacar.
│   └── test_target.7z        # Ejemplo de archivo 7z.
├── Cargo.toml                # Archivo de configuración de Cargo.
└── README.md                 # Documentación del proyecto.

Funcionamiento
	1.	Carga del diccionario: La herramienta carga un archivo de diccionario de contraseñas proporcionado como argumento y lee las contraseñas línea por línea.
	2.	Ataque a archivos .zip: Si el archivo proporcionado es un archivo .zip, la herramienta intentará descifrarlo usando las contraseñas del diccionario mediante la librería zip.
	3.	Ataque a archivos .7z: Si el archivo proporcionado es un archivo .7z, se utilizará la librería sevenz_rust para intentar descifrarlo con las contraseñas.
	4.	Proceso de prueba: La herramienta prueba cada contraseña del diccionario, una por una, y muestra en la terminal cuántas contraseñas han sido probadas. Si se encuentra la contraseña correcta, la herramienta termina y muestra un mensaje indicando el número de intentos realizados.

Contribuciones

Las contribuciones son bienvenidas. Si tienes alguna mejora o arreglo, por favor abre un pull request.

Licencia

Este proyecto está licenciado bajo la MIT License.

Este es todo el contenido en Markdown, ajustado a tus peticiones.
