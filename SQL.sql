DROP DATABASE IF EXISTS mps;
CREATE DATABASE mps;
USE mps;

CREATE TABLE TipoDocumento (
	id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(250) NOT NULL,
    abreviatura VARCHAR(4) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE TipoPersona(
    id INT NOT NULL AUTO_INCREMENT,
    descripcion VARCHAR(250) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE Usuario (
	id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(250) NOT NULL,
    correo VARCHAR(250) NOT NULL,
    telefono VARCHAR(250),
    identificacion VARCHAR(250) NOT NULL,
    contrasena VARCHAR(250) NOT NULL,
    programaPsi VARCHAR(250),
    tipoDocumento INT,
    tipoPersona INT,
    PRIMARY KEY (id),
    FOREIGN KEY (tipoDocumento) REFERENCES TipoDocumento(id),
    FOREIGN KEY (tipoPersona) REFERENCES TipoPersona(id)
); 

CREATE TABLE Modulo(
	id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(250) NOT NULL,
    imagen VARCHAR(250),
    descripcion VARCHAR(250),
    PRIMARY KEY (id)
);

CREATE TABLE SubModulo(
	id INT NOT NULL AUTO_INCREMENT,
    moduloId INT NOT NULL,
    titulo VARCHAR(250),
    contenido LONGTEXT NOT NULL,
    imagenTitulo VARCHAR(250),
    isImage BOOLEAN DEFAULT FALSE,
    isVideo BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (id),
    FOREIGN KEY (moduloId) REFERENCES Modulo(id)
);

INSERT INTO TipoDocumento (nombre, abreviatura) VALUES
('Cedula de ciudadania', 'CC'),
('Cedula de extranjeria', 'CE'),
('Tarjeta de identidad', 'TI'),
('Pasaporte', 'PAS'),
('Otro', 'OT');

INSERT INTO TipoPersona (descripcion) VALUES
('PACIENTES'),('CUIDADORES'),('ACOPEL'),('UNIMINUTO'),('OTRO');

INSERT INTO Modulo (nombre, imagen, descripcion) VALUES 
('mps', '../assets/icon/icon1.png', 'Mucopolisacaridosis'),
('calidad','../assets/icon/icon2.png', 'Calidad de vida'),
('bienestar', '../assets/icon/icon3.png', 'Bienestar'),
('organizaciones', '../assets/icon/icon4.png', 'Organizaciones'),
('salud', '../assets/icon/icon5.png', 'Salud mental'),
('bienestar', null, null),
('bienestar', null, null),
('bienestar', null, null);

INSERT INTO SubModulo (moduloId,titulo,contenido,imagenTitulo,IsImage,isVideo) VALUES
(1,'¿Qué es la Mucopolisacaridosis?', 'Las Mucopolisacaridosis son un grupo de enfermedades genéticas raras o huérfanas de baja prevalencia, que se caracteriza por deficiencias en las enzimas encargadas de la degradación de los glucosaminoglicanos a nivel lisosomal, produciendo disfunción de tejidos y síntomas multiorgánicos, como facies toscas, talla baja, rigidez muscular, irregularidad esquelética, entre otros.', "../assets/iconSubmodules/ICONO_MUCOPOLISACARIDOSIS.png", false, false);
-- (1, null,'https://www.youtube.com/embed/5En0qMr7KzI?si=_Dwm0WWahOeWqC48', null, false, true)

INSERT INTO SubModulo (moduloId,titulo,contenido,imagenTitulo,IsImage,isVideo) VALUES
(2,'¿Qué es Calidad de vida?', '<p>De acuerdo con la Organizaci&oacute;n Mundial de la Salud (OMS), la calidad de vida es definida como:</p><p>&nbsp;</p><p>La manera en que el individuo percibe su vida, el lugar que ocupa en el contexto cultural y el sistema de valores en que vive, la relaci&oacute;n con sus objetivos, expectativas, normas, criterios y preocupaciones, todo ello permeado por las actividades diarias, la salud f&iacute;sica, el estado psicol&oacute;gico, el grado de independencia, las relaciones sociales, los factores ambientales y sus creencias personales. (Cardona-Arias e Higuita-Guti&eacute;rrez, 2014, p.177; Cella, 1992).</p><p>&nbsp;</p><p>Es decir, cuando hablamos de una adecuada calidad de vida de (pacientes o cuidadores) nos referimos a que cuando eval&uacute;es a nivel personal las diferentes &aacute;reas de tu vida (social, salud, emocional, psicol&oacute;gico, entre otras), puedas percibir que en estas &aacute;reas las cosas est&aacute;n yendo en el camino esperado.</p>', "../assets/iconSubmodules/ICONO_CALIDAD_DE_VIDA.png", false, false),
(2, 'Planificación familiar','https://www.youtube.com/embed/wl56CUahMTU?si=Z8ZV4QPpu9QDY4Fg', null, false, true),
(2, 'Hablemos de sexualidad','https://www.youtube.com/embed/3WnlYtyqX_o?si=Ml0p6D9Ct60V1ue7', null, false, true);

INSERT INTO SubModulo(moduloId,titulo,contenido,imagenTitulo,IsImage,isVideo) VALUES
(3,'¿Qué es bienestar?','<p>El bienestar es la percepci&oacute;n que tiene una persona sobre su condici&oacute;n f&iacute;sica, mental y social, con la cual interact&uacute;a y se desarrolla en la sociedad.</p><p>&nbsp;</p><p><strong><em>A nivel f&iacute;sico:</em></strong>Es la percepci&oacute;n de tener buena salud f&iacute;sica en general, sentirse con vitalidad.</p><p>&nbsp;</p><p><strong><em>A nivel mental:</em></strong>Es la percepci&oacute;n de encontrarse emocionalmente bien, aceptando las emociones que presenta, con una sensaci&oacute;n de realizaci&oacute;n personal.</p><p>&nbsp;</p><p><strong><em>A nivel social: </em></strong>Es la percepci&oacute;n de desempe&ntilde;ar un papel en la sociedad, teniendo relaciones interpersonales saludables y manteniendo relaciones positivas.</p><p>&nbsp;</p><p>Fernandez-Lopez, et al., 2010.</p>',"../assets/iconSubmodules/ICONO_BIENESTAR.png",FALSE,FALSE);
-- (3,'Regulación emocional','<ul><li>¿Qué son las emociones?</li><li>Reconocimiento de emociones</li><li>Aspectos positivos y negativos</li></ul>', NULL,FALSE,FALSE),
-- (3,'Estimulación cognitiva','https://www.youtube.com/embed/dr7TURj3R7U?si=faa8H7wU926cFNJJ',NULL,FALSE,TRUE);

INSERT INTO SubModulo(moduloId,titulo,contenido,imagenTitulo,IsImage,isVideo) VALUES
(6,'¿Sabes como identificar emociones?', "https://www.youtube.com/embed/3gV4FKxeZCU?si=Vd9q2o5DAKZ3E_k6", NULL,FALSE,TRUE);

INSERT INTO SubModulo(moduloId,titulo,contenido,imagenTitulo,IsImage,isVideo) VALUES
(7,'¿Qué son las emociones?', 'Una emoción es un proceso que se activa cuando el organismo detecta algún peligro, amenaza o desequilibrio con el fin de poner en marcha los recursos a su alcance para controlar la situación (Fernández-Abascal y Palmero, 1999), es decir, estás nos permiten responder ante aquello que pasa en nuestro entorno implicando procesos cognitivos (pensamientos e interpretaciones), fisiológicos (salivación, sudor, palpitaciones, entre otros) y motores (comportamientos, conductas), dando respuesta también desde nuestra historia de aprendizaje.', NULL, FALSE,FALSE),
(7,'¡Leamos!', '<p>Rasgos sociales de temperamento, regulaci&oacute;n emicional y metacognicaci&oacute;n<a href="https://dialnet.unirioja.es/servlet/articulo?codigo=9217918">Aqu&iacute;</a></p>', NULL,FALSE,FALSE),
(7,'¡Vamos a meditar!', 'https://www.youtube.com/embed/Y6hraM3G2-U?si=Pt6NbaAD3LHlTTdp', "../assets/icon/meditacion.avif",FALSE,TRUE);

INSERT INTO SubModulo(moduloId,titulo,contenido,imagenTitulo,IsImage,isVideo) VALUES
(8,'Estimulación cognitiva', '<ul><li><strong></strong></li></ul><p>La estimulaci&oacute;n cognitiva es el conjunto de planes y estrategias que permiten mejorar el funcionamiento de las capacidades cognitivas, sociales, afectivas y dem&aacute;s esferas del sujeto que son susceptibles de mejorar a partir de ejercicios pr&aacute;cticos (Espert &amp; Villalba, 2014).</p><ul><li><strong >En qu&eacute; consiste:</strong></li></ul><p>Esta consiste en realizar actividades espec&iacute;ficas que se planean para cada capacidad o esfera a abordar en la persona, siendo as&iacute; esto lo que se conoce como &ldquo;programas de estimulaci&oacute;n cognitiva&rdquo;. Estas potencian las habilidades del sujeto, pero no frenan el deterioro cognitivo, ayudan a mejorar la autoeficacia percibida del sujeto, ya que permite dentro de lo posible que realice actividades de manera independiente, lo que aumenta su autoestima. (Espert &amp; Villalba, 2014).</p>', NULL,FALSE,FALSE),
(8,'¿Eres cuidador?', '<p><a href="https://www.cognifit.com/es/juegos-mentales">https://www.cognifit.com/es/juegos-mentales</a></p>', "../assets/iconSubmodules/cuidador.avif",FALSE,FALSE),
(8,'¿Eres paciente? ¿Iniciaste tu programa de estimulación?', '<p><a href="https://neuronup.com/">https://neuronup.com/</a></p>', "../assets/icon/neuronup_logo.png",FALSE,FALSE);

INSERT INTO SubModulo(moduloId,titulo,contenido,imagenTitulo,IsImage,isVideo) VALUES
(4,'¡Háblalo!','<p>Linea de apoyo</p><p><a href="https://www.hablalo.com.co/">www.hablalo.com.co</a></p>','../assets/org/hablalo.jpg',FALSE,FALSE),
(4,'Línea 106','<p>Linea de apoyo</p><p>O con el número 3007548933</p>','../assets/org/106.png',FALSE,FALSE),
(4,'Línea púrpura','Línea de apoyo','../assets/org/purpura.png',FALSE,FALSE),
(4,'Acopel','<p>Organización</p><p><a href="https://www.acopel.org.co/laweb/">Acopel</a><p>','../assets/org/acopel.png',FALSE,FALSE),
(4,'Aliber','Organización','../assets/org/alianza.png',FALSE,FALSE),
(4,'MinSalud','<p>Organización</p><p><a href="https://www.minsalud.gov.co/salud/publica/PENT/Paginas/enfermedades-huerfanas.aspx">Minsalud</a><p>','../assets/org/min.png',FALSE,FALSE),
(4,'National MPS Society','<p>Organización</p><p><a href="https://mpssociety.org/">National MPS Society</a><p>','../assets/org/society.png',FALSE,FALSE),
(4,'MPS','<p>Organización</p><p><a href="https://www.mpsesp.org/portal1/h_item-detail.php?contentid=1550">MPS</a><p>','../assets/org/mps.png',FALSE,FALSE),
(4,'','<p>Organización</p><p><a href="https://www.minsalud.gov.co/Portada2021/index.html">Ministerio de salud y protección social</a><p>','../assets/org/ministeriosalud.png',FALSE,FALSE);

INSERT INTO SubModulo(moduloId,titulo,contenido,imagenTitulo,IsImage,isVideo) VALUES
(5,'Salud Mental','Para la Organización Mundial de la Salud (OMS), la salud mental se define como “un estado de bienestar en el cual la persona es consciente de sus propias capacidades, puede afrontar las tensiones normales de la vida, puede trabajar de forma productiva y fructífera y es capaz de hacer una contribución a su comunidad”(2019).','../assets/iconSubmodules/ICONO_SALUD.png',FALSE,FALSE),
(5,'Respiración','Explicación de la importancia de respirar bien.',NULL,FALSE,FALSE),
(5,'Ejercicio de respiración dirigida','https://www.youtube.com/embed/1f9YyF1vHfc?si=TEG0jl4Xy4db2SX0',NULL,FALSE,TRUE),
(5,'Ruta del manejo del estrés','<ol><li>Tensionar el cuerpo.</li><li>Relajar el cuerpo.</li><li>Caminar.</li><li>Saber decir No a futuro</li><li>B&uacute;squeda de alternativas</li></ol>','../assets/icon/ruta.avif',FALSE,FALSE),
(5,'Recomendacion','Si tienes cuenta en Netflix te recomendamos el siguiente video<p><a href="https://www.netflix.com/co/title/81328829">Relaja tu mente</a></p>','../assets/icon/relaja_tu_mente.jpg',FALSE,FALSE);