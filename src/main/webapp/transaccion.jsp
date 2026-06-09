<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>DBOOK — <c:out value="${tipo == 'compra' ? 'Comprar libro' : 'Intercambiar libro'}"/></title>
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@500;600;700&family=Manrope:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
  :root{
    --navy:#182a40; --teal:#2dd4bf; --blue:#1652d6; --blue-deep:#0f3fb0;
    --ink:#1c2733; --muted:#6b7785; --line:#e3e8ee; --bg:#f0f2f7;
    --danger-bg:#fde8e8; --danger-tx:#b3261e;
  }
  *{box-sizing:border-box;margin:0;padding:0}
  body{font-family:"Manrope",sans-serif;color:var(--ink);background:var(--bg);min-height:100vh}

  header{background:var(--navy);color:#fff;padding:0 28px;height:58px;display:flex;align-items:center;gap:14px;box-shadow:0 2px 12px rgba(8,15,30,.25)}
  header img.logo{height:32px}
  .hinfo .htitle{font-family:"Outfit",sans-serif;font-size:17px;font-weight:600}
  .hinfo .bread{font-size:13px;color:#8ba8c0}
  .hinfo .bread span{color:#fff;font-weight:600}
  header a.back{margin-left:auto;color:#bfe9e1;text-decoration:none;font-size:13.5px;font-weight:600;padding:7px 14px;border-radius:8px;border:1px solid rgba(45,212,191,.3);transition:background .15s}
  header a.back:hover{background:rgba(45,212,191,.12)}

  .page{max-width:1000px;margin:26px auto 48px;padding:0 22px;display:grid;grid-template-columns:1fr 360px;gap:22px;align-items:start}

  /* Libro */
  .libro-card{background:#fff;border-radius:16px;padding:22px;box-shadow:0 4px 16px rgba(8,15,30,.08);margin-bottom:18px;display:flex;align-items:center;gap:16px}
  .libro-icon{width:52px;height:52px;border-radius:12px;background:linear-gradient(135deg,var(--navy),#2a4a6b);display:flex;align-items:center;justify-content:center;font-size:24px;flex-shrink:0}
  .libro-info .titulo{font-family:"Outfit",sans-serif;font-weight:700;font-size:17px}
  .libro-info .autor{font-size:13.5px;color:var(--muted);margin-top:3px}
  .libro-info .precio-tag{font-family:"Outfit",sans-serif;font-weight:700;font-size:18px;color:var(--blue);margin-top:6px}
  .badge{font-size:12px;font-weight:700;padding:4px 10px;border-radius:999px;display:inline-block;margin-top:6px}
  .badge.intercambio{background:rgba(22,82,214,.1);color:#1652d6}
  .badge.compra{background:rgba(180,120,0,.12);color:#9a6b00}

  /* Sección */
  .sec-title{font-family:"Outfit",sans-serif;font-size:16px;font-weight:700;margin-bottom:12px}

  /* Mis libros (intercambio) */
  .mis-libros{display:grid;grid-template-columns:1fr 1fr;gap:10px;margin-bottom:20px}
  .libro-opt{border:2px solid var(--line);border-radius:12px;padding:14px;cursor:pointer;background:#fff;transition:all .15s}
  .libro-opt:hover{border-color:#b0c8d8}
  .libro-opt input[type=radio]{display:none}
  .libro-opt.sel{border-color:var(--teal);background:rgba(45,212,191,.06);box-shadow:0 0 0 3px rgba(45,212,191,.15)}
  .libro-opt .opt-titulo{font-weight:700;font-size:13.5px;margin-bottom:3px}
  .libro-opt .opt-autor{font-size:12px;color:var(--muted)}
  .sin-libros{background:#fff;border:1px dashed var(--line);border-radius:12px;padding:18px;text-align:center;color:var(--muted);font-size:13.5px;margin-bottom:20px}

  /* Panel derecho */
  .right-card{background:#fff;border-radius:18px;padding:26px;box-shadow:0 4px 20px rgba(8,15,30,.08);position:sticky;top:24px}
  .right-card h3{font-family:"Outfit",sans-serif;font-size:17px;font-weight:700;margin-bottom:4px}
  .right-card .sub{color:var(--muted);font-size:13.5px;margin-bottom:20px}
  .slabel{font-size:11px;font-weight:700;color:var(--muted);letter-spacing:.7px;text-transform:uppercase;margin:18px 0 10px;display:flex;align-items:center;gap:8px}
  .slabel::after{content:'';flex:1;height:1px;background:var(--line)}

  /* Zonas como opciones seleccionables */
  .zona-opts{display:flex;flex-direction:column;gap:8px}
  .zona-opt{border:1.5px solid var(--line);border-radius:11px;padding:12px 14px;cursor:pointer;background:#fafbfd;transition:all .15s;display:flex;align-items:center;gap:10px}
  .zona-opt:hover{border-color:#b0c8d8}
  .zona-opt input[type=radio]{accent-color:var(--teal);width:16px;height:16px;flex-shrink:0}
  .zona-opt.sel{border-color:var(--teal);background:rgba(45,212,191,.06);box-shadow:0 0 0 3px rgba(45,212,191,.12)}
  .zona-opt .z-nombre{font-weight:700;font-size:13.5px}
  .zona-opt .z-desc{font-size:12px;color:var(--muted);margin-top:2px}

  /* Botón */
  .btn{width:100%;margin-top:20px;font-family:"Outfit",sans-serif;font-weight:600;font-size:15px;color:#fff;padding:14px;border:0;border-radius:12px;cursor:pointer;background:linear-gradient(120deg,var(--blue) 0%,var(--blue-deep) 55%,var(--teal) 165%);box-shadow:0 8px 20px rgba(22,82,214,.3);transition:filter .15s}
  .btn:hover{filter:brightness(1.06)}
  .aviso{background:rgba(245,166,35,.1);border:1.5px solid rgba(245,166,35,.4);border-radius:10px;padding:12px;font-size:13px;color:#7a5c00;margin-top:14px;line-height:1.4}
</style>
</head>
<body>

  <header>
    <img class="logo" src="${pageContext.request.contextPath}/img/dbook-logo.png" alt="DBOOK">
    <div class="hinfo">
      <div class="htitle">DBOOK</div>
      <div class="bread">Inicio /
        <span><c:out value="${tipo == 'compra' ? 'Comprar libro' : 'Intercambiar libro'}"/></span>
      </div>
    </div>
    <a class="back" href="${pageContext.request.contextPath}/inicio">← Volver al catálogo</a>
  </header>

  <div class="page">

    <%-- Columna izquierda --%>
    <div>
      <%-- Info del libro --%>
      <div class="libro-card">
        <div class="libro-icon">📚</div>
        <div class="libro-info">
          <div class="titulo">${libro.titulo}</div>
          <div class="autor">${libro.autor} &nbsp;·&nbsp; ${libro.carrera}</div>
          <c:if test="${tipo == 'compra'}">
            <div class="precio-tag">$ ${libro.precio}</div>
          </c:if>
          <span class="badge ${tipo}">
            <c:out value="${tipo == 'compra' ? 'En venta' : 'Intercambio'}"/>
          </span>
        </div>
      </div>

      <%-- Solo para intercambio: elegir qué libro ofrecer --%>
      <c:if test="${tipo == 'intercambio'}">
        <div class="sec-title">¿Qué libro ofreces a cambio?</div>
        <c:choose>
          <c:when test="${empty misLibros}">
            <div class="sin-libros">
              No tienes libros publicados para ofrecer.<br>
              <a href="${pageContext.request.contextPath}/publicar" style="color:var(--blue);font-weight:600">Publica uno primero →</a>
            </div>
          </c:when>
          <c:otherwise>
            <div class="mis-libros" id="misLibros">
              <c:forEach var="ml" items="${misLibros}">
                <div class="libro-opt" onclick="seleccionarLibro(this, '${ml.titulo}')">
                  <input type="radio" name="libroOpt" value="${ml.titulo}">
                  <div class="opt-titulo">${ml.titulo}</div>
                  <div class="opt-autor">${ml.autor}</div>
                </div>
              </c:forEach>
            </div>
          </c:otherwise>
        </c:choose>
      </c:if>
    </div>

    <%-- Columna derecha: zona + confirmar --%>
    <div class="right-card">
      <h3>
        <c:out value="${tipo == 'compra' ? 'Confirmar compra' : 'Confirmar intercambio'}"/>
      </h3>
      <p class="sub">Elige dónde se realizará la entrega dentro del campus UV.</p>

      <form method="post" action="${pageContext.request.contextPath}/transaccion" id="formTrans">
        <input type="hidden" name="idLibro"       value="${libro.id}">
        <input type="hidden" name="tipo"          value="${tipo}">
        <input type="hidden" name="libroOfrecido" id="libroOfrecido" value="">

        <div class="slabel">Zona de encuentro</div>
        <div class="zona-opts">
          <c:forEach var="z" items="${zonas}">
            <label class="zona-opt" onclick="resaltarZona(this)">
              <input type="radio" name="zona" value="${z.nombre}" required>
              <div>
                <div class="z-nombre">${z.nombre}</div>
                <div class="z-desc">${z.descripcion}</div>
              </div>
            </label>
          </c:forEach>
        </div>

        <button type="submit" class="btn">
          <c:out value="${tipo == 'compra' ? '✓ Confirmar compra' : '✓ Confirmar intercambio'}"/>
        </button>
      </form>

      <div class="aviso">
        ⚠ La transacción queda en estado <strong>pendiente</strong>. El publicador se comunicará contigo para coordinar.
      </div>
    </div>

  </div>

<script>
  // Resalta la zona seleccionada
  function resaltarZona(label) {
    document.querySelectorAll(".zona-opt").forEach(function(l){ l.classList.remove("sel"); });
    label.classList.add("sel");
  }

  // Resalta el libro ofrecido y actualiza el campo oculto
  function seleccionarLibro(card, titulo) {
    document.querySelectorAll(".libro-opt").forEach(function(c){ c.classList.remove("sel"); });
    card.classList.add("sel");
    document.getElementById("libroOfrecido").value = titulo;
  }
</script>
</body>
</html>