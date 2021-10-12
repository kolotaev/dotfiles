; This is global leiningen profile that is applied to all projects.
{:user {:plugins [[jonase/eastwood "0.2.5"]
                  [lein-kibit "0.1.5"]
                ;;   [lein-cljfmt "0.8.0"]
                  ; [venantius/ultra "0.5.2"]
                  [nightlight/lein-nightlight "1.9.3"]
                  [io.aviso/pretty "0.1.37"]
                  [lein-cloverage "1.0.10"]]
        :middleware [io.aviso.lein-pretty/inject]
        :dependencies [[io.aviso/pretty "0.1.37"]]
        :cljfmt {:remove-consecutive-blank-lines? false}}}
