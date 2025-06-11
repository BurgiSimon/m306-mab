# m306-mab
Überblick
Sie führen in Einzelarbeit ein IT-Projekt durch. Zur Planung und Steuerung verwenden Sie die Projektmethode "IPERKA". Informationen dazu erhalten Sie im Unterricht. Die Bewertung erfolgt analog einer IPA, Details folgen später in diesem Dokument. Das Projekt umfasst die Module 306 und 450:

	○ Modul 306: Planung, Varianten, Konzept, Realisierung, Test, Dokumentation
	○ Modul 450: Applikationen testen


Projektziele
	○ Ein Projekt als "IPA-Testlauf" durchführen. Damit optimale Vorbereitung auf die IPA. Sensibilisierung auf die in Zusammenhang mit der IPA wichtigen Aspekte (z.B. Planung, Dokumentation, Bewertung).
	○ Lernziele des Moduls 306 im Rahmen einer praktischen Arbeit anwenden
	○ Lernziele des Moduls 450 im Rahmen einer praktischen Arbeit anwenden
=======
## Grails 6.2.3 Documentation

- [User Guide](https://docs.grails.org/6.2.3/guide/index.html)
- [API Reference](https://docs.grails.org/6.2.3/api/index.html)
- [Grails Guides](https://guides.grails.org/index.html)
---

## Feature scaffolding documentation

- [Grails Scaffolding Plugin documentation](https://grails.github.io/scaffolding/latest/groovydoc/)

- [https://grails-fields-plugin.github.io/grails-fields/latest/guide/index.html](https://grails-fields-plugin.github.io/grails-fields/latest/guide/index.html)

## Feature geb documentation

- [Grails Geb Functional Testing for Grails documentation](https://github.com/grails3-plugins/geb#readme)

- [https://www.gebish.org/manual/current/](https://www.gebish.org/manual/current/)

## Feature asset-pipeline-grails documentation

- [Grails Asset Pipeline Core documentation](https://www.asset-pipeline.com/manual/)

## Docker Compose

To start only the database services for testing, run:

```bash
docker compose -f docker-compose-db.yml up -d
```

This launches MySQL and Adminer. Use the standard `docker-compose.yml` to start the full application.

To run the Grails app locally with this MySQL instance, ensure the `production` profile is active:

```bash
docker compose up -d
SPRING_PROFILES_ACTIVE=production ./grailsw run-app
```

Check the console output for `jdbc:mysql://` to confirm it connects to the container database.
