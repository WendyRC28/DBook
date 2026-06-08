<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>DBOOK — Inicio</title>
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@500;600;700&family=Manrope:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
  :root{
    --navy:#182a40; --teal:#2dd4bf; --blue:#1652d6;
    --ink:#1c2733; --muted:#6b7785; --line:#e7ebf0; --bg:#f4f6f9; --star:#f5a623;
  }
  *{box-sizing:border-box;margin:0;padding:0}
  body{font-family:"Manrope",sans-serif;color:var(--ink);background:var(--bg)}

  header{background:var(--navy);color:#fff;padding:14px 22px;display:flex;align-items:center;gap:12px}
  header img.logo{height:34px}
  header .hi{font-family:"Outfit",sans-serif;font-size:16px;font-weight:600}
  header .hi span{color:var(--teal)}
  header a.salir{margin-left:auto;color:#bfe9e1;text-decoration:none;font-size:14px;font-weight:600}
  header a.salir:hover{text-decoration:underline}

  .container{max-width:1000px;margin:0 auto;padding:22px 18px 40px}

  /* Menú con imágenes */
  .menu{display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:16px;margin-bottom:28px}
  .menu a{
    text-decoration:none;display:block;border-radius:14px;overflow:hidden;
    border:1px solid var(--line);box-shadow:0 2px 8px rgba(8,15,30,.07);
    transition:transform .12s ease, box-shadow .15s;
  }
  .menu a:hover{transform:translateY(-4px);box-shadow:0 14px 32px rgba(8,15,30,.15)}
  .menu a img{width:100%;height:auto;display:block}

  h2{font-family:"Outfit",sans-serif;font-size:19px;margin-bottom:6px}
  .sub{color:var(--muted);font-size:14px;margin-bottom:16px}

  .filtros{display:flex;flex-wrap:wrap;gap:8px;margin-bottom:18px}
  .filtros button{
    font-family:inherit;font-size:13.5px;font-weight:600;cursor:pointer;padding:8px 14px;
    border:1.5px solid var(--line);border-radius:999px;background:#fff;color:#43505d;transition:all .15s;
  }
  .filtros button.active{background:var(--navy);color:#fff;border-color:var(--navy)}

  .grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(220px,1fr));gap:16px}
  .libro{background:#fff;border:1px solid var(--line);border-radius:14px;padding:18px;display:flex;flex-direction:column;gap:6px}
  .libro .titulo{font-family:"Outfit",sans-serif;font-weight:600;font-size:15.5px;line-height:1.3}
  .libro .autor{font-size:13.5px;color:var(--muted)}
  .libro .meta{font-size:12.5px;color:var(--muted);margin-top:2px}
  .badge{align-self:flex-start;font-size:11.5px;font-weight:700;padding:4px 10px;border-radius:999px;margin-top:8px;text-transform:capitalize}
  .badge.intercambio{background:rgba(22,82,214,.12);color:#1652d6}
  .badge.venta{background:rgba(180,120,0,.14);color:#9a6b00}
  .badge.donacion{background:rgba(15,122,94,.14);color:#0f7a5e}
  .precio{font-family:"Outfit",sans-serif;font-weight:700;font-size:15px;margin-top:6px}
  .rating{font-size:13px;font-weight:600;margin-top:6px;color:#3a4654}
  .rating .star{color:var(--star)}
  .rating.sin{color:var(--muted);font-weight:500}
  .vacio{background:#fff;border:1px dashed var(--line);border-radius:14px;padding:40px;text-align:center;color:var(--muted)}
</style>
</head>
<body>
  <header>
    <img class="logo" src="${pageContext.request.contextPath}/img/dbook-logo.png" alt="DBOOK">
    <div class="hi">Hola, <span>${usuarioLogueado.nombre}</span></div>
    <a class="salir" href="${pageContext.request.contextPath}/login">Cerrar sesión</a>
  </header>

  <div class="container">

    <%-- Menú: cada tarjeta ES la imagen, ya trae título y descripción dentro --%>
    <div class="menu">
      <a href="${pageContext.request.contextPath}/publicar">
        <img src="${pageContext.request.contextPath}/img/publicarlibro.jpg" alt="Publicar libro">
      </a>
      <a href="${pageContext.request.contextPath}/zonas">
        <img src="${pageContext.request.contextPath}/img/zonasegura.jpg" alt="Zonas seguras">
      </a>
      <a href="${pageContext.request.contextPath}/foro">
        <img src="${pageContext.request.contextPath}/img/foro.jpg" alt="Foro">
      </a>
    </div>

    <h2>Catálogo de libros</h2>
    <p class="sub">Explora los libros publicados por la comunidad UV.</p>

    <div class="filtros" id="filtros">
      <button class="active" data-f="todos">Todos</button>
      <button data-f="intercambio">Intercambio</button>
      <button data-f="venta">Venta</button>
      <button data-f="donacion">Donación</button>
    </div>

    <c:choose>
      <c:when test="${empty libros}">
        <div class="vacio">Todavía no hay libros publicados. ¡Sé la primera en publicar uno!</div>
      </c:when>
      <c:otherwise>
        <div class="grid" id="grid">
          <c:forEach var="libro" items="${libros}">
            <div class="libro" data-estado="${libro.estado}">
              <div class="titulo">${libro.titulo}</div>
              <div class="autor">${libro.autor}</div>
              <div class="meta">Carrera: ${libro.carrera}</div>
              <span class="badge ${libro.estado}">${libro.estado}</span>

              <c:choose>
                <c:when test="${libro.totalCalificaciones > 0}">
                  <div class="rating">
                    <span class="star">★</span>
                    <fmt:formatNumber value="${libro.calificacionPromedio}" maxFractionDigits="1" minFractionDigits="1"/>
                    <span style="color:#9aa4af;font-weight:500">(${libro.totalCalificaciones})</span>
                  </div>
                </c:when>
                <c:otherwise>
                  <div class="rating sin">Sin calificaciones</div>
                </c:otherwise>
              </c:choose>

              <c:if test="${libro.estado == 'venta'}">
                <div class="precio">$ ${libro.precio}</div>
              </c:if>
              <div class="meta">Publicado por ${libro.nombreUsuario}</div>
            </div>
          </c:forEach>
        </div>
      </c:otherwise>
    </c:choose>

  </div>

<script>
  var botones = document.querySelectorAll("#filtros button");
  botones.forEach(function(b){
    b.addEventListener("click", function(){
      botones.forEach(function(x){ x.classList.remove("active"); });
      b.classList.add("active");
      var filtro = b.dataset.f;
      document.querySelectorAll(".libro").forEach(function(card){
        var mostrar = (filtro === "todos") || (card.dataset.estado === filtro);
        card.style.display = mostrar ? "" : "none";
      });
    });
  });
</script>
</body>
</html>