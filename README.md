KavakChallenge

Frameworks utilizados:

- Alamofire y ObjectMapper: Decidí usar ambos porque no pude consumir el servicio de manera nativa, ya que al usar Decodable causaba conflicto con el pueblo llamado "Brastlewark", como tiene la 'B' mayúscula no podía generar el campo de acceso porque se llamaría igual que la clase y me causó problemas.

El buscador está ligado al nombre de los pueblerinos.
La carga de las imágenes se implementó con caché y ese método está alojado en una extensión.
Se utilizó el patrón MVVM para el desarrollo de esta app.