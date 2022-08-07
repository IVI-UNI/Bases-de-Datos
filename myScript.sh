#!/bin/sh

#Se obtienen los csv con las notas de corte
: <<'END_COMMENT'
echo "Comienza el script de mysql"
echo "Descargando las notas de corte:"
rm -r -f $HOME/Practica1
mkdir -p $HOME/Practica1

wget -q -O /var/lib/mysql-files/notasCorte2021.csv 'https://zaguan.unizar.es/record/98173/files/CSV.csv'
sed -i -e 's/Grado: //g' /var/lib/mysql-files/notasCorte2021.csv
wget -q -O /var/lib/mysql-files/notasCorte2020.csv 'https://zaguan.unizar.es/record/87663/files/CSV.csv'
sed -i -e 's/Grado: //g' /var/lib/mysql-files/notasCorte2020.csv
wget -q -O /var/lib/mysql-files/notasCorte2019.csv 'https://zaguan.unizar.es/record/76876/files/CSV.csv'
sed -i -e 's/Grado: //g' /var/lib/mysql-files/notasCorte2019.csv

echo "Notas de corte descargadas"
#Obtención de datos de  los datos de movilidad de los últimos 3 años
echo "Obteniendo ficheros de Movilidad SICUE y ERASMUS de los 3 ultimos años..."
wget -q -O /var/lib/mysql-files/movilidad2021.csv 'https://zaguan.unizar.es/record/107373/files/CSV.csv'
sed -i '/Máster/d; /Doctorado/d' /var/lib/mysql-files/movilidad2021.csv
wget -q -O /var/lib/mysql-files/movilidad2020.csv 'https://zaguan.unizar.es/record/95648/files/CSV.csv'
sed -i '/Máster/d; /Doctorado/d' /var/lib/mysql-files/movilidad2020.csv
wget -q -O /var/lib/mysql-files/movilidad2019.csv 'https://zaguan.unizar.es/record/83980/files/CSV.csv'
sed -i '/Máster/d; /Doctorado/d' /var/lib/mysql-files/movilidad2019.csv
echo "Oteniendo datos de oferta y ocupación..."
#Obtención de datos de Oferta y Ocupación de los últimos 3 años

wget -q -O /var/lib/mysql-files/Oferta2021.csv 'https://zaguan.unizar.es/record/108270/files/CSV.csv'
sed -i -e 's/Grado: //g' /var/lib/mysql-files/Oferta2021.csv
sed -i '/Máster/d; /Doctorado/d' /var/lib/mysql-files/Oferta2021.csv
wget -q -O /var/lib/mysql-files/Oferta2020.csv 'https://zaguan.unizar.es/record/96835/files/CSV.csv'
sed -i -e 's/Grado: //g' /var/lib/mysql-files/Oferta2020.csv
sed -i '/Máster/d; /Doctorado/d' /var/lib/mysql-files/Oferta2020.csv
wget -q -O /var/lib/mysql-files/Oferta2019.csv 'https://zaguan.unizar.es/record/87665/files/CSV.csv'
sed -i -e 's/Grado: //g' /var/lib/mysql-files/Oferta2019.csv
sed -i '/Máster/d; /Doctorado/d' /var/lib/mysql-files/Oferta2019.csv

echo "Datos obtenidos exitosamente"

echo "Obteniendo datos de resultados y titulaciones"
#Obtención de datos de Resultados de los últimos 3 años
wget -q -O /var/lib/mysql-files/Resultados2021.csv 'https://zaguan.unizar.es/record/107369/files/CSV.csv'
sed -i '/Grado/!d' /var/lib/mysql-files/Resultados2021.csv
sed -i 's/1-//g' /var/lib/mysql-files/Resultados2021.csv
wget -q -O /var/lib/mysql-files/Resultados2020.csv 'https://zaguan.unizar.es/record/95644/files/CSV.csv'
sed -i '/Grado/!d' /var/lib/mysql-files/Resultados2020.csv
sed -i 's/1-//g' /var/lib/mysql-files/Resultados2020.csv
wget -q -O /var/lib/mysql-files/Resultados2019.csv 'https://zaguan.unizar.es/record/76879/files/CSV.csv'
sed -i '/Grado/!d' /var/lib/mysql-files/Resultados2019.csv
sed -i 's/1-//g' /var/lib/mysql-files/Resultados2019.csv

#Obtención de datos de Egresados de los últimos 3 años
echo "Obteniendo datos de Egresados"
wget -q -O /var/lib/mysql-files/Egresados2021.csv 'https://zaguan.unizar.es/record/107371/files/CSV.csv'
sed -i '/Grado/!d' /var/lib/mysql-files/Egresados2021.csv
sed -i -e 's/Grado: //g' /var/lib/mysql-files/Egresados2021.csv
wget -q -O /var/lib/mysql-files/Egresados2020.csv 'https://zaguan.unizar.es/record/98173/files/CSV.csv'
sed -i '/Grado/!d' /var/lib/mysql-files/Egresados2020.csv
sed -i -e 's/Grado: //g' /var/lib/mysql-files/Egresados2020.csv
wget -q -O /var/lib/mysql-files/Egresados2019.csv 'https://zaguan.unizar.es/record/76879/files/CSV.csv'
sed -i '/Grado/!d' /var/lib/mysql-files/Egresados2019.csv
sed -i -e 's/Grado: //g' /var/lib/mysql-files/Egresados2019.csv
END_COMMENT

