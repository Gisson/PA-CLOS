(defun cool-symbol (before extra &optional (after nil)) 
             (intern(string-upcase (concatenate 'string  before (string extra) after )))
             )

(defmacro def-class (class &rest values)
	(if (not (listp class))
		(setf class (list class))
	)
	
	(let* ((i 0) 
	(name (car class))
	(heir (list name)))
	
	(dolist (super (cdr class))
		(let ((current  (symbol-value (cool-symbol "global-" super ))))
			(setf heir (append heir current))
		)
	)
	
	`(progn 
		(setf ,(cool-symbol "global-" name) ',heir)
		(defun ,(cool-symbol  "make-" name) (&key ,@values)
			(let ((classval (vector ',class ,@values)))
				; (dolist (i ,heir)
					
				; )
			classval
			)
		)
			
		(defun ,(cool-symbol nil name "?" ) (,name)
			(if (and (simple-vector-p ,name) (listp (aref ,name 0)) (find ,(string name) (mapcar #'string (aref ,name 0)) :test #'equal))
					t
				nil
			)
		)
			
			
		,@(mapcar 
			#'(lambda (x) 
					(incf i)
					`(defun ,(cool-symbol nil name (concatenate 'string "-" (string x) )) (,name)
						(aref ,name ,i)
					)
			) values
		)
	))	
)
