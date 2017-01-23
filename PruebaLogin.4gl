GLOBALS 
  DEFINE Datos DYNAMIC ARRAY OF RECORD
           n_nombre  VARCHAR (30),
           n_edad    VARCHAR(30),
           n_fecha   VARCHAR(30),
           n_sexo    Varchar(30)
  END RECORD
END Globals
MAIN 
DEFINE usuario,pass STRING
CALL Datos.CLEAR()
OPEN WINDOW w1 WITH FORM "PruebaLogin"

INPUT usuario,pass FROM txttexto1,txtpass ATTRIBUTES(UNBUFFERED) 

ON ACTION btnmostrar
--message usuario," ",pass
CALL recibe(usuario,pass)



END INPUT 
CLOSE WINDOW w1 

END MAIN 

FUNCTION recibe(usua,contra)
DEFINE usua,contra,nombre STRING
DEFINE edad INTEGER
DEFINE sexo INTEGER  
DEFINE fecha DATE

DEFINE usuac,contrac STRING 
LET usuac="Felipe"
LET contrac="123"



IF (usuac=usua)AND (contrac==contra) THEN
 OPEN WINDOW w2 WITH FORM "Mensaje"
DIALOG ATTRIBUTES(UNBUFFERED)
    INPUT nombre,edad,sexo,fecha FROM txtnombre,txt_edad,Sexo,dt_fecha ATTRIBUTES(WITHOUT DEFAULTS)

    END INPUT 

        DISPLAY ARRAY Datos TO Record1.*
        
        END DISPLAY

        ON ACTION btn_DetalleRow
            if(Datos.getLength()>0)THEN 
              CALL MuestraRow(Datos[arr_curr()].*)
            END if

        ON action btn_Mostrar
            CALL muestra(nombre,edad,sexo,fecha)

        ON ACTION btn_MuestraDatos 
            CALL Datos.appendElement()
            LET Datos[Datos.getLength()].n_nombre=nombre; 
            LET Datos[Datos.getLength()].n_edad=edad; 
            LET Datos[Datos.getLength()].n_fecha=fecha;
            LET Datos[Datos.getLength()].n_sexo=sexo;  
        -- Muestra los datos en consola
            CALL muestratabla(Datos);
            
        ON action salir
            EXIT DIALOG    
            

            
END DIALOG 
    
 CLOSE WINDOW w2

 ELSE
    OPEN WINDOW werror WITH FORM "Error"
     MENU "Salir"
      ON action salir
      EXIT MENU


     END MENU
    CLOSE WINDOW werror
END IF


END function

FUNCTION muestra(nombre,edad,sexo,fecha)
DEFINE nombre STRING 
DEFINE edad INTEGER 
DEFINE sexo BOOLEAN 
DEFINE fecha DATE 

 OPEN WINDOW w3 WITH FORM "Muestra"

   MENU "muestra"
  
    ON action Salir
    EXIT MENU

    BEFORE MENU
    DISPLAY nombre TO lbl_Nombre
    DISPLAY edad TO lbl_Edad
    DISPLAY fecha TO lbl_Fecha
    IF(Sexo==1)THEN 
         DISPLAY "Masculino" TO lbl_sexo
         ELSE 
         DISPLAY "Femenino" TO lbl_sexo
    END IF        
  END MENU
 CLOSE WINDOW w3

END function

FUNCTION muestratabla(datos)
  DEFINE datos DYNAMIC ARRAY OF RECORD
           n_nombre  VARCHAR (30),
           n_edad    VARCHAR(30),
           n_fecha   VARCHAR(30),
           n_sexo    Varchar(30)
   END RECORD

            
END FUNCTION

FUNCTION MuestraRow(dato)
  DEFINE dato  RECORD
           n_nombre  VARCHAR (30),
           n_edad    VARCHAR(30),
           n_fecha   VARCHAR(30),
           n_sexo    Varchar(30)
   END RECORD
OPEN WINDOW w4 WITH FORM "Muestra"
   MENU "muestra"
  
    ON action Salir
    EXIT MENU

    BEFORE MENU
    DISPLAY dato.n_nombre TO lbl_Nombre
    DISPLAY dato.n_edad TO lbl_Edad
    DISPLAY dato.n_fecha TO lbl_Fecha
    IF(dato.n_sexo==1)THEN 
         DISPLAY "Masculino" TO lbl_sexo
         ELSE 
         DISPLAY "Femenino" TO lbl_sexo
    END IF        
  END MENU
 CLOSE WINDOW w4

END FUNCTION 