# Create random password
PASSWDDB="lol"
 
# Replace "-" with "_" for database username
MAINDB='resultadosofertaacademica'
 

 # If /root/.my.cnf exists then it wont ask for root password
#if [ -f /root/.my.cnf ]; then
 	mysql -e "DROP DATABASE IF EXISTS ${MAINDB} ;"
    mysql -e "CREATE DATABASE ${MAINDB} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
    mysql -e "CREATE USER profesor@localhost IDENTIFIED BY 'lol';"
    mysql -e "GRANT ALL PRIVILEGES ON ${MAINDB}.* TO 'profesor'@'localhost';"
    mysql -e "FLUSH PRIVILEGES;"
 : ' 
# If /root/.my.cnf doesn't exist then it'll ask for root password   
#else
    echo "Please enter root as MySQL user and Password!"
    echo "Note: password will be hidden when typing"
    read -sp rootpasswd
    mysql -uroot -p${rootpasswd} -e "CREATE DATABASE ${MAINDB} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
    mysql -uroot -p${rootpasswd} -e "CREATE USER profesor@localhost IDENTIFIED BY '${PASSWDDB}';"
    mysql -uroot -p${rootpasswd} -e "GRANT ALL PRIVILEGES ON ${MAINDB}.* TO 'profesor'@'localhost';"
    mysql -uroot -p${rootpasswd} -e "FLUSH PRIVILEGES;"
#fi 
'

#Creación de 3 tablas para los años 2019, 2020 y 2021 y se añaden los datos de sus correspondientes CSV
mysql -D resultadosofertaacademica -e "CREATE TABLE NotasCorte2021(CURSO_ACADEMICO INT, ESTUDIO VARCHAR(100), LOCALIDAD VARCHAR(30), CENTRO VARCHAR(100), PRELA_CONVO_NOTA_DEF CHAR(2), NOTA_CORTE_DEFINITIVA_JULIO  FLOAT, NOTA_CORTE_DEFINITIVA_SEPTIEMBRE FLOAT, FECHA_ACTUALIZACION VARCHAR(15));"
mysql -D resultadosofertaacademica -e "LOAD DATA INFILE '/var/lib/mysql-files/notasCorte2021.csv' INTO TABLE NotasCorte2021 FIELDS TERMINATED BY ';' ENCLOSED BY'' LINES TERMINATED BY '\n' IGNORE 1 ROWS (CURSO_ACADEMICO, ESTUDIO, LOCALIDAD, CENTRO, PRELA_CONVO_NOTA_DEF, NOTA_CORTE_DEFINITIVA_JULIO, @NOTA_CORTE_DEFINITIVA_SEPTIEMBRE, FECHA_ACTUALIZACION) SET NOTA_CORTE_DEFINITIVA_SEPTIEMBRE = NULLIF(@NOTA_CORTE_DEFINITIVA_SEPTIEMBRE, '');"


mysql -D resultadosofertaacademica -e "CREATE TABLE NotasCorte2020(CURSO_ACADEMICO INT, ESTUDIO VARCHAR(100), LOCALIDAD VARCHAR(30), CENTRO VARCHAR(100), PRELA_CONVO_NOTA_DEF CHAR(2), NOTA_CORTE_DEFINITIVA_JULIO  FLOAT, NOTA_CORTE_DEFINITIVA_SEPTIEMBRE VARCHAR(30), FECHA_ACTUALIZACION VARCHAR(15));"
mysql -D resultadosofertaacademica -e "LOAD DATA INFILE '/var/lib/mysql-files/notasCorte2020.csv' INTO TABLE NotasCorte2020 FIELDS TERMINATED BY ';' ENCLOSED BY'' LINES TERMINATED BY '\n' IGNORE 1 ROWS(CURSO_ACADEMICO, ESTUDIO, LOCALIDAD, CENTRO, PRELA_CONVO_NOTA_DEF, NOTA_CORTE_DEFINITIVA_JULIO, @NOTA_CORTE_DEFINITIVA_SEPTIEMBRE, FECHA_ACTUALIZACION) SET NOTA_CORTE_DEFINITIVA_SEPTIEMBRE = NULLIF(@NOTA_CORTE_DEFINITIVA_SEPTIEMBRE, '');"

mysql -D resultadosofertaacademica -e "CREATE TABLE NotasCorte2019(CURSO_ACADEMICO INT, ESTUDIO VARCHAR(100), LOCALIDAD VARCHAR(30), CENTRO VARCHAR(100), PRELA_CONVO_NOTA_DEF CHAR(2), NOTA_CORTE_DEFINITIVA_JULIO  FLOAT, NOTA_CORTE_DEFINITIVA_SEPTIEMBRE VARCHAR(30), FECHA_ACTUALIZACION VARCHAR(15));"
mysql -D resultadosofertaacademica -e "LOAD DATA INFILE '/var/lib/mysql-files/notasCorte2019.csv' INTO TABLE NotasCorte2019 FIELDS TERMINATED BY ';' ENCLOSED BY'' LINES TERMINATED BY '\n' IGNORE 1 ROWS(CURSO_ACADEMICO, ESTUDIO, LOCALIDAD, CENTRO, PRELA_CONVO_NOTA_DEF, NOTA_CORTE_DEFINITIVA_JULIO, @NOTA_CORTE_DEFINITIVA_SEPTIEMBRE, FECHA_ACTUALIZACION) SET NOTA_CORTE_DEFINITIVA_SEPTIEMBRE = NULLIF(@NOTA_CORTE_DEFINITIVA_SEPTIEMBRE, '');"

