(defmacro def-class (class &rest values)
	`(progn (defun ,(intern(string-upcase (concatenate 'string  "make-" (string class) ))) (&key ,@values)
				(vector ,@values)
			)
			
			(defun ,(intern(string-upcase (concatenate 'string  (string class) "?" ))) (class)
				(and (simple-vector-p class) (equal ,(length (vector values)) (length class) ) )
			)
			
		
			,@(dolist (val values)
				`(defun ,(intern(string-upcase (concatenate 'string (string class) "-" (string val) )))()
						(print 1)
					)		
			)	
			
	)	
)
