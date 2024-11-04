(in-package :mito-auth-jzon)

(defclass mito-auth-jzon-standard-direct-slot-definition
    (jzon-util:sensitive-standard-direct-slot-definition
     mito.dao.column:dao-table-column-standard-effective-slot-definitions)
  ())

(defclass mito-auth-jzon-standard-effective-slot-definition
    (jzon-util:sensitive-standard-effective-slot-definition
     mito.dao.column:dao-table-column-class)
  ())

(defclass mito-auth-jzon-metaclass (jzon-util:sensitive-metaclass mito:dao-table-mixin)
  ())

(defmethod closer-mop:direct-slot-definition-class ((class mito-auth-jzon-metaclass)
                                                    &rest initargs)
  (declare (ignorable initargs))
  (find-class 'mito-auth-jzon-standard-direct-slot-definition))

(defmethod closer-mop:effective-slot-definition-class ((class mito-auth-jzon-metaclass)
                                                       &rest initargs)
  (declare (ignorable initargs))
  (find-class 'mito-auth-jzon-standard-effective-slot-definition))

(defmethod closer-mop:validate-superclass ((class mito-auth-jzon-metaclass)
                                           (superclass standard-class))
  t)

(in-package :mito-auth)

(defclass has-secure-sensitive-password (has-secure-password)
  ((password-hash :col-type (:char 64)
                  :sensitive t
                  :initarg :password-hash
                  :reader password-hash)
   (password-salt :col-type (:binary 20)
                  :sensitive t
                  :initarg :password-salt
                  :initform
                  ;; Use /dev/urandom seed for portability.
                  (let ((ironclad:*prng* (ironclad:make-prng :fortuna :seed :urandom)))
                    (ironclad:make-random-salt 20))
                  :reader password-salt))
  (:metaclass mito-auth-jzon:mito-auth-jzon-metaclass ))

(export 'has-secure-sensitive-password)

(in-package :mito-auth-jzon)