echo " Datos cargados exitosamente"


#Carga de datos de movilidad a la base de datos resultadosofertaacademica
mysql -D resultadosofertaacademica -e "CREATE TABLE movilidad2019(CURSO_ACADEMICO INT, NOMBRE_PROGRAMA_MOVILIDAD VARCHAR(8), NOMBRE_AREA_ESTUDIOS_MOV VARCHAR(100), CENTRO VARCHAR(100), IN_OUT VARCHAR(4), NOMBRE_IDIOMA_NIVEL_MOVILIDAD VARCHAR(40), PAIS_UNIVERSIDAD_ACUERDO VARCHAR(30), UNIVERSIDAD_ACUERDO VARCHAR(100), PLAZAS_OFERTADAS_ALUMNOS INT, PLAZAS_ASIGNADAS_ALUMNO_OUT TINYINT, FECHA_ACTUALIZACION VARCHAR(30));"
mysql -D resultadosofertaacademica -e "LOAD DATA INFILE '/var/lib/mysql-files/movilidad2019.csv' INTO TABLE movilidad2019 FIELDS TERMINATED BY ';' ENCLOSED BY'' LINES TERMINATED BY '\n' IGNORE 1 ROWS;"

mysql -D resultadosofertaacademica -e "CREATE TABLE movilidad2020(CURSO_ACADEMICO INT, NOMBRE_PROGRAMA_MOVILIDAD VARCHAR(8), NOMBRE_AREA_ESTUDIOS_MOV VARCHAR(100), CENTRO VARCHAR(100), IN_OUT VARCHAR(4), NOMBRE_IDIOMA_NIVEL_MOVILIDAD VARCHAR(40), PAIS_UNIVERSIDAD_ACUERDO VARCHAR(30), UNIVERSIDAD_ACUERDO VARCHAR(100), PLAZAS_OFERTADAS_ALUMNOS INT, PLAZAS_ASIGNADAS_ALUMNO_OUT TINYINT, FECHA_ACTUALIZACION VARCHAR(30));"
mysql -D resultadosofertaacademica -e "LOAD DATA INFILE '/var/lib/mysql-files/movilidad2020.csv' INTO TABLE movilidad2020 FIELDS TERMINATED BY ';' ENCLOSED BY'' LINES TERMINATED BY '\n' IGNORE 1 ROWS;"

mysql -D resultadosofertaacademica -e "CREATE TABLE movilidad2021(CURSO_ACADEMICO INT, NOMBRE_PROGRAMA_MOVILIDAD VARCHAR(8), NOMBRE_AREA_ESTUDIOS_MOV VARCHAR(100), CENTRO VARCHAR(100), IN_OUT VARCHAR(4), NOMBRE_IDIOMA_NIVEL_MOVILIDAD VARCHAR(40), PAIS_UNIVERSIDAD_ACUERDO VARCHAR(30), UNIVERSIDAD_ACUERDO VARCHAR(100), PLAZAS_OFERTADAS_ALUMNOS INT, PLAZAS_ASIGNADAS_ALUMNO_OUT TINYINT, FECHA_ACTUALIZACION VARCHAR(30));"
mysql -D resultadosofertaacademica -e "LOAD DATA INFILE '/var/lib/mysql-files/movilidad2021.csv' INTO TABLE movilidad2021 FIELDS TERMINATED BY ';' ENCLOSED BY'' LINES TERMINATED BY '\n' IGNORE 1 ROWS;"

echo "Datos de movilidad cargados exitosamente en la base de datos"




echo " se van a cargar los datos de Oferta y ocupación a la base de datos"
#Carga de datos de oferta y ocypación el a base de datos resultadosofertaacademica
mysql -D resultadosofertaacademica -e "CREATE TABLE Oferta_Ocupacion2019(CURSO_ACADEMICO INT, ESTUDIO VARCHAR(150), LOCALIDAD VARCHAR(30), CENTRO VARCHAR(100),TIPO_CENTRO VARCHAR(25), TIPO_ESTUDIO VARCHAR(15), PLAZAS INT, PLAZAS_MATRICULADAS INT, PLAZAS_SOLICITADAS INT, INDICE_OCUPACION FLOAT, FECHA_ACTUALIZACION VARCHAR(30));"
mysql -D resultadosofertaacademica -e "LOAD DATA INFILE '/var/lib/mysql-files/Oferta2019.csv' INTO TABLE Oferta_Ocupacion2019 FIELDS TERMINATED BY ';' ENCLOSED BY'' LINES TERMINATED BY '\n' IGNORE 1 ROWS;"

mysql -D resultadosofertaacademica -e "CREATE TABLE Oferta_Ocupacion2020(CURSO_ACADEMICO INT, ESTUDIO VARCHAR(150), LOCALIDAD VARCHAR(30), CENTRO VARCHAR(100),TIPO_CENTRO VARCHAR(25), TIPO_ESTUDIO VARCHAR(15), PLAZAS INT, PLAZAS_MATRICULADAS INT, PLAZAS_SOLICITADAS INT, INDICE_OCUPACION FLOAT, FECHA_ACTUALIZACION VARCHAR(30));"
mysql -D resultadosofertaacademica -e "LOAD DATA INFILE '/var/lib/mysql-files/Oferta2020.csv' INTO TABLE Oferta_Ocupacion2020 FIELDS TERMINATED BY ';' ENCLOSED BY'' LINES TERMINATED BY '\n' IGNORE 1 ROWS;"

