{:test  {:dependencies  [[pjstadig/humane-test-output  "0.8.0"]]
         :injections  [(require 'pjstadig.humane-test-output)
                       (pjstadig.humane-test-output/activate!)]}
 :repl {:injections [(set! *print-length* 50)]}}
