<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>DBOOK — Mis solicitudes</title>
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@500;600;700&family=Manrope:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
  :root{
    --navy:#182a40; --teal:#2dd4bf; --blue:#1652d6;
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

  .page{max-width:860px;margin:26px auto 48px;padding:0 22px}

  /* Tabs */
  .tabs{display:flex;gap:4px;background:#fff;padding:5px;border-radius:14px;margin-bottom:22px;box-shadow:0 2px 8px rgba(8,15,30,.07);width:fit-content}
  .tab{padding:9px 20px;border-radius:10px;font-size:14px;font-weight:600;cursor:pointer;border:0;background:transparent;color:var(--muted);transition:all .15s;font-family:inherit}
  .tab.active{background:var(--navy);color:#fff}

  .seccion{display:none}
  .seccion.visible{display:block}

  .sec-head{margin-bottom:16px}
  .sec-head h2{font-family:"Outfit",sans-serif;font-size:20px;font-weight:700}
  .sec-head p{color:var(--muted);font-size:14px;margin-top:4px}

  /* Tarjetas */
  .sol-card{background:#fff;border:1px solid var(--line);border-radius:16px;padding:20px 22px;margin-bottom:12px;box-shadow:0 2px 10px rgba(8,15,30,.06);display:grid;grid-template-columns:auto 1fr auto;gap:16px;align-items:start}
  .sol-icon{width:46px;height:46px;border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:20px;flex-shrink:0}
  .sol-icon.compra{background:rgba(180,120,0,.12)}
  .sol-icon.intercambio{background:rgba(22,82,214,.1)}
  .sol-libro{font-family:"Outfit",sans-serif;font-weight:700;font-size:15.5px}
  .sol-autor{font-size:13px;color:var(--muted);margin-top:2px}
  .sol-quien{font-size:13.5px;margin-top:8px;color:var(--ink)}
  .sol-zona{font-size:13px;color:var(--muted);margin-top:4px}
  .sol-fecha{font-size:12px;color:var(--muted);margin-top:3px}
  .sol-meta{display:flex;flex-direction:column;align-items:flex-end;gap:6px;flex-shrink:0}
  .badge-tipo{font-size:12px;font-weight:700;padding:4px 10px;border-radius:999px}
  .badge-tipo.compra{background:rgba(180,120,0,.12);color:#9a6b00}
  .badge-tipo.intercambio{background:rgba(22,82,214,.1);color:#1652d6}
  .badge-estado{font-size:11.5px;font-weight:700;padding:3px 9px;border-radius:999px}
  .badge-estado.pendiente{background:rgba(245,166,35,.15);color:#7a5c00}
  .badge-estado.aceptada{background:rgba(15,122,94,.14);color:#0f7a5e}
  .badge-estado.rechazada{background:#fde8e8;color:#b3261e}

  .vacio{background:#fff;border:1px dashed var(--line);border-radius:14px;padding:40px;text-align:center;color:var(--muted)}
  .vacio .ico{font-size:36px;margin-bottom:10px}
</style>
</head>
<body>

  <header>
    <img class="logo" src="${pageContext.request.contextPath}/img/dbook-logo.png" alt="DBOOK">
    <div class="hinfo">
      <div class="htitle">DBOOK</div>
      <div class="bread">Inicio / <span>Mis solicitudes</span></div>
    </div>
    <a class="back" href="${pageContext.request.contextPath}/inicio">← Volver al inicio</a>
  </header>

  <div class="page">

    <%-- Tabs para cambiar entre recibidas y enviadas --%>
    <div class="tabs">
      <button class="tab active" onclick="cambiarTab('recibidas', this)">
        📥 Recibidas (${recibidas.size()})
      </button>
      <button class="tab" onclick="cambiarTab('enviadas', this)">
        📤 Enviadas (${enviadas.size()})
      </button>
    </div>

    <%-- SECCIÓN: Solicitudes recibidas (alguien quiere mi libro) --%>
    <div id="secRecibidas" class="seccion visible">
      <div class="sec-head">
        <h2>Solicitudes recibidas</h2>
        <p>Personas interesadas en tus libros publicados.</p>
      </div>

      <c:choose>
        <c:when test="${empty recibidas}">
          <div class="vacio"><div class="ico">📭</div><p>Nadie ha solicitado tus libros todavía.</p></div>
        </c:when>
        <c:otherwise>
          <c:forEach var="s" items="${recibidas}">
            <div class="sol-card">
              <div class="sol-icon ${s.tipo}">
                <c:out value="${s.tipo == 'compra' ? '💲' : '🔄'}"/>
              </div>
              <div>
                <div class="sol-libro">${s.tituloLibro}</div>
                <div class="sol-autor">${s.autorLibro}</div>
                <div class="sol-quien">
                  <strong>${s.nombreSolicitante}</strong>
                  <c:out value="${s.tipo == 'compra' ? ' quiere comprarlo' : ' quiere intercambiarlo'}"/>
                </div>
                <div class="sol-zona">📍 ${s.zonaEntrega}</div>
                <div class="sol-fecha">🗓 ${s.fecha}</div>
              </div>
              <div class="sol-meta">
                              <span class="badge-tipo ${s.tipo}">${s.tipo}</span>
                              <span class="badge-estado ${s.estado}">${s.estado}</span>
                              <c:if test="${s.estado == 'pendiente'}">
                                <form method="post" action="${pageContext.request.contextPath}/misSolicitudes"
                                      style="display:flex;gap:6px;margin-top:6px">
                                  <input type="hidden" name="idTransaccion" value="${s.id}">
                                  <button name="accion" value="aceptar"
                                          style="font-family:inherit;font-size:12px;font-weight:700;padding:7px 13px;border-radius:8px;border:0;background:rgba(15,122,94,.14);color:#0f7a5e;cursor:pointer">
                                    ✓ Aceptar
                                  </button>
                                  <button name="accion" value="rechazar"
                                          style="font-family:inherit;font-size:12px;font-weight:700;padding:7px 13px;border-radius:8px;border:0;background:#fde8e8;color:#b3261e;cursor:pointer">
                                    ✗ Rechazar
                                  </button>
                                </form>
                              </c:if>
                            </div>
                          </div>
                        </c:forEach>
                      </c:otherwise>
                    </c:choose>
                  </div>

                 <%-- SECCIÓN: Solicitudes enviadas (yo pedí un libro) --%>
    <div id="secEnviadas" class="seccion">
      <div class="sec-head">
        <h2>Solicitudes enviadas</h2>
        <p>Libros que has solicitado comprar o intercambiar.</p>
      </div>

      <c:choose>
        <c:when test="${empty enviadas}">
          <div class="vacio"><div class="ico">📭</div><p>No has enviado solicitudes todavía.</p></div>
        </c:when>
        <c:otherwise>
          <c:forEach var="s" items="${enviadas}">
            <div class="sol-card">
              <div class="sol-icon ${s.tipo}">
                <c:out value="${s.tipo == 'compra' ? '💲' : '🔄'}"/>
              </div>
              <div>
                <div class="sol-libro">${s.tituloLibro}</div>
                <div class="sol-autor">${s.autorLibro}</div>
                <div class="sol-quien">
                  Publicado por <strong>${s.nombreSolicitante}</strong>
                </div>
                <div class="sol-zona">📍 ${s.zonaEntrega}</div>
                <div class="sol-fecha">🗓 ${s.fecha}</div>
              </div>
              <div class="sol-meta">
                <span class="badge-tipo ${s.tipo}">${s.tipo}</span>
                <span class="badge-estado ${s.estado}">${s.estado}</span>
              </div>
            </div>
          </c:forEach>
        </c:otherwise>
      </c:choose>
    </div>

  </div>

<script>
  function cambiarTab(cual, btn) {
    // Oculta todas las secciones y desactiva todos los tabs
    document.querySelectorAll(".seccion").forEach(function(s){ s.classList.remove("visible"); });
    document.querySelectorAll(".tab").forEach(function(t){ t.classList.remove("active"); });
    // Muestra la sección elegida y activa el tab
    document.getElementById("sec" + cual.charAt(0).toUpperCase() + cual.slice(1)).classList.add("visible");
    btn.classList.add("active");
  }
</script>
</body>
</html>