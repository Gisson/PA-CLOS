(defmacro def-class (class &rest values)
	`(progn (defun ,class (&key ,@values)
				(vector ,@values)
			)
			
		
			,@(dolist (val values)
				`(defun ,(intern(string-upcase (concatenate 'string (string class) "-" (string val) )))()
						(print 1)
					)		
			)	
			
		; (def-class lol a) (setf as (LOL :A 1)) (LOL-A as)