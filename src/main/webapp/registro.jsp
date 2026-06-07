<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>DBOOK — Registro</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700&family=Manrope:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
  :root{
    --navy:#182a40; --navy-2:#13202f;
    --card:#ffffff; --ink:#1c2733; --muted:#6b7785; --line:#e3e8ee;
    --teal:#2dd4bf; --blue:#1652d6; --blue-deep:#0f3fb0;
    --danger-bg:#fde8e8; --danger-tx:#b3261e;
    --ok-bg:#e6f7f1; --ok-tx:#0f7a5e;
  }
  *{box-sizing:border-box;margin:0;padding:0}
  html,body{height:100%}
  body{
    font-family:"Manrope",-apple-system,Segoe UI,sans-serif;color:var(--ink);
    min-height:100vh;display:flex;align-items:center;justify-content:center;padding:32px 18px;
    background:
      radial-gradient(900px 460px at 50% -8%, rgba(45,212,191,.16), transparent 60%),
      radial-gradient(700px 500px at 100% 110%, rgba(22,82,214,.18), transparent 55%),
      linear-gradient(180deg,var(--navy) 0%, var(--navy-2) 100%);
  }
  .wrap{width:100%;max-width:430px;display:flex;flex-direction:column;align-items:center}
  .brand{margin-bottom:14px;opacity:0;animation:fade .6s ease .05s forwards}
  .brand img{width:172px;height:auto;display:block;filter:drop-shadow(0 6px 18px rgba(0,0,0,.35))}
  .card{
    width:100%;background:var(--card);border-radius:20px;padding:30px 30px 26px;
    box-shadow:0 24px 60px rgba(8,15,30,.45);opacity:0;transform:translateY(14px);
    animation:fade .6s ease .12s forwards;
  }
  .card h1{font-family:"Outfit",sans-serif;font-weight:700;font-size:22px;text-align:center;letter-spacing:.2px}
  .card .sub{text-align:center;color:var(--muted);font-size:14px;margin:4px 0 20px}
  .banner{font-size:13.5px;padding:11px 14px;border-radius:10px;margin-bottom:16px;line-height:1.35;display:none}
  .banner.err{display:block;background:var(--danger-bg);color:var(--danger-tx)}
  .banner.ok{display:block;background:var(--ok-bg);color:var(--ok-tx)}
  .banner.ok a{color:var(--ok-tx);font-weight:700}
  .field{margin-bottom:15px}
  .field label{display:block;font-size:13.5px;font-weight:600;margin-bottom:7px;color:#36424f}
  .input-shell{position:relative}
  .field input{
    width:100%;font-size:15px;font-family:inherit;color:var(--ink);padding:13px 14px;
    border:1.5px solid var(--line);border-radius:11px;background:#fbfcfe;
    transition:border-color .15s, box-shadow .15s, background .15s;
  }
  .field input::placeholder{color:#aab3bd}
  .field input:focus{outline:none;border-color:var(--teal);background:#fff;box-shadow:0 0 0 4px rgba(45,212,191,.16)}
  .field input.invalid{border-color:#e88;box-shadow:0 0 0 4px rgba(179,38,30,.10)}
  .toggle-eye{position:absolute;right:10px;top:50%;transform:translateY(-50%);border:0;background:transparent;
    cursor:pointer;color:var(--muted);padding:6px;border-radius:8px;display:flex;line-height:0}
  .toggle-eye:hover{color:var(--ink)}
  .err-msg{font-size:12.5px;color:var(--danger-tx);margin-top:6px;display:none}
  .err-msg.show{display:block}
  .seg{display:grid;grid-template-columns:1fr 1fr;gap:8px}
  .seg button{font-family:inherit;font-size:14px;font-weight:600;cursor:pointer;padding:12px;
    border:1.5px solid var(--line);border-radius:11px;background:#fbfcfe;color:#43505d;transition:all .15s}
  .seg button:hover{border-color:#c6d0db}
  .seg button.active{border-color:var(--teal);color:#0b5e52;background:rgba(45,212,191,.10);box-shadow:0 0 0 3px rgba(45,212,191,.12)}
  .btn{width:100%;margin-top:8px;font-family:"Outfit",sans-serif;font-weight:600;font-size:16px;color:#fff;
    padding:14px;border:0;border-radius:12px;cursor:pointer;letter-spacing:.3px;
    background:linear-gradient(120deg,var(--blue) 0%, var(--blue-deep) 55%, var(--teal) 165%);
    box-shadow:0 10px 24px rgba(22,82,214,.35);transition:transform .08s ease, box-shadow .15s, filter .15s}
  .btn:hover{filter:brightness(1.05);box-shadow:0 12px 28px rgba(22,82,214,.45)}
  .btn:active{transform:translateY(1px)}
  .divider{height:1px;background:var(--line);margin:20px 0 14px}
  .foot{text-align:center;font-size:14px;color:var(--muted)}
  .foot a{color:var(--blue);font-weight:600;text-decoration:none}
  .foot a:hover{text-decoration:underline}
  @keyframes fade{to{opacity:1;transform:none}}
</style>
</head>
<body>
  <div class="wrap">
    <div class="brand">
      <img src="${pageContext.request.contextPath}/img/dbook-logo.png" alt="DBOOK">
    </div>

    <main class="card">
      <h1>Crear cuenta</h1>
      <p class="sub">Regístrate con tu correo institucional UV</p>


      <c:if test="${not empty error}"><div class="banner err">${error}</div></c:if>
      <c:if test="${not empty exito}">
        <div class="banner ok">${exito} <a href="${pageContext.request.contextPath}/login">Iniciar sesión &rarr;</a></div>
      </c:if>


      <div id="banner" class="banner"></div>

      <form id="form" method="post" action="${pageContext.request.contextPath}/registro" novalidate>
        <div class="field">
          <label for="nombre">Nombre completo</label>
          <input id="nombre" name="nombre" type="text" placeholder="Ej. Ana López Martínez"
                 maxlength="100" autocomplete="name" value="${empty exito ? param.nombre : ''}">
          <div class="err-msg" id="e-nombre">Escribe tu nombre.</div>
        </div>

        <div class="field">
          <label for="correo">Correo UV</label>
          <input id="correo" name="correo" type="email" placeholder="usuario@uv.mx"
                 autocomplete="email" value="${empty exito ? param.correo : ''}">
          <div class="err-msg" id="e-correo">Solo se permiten correos institucionales uv.mx</div>
        </div>

        <div class="field">
          <label>Soy</label>
          <div class="seg" id="seg">
            <button type="button" data-rol="alumno">Alumno</button>
            <button type="button" data-rol="profesor">Profesor</button>
          </div>
          <input type="hidden" name="rol" id="rolInput" value="${empty param.rol ? 'alumno' : param.rol}">
        </div>

        <div class="field">
          <label for="contrasena">Contraseña</label>
          <div class="input-shell">
            <input id="contrasena" name="contrasena" type="password" placeholder="Mínimo 8 caracteres" autocomplete="new-password">
            <button type="button" class="toggle-eye" data-for="contrasena" aria-label="Mostrar contraseña">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M2 12s3.5-7 10-7 10 7 10 7-3.5 7-10 7S2 12 2 12Z"/><circle cx="12" cy="12" r="3"/></svg>
            </button>
          </div>
          <div class="err-msg" id="e-contrasena">La contraseña debe tener al menos 8 caracteres.</div>
        </div>

        <div class="field">
          <label for="confirmar">Confirmar contraseña</label>
          <div class="input-shell">
            <input id="confirmar" name="confirmar" type="password" placeholder="Repite tu contraseña" autocomplete="new-password">
            <button type="button" class="toggle-eye" data-for="confirmar" aria-label="Mostrar contraseña">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M2 12s3.5-7 10-7 10 7 10 7-3.5 7-10 7S2 12 2 12Z"/><circle cx="12" cy="12" r="3"/></svg>
            </button>
          </div>
          <div class="err-msg" id="e-confirmar">Las contraseñas no coinciden.</div>
        </div>

        <button type="submit" class="btn">Crear cuenta</button>
      </form>

      <div class="divider"></div>
      <p class="foot">¿Ya tienes cuenta? <a href="${pageContext.request.contextPath}/login">Inicia sesión</a></p>
    </main>
  </div>

<script>
  var rolInput = document.getElementById("rolInput");

  // Activa el botón de rol
  (function(){
    var v = rolInput.value || "alumno";
    document.querySelectorAll("#seg button").forEach(function(b){
      b.classList.toggle("active", b.dataset.rol === v);
    });
  })();

  document.getElementById("seg").addEventListener("click", function(e){
    var b = e.target.closest("button[data-rol]");
    if(!b) return;
    document.querySelectorAll("#seg button").forEach(function(x){ x.classList.remove("active"); });
    b.classList.add("active");
    rolInput.value = b.dataset.rol;
  });

  document.querySelectorAll(".toggle-eye").forEach(function(btn){
    btn.addEventListener("click", function(){
      var inp = document.getElementById(btn.dataset.for);
      inp.type = inp.type === "password" ? "text" : "password";
    });
  });

  var EMAIL_UV = /^[^\s@]+@([a-z0-9-]+\.)*uv\.mx$/i;
  var banner = document.getElementById("banner");

  function setErr(id, on){
    document.getElementById(id).classList.toggle("invalid", on);
    var m = document.getElementById("e-"+id);
    if(m) m.classList.toggle("show", on);
  }

  // Validacion
  document.getElementById("form").addEventListener("submit", function(ev){
    banner.className = "banner";
    var nombre = document.getElementById("nombre").value.trim();
    var correo = document.getElementById("correo").value.trim();
    var pass   = document.getElementById("contrasena").value;
    var pass2  = document.getElementById("confirmar").value;

    var ok = true;
    setErr("nombre", false); setErr("correo", false); setErr("contrasena", false); setErr("confirmar", false);
    if(nombre.length < 3){ setErr("nombre", true); ok=false; }
    if(!EMAIL_UV.test(correo)){ setErr("correo", true); ok=false; }
    if(pass.length < 8){ setErr("contrasena", true); ok=false; }
    if(pass2 !== pass || pass2 === ""){ setErr("confirmar", true); ok=false; }

    if(!ok){
      ev.preventDefault();
      banner.textContent = "Revisa los campos marcados antes de continuar.";
      banner.className = "banner err";
    }
    // envia a /registro (servlet)
  });
</script>
</body>
</html>
