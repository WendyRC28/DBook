<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>DBOOK — Foros literarios</title>
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@500;600;700&family=Manrope:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
  :root{
    --navy:#182a40; --teal:#2dd4bf; --blue:#1652d6; --blue-deep:#0f3fb0;
    --ink:#1c2733; --muted:#6b7785; --line:#e7ebf0; --bg:#f0f2f7;
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

  .page{max-width:1100px;margin:26px auto 48px;padding:0 22px;display:grid;grid-template-columns:1fr 340px;gap:22px;align-items:start}

  .hero{border-radius:18px;overflow:hidden;box-shadow:0 4px 16px rgba(8,15,30,.10);margin-bottom:20px}
 .hero img{width:100%;height:auto;object-fit:contain;background:#ffcrear forof;display:block;border-radius:18px}

  .foros-head h2{font-family:"Outfit",sans-serif;font-size:19px;font-weight:700}
  .foros-head p{color:var(--muted);font-size:14px;margin-top:3px;margin-bottom:16px}

  .foro-card{background:#fff;border:1px solid var(--line);border-radius:14px;margin-bottom:14px;overflow:hidden;box-shadow:0 2px 8px rgba(8,15,30,.06)}
  .foro-top{padding:16px 20px;display:flex;align-items:center;gap:14px}
  .foro-icon{width:44px;height:44px;border-radius:10px;background:linear-gradient(135deg,var(--navy),#2a4a6b);display:flex;align-items:center;justify-content:center;font-size:20px;flex-shrink:0}
  .foro-info{flex:1}
  .foro-titulo{font-family:"Outfit",sans-serif;font-weight:700;font-size:15px}
  .foro-meta{font-size:12.5px;color:var(--muted);margin-top:2px}
  .badge-carrera{font-size:11.5px;font-weight:700;padding:3px 9px;border-radius:999px;background:rgba(22,82,214,.1);color:var(--blue);white-space:nowrap}
  .foro-footer{padding:8px 20px 14px;border-top:1px solid var(--line)}
  .btn-ver{color:var(--blue);text-decoration:none;font-size:13.5px;font-weight:600}
  .btn-ver:hover{text-decoration:underline}

  .comentarios{padding:6px 20px 20px;border-top:1px solid var(--line)}
  .comentario{display:flex;gap:10px;margin-bottom:14px}
  .avatar{width:36px;height:36px;border-radius:50%;background:var(--navy);color:#fff;display:flex;align-items:center;justify-content:center;font-family:"Outfit",sans-serif;font-weight:700;font-size:14px;flex-shrink:0}
  .com-body{flex:1}
  .com-quien{font-size:13px;font-weight:700;margin-bottom:3px}
  .com-texto{font-size:14px;line-height:1.5;color:#2c3a48;background:#f6f8fb;padding:10px 14px;border-radius:10px}
  .com-fecha{font-size:11.5px;color:var(--muted);margin-top:4px}
  .sin-com{text-align:center;color:var(--muted);font-size:14px;padding:14px 0;font-style:italic}

  .form-com{margin-top:14px;display:flex;gap:10px;align-items:flex-end}
  .form-com textarea{flex:1;font-family:inherit;font-size:14px;padding:11px 14px;border:1.5px solid var(--line);border-radius:11px;background:#fafbfd;resize:none;height:60px;transition:border-color .15s,box-shadow .15s}
  .form-com textarea:focus{outline:none;border-color:var(--teal);box-shadow:0 0 0 3px rgba(45,212,191,.14)}
  .btn-com{font-family:"Outfit",sans-serif;font-weight:600;font-size:14px;color:#fff;padding:11px 18px;border:0;border-radius:10px;cursor:pointer;background:linear-gradient(120deg,var(--blue),var(--blue-deep));box-shadow:0 4px 14px rgba(22,82,214,.3);white-space:nowrap}
  .btn-com:hover{filter:brightness(1.06)}

  .crear-card{background:#fff;border-radius:18px;padding:26px 24px;box-shadow:0 4px 20px rgba(8,15,30,.08);position:sticky;top:24px}
  .crear-card h3{font-family:"Outfit",sans-serif;font-size:17px;font-weight:700;margin-bottom:4px}
  .crear-card .sub{color:var(--muted);font-size:13.5px;margin-bottom:20px}
  .slabel{font-size:11.5px;font-weight:700;color:var(--muted);letter-spacing:.7px;text-transform:uppercase;margin:16px 0 10px;display:flex;align-items:center;gap:8px}
  .slabel::after{content:'';flex:1;height:1px;background:var(--line)}
  .field label{display:block;font-size:13.5px;font-weight:600;margin-bottom:6px;color:#36424f}
  .field select{width:100%;font-size:14px;font-family:inherit;color:var(--ink);padding:11px 14px;border:1.5px solid var(--line);border-radius:10px;background:#fafbfd;transition:border-color .15s,box-shadow .15s}
  .field select:focus{outline:none;border-color:var(--teal);box-shadow:0 0 0 3px rgba(45,212,191,.14)}
  .btn-crear{width:100%;margin-top:18px;font-family:"Outfit",sans-serif;font-weight:600;font-size:15px;color:#fff;padding:13px;border:0;border-radius:11px;cursor:pointer;background:linear-gradient(120deg,var(--blue) 0%,var(--blue-deep) 55%,var(--teal) 165%);box-shadow:0 8px 20px rgba(22,82,214,.3);transition:filter .15s}
  .btn-crear:hover{filter:brightness(1.06)}
  .err-banner{font-size:13px;padding:10px 12px;border-radius:9px;margin-bottom:14px;background:#fde8e8;color:#b3261e;display:none}
  .err-banner.show{display:block}
  .vacio{text-align:center;color:var(--muted);font-size:14px;padding:24px;background:#fff;border:1px dashed var(--line);border-radius:14px}
</style>
</head>
<body>

  <header>
    <img class="logo" src="${pageContext.request.contextPath}/img/dbook-logo.png" alt="DBOOK">
    <div class="hinfo">
      <div class="htitle">DBOOK</div>
      <div class="bread">Inicio / <span>Foros literarios</span></div>
    </div>
    <a class="back" href="${pageContext.request.contextPath}/inicio">← Volver al inicio</a>
  </header>

  <div class="page">

    <div>
      <div class="hero">
        <img src="${pageContext.request.contextPath}/img/foro-banner.png" alt="Foros">
      </div>

      <div class="foros-head">
        <h2>Foros literarios</h2>
        <p>Espacios de discusión sobre libros entre la comunidad UV.</p>
      </div>

      <c:choose>
        <c:when test="${empty foros}">
          <div class="vacio">Aún no hay foros. ¡Crea el primero desde el panel de la derecha!</div>
        </c:when>
        <c:otherwise>
          <c:forEach var="foro" items="${foros}">
            <div class="foro-card">
              <div class="foro-top">
                <div class="foro-icon">📖</div>
                <div class="foro-info">
                  <div class="foro-titulo">${foro.tituloLibro}</div>
                  <div class="foro-meta">${foro.autorLibro} &nbsp;·&nbsp; Creado por ${foro.nombreUsuario}</div>
                </div>
                <span class="badge-carrera">${foro.carreraLibro}</span>
              </div>

              <c:choose>
                <c:when test="${idSel == foro.id}">
                  <div class="comentarios">
                    <c:choose>
                      <c:when test="${empty comentarios}">
                        <p class="sin-com">Aún no hay comentarios. ¡Sé la primera!</p>
                      </c:when>
                      <c:otherwise>
                        <c:forEach var="com" items="${comentarios}">
                          <div class="comentario">
                            <div class="avatar">${com.nombreUsuario.substring(0,1).toUpperCase()}</div>
                            <div class="com-body">
                              <div class="com-quien">${com.nombreUsuario}</div>
                              <div class="com-texto">${com.contenido}</div>
                              <div class="com-fecha">${com.fecha}</div>
                            </div>
                          </div>
                        </c:forEach>
                      </c:otherwise>
                    </c:choose>

                    <form class="form-com" method="post" action="${pageContext.request.contextPath}/foro">
                      <input type="hidden" name="accion"   value="comentar">
                      <input type="hidden" name="idEvento" value="${foro.id}">
                      <textarea name="contenido" placeholder="Escribe tu comentario..." required></textarea>
                      <button type="submit" class="btn-com">Comentar</button>
                    </form>
                  </div>
                </c:when>
                <c:otherwise>
                  <div class="foro-footer">
                    <a class="btn-ver" href="${pageContext.request.contextPath}/foro?id=${foro.id}">
                      Ver comentarios →
                    </a>
                  </div>
                </c:otherwise>
              </c:choose>
            </div>
          </c:forEach>
        </c:otherwise>
      </c:choose>
    </div>

    <div class="crear-card">
      <h3>Crear un foro</h3>
      <p class="sub">Abre un espacio de discusión sobre un libro.</p>

      <c:if test="${not empty param.error}">
        <div class="err-banner show">Selecciona un libro para continuar.</div>
      </c:if>

     <form method="post" action="${pageContext.request.contextPath}/foro">
             <input type="hidden" name="accion" value="crear">

             <div class="slabel">Información del libro</div>

             <div class="field" style="margin-bottom:12px">
               <label for="nombreLibro">Nombre del libro</label>
               <input id="nombreLibro" name="nombreLibro" type="text"
                      placeholder="Ej. Cien años de soledad" required
                      style="width:100%;font-size:14px;font-family:inherit;color:#1c2733;padding:11px 14px;border:1.5px solid #e7ebf0;border-radius:10px;background:#fafbfd;outline:none">
             </div>

             <div class="field" style="margin-bottom:12px">
               <label for="autorLibro">Autor</label>
               <input id="autorLibro" name="autorLibro" type="text"
                      placeholder="Ej. Gabriel García Márquez"
                      style="width:100%;font-size:14px;font-family:inherit;color:#1c2733;padding:11px 14px;border:1.5px solid #e7ebf0;border-radius:10px;background:#fafbfd;outline:none">
             </div>

             <div class="field" style="margin-bottom:4px">
               <label for="genero">Género / Carrera</label>
               <input id="genero" name="genero" type="text"
                      placeholder="Ej. Novela, Ingeniería, General..."
                      style="width:100%;font-size:14px;font-family:inherit;color:#1c2733;padding:11px 14px;border:1.5px solid #e7ebf0;border-radius:10px;background:#fafbfd;outline:none">
             </div>

             <button type="submit" class="btn-crear">Crear foro</button>
           </form>
    </div>

  </div>
</body>
</html>