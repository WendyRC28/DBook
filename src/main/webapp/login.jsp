<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Book Management — Login</title>
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #1a1a2e, #16213e);
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .card { border-radius: 20px; box-shadow: 0 20px 60px rgba(0,0,0,0.4); }
        .btn-primary { background: #0077b6; border: none; }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card p-4">
                <h3 class="text-center mb-4">📚 Book Management</h3>
                <p class="text-center text-muted">Ingresa con tu correo institucional UV</p>

                <!-- Si el servlet mandó un error, se muestra aquí -->
                <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger">
                        <%= request.getAttribute("error") %>
                    </div>
                <% } %>

                <!-- El action="/login" llama al ServletLogin con doPost -->
                <form action="<%= request.getContextPath() %>/login" method="post">
                    <div class="mb-3">
                        <label class="form-label">Correo UV</label>
                        <input type="email" name="correo" class="form-control"
                               placeholder="usuario@uv.mx" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Contraseña</label>
                        <input type="password" name="contrasena" class="form-control" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Entrar</button>
                </form>

                <hr>
                <p class="text-center mt-2">
                    ¿No tienes cuenta?
                    <a href="<%= request.getContextPath() %>/registro">Regístrate aquí</a>
                </p>
            </div>
        </div>
    </div>
</div>
</body>
</html>