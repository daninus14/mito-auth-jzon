(defclass c1 (mito-auth-jzon:has-secure-password)
  ((name :accessor name :initargs :name :initform NIL :col-type (or :null :text)))
  (:metaclass mito-auth-jzon:mito-auth-jzon-metaclass))


(com.inuoe.jzon:stringify (make-instance 'c1 :name "john" :password "robert"))
