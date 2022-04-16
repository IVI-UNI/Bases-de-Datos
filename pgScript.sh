#!/bin/sh

#Se obtienen los csv con las notas de corte
echo "Comienza el script de postgres"
echo "Descargando las notas de corte:"
wget -q -O $HOME/Practica1/notasCorte2021.csv 'https://zaguan.unizar.es/record/98173/files/CSV.csv'
sed -i -e 's/Grado: //g' $HOME/Practica1/notasCorte2021.csv
wget -q -O $HOME/Practica1/notasCorte2020.csv 'https://zaguan.unizar.es/record/87663/files/CSV.csv'
sed -i -e 's/Grado: //g' $HOME/Practica1/notasCorte2020.csv
wget -q -O $HOME/Practica1/notasCorte2019.csv 'https://zaguan.unizar.es/record/76876/files/CSV.csv'
sed -i -e 's/Grado: //g' $HOME/Practica1/notasCorte2019.csv

echo "Notas de corte descargadas"

echo " Cargando datos en la base de datos..."
#Creación de la base de datos temporal notasCorte

psql -U postgres -c "DROP DATABASE IF EXISTS temporal;"
psql -U postgres -c  "CREATE DATABASE  temporal OWNER postgres;"
#Creación de 3 tablas para los años 2019, 2020 y 2021 y se añaden los datos de sus correspondientes CSV
psql -U postgres  temporal -c "CREATE TABLE NotasCorte2019(CURSO_ACADEMICO SMALLINT, ESTUDIO VARCHAR(100), LOCALIDAD VARCHAR(30), CENTRO VARCHAR(100), PRELA_CONVO_NOTA_DEF CHAR(2), NOTA_CORTE_DEFINITIVA_JULIO  float(3), NOTA_CORTE_DEFINITIVA_SEPTIEMBRE float(3), FECHA_ACTUALIZACION DATE);"
psql -U postgres temporal -c "COPY NotasCorte2019 FROM '$HOME/Practica1/notasCorte2019.csv' DELIMITER ';'CSV HEADER;"

psql -U postgres temporal -c "CREATE TABLE NotasCorte2020(CURSO_ACADEMICO SMALLINT, ESTUDIO VARCHAR(100), LOCALIDAD VARCHAR(30), CENTRO VARCHAR(100), PRELA_CONVO_NOTA_DEF CHAR(2), NOTA_CORTE_DEFINITIVA_JULIO  float(3), NOTA_CORTE_DEFINITIVA_SEPTIEMBRE float(3), FECHA_ACTUALIZACION DATE);"
psql -U postgres temporal -c "COPY NotasCorte2020 FROM '$HOME/Practica1/notasCorte2020.csv' DELIMITER ';'CSV HEADER;"

psql -U postgres temporal -c "CREATE TABLE NotasCorte2021(CURSO_ACADEMICO SMALLINT, ESTUDIO VARCHAR(100), LOCALIDAD VARCHAR(30), CENTRO VARCHAR(100), PRELA_CONVO_NOTA_DEF CHAR(2), NOTA_CORTE_DEFINITIVA_JULIO  float(3), NOTA_CORTE_DEFINITIVA_SEPTIEMBRE float(3), FECHA_ACTUALIZACION DATE);"
psql -U postgres temporal -c "COPY NotasCorte2021 FROM '$HOME/Practica1/notasCorte2021.csv' DELIMITER ';'CSV HEADER;"

echo " Datos cargados exitosamente"

#Obtención de datos de  los datos de movilidad de los últimos 3 años
echo "Obteniendo ficheros de Movilidad SICUE y ERASMUS de los 3 ultimos años..."
wget -q -O $HOME/Practica1/movilidad2021.csv 'https://zaguan.unizar.es/record/107373/files/CSV.csv'
wget -q -O $HOME/Practica1/movilidad2020.csv 'https://zaguan.unizar.es/record/95648/files/CSV.csv'
wget -q -O $HOME/Practica1/movilidad2019.csv 'https://zaguan.unizar.es/record/83980/files/CSV.csv'

