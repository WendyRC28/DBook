<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DBook - Biblioteca Virtual UV</title>
    <link rel="stylesheet" href="css/estilos.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
</head>
<body>

    <div class="contenedor">

        <!-- LADO IZQUIERDO -->
        <div class="lado-izquierdo">
            <div class="marca">
                <h1 class="logo">DBook</h1>
                <p class="slogan">Biblioteca virtual universitaria</p>
            </div>

            <div class="descripcion">
                <p>Intercambia, vende y dona libros</p>
                <p>con otros universitarios UV.</p>
            </div>

            <div class="roles">
                <div class="chips">
                    <span class="chip">alumno</span>
                    <span class="chip">profesor</span>
                </div>
                <p class="roles-texto">Acceso con correo institucional</p>
            </div>
        </div>

        <!-- LADO DERECHO -->
        <div class="lado-derecho">
            <div class="formulario">

                <h2 class="titulo-form">Bienvenido</h2>
                <p class="subtitulo-form">Ingresa con tu correo institucional</p>

                <div class="pestanas">
                    <button class="btn-pestana activo">Iniciar sesion</button>
                    <button class="btn-pestana">Registrarse</button>
                </div>

                <div class="campo">
                    <label>Correo UV</label>
                    <input type="email" placeholder="usuario@uv.mx">
                </div>

                <div class="campo">
                    <label>Contrasena</label>
                    <input type="password" placeholder="••••••••">
                </div>

                <button class="btn-entrar">Entrar</button>

                <a href="#" class="link-olvide">¿Olvidaste tu contrasena?</a>

            </div>
        </div>

    </div>

</body>
</html>