mysql -D resultadosofertaacademica -e "CREATE TABLE Oferta_Ocupacion2021(CURSO_ACADEMICO INT, ESTUDIO VARCHAR(150), LOCALIDAD VARCHAR(30), CENTRO VARCHAR(100),TIPO_CENTRO VARCHAR(25), TIPO_ESTUDIO VARCHAR(15), PLAZAS INT, PLAZAS_MATRICULADAS INT, PLAZAS_SOLICITADAS INT, INDICE_OCUPACION FLOAT, FECHA_ACTUALIZACION VARCHAR(30));"
mysql -D resultadosofertaacademica -e "LOAD DATA INFILE '/var/lib/mysql-files/Oferta2021.csv' INTO TABLE Oferta_Ocupacion2021 FIELDS TERMINATED BY ';' ENCLOSED BY'' LINES TERMINATED BY '\n' IGNORE 1 ROWS;"

echo "datos de oferta y ocupación cargados en la base de datos"


#Carga de datos resltados a la base de datos resultadosofertaacademica
echo "Cargando resultados de la oferta academica a la base de datos..."
mysql -D resultadosofertaacademica -e "CREATE TABLE Resultados2021(CURSO_ACADEMICO INT,CENTRO VARCHAR(100), ESTUDIO VARCHAR(150),TIPO_ESTUDIO VARCHAR(50), ALUMNOS_MATRICULADOS INT, ALUMNOS_NUEVO_INGRESO INT, PLAZAS_OFERTADAS INT, ALUMNOS_GRADUADOS INT,ALUMNOS_ADAPTA_GRADO_MATRI INT, ALUMNOS_ADAPTA_GRADO_MATRI_NI INT, ALUMNOS_ADAPTA_GRADO_TITULADO INT, ALUMNOS_CON_RECONOCIMIENTO INT, ALUMNOS_MOVILIDAD_ENTRADA INT, ALUMNOS_MOVILIDAD_SALIDA INT, CREDITOS_MATRICULADOS FLOAT, CREDITOS_RECONOCIDOS FLOAT, DURACION_MEDIA_GRADUADOS FLOAT, TASA_EXITO FLOAT, TASA_RENDIMIENTO FLOAT, TASA_EFICIENCIA FLOAT, TASA_ABANDONO FLOAT, TASA_GRADUACION FLOAT, FECHA_ACTUALIZACION VARCHAR(30));"
mysql -D resultadosofertaacademica -e "LOAD DATA INFILE '/var/lib/mysql-files/Resultados2021.csv' INTO TABLE Resultados2021 FIELDS TERMINATED BY ';' ENCLOSED BY'' LINES TERMINATED BY '\n' IGNORE 1 ROWS (CURSO_ACADEMICO,CENTRO, ESTUDIO,TIPO_ESTUDIO, @ALUMNOS_MATRICULADOS, @ALUMNOS_NUEVO_INGRESO, @PLAZAS_OFERTADAS, @ALUMNOS_GRADUADOS,@ALUMNOS_ADAPTA_GRADO_MATRI, @ALUMNOS_ADAPTA_GRADO_MATRI_NI, @ALUMNOS_ADAPTA_GRADO_TITULADO, @ALUMNOS_CON_RECONOCIMIENTO, @ALUMNOS_MOVILIDAD_ENTRADA, @ALUMNOS_MOVILIDAD_SALIDA, @CREDITOS_MATRICULADOS, @CREDITOS_RECONOCIDOS, @DURACION_MEDIA_GRADUADOS, @TASA_EXITO, @TASA_RENDIMIENTO, @TASA_EFICIENCIA, @TASA_ABANDONO, @TASA_GRADUACION, FECHA_ACTUALIZACION) 
										SET ALUMNOS_NUEVO_INGRESO = NULLIF(@ALUMNOS_NUEVO_INGRESO,''), ALUMNOS_MATRICULADOS= NULLIF(@ALUMNOS_MATRICULADOS,''), ALUMNOS_NUEVO_INGRESO= NULLIF(@ALUMNOS_NUEVO_INGRESO,''), PLAZAS_OFERTADAS= NULLIF(@PLAZAS_OFERTADAS,''), ALUMNOS_GRADUADOS= NULLIF(@ALUMNOS_GRADUADOS,''),ALUMNOS_ADAPTA_GRADO_MATRI= NULLIF(@ALUMNOS_ADAPTA_GRADO_MATRI,''), ALUMNOS_ADAPTA_GRADO_MATRI_NI= NULLIF(@ALUMNOS_ADAPTA_GRADO_MATRI_NI,''), ALUMNOS_ADAPTA_GRADO_TITULADO= NULLIF(@ALUMNOS_ADAPTA_GRADO_TITULADO,''), ALUMNOS_CON_RECONOCIMIENTO= NULLIF(@ALUMNOS_CON_RECONOCIMIENTO,''), ALUMNOS_MOVILIDAD_ENTRADA= NULLIF(@ALUMNOS_MOVILIDAD_ENTRADA,''), ALUMNOS_MOVILIDAD_ENTRADA= NULLIF(@ALUMNOS_MOVILIDAD_SALIDA,''),
										 CREDITOS_MATRICULADOS= NULLIF(@CREDITOS_MATRICULADOS,''), CREDITOS_RECONOCIDOS= NULLIF(@CREDITOS_RECONOCIDOS,''), DURACION_MEDIA_GRADUADOS= NULLIF(@DURACION_MEDIA_GRADUADOS,''), TASA_EXITO= NULLIF(@TASA_EXITO,''), TASA_RENDIMIENTO= NULLIF(@TASA_RENDIMIENTO,''), TASA_EFICIENCIA= NULLIF(@TASA_EFICIENCIA,''), TASA_ABANDONO= NULLIF(@TASA_ABANDONO,''), TASA_GRADUACION= NULLIF(@TASA_GRADUACION,'');"

