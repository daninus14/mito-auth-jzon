
(defclass user1 (mito-auth:has-secure-sensitive-password)
  ((name :col-type (:varchar 60)
         :initarg :name
         :accessor user-name)
   (email :col-type (:varchar 255)
          :initarg :email
          :accessor user-email))
  (:metaclass mito-auth-jzon:mito-auth-jzon-metaclass))


(make-instance 'user1 :name "robert" :email "robert@ludlum.com" :password "bourne")

(com.inuoe.jzon:stringify (make-instance 'user1 :name "robert" :email "robert@ludlum.com" :password "bourne"))
