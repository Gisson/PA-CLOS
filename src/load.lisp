(defun gen-symbol (before extra &optional (after "")) 
    (intern(string-upcase (concatenate 'string  (string before) (string extra) (string after) ))))

(defmacro def-class (class &rest values)
    (if (not (listp class))
        (setf class (list class))
    )
    
    (let* ((i 0) 
    (name (car class))
    (heir (list name)))
    
    (dolist (super (cdr class))
        (let ((current-heir (symbol-value (gen-symbol "global-" super "-heir" )))
        (current-values (symbol-value (gen-symbol "global-" super "-values" ))))
        
        (setf heir (append heir current-heir))
            (setf values (append values current-values))
        )
    )
    
    `(progn 
        (setf ,(gen-symbol "global-" name "-heir") ',heir)
        (setf ,(gen-symbol "global-" name "-values") ',values)
        
        (defun ,(gen-symbol "make-" name) (&key ,@values)
            (let* ((table (make-hash-table))
            (classval (vector ',class table))
            (val-it 0)
            (val-names  ',values))
            (dolist (val (list ,@values))
                (setf (gethash (nth val-it val-names) table) val)
                (incf val-it)
            )
            classval
            )
        )
            
        (defun ,(gen-symbol name "?") (,name)
            (if (and (simple-vector-p ,name) (listp (aref ,name 0)) (find ,(string name) (mapcar #'string ',heir) :test #'equal))
                    t
                nil
            )
        )
            
            
        ,@(mapcar 
            #'(lambda (x) 
                    (incf i)
                    `(defun ,(gen-symbol name "-" x) (,name)
                        (values (gethash ',x (aref ,name 1)))
                    )
            ) values
        )
    ))  
)