# zven2crack

Este proyecto tiene como objetivo la automatización del crackeo de archivos `.7z` utilizando un diccionario de contraseñas. Los archivos de diccionario se encuentran en el directorio `dictionaries`.

## Estructura del Proyecto

zven2crack/
│
├── dictionaries/        # Diccionarios de contraseñas
├── src/                 # Código fuente de la aplicación
├── target/              # Archivos de registro para depuración
└── README.md            # Documentación del proyecto

## Instalación y Compilación

### Requisitos

- Un sistema basado en Linux (por ejemplo, Ubuntu).
- Acceso a terminal con privilegios de `sudo`.

### Pasos para la instalación

1. **Ejecuta el script `run.sh`**:
   El proyecto incluye un script `run.sh` que automatiza la instalación de las dependencias necesarias. Para ejecutarlo, sigue estos pasos:

   ```bash
   chmod +x run.sh  # Da permisos de ejecución al script
   ./run.sh         # Ejecuta el script para actualizar e instalar dependencias

El script realiza las siguientes acciones:
	•	Actualiza el sistema.
	•	Instala las dependencias necesarias como build-essential y curl.
	•	Instala Rust y Cargo (el gestor de paquetes de Rust).
	•	Configura las variables de entorno necesarias para Rust.

	2.	Configuración de entorno:
Al ejecutar el script run.sh, las variables de entorno necesarias para Rust serán configuradas automáticamente. Sin embargo, si necesitas hacer esto manualmente, puedes añadir lo siguiente a tu archivo ~/.bashrc:

export CARGO_HOME="$HOME/.cargo"
export RUSTUP_HOME="$HOME/.rustup"
export PATH="$CARGO_HOME/bin:$PATH"


	3.	Compilación del Proyecto:
Una vez que las dependencias estén instaladas, entra en el directorio zven2crack y compila el proyecto con los siguientes comandos:

cd zven2crack   # Entra al directorio del proyecto
cargo build     # Compila el proyecto
cargo run       # Ejecuta el proyecto



Uso

Una vez que el proyecto esté compilado, puedes usarlo de la siguiente manera:

cargo run <ruta_del_archivo_7z> <ruta_del_diccionario>

Donde:
	•	<ruta_del_archivo_7z> es el archivo .7z que deseas atacar.
	•	<ruta_del_diccionario> es el archivo de texto que contiene el diccionario de contraseñas que será probado.

Por ejemplo, para atacar un archivo test.7z con un diccionario llamado passwords.txt:

cargo run ./targetz/test_target.7z ./dictionaries/10k-worst-passwords.txt

Salida esperada

El programa probará las contraseñas del diccionario en el archivo .7z. Si encuentra la correcta, mostrará un mensaje indicando la contraseña encontrada y cuántas contraseñas se probaron.

Notas
	•	Se recomienda usar diccionarios grandes para mejorar las posibilidades de éxito, como el archivo 10k-worst-passwords.txt que se incluye en el proyecto.
	•	Si el archivo .7z está protegido con una contraseña, el programa continuará probando las contraseñas hasta encontrar la correcta.

Este archivo `README.md` tiene una estructura organizada y proporciona instrucciones claras sobre cómo instalar, compilar y ejecutar el proyecto, haciendo énfasis en la instalación y la configuración del entorno.

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
