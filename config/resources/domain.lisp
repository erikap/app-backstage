(in-package :mu-cl-resources)

(defparameter *supply-cache-headers-p* t
  "when non-nil, cache headers are supplied.  this works together with mu-cache.")
(setf *cache-model-properties-p* t)
(defparameter *cache-count-queries* t)
(defparameter *include-count-in-paginated-responses* t
  "when non-nil, all paginated listings will contain the number
   of responses in the result object's meta.")
(defparameter *max-group-sorted-properties* nil)

;;
;; Music library
;;

(define-resource score ()
  :class (s-prefix "schema:MusicComposition") ;; < nie:InformationElement
  :properties `((:title :string ,(s-prefix "schema:name"))
                (:description :string ,(s-prefix "schema:description"))
                (:comment :string ,(s-prefix "nie:comment"))
                (:composer :string ,(s-prefix "schema:composer"))
                (:arranger :string ,(s-prefix "music:arranger"))
                (:duration :string ,(s-prefix "schema:timeRequired"))
                (:genre :string ,(s-prefix "schema:genre"))
                (:publisher :string ,(s-prefix "schema:publisher"))
		(:created :datetime ,(s-prefix "dct:created"))
		(:modified :datetime ,(s-prefix "dct:modified")))
  :has-one `((score-status :via ,(s-prefix "adms:status")
                           :as "status"))
  :has-many `((score-part :via ,(s-prefix "schema:hasPart")
                          :as "parts"))
  :resource-base (s-url "http://backstage.data.gift/scores/")
  :on-path "scores")

(define-resource score-part ()
  :class (s-prefix "music:ScorePart") ;; < schema:CreativeWork ; nie:InformationElement
  :properties `((:created :datetime ,(s-prefix "dct:created"))
		(:modified :datetime ,(s-prefix "dct:modified")))
  :has-one `((score :via ,(s-prefix "schema:hasPart")
                    :inverse t
                    :as "score")
             (instrument :via ,(s-prefix "music:instrument")
                         :inverse t
                         :as "instrument")
             (instrument-part :via ,(s-prefix "music:instrumentPart")
                              :inverse t
                              :as "instrument-part")
             (key :via ,(s-prefix "music:key")
                  :inverse t
                  :as "key")
             (clef :via ,(s-prefix "music:clef")
                   :inverse t
                   :as "clef")
             (file :via ,(s-prefix "nie:isStoredAs")
                   :as "file"))
  :resource-base (s-url "http://backstage.data.gift/score-parts/")
  :on-path "score-parts")

(define-resource instrument ()
  :class (s-prefix "music:Instrument")  ;; < skos:Concept
  :properties `((:label :string ,(s-prefix "skos:prefLabel"))
                (:position :number ,(s-prefix "schema:position")))
  :has-many `((instrument-part :via ,(s-prefix "music:hasInstrumentPart")
                               :as "instrument-parts"))
  :resource-base (s-url "http://backstage.data.gift/instruments/")
  :features '(include-uri)
  :on-path "instruments")

(define-resource instrument-part ()
  :class (s-prefix "music:InstrumentPart")  ;; < skos:Concept
  :properties `((:label :string ,(s-prefix "skos:prefLabel")))
  :has-one `((instrument :via ,(s-prefix "music:hasInstrumentPart")
                         :inverse t
                         :as "instrument"))
  :resource-base (s-url "http://backstage.data.gift/instrument-parts/")
  :features '(include-uri)
  :on-path "instrument-parts")

(define-resource key ()
  :class (s-prefix "music:Key")  ;; < skos:Concept
  :properties `((:label :string ,(s-prefix "skos:prefLabel")))
  :resource-base (s-url "http://backstage.data.gift/keys/")
  :features '(include-uri)
  :on-path "keys")

(define-resource clef ()
  :class (s-prefix "music:Clef")  ;; < skos:Concept
  :properties `((:label :string ,(s-prefix "skos:prefLabel")))
  :resource-base (s-url "http://backstage.data.gift/clefs/")
  :features '(include-uri)
  :on-path "clefs")

(define-resource score-part-template ()
  :class (s-prefix "app:ScorePartTemplate")
  :properties `((:position :number ,(s-prefix "schema:position")))
  :has-one `((instrument :via ,(s-prefix "music:instrument")
                         :inverse t
                         :as "instrument")
             (instrument-part :via ,(s-prefix "music:instrumentPart")
                              :inverse t
                              :as "instrument-part")
             (key :via ,(s-prefix "music:key")
                  :inverse t
                  :as "key")
             (clef :via ,(s-prefix "music:clef")
                   :inverse t
                   :as "clef"))
  :resource-base (s-url "http://backstage.data.gift/score-part-templates/")
  :features '(include-uri)
  :on-path "score-part-templates")

(define-resource score-status ()
  :class (s-prefix "app:ScoreStatus")  ;; < skos:Concept
  :properties `((:label :string ,(s-prefix "skos:prefLabel")))
  :resource-base (s-url "http://backstage.data.gift/score-statuses/")
  :features '(include-uri)
  :on-path "score-statuses")


;;
;; Files
;;

(define-resource file ()
  :class (s-prefix "nfo:FileDataObject")
  :properties `((:filename :string ,(s-prefix "nfo:fileName"))
                (:format :string ,(s-prefix "dct:format"))
                (:size :number ,(s-prefix "nfo:fileSize"))
                (:extension :string ,(s-prefix "dbpedia:fileExtension"))
                (:created :datetime ,(s-prefix "nfo:fileCreated")))
  :has-one `((file :via ,(s-prefix "nie:dataSource")
                   :inverse t
                   :as "download"))
  :resource-base (s-url "http://backstage.data.gift/files/")
  :on-path "files")