mysql -D resultadosofertaacademica -e "CREATE TABLE Resultados2020(CURSO_ACADEMICO INT,CENTRO VARCHAR(100), ESTUDIO VARCHAR(150),TIPO_ESTUDIO VARCHAR(50), ALUMNOS_MATRICULADOS INT, ALUMNOS_NUEVO_INGRESO INT, PLAZAS_OFERTADAS INT, ALUMNOS_GRADUADOS INT,ALUMNOS_ADAPTA_GRADO_MATRI INT, ALUMNOS_ADAPTA_GRADO_MATRI_NI INT, ALUMNOS_ADAPTA_GRADO_TITULADO INT, ALUMNOS_CON_RECONOCIMIENTO INT, ALUMNOS_MOVILIDAD_ENTRADA INT, ALUMNOS_MOVILIDAD_SALIDA INT, CREDITOS_MATRICULADOS FLOAT, CREDITOS_RECONOCIDOS FLOAT, DURACION_MEDIA_GRADUADOS FLOAT, TASA_EXITO FLOAT, TASA_RENDIMIENTO FLOAT, TASA_EFICIENCIA FLOAT, TASA_ABANDONO FLOAT, TASA_GRADUACION FLOAT, FECHA_ACTUALIZACION VARCHAR(30));"
mysql -D resultadosofertaacademica -e "LOAD DATA INFILE '/var/lib/mysql-files/Resultados2020.csv' INTO TABLE Resultados2020 FIELDS TERMINATED BY ';' ENCLOSED BY'' LINES TERMINATED BY '\n' IGNORE 1 ROWS(CURSO_ACADEMICO,CENTRO, ESTUDIO,TIPO_ESTUDIO, @ALUMNOS_MATRICULADOS, @ALUMNOS_NUEVO_INGRESO, @PLAZAS_OFERTADAS, @ALUMNOS_GRADUADOS,@ALUMNOS_ADAPTA_GRADO_MATRI, @ALUMNOS_ADAPTA_GRADO_MATRI_NI, @ALUMNOS_ADAPTA_GRADO_TITULADO, @ALUMNOS_CON_RECONOCIMIENTO, @ALUMNOS_MOVILIDAD_ENTRADA, @ALUMNOS_MOVILIDAD_SALIDA, @CREDITOS_MATRICULADOS, @CREDITOS_RECONOCIDOS, @DURACION_MEDIA_GRADUADOS, @TASA_EXITO, @TASA_RENDIMIENTO, @TASA_EFICIENCIA, @TASA_ABANDONO, @TASA_GRADUACION, FECHA_ACTUALIZACION) 
										SET ALUMNOS_NUEVO_INGRESO = NULLIF(@ALUMNOS_NUEVO_INGRESO,''), ALUMNOS_MATRICULADOS= NULLIF(@ALUMNOS_MATRICULADOS,''), ALUMNOS_NUEVO_INGRESO= NULLIF(@ALUMNOS_NUEVO_INGRESO,''), PLAZAS_OFERTADAS= NULLIF(@PLAZAS_OFERTADAS,''), ALUMNOS_GRADUADOS= NULLIF(@ALUMNOS_GRADUADOS,''),ALUMNOS_ADAPTA_GRADO_MATRI= NULLIF(@ALUMNOS_ADAPTA_GRADO_MATRI,''), ALUMNOS_ADAPTA_GRADO_MATRI_NI= NULLIF(@ALUMNOS_ADAPTA_GRADO_MATRI_NI,''), ALUMNOS_ADAPTA_GRADO_TITULADO= NULLIF(@ALUMNOS_ADAPTA_GRADO_TITULADO,''), ALUMNOS_CON_RECONOCIMIENTO= NULLIF(@ALUMNOS_CON_RECONOCIMIENTO,''), ALUMNOS_MOVILIDAD_ENTRADA= NULLIF(@ALUMNOS_MOVILIDAD_ENTRADA,''), ALUMNOS_MOVILIDAD_ENTRADA= NULLIF(@ALUMNOS_MOVILIDAD_SALIDA,''),
										 CREDITOS_MATRICULADOS= NULLIF(@CREDITOS_MATRICULADOS,''), CREDITOS_RECONOCIDOS= NULLIF(@CREDITOS_RECONOCIDOS,''), DURACION_MEDIA_GRADUADOS= NULLIF(@DURACION_MEDIA_GRADUADOS,''), TASA_EXITO= NULLIF(@TASA_EXITO,''), TASA_RENDIMIENTO= NULLIF(@TASA_RENDIMIENTO,''), TASA_EFICIENCIA= NULLIF(@TASA_EFICIENCIA,''), TASA_ABANDONO= NULLIF(@TASA_ABANDONO,''), TASA_GRADUACION= NULLIF(@TASA_GRADUACION,'');"

