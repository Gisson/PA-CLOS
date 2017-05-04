(defmacro def-class (class &rest values)
	(let ((i -1))
	`(progn 
		(defun ,(intern(string-upcase (concatenate 'string  "make-" (string class) ))) (&key ,@values)
				(vector ,@values)
			)
			
		(defun ,(intern(string-upcase (concatenate 'string  (string class) "?" ))) (,class)
				(and (simple-vector-p class) (equal ,(length (vector values)) (length ,class) ) )
			)
			,@(mapcar 
				#'(lambda (x) 
					(incf i)
					`(defun ,(intern(string-upcase (concatenate 'string (string class) "-" (string x) ))) (,class)
						(aref ,class ,i)
					)
				) values)
		)
	)	
)
