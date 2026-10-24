# Álbum amiibo ACNH

Web estática para consultar las 400 tarjetas amiibo de Animal Crossing (series 1–4),
marcar favoritos y elegir los 10 vecinos de tu isla. Pensada sobre todo para el móvil.

## Uso

No hay paso de build: todo está en `index.html`. Para verla en local, abre el archivo en el
navegador o sirve la carpeta con cualquier servidor estático. Se despliega en Vercel tal cual.

Los favoritos y la isla se guardan en el `localStorage` del navegador.

## Datos

- [AmiiboAPI](https://github.com/N3evin/AmiiboAPI) (N3evin): números, series e ids de las tarjetas.
- [animal-crossing](https://www.npmjs.com/package/animal-crossing) (Norviah): personalidad,
  cumpleaños, muletilla, afición, estilos y colores de los vecinos.

Las fotos de las tarjetas no están en este repositorio: se enlazan desde AmiiboAPI
(GitHub y jsDelivr como respaldo). Animal Crossing y amiibo son marcas de Nintendo.
