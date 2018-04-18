; This is global leiningen profile that is applied to all projects.
{:user {:plugins [[jonase/eastwood "0.2.5"]
                  [lein-kibit "0.1.5"]
                  [lein-cljfmt "0.5.7"]
                  ; [venantius/ultra "0.5.2"]
                  [io.aviso/pretty "0.1.34"]
                  [lein-cloverage "1.0.10"]]
        :dependencies [[io.aviso/pretty "0.1.34"]]

        :cljfmt {:remove-consecutive-blank-lines? false}}}
