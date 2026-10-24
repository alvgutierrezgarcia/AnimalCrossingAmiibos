# Álbum amiibo ACNH

Proyecto personal y privado: web estática para consultar las 400 tarjetas amiibo de
Animal Crossing (series 1–4) y elegir los vecinos de la isla. Se despliega en Vercel desde
github.com/alvgutierrezgarcia/AnimalCrossingAmiibos, **sin paso de build**: lo que hay en el
repo es lo que se sirve. No añadas bundlers, npm ni frameworks.

## Cómo trabajar
- Antes de tocar nada en una tarea nueva, lee `index.html`, resume cómo está organizado lo
  que afecta a la tarea y propón un plan. Espera el visto bueno antes de implementar.
- Cambios pequeños, en commits separados y con mensajes claros en español.
- Mantén el diseño, el idioma (todo el texto de la interfaz en español) y el enfoque móvil.
- Prueba siempre a ~390 px de ancho: nada de scroll horizontal. Comprueba también el modo oscuro.
- Para probar en local basta con abrir `index.html` o servir la carpeta con cualquier servidor estático.

## Estructura
Todo está en `index.html`:
1. `<style>`: variables de color en `:root` (con modo oscuro por `prefers-color-scheme` y
   `data-theme`), componentes y, al final, los ajustes móviles (`max-width: 700px` y `480px`).
   Fuentes: Baloo 2 (títulos), Nunito Sans (texto), DM Mono (números).
2. HTML: cabecera, barra fija (pestañas Catálogo · Favoritos · Mi isla, buscador, botón
   «Filtros», desplegable de especies), `<main>` donde se pinta todo, hoja inferior de ficha y toast.
   En móvil las pestañas pasan a una barra fija abajo.
3. `<script>`, por secciones (`// ---------- … ----------`):
   - Datos: `const CARDS = [...]` (una sola línea muy larga; no la leas entera ni la reformatees),
     `EMOJI` por especie, `PERS`, `COLORS`, constantes (`MAX_ISLAND = 10`).
   - Fotos: `IMG_BASES` + `imgTag()` + un listener global de `error` que hace el fallback.
   - `state` y persistencia en localStorage.
   - Acciones: `toggleFav`, `toggleIsland`.
   - Render: todo se repinta con `render()` → `renderFilters`/`renderList` o `renderIsland`, más `renderSheet`.
   - Eventos: delegación en `document` con atributos `data-fav`, `data-island`, `data-open`,
     `data-tab`, `data-series`, `data-kind`…

## Modelo de datos (cada elemento de `CARDS`)
| campo | significado |
|---|---|
| `n` | nº de tarjeta (1–400), clave principal |
| `s` | serie (1–4) |
| `en` / `es` | nombre en inglés / español |
| `sp` | especie en español |
| `v` | 1 vecino, 0 personaje especial |
| `p` | personalidad: Perezoso, Atlético, Gruñón, Esnob, Normal, Alegre, Presumida, Dulce |
| `g` | `"M"` / `"F"` |
| `b` | cumpleaños `"M/D"` |
| `c` · `h` | muletilla · afición |
| `st` · `co` | estilos `[]` · colores `[]` (claves en inglés, traducidas con `COLORS`) |
| `i` | id amiibo `"hhhhhhhh-tttttttt"`, clave de la foto |

`p`, `c`, `h`, `st` y `co` solo existen en vecinos. Fuentes: AmiiboAPI (N3evin) y el paquete
npm `animal-crossing` (Norviah), cruzados por número de tarjeta.

## Reglas
- **No descargues ni guardes imágenes de Nintendo en el repo.** Las fotos solo se enlazan:
  `https://raw.githubusercontent.com/N3evin/AmiiboAPI/master/images/icon_{i}.png`, luego
  jsDelivr (`cdn.jsdelivr.net/gh/N3evin/AmiiboAPI@master/images/`) y, como último recurso,
  el emoji de la especie.
- Mi isla admite 10 vecinos como máximo; los especiales (`v: 0`) no pueden añadirse.
- localStorage: `"acnh-amiibo-v1"` → `{ favs: [n], island: [n] }`; `"acnh-amiibo-v1-ui"` →
  `{ sort, series }`. No cambies estas claves ni su forma sin migrar los datos guardados.

## Hoja de ruta
1. README en UTF-8 (estaba en UTF-16 por crearlo con `echo >>` en PowerShell).
2. Quitar el código muerto de la versión artefacto de Claude (`window.claude`, `claude.use("db")`).
3. Sincronizar favoritos e isla entre dispositivos con Supabase, manteniendo localStorage
   como respaldo sin conexión.
4. Opcional: separar los datos a `cards.json` y el JS a su propio archivo, sin añadir build.
