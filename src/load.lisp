(defmacro def-class (class &rest values)
	(if (not (listp class))
		(setf class (list class))
	)
	
	(let* ((i 0) 
	(name (car class))
	(heir (list name)))
	
	(dolist (super (cdr class))
		(let ((current  (symbol-value (intern(string-upcase (concatenate 'string  "global-" (string super) ))))))
			(setf heir (append heir current))
		)
	)
	
	`(progn 
		(setf ,(intern(string-upcase (concatenate 'string  "global-" (string name) ))) ',heir)
		(defun ,(intern(string-upcase (concatenate 'string  "make-" (string name) ))) (&key ,@values)
			(let ((classval (vector ',class ,@values)))
				; (dolist (i ,heir)
					
				; )
			classval
			)
		)
			
		(defun ,(intern(string-upcase (concatenate 'string  (string name) "?" ))) (,name)
			(if (and (simple-vector-p ,name) (listp (aref ,name 0)) (find ,(string name) (mapcar #'string (aref ,name 0)) :test #'equal))
					t
				nil
			)
		)
			
			
		,@(mapcar 
			#'(lambda (x) 
					(incf i)
					`(defun ,(intern(string-upcase (concatenate 'string (string name) "-" (string x) ))) (,name)
						(aref ,name ,i)
					)
			) values
		)
	))	
)
