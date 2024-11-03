(defsystem "mito-auth-jzon"
  :version "0.1.0"
  :author "Daniel Nussenbaum"
  :license "MIT"
  :depends-on ("com.inuoe.jzon"
               "jzon-util"
               "mito"
               "ironclad"
               "babel"
               "closer-mop")
  :components ((:module "src"
                :components
                ((:file "packages")
                 (:file "mito-auth-jzon"))))
  :description "Utilities for com.inuoe.jzon")
