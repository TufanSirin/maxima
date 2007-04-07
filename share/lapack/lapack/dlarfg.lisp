;;; Compiled by f2cl version 2.0 beta Date: 2006/12/21 03:42:11 
;;; Using Lisp CMU Common Lisp CVS Head 2006-12-02 00:15:46 (19D)
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package :lapack)


(let* ((one 1.0) (zero 0.0))
  (declare (type (double-float 1.0 1.0) one)
           (type (double-float 0.0 0.0) zero))
  (defun dlarfg (n alpha x incx tau)
    (declare (type (array double-float (*)) x)
             (type (double-float) tau alpha)
             (type (f2cl-lib:integer4) incx n))
    (f2cl-lib:with-multi-array-data
        ((x double-float x-%data% x-%offset%))
      (prog ((beta 0.0) (rsafmn 0.0) (safmin 0.0) (xnorm 0.0) (j 0) (knt 0))
        (declare (type (double-float) beta rsafmn safmin xnorm)
                 (type (f2cl-lib:integer4) j knt))
        (cond
          ((<= n 1)
           (setf tau zero)
           (go end_label)))
        (setf xnorm (dnrm2 (f2cl-lib:int-sub n 1) x incx))
        (cond
          ((= xnorm zero)
           (setf tau zero))
          (t
           (setf beta (- (f2cl-lib:sign (dlapy2 alpha xnorm) alpha)))
           (setf safmin (/ (dlamch "S") (dlamch "E")))
           (cond
             ((< (abs beta) safmin)
              (tagbody
                (setf rsafmn (/ one safmin))
                (setf knt 0)
               label10
                (setf knt (f2cl-lib:int-add knt 1))
                (dscal (f2cl-lib:int-sub n 1) rsafmn x incx)
                (setf beta (* beta rsafmn))
                (setf alpha (* alpha rsafmn))
                (if (< (abs beta) safmin) (go label10))
                (setf xnorm (dnrm2 (f2cl-lib:int-sub n 1) x incx))
                (setf beta (- (f2cl-lib:sign (dlapy2 alpha xnorm) alpha)))
                (setf tau (/ (- beta alpha) beta))
                (dscal (f2cl-lib:int-sub n 1) (/ one (- alpha beta)) x incx)
                (setf alpha beta)
                (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                              ((> j knt) nil)
                  (tagbody (setf alpha (* alpha safmin)) label20))))
             (t
              (setf tau (/ (- beta alpha) beta))
              (dscal (f2cl-lib:int-sub n 1) (/ one (- alpha beta)) x incx)
              (setf alpha beta)))))
        (go end_label)
       end_label
        (return (values nil alpha nil nil tau))))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::dlarfg
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo
           :arg-types '((fortran-to-lisp::integer4) (double-float)
                        (array double-float (*)) (fortran-to-lisp::integer4)
                        (double-float))
           :return-values '(nil fortran-to-lisp::alpha nil nil
                            fortran-to-lisp::tau)
           :calls '(fortran-to-lisp::dscal fortran-to-lisp::dlamch
                    fortran-to-lisp::dlapy2 fortran-to-lisp::dnrm2))))