#Carga de datos de movilidad a la base de datos temporal
psql -U postgres temporal -c "CREATE TABLE movilidad2019(CURSO_ACADEMICO SMALLINT, NOMBRE_PROGRAMA_MOVILIDAD VARCHAR(8), NOMBRE_AREA_ESTUDIOS_MOV VARCHAR, CENTRO VARCHAR(100), IN_OUT VARCHAR(4), NOMBRE_IDIOMA_NIVEL_MOVILIDAD VARCHAR(40), PAIS_UNIVERSIDAD_ACUERDO VARCHAR(30), UNIVERSIDAD_ACUERDO VARCHAR, PLAZAS_OFERTADAS_ALUMNOS INT, PLAZAS_ASIGNADAS_ALUMNO_OUT SMALLINT, FECHA_ACTUALIZACION DATE);"
psql -U postgres temporal -c "COPY movilidad2019 FROM '$HOME/Practica1/movilidad2019.csv' DELIMITER ';' CSV HEADER;"

psql -U postgres temporal -c "CREATE TABLE movilidad2020(CURSO_ACADEMICO SMALLINT, NOMBRE_PROGRAMA_MOVILIDAD VARCHAR(8), NOMBRE_AREA_ESTUDIOS_MOV VARCHAR, CENTRO VARCHAR(100), IN_OUT VARCHAR(4), NOMBRE_IDIOMA_NIVEL_MOVILIDAD VARCHAR(40), PAIS_UNIVERSIDAD_ACUERDO VARCHAR(30), UNIVERSIDAD_ACUERDO VARCHAR, PLAZAS_OFERTADAS_ALUMNOS INT, PLAZAS_ASIGNADAS_ALUMNO_OUT SMALLINT, FECHA_ACTUALIZACION DATE);"
psql -U postgres temporal -c "COPY movilidad2020 FROM '$HOME/Practica1/movilidad2020.csv' DELIMITER ';' CSV HEADER;"

psql -U postgres temporal -c "CREATE TABLE movilidad2021(CURSO_ACADEMICO SMALLINT, NOMBRE_PROGRAMA_MOVILIDAD VARCHAR(8), NOMBRE_AREA_ESTUDIOS_MOV VARCHAR, CENTRO VARCHAR(100), IN_OUT VARCHAR(4), NOMBRE_IDIOMA_NIVEL_MOVILIDAD VARCHAR(40), PAIS_UNIVERSIDAD_ACUERDO VARCHAR(30), UNIVERSIDAD_ACUERDO VARCHAR, PLAZAS_OFERTADAS_ALUMNOS INT, PLAZAS_ASIGNADAS_ALUMNO_OUT SMALLINT, FECHA_ACTUALIZACION DATE);"
psql -U postgres temporal -c "COPY movilidad2021 FROM '$HOME/Practica1/movilidad2021.csv' DELIMITER ';' CSV HEADER;"

echo "Datos de movilidad cargados exitosamente en la base de datos"

echo "Oteniendo datos de oferta y ocupación..."
#Obtención de datos de Oferta y Ocupación de los últimos 3 años

wget -q -O $HOME/Practica1/Oferta2021.csv 'https://zaguan.unizar.es/record/108270/files/CSV.csv'
wget -q -O $HOME/Practica1/Oferta2020.csv 'https://zaguan.unizar.es/record/96835/files/CSV.csv'
wget -q -O $HOME/Practica1/Oferta2019.csv 'https://zaguan.unizar.es/record/87665/files/CSV.csv'

echo "Datos obtenidos exitosamente"

echo " se van a cargar los datos a la base de datos"
#Carga de datos de oferta y ocypación el a base de datos temporal
psql -U postgres  temporal -c "CREATE TABLE Oferta_Ocupacion2019(CURSO_ACADEMICO SMALLINT, ESTUDIO VARCHAR(150), LOCALIDAD VARCHAR(30), CENTRO VARCHAR(100),TIPO_CENTRO VARCHAR(25), TIPO_ESTUDIO VARCHAR(15), PLAZAS SMALLINT, PLAZAS_MATRICULADAS SMALLINT, PLAZAS_SOLICITADAS INT, INDICE_OCUPACION FLOAT, FECHA_ACTUALIZACION DATE);"
psql -U postgres temporal -c "COPY Oferta_Ocupacion2019 FROM '$HOME/Practica1/Oferta2019.csv' DELIMITER ';'CSV HEADER;"

