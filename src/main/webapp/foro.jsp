<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>DBOOK &#8212; Foros literarios</title>
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@500;600;700&family=Manrope:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
  :root{
    --navy:#182a40; --teal:#2dd4bf; --blue:#1652d6; --blue-deep:#0f3fb0;
    --ink:#1c2733; --muted:#6b7785; --line:#e3e8ee; --bg:#f0f2f7;
    --danger-bg:#fde8e8; --danger-tx:#b3261e;
  }
  *{box-sizing:border-box;margin:0;padding:0}
  body{font-family:"Manrope",sans-serif;color:var(--ink);background:var(--bg);min-height:100vh}

  /* Header */
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

  /* Layout */
  .page{max-width:1060px;margin:28px auto 48px;padding:0 22px;display:grid;grid-template-columns:1fr 360px;gap:22px;align-items:start}

  /* Banner imagen */
  .banner-img{
    width:100%;border-radius:16px;overflow:hidden;
    box-shadow:0 4px 20px rgba(8,15,30,.1);margin-bottom:22px;
  }
  .banner-img img{width:100%;display:block}

  /* Títulos sección */
  .section-title{font-family:"Outfit",sans-serif;font-size:19px;font-weight:700;margin-bottom:6px}
  .section-sub{color:var(--muted);font-size:14px;margin-bottom:18px}

  /* Tarjetas foros */
  .grid{display:flex;flex-direction:column;gap:14px}

  .foro-card{
    background:#fff;border:1px solid var(--line);border-radius:14px;
    padding:0;box-shadow:0 2px 8px rgba(8,15,30,.06);
    transition:box-shadow .15s,transform .12s;overflow:hidden;
  }
  .foro-card:hover{box-shadow:0 8px 24px rgba(8,15,30,.12);transform:translateY(-2px)}

  .foro-header{padding:18px 20px 14px;border-bottom:1px solid var(--line);cursor:pointer}
  .foro-nombre{font-family:"Outfit",sans-serif;font-weight:700;font-size:16px;margin-bottom:4px}
  .foro-libro{font-size:13.5px;color:var(--blue);font-weight:600}
  .foro-autor{font-size:12.5px;color:var(--muted);margin-top:2px}
  .foro-toggle{float:right;font-size:12px;color:var(--muted);margin-top:2px}

  /* Sección comentarios */
  .comentarios-section{padding:16px 20px;background:#fafbfd;display:none}
  .comentarios-section.open{display:block}

  .comentarios-lista{display:flex;flex-direction:column;gap:10px;margin-bottom:14px}

  .comentario{background:#fff;border:1px solid var(--line);border-radius:10px;padding:12px 14px}
  .comentario-autor{font-size:12.5px;font-weight:700;color:var(--navy);margin-bottom:4px}
  .comentario-fecha{font-size:11.5px;color:var(--muted);margin-left:8px;font-weight:400}
  .comentario-texto{font-size:13.5px;color:var(--ink);line-height:1.5}

  .sin-comentarios{font-size:13px;color:var(--muted);text-align:center;padding:10px 0 14px}

  /* Formulario comentar */
  .form-comentar{display:flex;gap:8px;align-items:flex-end}
  .form-comentar textarea{
    flex:1;font-family:inherit;font-size:13.5px;color:var(--ink);
    padding:10px 12px;border:1.5px solid var(--line);border-radius:10px;
    background:#fff;resize:none;height:60px;transition:border-color .15s,box-shadow .15s;
  }
  .form-comentar textarea:focus{
    outline:none;border-color:var(--teal);box-shadow:0 0 0 3px rgba(45,212,191,.14);
  }
  .form-comentar button{
    font-family:"Outfit",sans-serif;font-size:13.5px;font-weight:600;color:#fff;
    padding:10px 16px;border:0;border-radius:10px;cursor:pointer;white-space:nowrap;
    background:linear-gradient(120deg,var(--blue),var(--teal));
    box-shadow:0 4px 12px rgba(22,82,214,.25);transition:filter .15s;
  }
  .form-comentar button:hover{filter:brightness(1.06)}

  .vacio{
    background:#fff;border:1px dashed var(--line);border-radius:14px;
    padding:40px;text-align:center;color:var(--muted);font-size:14px;
  }

  /* Formulario crear foro (columna derecha) */
  .form-card{
    background:#fff;border-radius:18px;padding:28px;
    box-shadow:0 4px 20px rgba(8,15,30,.08);position:sticky;top:24px;
  }
  .form-head{margin-bottom:18px}
  .form-head h2{font-family:"Outfit",sans-serif;font-size:18px;font-weight:700}
  .form-head p{color:var(--muted);font-size:13.5px;margin-top:4px}

  .banner-err{
    font-size:13.5px;padding:11px 14px;border-radius:10px;margin-bottom:16px;
    background:var(--danger-bg);color:var(--danger-tx);display:none;
  }
  .banner-err.show{display:block}

  .section-label{
    font-size:11.5px;font-weight:700;color:var(--muted);letter-spacing:.8px;
    text-transform:uppercase;margin:18px 0 12px;display:flex;align-items:center;gap:8px;
  }
  .section-label::after{content:'';flex:1;height:1px;background:var(--line)}

  .field{margin-bottom:13px}
  .field label{display:block;font-size:13.5px;font-weight:600;margin-bottom:6px;color:#36424f}
  .field input,.field select{
    width:100%;font-size:14.5px;font-family:inherit;color:var(--ink);padding:11px 13px;
    border:1.5px solid var(--line);border-radius:10px;background:#fafbfd;
    transition:border-color .15s,box-shadow .15s;
  }
  .field input:focus,.field select:focus{
    outline:none;border-color:var(--teal);background:#fff;
    box-shadow:0 0 0 4px rgba(45,212,191,.14);
  }

  .btn{
    width:100%;margin-top:20px;font-family:"Outfit",sans-serif;font-weight:600;
    font-size:15px;color:#fff;padding:13px;border:0;border-radius:12px;cursor:pointer;
    background:linear-gradient(120deg,var(--blue) 0%,var(--blue-deep) 55%,var(--teal) 165%);
    box-shadow:0 8px 20px rgba(22,82,214,.32);transition:filter .15s,transform .08s;
  }
  .btn:hover{filter:brightness(1.06)}
  .btn:active{transform:translateY(1px)}
</style>
</head>
<body>

  <header>
    <img class="logo" src="${pageContext.request.contextPath}/img/dbook-logo.png" alt="DBOOK">
    <div>
      <div class="header-title">DBOOK</div>
      <div class="breadcrumb">Inicio / <span>Foros literarios</span></div>
    </div>
    <a class="back" href="${pageContext.request.contextPath}/inicio">&#8592; Volver al cat&#225;logo</a>
  </header>

  <div class="page">

    <%-- Columna izquierda --%>
    <div>
      <%-- Imagen banner --%>
      <div class="banner-img">
       <img src="${pageContext.request.contextPath}/img/foro-banner.png" ...>
      </div>

      <div class="section-title">Foros literarios</div>
      <p class="section-sub">Espacios de discusi&#243;n sobre libros entre la comunidad UV.</p>

      <c:choose>
        <c:when test="${empty foros}">
          <div class="vacio">Todav&#237;a no hay foros creados. &#161;Crea el primero!</div>
        </c:when>
        <c:otherwise>
          <div class="grid">
            <c:forEach var="f" items="${foros}">
              <div class="foro-card" id="foro-${f.id}">

                <%-- Encabezado clickeable para expandir/colapsar --%>
                <div class="foro-header" onclick="toggleComentarios(${f.id})">
                  <span class="foro-toggle" id="toggle-${f.id}">&#9660; Ver comentarios</span>
                  <div class="foro-nombre">${f.nombre}</div>
                  <div class="foro-libro">${f.tituloLibro}</div>
                  <div class="foro-autor">${f.autorLibro}</div>
                </div>

                <%-- Comentarios del foro (se cargan al expandir) --%>
                <div class="comentarios-section" id="comentarios-${f.id}">

                  <div class="comentarios-lista" id="lista-${f.id}">
                    <c:set var="hayComentarios" value="false"/>
                    <c:forEach var="c" items="${comentariosPorForo[f.id]}">
                      <c:set var="hayComentarios" value="true"/>
                      <div class="comentario">
                        <div class="comentario-autor">
                          ${c.nombreUsuario}
                          <span class="comentario-fecha">
                            <fmt:formatDate value="${c.fecha}" pattern="dd/MM/yyyy HH:mm"/>
                          </span>
                        </div>
                        <div class="comentario-texto">${c.contenido}</div>
                      </div>
                    </c:forEach>
                    <c:if test="${not hayComentarios}">
                      <div class="sin-comentarios">A&#250;n no hay comentarios. &#161;S&#233; el primero!</div>
                    </c:if>
                  </div>

                  <%-- Formulario para comentar --%>
                  <form method="post" action="${pageContext.request.contextPath}/foro">
                    <input type="hidden" name="accion" value="comentar">
                    <input type="hidden" name="idForo" value="${f.id}">
                    <div class="form-comentar">
                      <textarea name="contenido" placeholder="Escribe tu comentario..." required></textarea>
                      <button type="submit">Comentar</button>
                    </div>
                  </form>

                </div>
              </div>
            </c:forEach>
          </div>
        </c:otherwise>
      </c:choose>
    </div>

    <%-- Columna derecha: formulario crear foro --%>
    <div class="form-card">
      <div class="form-head">
        <h2>Crear un foro</h2>
        <p>Organiza un espacio de discusi&#243;n sobre un libro.</p>
      </div>

      <c:if test="${not empty error}">
        <div class="banner-err show">${error}</div>
      </c:if>

      <form method="post" action="${pageContext.request.contextPath}/foro">
        <input type="hidden" name="accion" value="crear">

        <div class="section-label">Informaci&#243;n del foro</div>

        <div class="field">
          <label for="nombre">Nombre del foro</label>
          <input id="nombre" name="nombre" type="text"
                 placeholder="Ej. Club de lectura &#8212; Realismo m&#225;gico"
                 value="${param.nombre}" required>
        </div>

        <div class="section-label">Libro a discutir</div>

        <div class="field">
          <label for="idLibro">Selecciona un libro</label>
          <select id="idLibro" name="idLibro" required>
            <option value="">-- Elige un libro --</option>
            <c:forEach var="libro" items="${libros}">
              <option value="${libro.id}"
                <c:if test="${param.idLibro == libro.id}">selected</c:if>>
                ${libro.titulo} &#8212; ${libro.autor}
              </option>
            </c:forEach>
          </select>
        </div>

        <button type="submit" class="btn">Crear foro</button>
      </form>
    </div>

  </div>

<script>
  function toggleComentarios(id) {
    var sec    = document.getElementById('comentarios-' + id);
    var toggle = document.getElementById('toggle-' + id);
    var abierto = sec.classList.toggle('open');
    toggle.innerHTML = abierto ? '&#9650; Ocultar' : '&#9660; Ver comentarios';
  }

  // Abrir automáticamente si viene con ?id=X#comentarios
  var params = new URLSearchParams(window.location.search);
  var foroId = params.get('id');
  if (foroId) {
    var sec = document.getElementById('comentarios-' + foroId);
    var tog = document.getElementById('toggle-' + foroId);
    if (sec) {
      sec.classList.add('open');
      if (tog) tog.innerHTML = '&#9650; Ocultar';
      setTimeout(function(){
        document.getElementById('foro-' + foroId).scrollIntoView({behavior:'smooth'});
      }, 200);
    }
  }
</script>
</body>
</html>