mysql -D resultadosofertaacademica -e "CREATE TABLE Resultados2019(CURSO_ACADEMICO INT,CENTRO VARCHAR(100), ESTUDIO VARCHAR(150),TIPO_ESTUDIO VARCHAR(50), ALUMNOS_MATRICULADOS INT, ALUMNOS_NUEVO_INGRESO INT, PLAZAS_OFERTADAS INT, ALUMNOS_GRADUADOS INT,ALUMNOS_ADAPTA_GRADO_MATRI INT, ALUMNOS_ADAPTA_GRADO_MATRI_NI INT, ALUMNOS_ADAPTA_GRADO_TITULADO INT, ALUMNOS_CON_RECONOCIMIENTO INT, ALUMNOS_MOVILIDAD_ENTRADA INT, ALUMNOS_MOVILIDAD_SALIDA INT, CREDITOS_MATRICULADOS FLOAT, CREDITOS_RECONOCIDOS FLOAT, DURACION_MEDIA_GRADUADOS FLOAT, TASA_EXITO FLOAT, TASA_RENDIMIENTO FLOAT, TASA_EFICIENCIA FLOAT, TASA_ABANDONO FLOAT, TASA_GRADUACION FLOAT, FECHA_ACTUALIZACION VARCHAR(30));"
mysql -D resultadosofertaacademica -e "LOAD DATA INFILE '/var/lib/mysql-files/Resultados2019.csv' INTO TABLE Resultados2019 FIELDS TERMINATED BY ';' ENCLOSED BY'' LINES TERMINATED BY '\n' IGNORE 1 ROWS(CURSO_ACADEMICO,CENTRO, ESTUDIO,TIPO_ESTUDIO, @ALUMNOS_MATRICULADOS, @ALUMNOS_NUEVO_INGRESO, @PLAZAS_OFERTADAS, @ALUMNOS_GRADUADOS,@ALUMNOS_ADAPTA_GRADO_MATRI, @ALUMNOS_ADAPTA_GRADO_MATRI_NI, @ALUMNOS_ADAPTA_GRADO_TITULADO, @ALUMNOS_CON_RECONOCIMIENTO, @ALUMNOS_MOVILIDAD_ENTRADA, @ALUMNOS_MOVILIDAD_SALIDA, @CREDITOS_MATRICULADOS, @CREDITOS_RECONOCIDOS, @DURACION_MEDIA_GRADUADOS, @TASA_EXITO, @TASA_RENDIMIENTO, @TASA_EFICIENCIA, @TASA_ABANDONO, @TASA_GRADUACION, FECHA_ACTUALIZACION) 
										SET ALUMNOS_NUEVO_INGRESO = NULLIF(@ALUMNOS_NUEVO_INGRESO,''), ALUMNOS_MATRICULADOS= NULLIF(@ALUMNOS_MATRICULADOS,''), ALUMNOS_NUEVO_INGRESO= NULLIF(@ALUMNOS_NUEVO_INGRESO,''), PLAZAS_OFERTADAS= NULLIF(@PLAZAS_OFERTADAS,''), ALUMNOS_GRADUADOS= NULLIF(@ALUMNOS_GRADUADOS,''),ALUMNOS_ADAPTA_GRADO_MATRI= NULLIF(@ALUMNOS_ADAPTA_GRADO_MATRI,''), ALUMNOS_ADAPTA_GRADO_MATRI_NI= NULLIF(@ALUMNOS_ADAPTA_GRADO_MATRI_NI,''), ALUMNOS_ADAPTA_GRADO_TITULADO= NULLIF(@ALUMNOS_ADAPTA_GRADO_TITULADO,''), ALUMNOS_CON_RECONOCIMIENTO= NULLIF(@ALUMNOS_CON_RECONOCIMIENTO,''), ALUMNOS_MOVILIDAD_ENTRADA= NULLIF(@ALUMNOS_MOVILIDAD_ENTRADA,''), ALUMNOS_MOVILIDAD_ENTRADA= NULLIF(@ALUMNOS_MOVILIDAD_SALIDA,''),
										 CREDITOS_MATRICULADOS= NULLIF(@CREDITOS_MATRICULADOS,''), CREDITOS_RECONOCIDOS= NULLIF(@CREDITOS_RECONOCIDOS,''), DURACION_MEDIA_GRADUADOS= NULLIF(@DURACION_MEDIA_GRADUADOS,''), TASA_EXITO= NULLIF(@TASA_EXITO,''), TASA_RENDIMIENTO= NULLIF(@TASA_RENDIMIENTO,''), TASA_EFICIENCIA= NULLIF(@TASA_EFICIENCIA,''), TASA_ABANDONO= NULLIF(@TASA_ABANDONO,''), TASA_GRADUACION= NULLIF(@TASA_GRADUACION,'');"

echo "datos de resultados de la oferta academica cargados en la base de datos"


