(defmacro def-class (class &rest values)
	(if (not (listp class))
		(setf class (list class))
	)
	
	(let* ((i 0) 
	(name (car class))
	(heir (list name)))
	
	(dolist (super (cdr class))
		(let ((current-heir  (symbol-value (intern(string-upcase (concatenate 'string  "global-" (string super) "-heir" )))))
		(current-values (symbol-value (intern(string-upcase (concatenate 'string  "global-" (string super) "-values" ))))))
		
		(setf heir (append heir current-heir))
			(setf values (append values current-values))
		)
	)
	
	`(progn 
		(setf ,(intern(string-upcase (concatenate 'string  "global-" (string name) "-heir" ))) ',heir)
		(setf ,(intern(string-upcase (concatenate 'string  "global-" (string name) "-values" ))) ',values)
		
		(defun ,(intern(string-upcase (concatenate 'string  "make-" (string name) ))) (&key ,@values)
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
			
		(defun ,(intern(string-upcase (concatenate 'string  (string name) "?" ))) (,name)
			(if (and (simple-vector-p ,name) (listp (aref ,name 0)) (find ,(string name) (mapcar #'string ',heir) :test #'equal))
					t
				nil
			)
		)
			
			
		,@(mapcar 
			#'(lambda (x) 
					(incf i)
					`(defun ,(intern(string-upcase (concatenate 'string (string name) "-" (string x) ))) (,name)
						(values (gethash ',x (aref ,name 1)))
					)
			) values
		)
	))	
)
