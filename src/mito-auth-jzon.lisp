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
                                           (superclass closer-mop:standard-class))
  t)

(defclass has-secure-password ()
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
  (:metaclass mito-auth-jzon-metaclass))

(defun make-password-hash (password salt)
  (ironclad:byte-array-to-hex-string
   (digest-sequence
    :sha256
    (concatenate '(vector (unsigned-byte 8))
                 (babel:string-to-octets password)
                 salt))))

(defgeneric (setf password) (password auth)
  (:method (password (object has-secure-password))
    (let ((password-hash
            (make-password-hash password
                                (slot-value object 'password-salt))))
      (setf (slot-value object 'password-hash) password-hash))))

(defmethod initialize-instance :after ((object has-secure-password) &rest initargs
                                       &key password &allow-other-keys)
  (declare (ignore initargs))
  (when password
    (setf (password object) password)))

(defun auth (object password)
  (string= (password-hash object)
           (make-password-hash password
                               (password-salt object))))