psql -U postgres  temporal -c "CREATE TABLE Oferta_Ocupacion2020(CURSO_ACADEMICO SMALLINT, ESTUDIO VARCHAR(150), LOCALIDAD VARCHAR(30), CENTRO VARCHAR(100),TIPO_CENTRO VARCHAR(25), TIPO_ESTUDIO VARCHAR(15), PLAZAS SMALLINT, PLAZAS_MATRICULADAS SMALLINT, PLAZAS_SOLICITADAS INT, INDICE_OCUPACION FLOAT, FECHA_ACTUALIZACION DATE);"
psql -U postgres temporal -c "COPY Oferta_Ocupacion2020 FROM '$HOME/Practica1/Oferta2020.csv' DELIMITER ';'CSV HEADER;"

psql -U postgres  temporal -c "CREATE TABLE Oferta_Ocupacion2021(CURSO_ACADEMICO SMALLINT, ESTUDIO VARCHAR(150), LOCALIDAD VARCHAR(30), CENTRO VARCHAR(100),TIPO_CENTRO VARCHAR(25), TIPO_ESTUDIO VARCHAR(15), PLAZAS SMALLINT, PLAZAS_MATRICULADAS SMALLINT, PLAZAS_SOLICITADAS INT, INDICE_OCUPACION FLOAT, FECHA_ACTUALIZACION DATE);"
psql -U postgres temporal -c "COPY Oferta_Ocupacion2021 FROM '$HOME/Practica1/Oferta2021.csv' DELIMITER ';'CSV HEADER;"

echo "datos de oferta y ocupación cargados en la base de datos"

echo "Obteniendo datos de resultados y titulaciones"
#Obtención de datos de egresados de los últimos 3 años
wget -q -O $HOME/Practica1/Resultados2021.csv 'https://zaguan.unizar.es/record/107369/files/CSV.csv'
wget -q -O $HOME/Practica1/Resultados2020.csv 'https://zaguan.unizar.es/record/95644/files/CSV.csv'
wget -q -O $HOME/Practica1/Resultados2019.csv 'https://zaguan.unizar.es/record/76879/files/CSV.csv'
#Carga de datos resltados a la base de datos temporal
echo "Cargando datos a la base de datos..."
psql -U postgres  temporal -c "CREATE TABLE Resultados2021(CURSO_ACADEMICO SMALLINT,CENTRO VARCHAR(100), ESTUDIO VARCHAR(150),TIPO_ESTUDIO VARCHAR(15), ALUMNOS_MATRICULADOS SMALLINT, ALUMNOS_NUEVO_INGRESO SMALLINT, PLAZAS_OFERTADAS SMALLINT, ALUMNOS_GRADUADOS INT, INDICE_OCUPACION FLOAT, FECHA_ACTUALIZACION DATE);"
psql -U postgres temporal -c "COPY Resultados2021 FROM '$HOME/Practica1/Resultados2021.csv' DELIMITER ';'CSV HEADER;"
psql -U postgres  temporal -c "CREATE TABLE Resultados2020(CURSO_ACADEMICO SMALLINT,CENTRO VARCHAR(100), ESTUDIO VARCHAR(150),TIPO_ESTUDIO VARCHAR(15), ALUMNOS_MATRICULADOS SMALLINT, ALUMNOS_NUEVO_INGRESO SMALLINT, PLAZAS_OFERTADAS SMALLINT, ALUMNOS_GRADUADOS INT, INDICE_OCUPACION FLOAT, FECHA_ACTUALIZACION DATE);"
psql -U postgres temporal -c "COPY Resultados2020 FROM '$HOME/Practica1/Resultados2020.csv' DELIMITER ';'CSV HEADER;"
psql -U postgres  temporal -c "CREATE TABLE Resultados2019(CURSO_ACADEMICO SMALLINT,CENTRO VARCHAR(100), ESTUDIO VARCHAR(150),TIPO_ESTUDIO VARCHAR(15), ALUMNOS_MATRICULADOS SMALLINT, ALUMNOS_NUEVO_INGRESO SMALLINT, PLAZAS_OFERTADAS SMALLINT, ALUMNOS_GRADUADOS INT, INDICE_OCUPACION FLOAT, FECHA_ACTUALIZACION DATE);"
psql -U postgres temporal -c "COPY Resultados2019 FROM '$HOME/Practica1/Resultados2019.csv' DELIMITER ';'CSV HEADER;"

