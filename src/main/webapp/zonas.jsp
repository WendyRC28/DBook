<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>DBOOK — Zonas seguras</title>

<!-- Leaflet: librería de mapas gratuita, sin clave de API -->
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"/>
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

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

  .page{max-width:900px;margin:26px auto 48px;padding:0 22px}

  /* Banner */
  .banner-card{border-radius:18px;overflow:hidden;margin-bottom:20px;box-shadow:0 4px 16px rgba(8,15,30,.10)}
  .banner-card img{width:100%;height:auto;display:block}

  /* Mapa */
  .map-card{background:#fff;border-radius:18px;overflow:hidden;box-shadow:0 4px 16px rgba(8,15,30,.08);margin-bottom:20px}
  .map-title{padding:16px 20px 0;font-family:"Outfit",sans-serif;font-size:17px;font-weight:700}
  .map-sub{padding:4px 20px 14px;font-size:13.5px;color:var(--muted)}
  #mapa{height:340px;width:100%}

  /* Tarjetas de zona */
  .zonas-grid{display:grid;grid-template-columns:1fr 1fr;gap:14px}
  .zona-card{background:#fff;border:1px solid var(--line);border-radius:14px;padding:18px;box-shadow:0 2px 8px rgba(8,15,30,.06)}
  .zona-icon{width:40px;height:40px;border-radius:10px;background:linear-gradient(135deg,var(--navy),#2a4a6b);display:flex;align-items:center;justify-content:center;font-size:18px;margin-bottom:10px}
  .zona-nombre{font-family:"Outfit",sans-serif;font-weight:700;font-size:15px;margin-bottom:4px}
  .zona-desc{font-size:13px;color:var(--muted);margin-bottom:12px;line-height:1.4}
  .btn-maps{display:inline-flex;align-items:center;gap:6px;font-size:13px;font-weight:600;color:var(--blue);text-decoration:none;padding:7px 12px;border-radius:8px;border:1.5px solid rgba(22,82,214,.2);transition:all .15s}
  .btn-maps:hover{background:rgba(22,82,214,.06);border-color:var(--blue)}

  /* Panel derecho */
  .info-card{background:#fff;border-radius:18px;padding:24px;box-shadow:0 4px 20px rgba(8,15,30,.08);position:sticky;top:24px}
  .info-card h3{font-family:"Outfit",sans-serif;font-size:17px;font-weight:700;margin-bottom:6px}
  .info-card .sub{color:var(--muted);font-size:13.5px;margin-bottom:20px}
  .aviso{background:rgba(45,212,191,.08);border:1.5px solid rgba(45,212,191,.3);border-radius:12px;padding:14px;margin-bottom:18px}
  .aviso p{font-size:13.5px;line-height:1.5;color:#0b5e52}
  .aviso strong{font-weight:700}
  .regla{display:flex;align-items:flex-start;gap:10px;margin-bottom:12px}
  .regla-dot{width:8px;height:8px;border-radius:50%;flex-shrink:0;margin-top:5px}
  .regla-dot.ok{background:var(--teal)}
  .regla-dot.no{background:#e57373}
  .regla p{font-size:13.5px;color:#4a5970;line-height:1.4}
  .regla p strong{color:var(--ink)}
  .tipo-chips{display:flex;gap:8px;flex-wrap:wrap;margin-top:16px}
  .chip{font-size:12px;font-weight:700;padding:5px 12px;border-radius:999px}
  .chip.inter{background:rgba(22,82,214,.1);color:#1652d6}
  .chip.venta{background:rgba(180,120,0,.12);color:#9a6b00}
  .chip.no-dona{background:#fde8e8;color:#b3261e;text-decoration:line-through}
</style>
</head>
<body>

  <header>
    <img class="logo" src="${pageContext.request.contextPath}/img/dbook-logo.png" alt="DBOOK">
    <div class="hinfo">
      <div class="htitle">DBOOK</div>
      <div class="bread">Inicio / <span>Zonas seguras</span></div>
    </div>
    <a class="back" href="${pageContext.request.contextPath}/inicio">← Volver al inicio</a>
  </header>

  <div class="page">

    <%-- Columna izquierda: banner + mapa + tarjetas --%>
    <div>
      <div class="banner-card">
        <img src="${pageContext.request.contextPath}/img/zonas-banner.png" alt="Zonas seguras">
      </div>

      <div class="map-card">
        <div class="map-title">Mapa del campus UV</div>
        <div class="map-sub">Toca un pin para ver el nombre y descripción de la zona.</div>
        <div id="mapa"></div>
      </div>

      <div class="zonas-grid">
        <c:forEach var="z" items="${zonas}">
          <div class="zona-card">
            <div class="zona-icon">📍</div>
            <div class="zona-nombre">${z.nombre}</div>
            <div class="zona-desc">${z.descripcion}</div>
            <a class="btn-maps"
               href="https://maps.google.com/?q=${z.latitud},${z.longitud}"
               target="_blank">
              🗺 Ver en Google Maps
            </a>
          </div>
        </c:forEach>
      </div>
    </div>

<script>
  // 1) Crea el mapa centrado en el campus UV (zoom 16 = nivel edificio)
  var mapa = L.map('mapa');

  // 2) Capa de tiles de OpenStreetMap (gratis, sin clave de API)
  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '© OpenStreetMap contributors',
    maxZoom: 19
  }).addTo(mapa);

  //
  //    El servlet  leyó de PostgreSQL y el JSP
  var zonas = [
    <c:forEach var="z" items="${zonas}">
    {
      nombre: "${z.nombre}",
      desc:   "${z.descripcion}",
      lat:    ${z.latitud},
      lng:    ${z.longitud}
    },
    </c:forEach>
  ];

  // 4) Por cada zona crea un pin (marker) con una ventanita de información
  zonas.forEach(function(z) {
    L.marker([z.lat, z.lng])
     .addTo(mapa)
     .bindPopup(
       "<b style='font-family:Outfit,sans-serif'>" + z.nombre + "</b>" +
       "<br><span style='font-size:12px;color:#6b7785'>" + z.desc + "</span>"
     );
  });
  if (zonas.length > 0) {
      var grupo = L.featureGroup(
        zonas.map(function(z){ return L.marker([z.lat, z.lng]); })
      );
      mapa.fitBounds(grupo.getBounds().pad(0.3));
    } else {
      mapa.setView([19.1535, -96.1140], 15);
    }
  </script>
</body>
</html>