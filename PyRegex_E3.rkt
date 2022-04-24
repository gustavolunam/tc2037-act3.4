#lang racket

#|*************************

Gustavo Luna Muñoz - A01411619
Axel Amós Hernández Cárdenas - A00829837
Brandon Alan Hernández Flores - A00830202

Última Versión: 21-Abr-22

Este programa resalta palabras reservadas, comentarios, números y
operadores de Python mediante el uso de expresiones regulares y HTML+CSS.

-- Como ejecutarlo --

Introducir la siguiente linea en la terminal RUN
(primero irá el archivo de entrada y luego el de salida):

(resaltadorPy "

-- Driver Codes --

(resaltadorPy "Python1_Booleanos.py" "1.html")
(resaltadorPy "Python2_Ciclos.py" "2.html")
(resaltadorPy "Python3_Condicionales.py" "3.html")
(resaltadorPy "Python4_FullRegex.py" "4.html")

1. Scripts variados de booleanos y ciclos
2. Scripts variados de ciclos + fibonacci
3. Scripts variados de condicionales y ciclos
4. Lista de resaltados
***************************|#

; Lista del Header HTML del archivo de Salida
(define headerHTML(list "<!DOCTYPE html>"
        "<html>"
        "<head>"
            "<meta charset=\"UTF-8\">"
            "<!-- white-space: pre modifica el body para que cada linea finalice con <br> (salto de linea), preservando la sintaxis original -->"
            "<!-- CSS naranja para los números -->"
            "<!-- CSS rojo para los booleanos -->"
            "<!-- CSS morado para los condicionales -->"
            "<!-- CSS azul para los operadores aritmeticos -->"
            "<!-- CSS verde para los strings especiales -->"
            "<!-- CSS rosa para los condicionales especiales -->"
            "<style>"
                   "body{ white-space: pre; font-family: Courier New; font-size: 14px }"
                   "h3{ text-align: center }"
                   ".center { display: block; margin-left: auto; margin-right: auto; width: 75px; height: 75px ;}"
                   ".numero{ color: orange; }"
                   ".booleano{ color: red; }"
                   ".condicional{ color: magenta; }"
                   ".extra{ color: hotpink; }"
                   ".operador{ color: blue; }"
                   ".header{ color: YellowGreen; }"
            "</style>"
            "<title>Resaltador de sintaxis de Python</title>"
        "</head>"
        "<body>"
            "<img src=https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Python-logo-notext.svg/1200px-Python-logo-notext.svg.png alt=Python_Logo class=center>"
            "<h3> Resaltador de Sintaxis de Python </h3>"
            "<br>"))

; Lista del Cierre HTML del archivo de Salida
(define finalHTML(list "</body>"
        "</html>"))

; Función que determinará cuales expresiones regulares se cumplen para una línea del archivo.
; Al encontrar una, la cambia por su formato HTML utilizando el tag de <span> permitiendo que
; en el output file la palabra se vea resaltada dependiendo de la clase asignada por el <style>.
; Complejidad: O(N)

(define (regex listaPy)
  (let regexAhtml 
    ; Definimos un nuevo nombre a la listaPy y una lista final que guardara el sintaxis HTML. La inicializamos vacía.
    ([listaArchEnt listaPy][listaHTML empty])
    ; Preguntamos si la lista de lineas esta vacia
    (if(empty? listaArchEnt)
       ; Si #t quiere decir que ya recorrimos toda la listaPy (listaArchEnt). Regresamos el formato HTML guardado en listaHTML
       listaHTML 
       ; Si #f quiere decir que aun no acabamos y debemos validar la linea siguiente. let* es un operando especial para evaluar condiciones 1 por 1. (los necesarios)
       (let*
           ; Creamos una variable especial para el car de la lista y empezamos el regex y formateo en HTML.
           ([car_de_lista (car listaArchEnt)]
            ; [ car de lista se convertirá en <span> (formato HTML) en caso de encontrar un match con la expresión ]
            ; [ & sustiuye al input en el insert en Racket (regEXP-input-insert) ]
            [car_de_lista (regexp-replace* #px"for" car_de_lista "<span class='condicional'>&</span>")]
            [car_de_lista (regexp-replace* #px"(if|elif)" car_de_lista "<span class='condicional'>&</span>")]
            [car_de_lista (regexp-replace* #px"else" car_de_lista "<span class='condicional'>&</span>")]
            [car_de_lista (regexp-replace* #px"while" car_de_lista "<span class='condicional'>&</span>"	)]
            [car_de_lista (regexp-replace* #px"return" car_de_lista "<span class='condicional'>&</span>")]
            [car_de_lista (regexp-replace* #px"break" car_de_lista "<span class='condicional'>&</span>")]
            [car_de_lista (regexp-replace* #px"bool" car_de_lista "<span class='condicional'>&</span>")]
            [car_de_lista (regexp-replace* #px"append" car_de_lista "<span class='condicional'>&</span>")]
            [car_de_lista (regexp-replace* #px"str" car_de_lista "<span class='condicional'>&</span>")]
            [car_de_lista (regexp-replace* #px"len" car_de_lista "<span class='condicional'>&</span>")]
            [car_de_lista (regexp-replace* #px"print" car_de_lista "<span class='extra'>&</span>")]
            [car_de_lista (regexp-replace* #px"pass" car_de_lista "<span class='extra'>&</span>")]
            [car_de_lista (regexp-replace* #px"try" car_de_lista "<span class='extra'>&</span>")]
            [car_de_lista (regexp-replace* #px"pow" car_de_lista "<span class='extra'>&</span>")]
            [car_de_lista (regexp-replace* #px"except" car_de_lista "<span class='extra'>&</span>")]
            [car_de_lista (regexp-replace* #px"del" car_de_lista "<span class='extra'>&</span>"	)]
            [car_de_lista (regexp-replace* #px"range" car_de_lista "<span class='extra'>&</span>")]
            [car_de_lista (regexp-replace* #px"global" car_de_lista "<span class='header'>&</span>")]
            [car_de_lista (regexp-replace* #px"import" car_de_lista "<span class='header'>&</span>")]
            [car_de_lista (regexp-replace* #px"input" car_de_lista "<span class='condicional'>&</span>")]
            [car_de_lista (regexp-replace* #px"float" car_de_lista "<span class='condicional'>&</span>")]
            [car_de_lista (regexp-replace* #px"def" car_de_lista "<span class='header'>&</span>")]
            [car_de_lista (regexp-replace* #px"([+]|[-]|[*])" car_de_lista "<span class='operador'>&</span>")]
            [car_de_lista (regexp-replace* #px"#.*" car_de_lista "<span class='header'>&</span>")] ; Comentarios
            [car_de_lista (regexp-replace* #px"!=" car_de_lista "<span class='operador'>&</span>")]
            [car_de_lista (regexp-replace* #px"==" car_de_lista "<span class='operador'>&</span>")]
            [car_de_lista (regexp-replace* #px"%" car_de_lista "<span class='operador'>&</span>")]
            [car_de_lista (regexp-replace* #px"//" car_de_lista "<span class='operador'>&</span>")]
            [car_de_lista (regexp-replace* #px"[(]|[)]" car_de_lista "<span class='operador'>&</span>")]
            [car_de_lista (regexp-replace* #px"<=" car_de_lista "<span class='operador'>&</span>")]
            [car_de_lista (regexp-replace* #px"(None|none)" car_de_lista "<span class='booleano'>&</span>")]
            [car_de_lista (regexp-replace* #px"(True|true)" car_de_lista "<span class='booleano'>&</span>")]
            [car_de_lista (regexp-replace* #px"(False|false)" car_de_lista "<span class='booleano'>&</span>")]
            [car_de_lista (regexp-replace* #px"and" car_de_lista "<span class='booleano'>&</span>")]
            [car_de_lista (regexp-replace* #px"not" car_de_lista "<span class='booleano'>&</span>")]
            [car_de_lista (regexp-replace* #px"[0-9]+" car_de_lista "<span class='numero'>&</span>")])
         ; Apendizamos los formatos HTML e iteramos para el resto de la lista
         (regexAhtml (cdr listaArchEnt) (append listaHTML (list car_de_lista)))))))
        ;pasamos como nueva lista el cdr de listaArchEnt y apendizamos a la lista final el nuevo car dado por regex-replace*

(define (resaltadorPy file1 file2)
  
#| display-lines-to-file: Desplegará cada elemento (car) de la lista añadiendo
   un separador (por default \n) para regresar la sintaxis original del archivo,
   en el archivo de salida (file2)

   Para evitar errores en caso de que el archivo ya exista:
   #:exists 'truncate or #:exists 'update to re-write or
   update the file or #:exists 'append to add to the file

|#
  
  (display-lines-to-file headerHTML file2 #:exists 'truncate) ;#:exists 'truncate re-escribirá el archivo de salida en caso de que ya exista

  ; file->lines creará una lista de un solo string POR LAS LINEAS que contenga el archivo
  (define listaPy (file->lines file1))  
  (display-lines-to-file (regex listaPy) file2 #:exists 'append) ;si ya existe lo apendizamos a file2 (archSalida
  
  ; Para cerrar el documento .html, volvemos a escribir en el archivo de salida
   (display-lines-to-file finalHTML file2 #:exists 'append)
  )


