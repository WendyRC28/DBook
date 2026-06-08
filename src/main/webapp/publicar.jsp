<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>DBOOK — Publicar libro</title>
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@500;600;700&family=Manrope:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
  :root{
    --navy:#182a40; --teal:#2dd4bf; --blue:#1652d6; --blue-deep:#0f3fb0;
    --ink:#1c2733; --muted:#6b7785; --line:#e3e8ee; --bg:#f0f2f7;
    --danger-bg:#fde8e8; --danger-tx:#b3261e;
  }
  *{box-sizing:border-box;margin:0;padding:0}
  body{font-family:"Manrope",sans-serif;color:var(--ink);background:var(--bg);min-height:100vh}

  /* ── Header ── */
  header{
    background:var(--navy);color:#fff;padding:0 28px;height:58px;
    display:flex;align-items:center;gap:14px;
    box-shadow:0 2px 12px rgba(8,15,30,.25);
  }
  header img.logo{height:32px}
  .header-title{font-family:"Outfit",sans-serif;font-size:17px;font-weight:600}
  .breadcrumb{font-size:13px;color:#8ba8c0;margin-left:4px}
  .breadcrumb span{color:#fff;font-weight:600}
  header a.back{
    margin-left:auto;color:#bfe9e1;text-decoration:none;font-size:13.5px;font-weight:600;
    display:flex;align-items:center;gap:6px;padding:7px 14px;border-radius:8px;
    border:1px solid rgba(45,212,191,.3);transition:background .15s;
  }
  header a.back:hover{background:rgba(45,212,191,.12)}

  /* ── Layout dos columnas ── */
  .page{max-width:1060px;margin:28px auto 48px;padding:0 22px;display:grid;grid-template-columns:1fr 380px;gap:22px;align-items:start}

  /* ── Columna izquierda: formulario ── */
  .form-card{background:#fff;border-radius:18px;padding:32px 36px;box-shadow:0 4px 20px rgba(8,15,30,.08)}

  .form-head{margin-bottom:22px}
  .form-head h2{font-family:"Outfit",sans-serif;font-size:22px;font-weight:700}
  .form-head p{color:var(--muted);font-size:14px;margin-top:4px}

  .banner{font-size:13.5px;padding:11px 14px;border-radius:10px;margin-bottom:18px;line-height:1.35;display:none}
  .banner.err{display:block;background:var(--danger-bg);color:var(--danger-tx)}

  .section-label{
    font-size:11.5px;font-weight:700;color:var(--muted);letter-spacing:.8px;
    text-transform:uppercase;margin:22px 0 14px;display:flex;align-items:center;gap:8px;
  }
  .section-label::after{content:'';flex:1;height:1px;background:var(--line)}

  .field{margin-bottom:14px}
  .field label{display:block;font-size:13.5px;font-weight:600;margin-bottom:6px;color:#36424f}
  .field input{
    width:100%;font-size:15px;font-family:inherit;color:var(--ink);padding:12px 14px;
    border:1.5px solid var(--line);border-radius:10px;background:#fafbfd;
    transition:border-color .15s,box-shadow .15s;
  }
  .field input:focus{outline:none;border-color:var(--teal);background:#fff;box-shadow:0 0 0 4px rgba(45,212,191,.14)}

  /* Tipo de oferta: tarjetas con imagen */
  .tipo-grid{display:grid;grid-template-columns:1fr 1fr 1fr;gap:10px}
  .tipo-card{
    border:2px solid var(--line);border-radius:14px;padding:14px 8px 12px;
    display:flex;flex-direction:column;align-items:center;gap:7px;
    cursor:pointer;background:#fafbfd;transition:all .15s;
  }
  .tipo-card:hover{border-color:#b0c8d8;transform:translateY(-2px);box-shadow:0 6px 16px rgba(8,15,30,.08)}
  .tipo-card img{width:64px;height:64px;object-fit:contain}
  .tipo-card span{font-family:"Outfit",sans-serif;font-size:13.5px;font-weight:600;color:#36424f}
  .tipo-card.active{border-color:var(--teal);background:rgba(45,212,191,.06);box-shadow:0 0 0 3px rgba(45,212,191,.18)}
  .tipo-card.active span{color:#0b5e52}

  #campoPrecio{display:none}

  .btn{
    width:100%;margin-top:24px;font-family:"Outfit",sans-serif;font-weight:600;font-size:16px;color:#fff;
    padding:14px;border:0;border-radius:12px;cursor:pointer;letter-spacing:.3px;
    background:linear-gradient(120deg,var(--blue) 0%,var(--blue-deep) 55%,var(--teal) 165%);
    box-shadow:0 8px 20px rgba(22,82,214,.32);transition:filter .15s,transform .08s;
  }
  .btn:hover{filter:brightness(1.06)}
  .btn:active{transform:translateY(1px)}

  /* ── Columna derecha: panel visual (sticky) ── */
  .visual{position:sticky;top:24px;border-radius:18px;overflow:hidden;box-shadow:0 4px 20px rgba(8,15,30,.12)}
  .visual img.banner-img{width:100%;display:block;height:210px;object-fit:cover;object-position:center}
  .visual-body{background:var(--navy);padding:24px}
  .visual-body h3{font-family:"Outfit",sans-serif;color:#fff;font-size:16px;font-weight:700;margin-bottom:14px}
  .tip{display:flex;align-items:flex-start;gap:10px;margin-bottom:12px}
  .tip-dot{width:8px;height:8px;border-radius:50%;background:var(--teal);margin-top:5px;flex-shrink:0}
  .tip p{font-size:13.5px;color:#b8cfe0;line-height:1.5}
  .tip p strong{color:#fff}
</style>
</head>
<body>

  <header>
    <img class="logo" src="${pageContext.request.contextPath}/img/dbook-logo.png" alt="DBOOK">
    <div>
      <div class="header-title">DBOOK</div>
      <div class="breadcrumb">Inicio / <span>Publicar libro</span></div>
    </div>
    <a class="back" href="${pageContext.request.contextPath}/inicio">← Volver al catálogo</a>
  </header>

  <div class="page">

    <%-- Columna izquierda: formulario --%>
    <div class="form-card">
      <div class="form-head">
        <h2>Publicar un libro</h2>
        <p>Comparte un libro con la comunidad universitaria UV.</p>
      </div>

      <c:if test="${not empty error}"><div class="banner err">${error}</div></c:if>

      <form method="post" action="${pageContext.request.contextPath}/publicar">

        <div class="section-label">Información del libro</div>

        <div class="field">
          <label for="titulo">Título</label>
          <input id="titulo" name="titulo" type="text" placeholder="Ej. Cálculo de una variable"
                 value="${param.titulo}" required>
        </div>
        <div class="field">
          <label for="autor">Autor</label>
          <input id="autor" name="autor" type="text" placeholder="Ej. James Stewart"
                 value="${param.autor}" required>
        </div>
        <div class="field">
          <label for="carrera">Carrera relacionada</label>
          <input id="carrera" name="carrera" type="text" placeholder="Ej. Ingeniería, Medicina, General..."
                 value="${param.carrera}" required>
        </div>

        <div class="section-label">Tipo de oferta</div>

        <div class="tipo-grid" id="tipoGrid">
          <div class="tipo-card active" data-val="intercambio">
            <img src="${pageContext.request.contextPath}/img/intercambio.png" alt="Intercambio">
            <span>Intercambio</span>
          </div>
          <div class="tipo-card" data-val="venta">
            <img src="${pageContext.request.contextPath}/img/venta.png" alt="Venta">
            <span>Venta</span>
          </div>
          <div class="tipo-card" data-val="donacion">
            <img src="${pageContext.request.contextPath}/img/donacion.png" alt="Donación">
            <span>Donación</span>
          </div>
        </div>
        <input type="hidden" name="estado" id="estadoInput"
               value="${empty param.estado ? 'intercambio' : param.estado}">

        <div id="campoPrecio">
          <div class="section-label">Precio</div>
          <div class="field">
            <label for="precio">Precio ($)</label>
            <input id="precio" name="precio" type="number" min="0" step="0.01"
                   placeholder="Ej. 150.00" value="${param.precio}">
          </div>
        </div>

        <button type="submit" class="btn">Publicar libro</button>
      </form>
    </div>

    <%-- Columna derecha: panel visual fijo --%>
    <div class="visual">
      <img class="banner-img" src="${pageContext.request.contextPath}/img/publica.png" alt="Publica tus libros">
      <div class="visual-body">
        <h3>¿Por qué publicar en DBOOK?</h3>
        <div class="tip"><div class="tip-dot"></div><p><strong>Intercambia</strong> libros con otros estudiantes de la UV.</p></div>
        <div class="tip"><div class="tip-dot"></div><p><strong>Vende</strong> tus libros a precios accesibles para la comunidad.</p></div>
        <div class="tip"><div class="tip-dot"></div><p><strong>Dona</strong> los que ya no necesitas y ayuda a otros.</p></div>
        <div class="tip"><div class="tip-dot"></div><p>Todos los intercambios se realizan en <strong>zonas seguras</strong> dentro del campus.</p></div>
      </div>
    </div>

  </div>

<script>
  var estadoInput = document.getElementById("estadoInput");
  var campoPrecio = document.getElementById("campoPrecio");

  (function(){
    var v = estadoInput.value || "intercambio";
    document.querySelectorAll(".tipo-card").forEach(function(c){
      c.classList.toggle("active", c.dataset.val === v);
    });
    campoPrecio.style.display = (v === "venta") ? "block" : "none";
  })();

  document.getElementById("tipoGrid").addEventListener("click", function(e){
    var card = e.target.closest(".tipo-card");
    if(!card) return;
    document.querySelectorAll(".tipo-card").forEach(function(c){ c.classList.remove("active"); });
    card.classList.add("active");
    estadoInput.value = card.dataset.val;
    campoPrecio.style.display = (card.dataset.val === "venta") ? "block" : "none";
  });
</script>
</body>
</html>