#Obtención de datos de  de los últimos 3 años
wget -q -O $HOME/Practica1/Egresados2021.csv 'https://zaguan.unizar.es/record/107371/files/CSV.csv'
wget -q -O $HOME/Practica1/Egresados2020.csv 'https://zaguan.unizar.es/record/98173/files/CSV.csv'
wget -q -O $HOME/Practica1/Egresados2019.csv 'https://zaguan.unizar.es/record/76879/files/CSV.csv'
#Carga de datos resltados a la base de datos temporal
echo "Cargando datos a la base de datos..."
psql -U postgres  temporal -c "CREATE TABLE Egresados2021(CURSO_ACADEMICO SMALLINT,LOCALIDAD VARCHAR(100), ESTUDIO VARCHAR(150),TIPO_ESTUDIO VARCHAR(15), TIPO_EGRESO VARCHAR(70), SEXO VARCHAR(10), ALUMNOS_GRADUADOS SMALLINT, ALUMNOS_INTERRUMPEN_STUDIOS INT, ALUMNOS_INTERRUMPEN_EST_ANO1 INT, ALUMNOS_TRASLADAN_OTRA_UNIV INT , DURACION_mEDIA_GRADUADOS INT, TASA_EFIENCIA FLOAT, FECHA_ACTUALIZACION DATE);"
psql -U postgres temporal -c "COPY Egresados2021 FROM '$HOME/Practica1/Egresados2021.csv' DELIMITER ';'CSV HEADER;"

psql -U postgres  temporal -c "CREATE TABLE Egresados2020(CURSO_ACADEMICO SMALLINT,LOCALIDAD VARCHAR(100), ESTUDIO VARCHAR(150),TIPO_ESTUDIO VARCHAR(15), TIPO_EGRESO VARCHAR(70), SEXO VARCHAR(10), ALUMNOS_GRADUADOS SMALLINT, ALUMNOS_INTERRUMPEN_STUDIOS INT, ALUMNOS_INTERRUMPEN_EST_ANO1 INT, ALUMNOS_TRASLADAN_OTRA_UNIV INT , DURACION_mEDIA_GRADUADOS INT, TASA_EFIENCIA FLOAT, FECHA_ACTUALIZACION DATE);"
psql -U postgres temporal -c "COPY Egresados2020 FROM '$HOME/Practica1/Egresados2021.csv' DELIMITER ';'CSV HEADER;"

psql -U postgres  temporal -c "CREATE TABLE Egresados2019(CURSO_ACADEMICO SMALLINT,LOCALIDAD VARCHAR(100), ESTUDIO VARCHAR(150),TIPO_ESTUDIO VARCHAR(15), TIPO_EGRESO VARCHAR(70), SEXO VARCHAR(10), ALUMNOS_GRADUADOS SMALLINT, ALUMNOS_INTERRUMPEN_STUDIOS INT, ALUMNOS_INTERRUMPEN_EST_ANO1 INT, ALUMNOS_TRASLADAN_OTRA_UNIV INT , DURACION_mEDIA_GRADUADOS INT, TASA_EFIENCIA FLOAT, FECHA_ACTUALIZACION DATE);"
psql -U postgres temporal -c "COPY Egresados2019 FROM '$HOME/Practica1/Egresados2021.csv' DELIMITER ';'CSV HEADER;"
