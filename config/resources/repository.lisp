(in-package :mu-cl-resources)

;;;;
;; NOTE
;; docker-compose stop; docker-compose rm; docker-compose up
;; after altering this file.


;;;;;
;; You can use the muext: prefix when you're still searching for
;; the right predicates during development.  This should *not* be
;; used to publish any data under.  It's merely a prefix of which
;; the mu.semte.ch organisation indicates that it will not be used
;; by them and that it shouldn't be used for permanent URIs.

(add-prefix "ext" "http://mu.semte.ch/vocabularies/ext/")
(add-prefix "dct" "http://purl.org/dc/terms/")
(add-prefix "adms" "http://www.w3.org/ns/adms#")
(add-prefix "skos" "http://www.w3.org/2004/02/skos/core#")
(add-prefix "nfo" "http://www.semanticdesktop.org/ontologies/2007/03/22/nfo#")
(add-prefix "nie" "http://www.semanticdesktop.org/ontologies/2007/01/19/nie#")
(add-prefix "dbpedia" "http://dbpedia.org/ontology/")
(add-prefix "schema" "http://schema.org/")

(add-prefix "music" "http://backstage.data.gift/vocabularies/music/")
(add-prefix "app" "http://backstage.data.gift/vocabularies/application/")
