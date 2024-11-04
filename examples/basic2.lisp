
(defclass user1 (mito-auth:has-secure-sensitive-password)
  ((name :col-type (:varchar 60)
         :initarg :name
         :accessor user-name)
   (email :col-type (:varchar 255)
          :initarg :email
          :accessor user-email)
   (secret :col-type (or :null :text)
           :accessor secret
           :sensitive t))
  (:metaclass mito-auth-jzon:mito-auth-jzon-metaclass))


(make-instance 'user1 :name "robert" :email "robert@ludlum.com" :password "bourne" :secret "jason")

(com.inuoe.jzon:stringify (make-instance 'user1 :name "robert" :email "robert@ludlum.com" :password "bourne" :secret "jason"))