#Carga de datos resltados a la base de datos resultadosofertaacademica
echo "Cargando datos a la base de datos..."
mysql -D resultadosofertaacademica -e "CREATE TABLE Egresados2021(CURSO_ACADEMICO INT,LOCALIDAD VARCHAR(100), ESTUDIO VARCHAR(150),TIPO_ESTUDIO VARCHAR(50), TIPO_EGRESO VARCHAR(70), SEXO VARCHAR(10), ALUMNOS_GRADUADOS INT, ALUMNOS_INTERRUMPEN_ESTUDIOS INT, ALUMNOS_INTERRUMPEN_EST_ANO1 INT, ALUMNOS_TRASLADAN_OTRA_UNIV INT , DURACION_mEDIA_GRADUADOS FLOAT, TASA_EFIENCIA FLOAT, FECHA_ACTUALIZACION VARCHAR(30));"
mysql -D resultadosofertaacademica -e "LOAD DATA INFILE '/var/lib/mysql-files/Egresados2021.csv' INTO TABLE Egresados2021 FIELDS TERMINATED BY ';' ENCLOSED BY'' LINES TERMINATED BY '\n' IGNORE 1 ROWS(CURSO_ACADEMICO,LOCALIDAD, ESTUDIO,TIPO_ESTUDIO, TIPO_EGRESO, SEXO, @ALUMNOS_GRADUADOS, @ALUMNOS_INTERRUMPEN_ESTUDIOS, @ALUMNOS_INTERRUMPEN_EST_ANO1, @ALUMNOS_TRASLADAN_OTRA_UNIV, @DURACION_mEDIA_GRADUADOS, @TASA_EFIENCIA, FECHA_ACTUALIZACION)SET 
										ALUMNOS_GRADUADOS= NULLIF(@ALUMNOS_GRADUADOS,''),ALUMNOS_INTERRUMPEN_ESTUDIOS= NULLIF(@ALUMNOS_INTERRUMPEN_ESTUDIOS,''),ALUMNOS_INTERRUMPEN_EST_ANO1= NULLIF(@ALUMNOS_INTERRUMPEN_EST_ANO1,''),ALUMNOS_TRASLADAN_OTRA_UNIV= NULLIF(@ALUMNOS_TRASLADAN_OTRA_UNIV,''),DURACION_mEDIA_GRADUADOS= NULLIF(@DURACION_mEDIA_GRADUADOS,''),TASA_EFIENCIA= NULLIF(@TASA_EFIENCIA,'');"

mysql -D resultadosofertaacademica -e "CREATE TABLE Egresados2020(CURSO_ACADEMICO INT,LOCALIDAD VARCHAR(100), ESTUDIO VARCHAR(150),TIPO_ESTUDIO VARCHAR(50), TIPO_EGRESO VARCHAR(70), SEXO VARCHAR(10), ALUMNOS_GRADUADOS INT, ALUMNOS_INTERRUMPEN_ESTUDIOS INT, ALUMNOS_INTERRUMPEN_EST_ANO1 INT, ALUMNOS_TRASLADAN_OTRA_UNIV INT , DURACION_mEDIA_GRADUADOS FLOAT, TASA_EFIENCIA FLOAT, FECHA_ACTUALIZACION VARCHAR(30));"
mysql -D resultadosofertaacademica -e "LOAD DATA INFILE '/var/lib/mysql-files/Egresados2020.csv' INTO TABLE Egresados2020 FIELDS TERMINATED BY ';' ENCLOSED BY'' LINES TERMINATED BY '\n' IGNORE 1 ROWS(CURSO_ACADEMICO,LOCALIDAD, ESTUDIO,TIPO_ESTUDIO, TIPO_EGRESO, SEXO, @ALUMNOS_GRADUADOS, @ALUMNOS_INTERRUMPEN_ESTUDIOS, @ALUMNOS_INTERRUMPEN_EST_ANO1, @ALUMNOS_TRASLADAN_OTRA_UNIV, @DURACION_mEDIA_GRADUADOS, @TASA_EFIENCIA, FECHA_ACTUALIZACION)SET 
										ALUMNOS_GRADUADOS= NULLIF(@ALUMNOS_GRADUADOS,''),ALUMNOS_INTERRUMPEN_ESTUDIOS= NULLIF(@ALUMNOS_INTERRUMPEN_ESTUDIOS,''),ALUMNOS_INTERRUMPEN_EST_ANO1= NULLIF(@ALUMNOS_INTERRUMPEN_EST_ANO1,''),ALUMNOS_TRASLADAN_OTRA_UNIV= NULLIF(@ALUMNOS_TRASLADAN_OTRA_UNIV,''),DURACION_mEDIA_GRADUADOS= NULLIF(@DURACION_mEDIA_GRADUADOS,''),TASA_EFIENCIA= NULLIF(@TASA_EFIENCIA,'');"

