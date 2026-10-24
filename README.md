# Álbum amiibo ACNH

Web estática para consultar las 400 tarjetas amiibo de Animal Crossing (series 1–4),
marcar favoritos y elegir los 10 vecinos de tu isla. Pensada sobre todo para el móvil.

## Uso

No hay paso de build: todo está en `index.html`. Para verla en local, abre el archivo en el
navegador o sirve la carpeta con cualquier servidor estático. Se despliega en Vercel tal cual.

Los favoritos y la isla se guardan en el `localStorage` del navegador. Si inicias sesión
(«Sincronizar entre dispositivos», al pie de la página, con un código que llega por email),
también se guardan en Supabase y se ven igual en el móvil y en el ordenador.

## Supabase

1. Ejecuta [`supabase/schema.sql`](supabase/schema.sql) en el editor SQL del proyecto.
2. Configura un SMTP propio (*Authentication → Emails → Set up SMTP*): sin él, Supabase no
   deja editar las plantillas. Después pega [`supabase/email-codigo.html`](supabase/email-codigo.html)
   en las plantillas «Magic Link» y «Confirm signup», que son las que llevan el código (`{{ .Token }}`).
3. Tras entrar por primera vez, desactiva el registro de usuarios nuevos en
   *Authentication → Sign In / Providers*.

La URL del proyecto y la clave pública están en `index.html` (`SB_URL`, `SB_KEY`). Esa clave
es pública por diseño: lo que protege los datos es la RLS de la tabla.

## Datos

- [AmiiboAPI](https://github.com/N3evin/AmiiboAPI) (N3evin): números, series e ids de las tarjetas.
- [animal-crossing](https://www.npmjs.com/package/animal-crossing) (Norviah): personalidad,
  cumpleaños, muletilla, afición, estilos y colores de los vecinos.

Las fotos de las tarjetas no están en este repositorio: se enlazan desde AmiiboAPI
(GitHub y jsDelivr como respaldo). Animal Crossing y amiibo son marcas de Nintendo.
