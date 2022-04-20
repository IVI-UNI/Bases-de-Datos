DROP DATABASE IF EXISTS ResultadosOfertaAcademica;
CREATE DATABASE ResultadosOfertaAcademica;

CREATE TABLE ResultadosOfertaAcademica.Estudio (
	id_estudio smallint NOT NULL ,
	nombre_estudio varchar(100) NULL,
	tipo_estudio varchar(15) NULL,
    PRIMARY KEY(id_estudio)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
    
CREATE TABLE ResultadosOfertaAcademica.Centro (
	id_centro smallint NOT NULL ,
	nombre_centro varchar(100) NULL,
	tipo_centro varchar(15) NULL,
    PRIMARY KEY(id_centro)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;  

CREATE TABLE ResultadosOfertaAcademica.Impartido (
    IDestudio smallint,	
    IDcentro smallint,
    curso smallint,
	plazas_ofertadas smallint NULL,
    plazas_matriculadas smallint NULL,
    plazas_solicitadas int NULL,
	alumnos_nuevo_ingreso smallint NULL,
    nota_corte_julio float NULL,
    nota_corte_septiembre float NULL,
    alumnos_graduados smallint NULL,
    alumnos_adapta_grado_matri smallint NULL,
    alumnos_adapta_grado_matri_ni smallint NULL,
    alumnos_adapta_grado_titulado smallint NULL,
    alumnos_con_reconocimiento smallint NULL,  
    alumnos_movilidad_entrada smallint NULL,
    alumnos_movilidad_salida smallint NULL,
    creditos_matriculados float NULL,
    creditos_reconocidos float NULL,
    duracion_media_graduados float NULL,
    egresados_voluntarios smallint NULL,
    indice_ocupacion float NULL,
    tasa_exito float NULL,
    tasa_rendimiento float NULL,
    tasa_abandono float NULL,
    tasa_graduacion float NULL,
    PRIMARY KEY (IDestudio, IDcentro),
    FOREIGN KEY (IDcentro) REFERENCES ResultadosOfertaAcademica.Centro(id_centro)
	ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (IDestudio) REFERENCES ResultadosOfertaAcademica.Estudio(id_estudio)
	ON DELETE CASCADE ON UPDATE CASCADE
    
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE ResultadosOfertaAcademica.Localidad (
	id_localidad smallint NOT NULL ,
	nombre_localidad varchar(100) NULL,
    PRIMARY KEY(id_localidad) 
)ENGINE=InnoDB DEFAULT CHARSET=utf8; 

CREATE TABLE ResultadosOfertaAcademica.Pais (
	id_pais smallint NOT NULL ,
	nombre_pais varchar(100) NULL,
    PRIMARY KEY(id_pais) 
)ENGINE=InnoDB DEFAULT CHARSET=utf8;   
    
CREATE TABLE ResultadosOfertaAcademica.Movilidad (
	nombre_movilidad varchar(100) NOT NULL,
    id_centro smallint NOT NULL,
    PRIMARY KEY(nombre_movilidad, id_centro),
    FOREIGN KEY (id_centro) REFERENCES ResultadosOfertaAcademica.Centro(id_centro)
	ON DELETE CASCADE ON UPDATE CASCADE    
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE ResultadosOfertaAcademica.Realiza (
	curso smallint,
	nombre_movilidad varchar(100),
    id_centro smallint,
    id_pais smallint NOT NULL,
    area_estudios varchar(100) NULL,
    in_out varchar(4) NULL,
    nombre_idioma varchar(50),
    universidad_destino varchar(100),
    plazas_ofertadas smallint,
    plazas_asignadas smallint,
    PRIMARY KEY (nombre_movilidad, id_centro),
    FOREIGN KEY (nombre_movilidad) REFERENCES ResultadosOfertaAcademica.Movilidad(nombre_movilidad)
	ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (id_pais) REFERENCES ResultadosOfertaAcademica.Pais(id_pais)
	ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_centro) REFERENCES ResultadosOfertaAcademica.Centro(id_centro)
	ON DELETE CASCADE ON UPDATE CASCADE
  )ENGINE=InnoDB DEFAULT CHARSET=utf8;  
  
  
#CREATE TABLE ESTUDIO