mysql -D resultadosofertaacademica -e "CREATE TABLE Egresados2019(CURSO_ACADEMICO INT,LOCALIDAD VARCHAR(100), ESTUDIO VARCHAR(150),TIPO_ESTUDIO VARCHAR(50), TIPO_EGRESO VARCHAR(70), SEXO VARCHAR(10), ALUMNOS_GRADUADOS INT, ALUMNOS_INTERRUMPEN_ESTUDIOS INT, ALUMNOS_INTERRUMPEN_EST_ANO1 INT, ALUMNOS_TRASLADAN_OTRA_UNIV INT , DURACION_mEDIA_GRADUADOS FLOAT, TASA_EFIENCIA FLOAT, FECHA_ACTUALIZACION VARCHAR(30));"
mysql -D resultadosofertaacademica -e "LOAD DATA INFILE '/var/lib/mysql-files/Egresados2019.csv' INTO TABLE Egresados2019 FIELDS TERMINATED BY ';' ENCLOSED BY'' LINES TERMINATED BY '\n' IGNORE 1 ROWS(CURSO_ACADEMICO, LOCALIDAD, ESTUDIO, TIPO_ESTUDIO, TIPO_EGRESO, SEXO, @ALUMNOS_GRADUADOS, @ALUMNOS_INTERRUMPEN_ESTUDIOS, @ALUMNOS_INTERRUMPEN_EST_ANO1, @ALUMNOS_TRASLADAN_OTRA_UNIV, @DURACION_mEDIA_GRADUADOS, @TASA_EFIENCIA, FECHA_ACTUALIZACION) 
										SET ALUMNOS_GRADUADOS= NULLIF(@ALUMNOS_GRADUADOS,''), ALUMNOS_INTERRUMPEN_ESTUDIOS= NULLIF(@ALUMNOS_INTERRUMPEN_ESTUDIOS,''), ALUMNOS_INTERRUMPEN_EST_ANO1= NULLIF(@ALUMNOS_INTERRUMPEN_EST_ANO1,''), ALUMNOS_TRASLADAN_OTRA_UNIV= NULLIF(@ALUMNOS_TRASLADAN_OTRA_UNIV,''), DURACION_mEDIA_GRADUADOS= NULLIF(@DURACION_mEDIA_GRADUADOS,''), TASA_EFIENCIA= NULLIF(@TASA_EFIENCIA,'');"
: << 'luego'
mysql -uprofesor -p${PASSWDDB} -e "

CREATE TABLE ${MAINDB}.Estudio (
	id_estudio tinyint NOT NULL ,
	nombre_estudio varchar(100) NULL,
	tipo_estudio varchar(15) NULL,
    PRIMARY KEY(id_estudio)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
    
CREATE TABLE ${MAINDB}.Centro (
	id_centro TINYINT NOT NULL ,
	nombre_centro varchar(100) NULL,
	tipo_centro varchar(15) NULL,
    PRIMARY KEY(id_centro)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;  

CREATE TABLE ${MAINDB}.Impartido (
    IDestudio TINYINT,	
    IDcentro TINYINT,
    curso TINYINT,
	plazas_ofertadas TINYINT NULL,
    plazas_matriculadas TINYINT NULL,
    plazas_solicitadas int NULL,
	alumnos_nuevo_ingreso TINYINT NULL,
    nota_corte_julio float NULL,
    nota_corte_septiembre float NULL,
    alumnos_graduados TINYINT NULL,
    alumnos_adapta_grado_matri TINYINT NULL,
    alumnos_adapta_grado_matri_ni TINYINT NULL,
    alumnos_adapta_grado_titulado TINYINT NULL,
    alumnos_con_reconocimiento TINYINT NULL,  
    alumnos_movilidad_entrada TINYINT NULL,
    alumnos_movilidad_salida TINYINT NULL,
    creditos_matriculados float NULL,
    creditos_reconocidos float NULL,
    duracion_media_graduados float NULL,
    egresados_voluntarios TINYINT NULL,
    indice_ocupacion float NULL,
    tasa_exito float NULL,
    tasa_rendimiento float NULL,
    tasa_abandono float NULL,
    tasa_graduacion float NULL,
    PRIMARY KEY (IDestudio, IDcentro),
    FOREIGN KEY (IDcentro) REFERENCES ${MAINDB}.Centro(id_centro)
	ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (IDestudio) REFERENCES ${MAINDB}.Estudio(id_estudio)
	ON DELETE CASCADE ON UPDATE CASCADE
    
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE ${MAINDB}.Localidad (
	id_localidad TINYINT NOT NULL ,
	nombre_localidad varchar(100) NULL,
    PRIMARY KEY(id_localidad) 
)ENGINE=InnoDB DEFAULT CHARSET=utf8; 

CREATE TABLE ${MAINDB}.Pais (
	id_pais TINYINT NOT NULL ,
	nombre_pais varchar(100) NULL,
    PRIMARY KEY(id_pais) 
)ENGINE=InnoDB DEFAULT CHARSET=utf8;   
    
CREATE TABLE ${MAINDB}.Movilidad (
	nombre_movilidad varchar(100) NOT NULL,
    id_centro TINYINT NOT NULL,
    PRIMARY KEY(nombre_movilidad, id_centro),
    FOREIGN KEY (id_centro) REFERENCES ${MAINDB}.Centro(id_centro)
	ON DELETE CASCADE ON UPDATE CASCADE    
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE ${MAINDB}.Realiza (
	curso TINYINT,
	nombre_movilidad varchar(100),
    id_centro TINYINT,
    id_pais TINYINT NOT NULL,
    area_estudios varchar(100) NULL,
    in_out varchar(4) NULL,
    nombre_idioma varchar(50),
    universidad_destino varchar(100),
    plazas_ofertadas TINYINT,
    plazas_asignadas TINYINT,
    PRIMARY KEY (nombre_movilidad, id_centro),
    FOREIGN KEY (nombre_movilidad) REFERENCES ${MAINDB}.Movilidad(nombre_movilidad)
	ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (id_pais) REFERENCES ${MAINDB}.Pais(id_pais)
	ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_centro) REFERENCES ${MAINDB}.Centro(id_centro)
	ON DELETE CASCADE ON UPDATE CASCADE
  )ENGINE=InnoDB DEFAULT CHARSET=utf8;  
  
  
#CREATE TABLE ESTUDIO"
luego