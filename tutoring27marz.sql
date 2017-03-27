--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: del_student(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION del_student() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
DELETE FROM login where username = OLD.st_name;
RETURN NEW;
END;
$$;


--
-- Name: del_teacher(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION del_teacher() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
DELETE FROM login where username = OLD.te_name;
RETURN NEW;
END;
$$;


--
-- Name: dumpedfun(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION dumpedfun() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE teacher_period SET dumped_info = 1 WHERE id_teacher = NEW.id_teacher;
RETURN NEW;
END;
$$;


--
-- Name: subject_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION subject_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO subject_class_hours(id_subject)
VALUES(NEW.id);
RETURN NEW;
END;
$$;


--
-- Name: trig_student(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION trig_student() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO login(username,password,type) VALUES(NEW.st_name, NEW.password, 2);
RETURN NEW;
END;
$$;


--
-- Name: trig_teacher(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION trig_teacher() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO login(username,password,type) VALUES(NEW.te_name, NEW.password, 1);
RETURN NEW;
END;
$$;


--
-- Name: tutoring_between(integer, date); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION tutoring_between(teacher integer, day date) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    DECLARE
      total integer;
    BEGIN
      SELECT COUNT(*) INTO total
      FROM student_requests_tutoring
      WHERE id_teacher = teacher
      AND date = day;
    RETURN total;
  END;
  $$;


--
-- Name: up_student(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION up_student() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE login SET username = NEW.st_name, password = NEW.password WHERE username = OLD.st_name;
RETURN NEW;
END;
$$;


--
-- Name: up_teacher(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION up_teacher() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE login SET username = NEW.te_name , password = NEW.password WHERE username = OLD.te_name;
RETURN NEW;
END;
$$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: academic_consulting_hours; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE academic_consulting_hours (
    id integer NOT NULL,
    start_hour time without time zone,
    end_hour time without time zone,
    days character varying(10),
    CONSTRAINT hours_tutoring CHECK (((start_hour >= '07:00:00'::time without time zone) AND (end_hour <= '20:00:00'::time without time zone)))
);


--
-- Name: academic_consulting_hours_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE academic_consulting_hours_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: academic_consulting_hours_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE academic_consulting_hours_id_seq OWNED BY academic_consulting_hours.id;


--
-- Name: academic_period; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE academic_period (
    id integer NOT NULL,
    period character varying(10)
);


--
-- Name: academic_period_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE academic_period_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: academic_period_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE academic_period_id_seq OWNED BY academic_period.id;


--
-- Name: teacher; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE teacher (
    id integer NOT NULL,
    te_name character varying(50),
    password character varying(50)
);


--
-- Name: teacher_has_tutoring_hours; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE teacher_has_tutoring_hours (
    id integer NOT NULL,
    id_teacher integer,
    id_tutoring integer,
    available smallint DEFAULT 0
);


--
-- Name: asesorias; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW asesorias AS
 SELECT teacher_has_tutoring_hours.id,
    teacher.te_name,
    academic_consulting_hours.start_hour,
    academic_consulting_hours.end_hour,
    academic_consulting_hours.days
   FROM ((teacher_has_tutoring_hours
     JOIN teacher ON ((teacher_has_tutoring_hours.id_teacher = teacher.id)))
     JOIN academic_consulting_hours ON ((teacher_has_tutoring_hours.id_tutoring = academic_consulting_hours.id)));


--
-- Name: class_hours; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE class_hours (
    id integer NOT NULL,
    start_hour time without time zone,
    end_hour time without time zone,
    days character varying(10),
    CONSTRAINT hours CHECK (((start_hour >= '07:00:00'::time without time zone) AND (end_hour <= '20:00:00'::time without time zone)))
);


--
-- Name: class_hours_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE class_hours_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: class_hours_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE class_hours_id_seq OWNED BY class_hours.id;


--
-- Name: hours_teacher; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW hours_teacher AS
 SELECT teacher.te_name,
    academic_consulting_hours.start_hour,
    academic_consulting_hours.end_hour
   FROM ((teacher_has_tutoring_hours
     JOIN teacher ON ((teacher_has_tutoring_hours.id_teacher = teacher.id)))
     JOIN academic_consulting_hours ON ((teacher_has_tutoring_hours.id_tutoring = academic_consulting_hours.id)));


--
-- Name: login; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE login (
    id integer NOT NULL,
    username text,
    password text,
    type integer
);


--
-- Name: login_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE login_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: login_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE login_id_seq OWNED BY login.id;


--
-- Name: student; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE student (
    id integer NOT NULL,
    st_name character varying(50),
    password character varying(50)
);


--
-- Name: student_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE student_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: student_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE student_id_seq OWNED BY student.id;


--
-- Name: student_period; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE student_period (
    id integer NOT NULL,
    id_student integer,
    id_period integer
);


--
-- Name: student_period_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE student_period_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: student_period_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE student_period_id_seq OWNED BY student_period.id;


--
-- Name: student_requests_tutoring; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE student_requests_tutoring (
    id integer NOT NULL,
    id_student integer,
    id_teacher integer,
    id_subject integer,
    id_tutoring integer,
    topic character varying(50),
    date date
);


--
-- Name: subject; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE subject (
    id integer NOT NULL,
    name character varying(50)
);


--
-- Name: student_requests; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW student_requests AS
 SELECT student.st_name AS student,
    teacher.te_name AS teacher,
    subject.name AS subject,
    student_requests_tutoring.topic,
    academic_consulting_hours.start_hour,
    academic_consulting_hours.end_hour,
    student_requests_tutoring.date
   FROM student,
    teacher,
    subject,
    academic_consulting_hours,
    student_requests_tutoring
  WHERE ((student.id = student_requests_tutoring.id_student) AND (teacher.id = student_requests_tutoring.id_teacher) AND (subject.id = student_requests_tutoring.id_subject) AND (academic_consulting_hours.id = student_requests_tutoring.id_tutoring));


--
-- Name: student_requests_tutoring_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE student_requests_tutoring_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: student_requests_tutoring_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE student_requests_tutoring_id_seq OWNED BY student_requests_tutoring.id;


--
-- Name: subject_class_hours; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE subject_class_hours (
    id integer NOT NULL,
    id_subject integer,
    id_class integer
);


--
-- Name: subject_class_hours_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE subject_class_hours_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: subject_class_hours_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE subject_class_hours_id_seq OWNED BY subject_class_hours.id;


--
-- Name: subject_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE subject_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: subject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE subject_id_seq OWNED BY subject.id;


--
-- Name: teacher_available_tutoring; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW teacher_available_tutoring AS
 SELECT teacher.te_name AS teacher,
    academic_consulting_hours.start_hour,
    academic_consulting_hours.end_hour,
    academic_consulting_hours.days
   FROM teacher,
    academic_consulting_hours,
    teacher_has_tutoring_hours
  WHERE ((teacher.id = teacher_has_tutoring_hours.id_teacher) AND (academic_consulting_hours.id = teacher_has_tutoring_hours.id_tutoring));


--
-- Name: teacher_class; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE teacher_class (
    id integer NOT NULL,
    id_teacher integer,
    id_class integer
);


--
-- Name: teacher_class_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE teacher_class_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: teacher_class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE teacher_class_id_seq OWNED BY teacher_class.id;


--
-- Name: teacher_subject; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE teacher_subject (
    id integer NOT NULL,
    id_teacher integer,
    id_subject integer
);


--
-- Name: teacher_classes_hours; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW teacher_classes_hours AS
 SELECT teacher.te_name AS teacher,
    subject.name,
    class_hours.start_hour,
    class_hours.end_hour,
    class_hours.days AS subject
   FROM teacher,
    subject,
    class_hours,
    teacher_class,
    subject_class_hours,
    teacher_subject
  WHERE ((teacher.id = teacher_class.id_teacher) AND (class_hours.id = teacher_class.id_class) AND (subject.id = subject_class_hours.id_subject) AND (class_hours.id = subject_class_hours.id_class) AND (teacher.id = teacher_subject.id_teacher) AND (subject.id = teacher_subject.id_subject));


--
-- Name: teacher_has_tutoring_hours_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE teacher_has_tutoring_hours_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: teacher_has_tutoring_hours_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE teacher_has_tutoring_hours_id_seq OWNED BY teacher_has_tutoring_hours.id;


--
-- Name: teacher_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE teacher_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: teacher_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE teacher_id_seq OWNED BY teacher.id;


--
-- Name: teacher_period; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE teacher_period (
    id integer NOT NULL,
    id_teacher integer,
    id_period integer,
    dumped_info smallint DEFAULT 1
);


--
-- Name: teacher_period_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE teacher_period_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: teacher_period_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE teacher_period_id_seq OWNED BY teacher_period.id;


--
-- Name: teacher_subject_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE teacher_subject_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: teacher_subject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE teacher_subject_id_seq OWNED BY teacher_subject.id;


--
-- Name: tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tokens (
    id integer NOT NULL,
    token character varying(16),
    used smallint,
    username character varying(100),
    password character varying(100),
    u_name character varying(100)
);


--
-- Name: tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tokens_id_seq OWNED BY tokens.id;


--
-- Name: academic_consulting_hours id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY academic_consulting_hours ALTER COLUMN id SET DEFAULT nextval('academic_consulting_hours_id_seq'::regclass);


--
-- Name: academic_period id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY academic_period ALTER COLUMN id SET DEFAULT nextval('academic_period_id_seq'::regclass);


--
-- Name: class_hours id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY class_hours ALTER COLUMN id SET DEFAULT nextval('class_hours_id_seq'::regclass);


--
-- Name: login id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY login ALTER COLUMN id SET DEFAULT nextval('login_id_seq'::regclass);


--
-- Name: student id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY student ALTER COLUMN id SET DEFAULT nextval('student_id_seq'::regclass);


--
-- Name: student_period id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY student_period ALTER COLUMN id SET DEFAULT nextval('student_period_id_seq'::regclass);


--
-- Name: student_requests_tutoring id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY student_requests_tutoring ALTER COLUMN id SET DEFAULT nextval('student_requests_tutoring_id_seq'::regclass);


--
-- Name: subject id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY subject ALTER COLUMN id SET DEFAULT nextval('subject_id_seq'::regclass);


--
-- Name: subject_class_hours id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY subject_class_hours ALTER COLUMN id SET DEFAULT nextval('subject_class_hours_id_seq'::regclass);


--
-- Name: teacher id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY teacher ALTER COLUMN id SET DEFAULT nextval('teacher_id_seq'::regclass);


--
-- Name: teacher_class id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY teacher_class ALTER COLUMN id SET DEFAULT nextval('teacher_class_id_seq'::regclass);


--
-- Name: teacher_has_tutoring_hours id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY teacher_has_tutoring_hours ALTER COLUMN id SET DEFAULT nextval('teacher_has_tutoring_hours_id_seq'::regclass);


--
-- Name: teacher_period id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY teacher_period ALTER COLUMN id SET DEFAULT nextval('teacher_period_id_seq'::regclass);


--
-- Name: teacher_subject id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY teacher_subject ALTER COLUMN id SET DEFAULT nextval('teacher_subject_id_seq'::regclass);


--
-- Name: tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tokens ALTER COLUMN id SET DEFAULT nextval('tokens_id_seq'::regclass);


--
-- Data for Name: academic_consulting_hours; Type: TABLE DATA; Schema: public; Owner: -
--

COPY academic_consulting_hours (id, start_hour, end_hour, days) FROM stdin;
1	09:00:00	09:30:00	LMV
2	10:00:00	10:30:00	LMV
3	14:00:00	14:30:00	LMV
4	10:30:00	11:00:00	LMV
5	09:30:00	10:00:00	MJ
6	11:30:00	12:00:00	MJ
7	13:00:00	13:30:00	MJ
8	09:00:00	09:30:00	MJ
9	15:00:00	15:30:00	MJ
10	16:00:00	16:30:00	LMV
11	14:30:00	15:00:00	V
12	18:00:00	18:01:00	L
13	16:00:00	19:05:00	D
\.


--
-- Name: academic_consulting_hours_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('academic_consulting_hours_id_seq', 13, true);


--
-- Data for Name: academic_period; Type: TABLE DATA; Schema: public; Owner: -
--

COPY academic_period (id, period) FROM stdin;
1	EM16
2	AD16
3	EM17
\.


--
-- Name: academic_period_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('academic_period_id_seq', 3, true);


--
-- Data for Name: class_hours; Type: TABLE DATA; Schema: public; Owner: -
--

COPY class_hours (id, start_hour, end_hour, days) FROM stdin;
1	07:00:00	08:30:00	LMV
2	08:30:00	10:00:00	LMV
3	10:00:00	11:30:00	LM
4	11:30:00	13:00:00	LM
5	07:00:00	08:00:00	MJ
6	08:00:00	09:30:00	MJ
7	10:00:00	11:30:00	MJ
8	11:30:00	13:00:00	MJ
9	14:00:00	15:00:00	MJ
10	10:00:00	13:30:00	V
12	17:00:00	18:00:00	JV
\.


--
-- Name: class_hours_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('class_hours_id_seq', 15, true);


--
-- Data for Name: login; Type: TABLE DATA; Schema: public; Owner: -
--

COPY login (id, username, password, type) FROM stdin;
1	neil peart	jamonun	1
3	Antonio sanchez 	jaz77	1
4	Thomas Lang	germn12	1
5	Jojo may	ant 99	1
6	Eric Moore	dwpliz	1
7	Aaron spears	detroit22	1
8	John boham	ledzep	1
9	Keith moon	horzeman	1
10	chad smith	thepeperman	1
12	rodolfo	King123	2
13	caligari	elcaligari	2
15	Luis villas	Legday45	2
16	Charlie parker	emparedado	2
17	Lars ulrich	doblebobmo1	2
18	James Hetfield	ltdfire	2
19	Kirk Hammet	wahwahwah	2
20	robert trujillo	bassman12	2
21	cliff burton	ridethelightining	2
22	Alberto Oliart	Oly	2
23	Ivan Gonzalez	uber	2
24	king diamond	4c39e90d6a5c38a3f8a9b1f05840f240	1
2	Vinnie col	a0701a6b4866d24ed71dfaaf53a2a3b8	1
14	Armando C	26fa5625feec9b7f67a1c571e9204a76	2
25	admin	21232f297a57a5a743894a0e4a801fc3	0
26	testeacher	ca3ef687227e873eab821c7eac51f13e	1
27	\N	fb469d7ef430b0baf0cab6c436e70375	1
28	etst	fb469d7ef430b0baf0cab6c436e70375	2
11	carlos ballarta	12f0a8c7b1f43f325fabfd270cf25bf3	2
29	carlos ballarta	12f0a8c7b1f43f325fabfd270cf25bf3	2
30	testtest	f9674e842b7919d2c884aef69090b8c8	2
32	pach	\N	2
33	pachadams	ec6a6536ca304edf844d1d248a4f08dc	2
31	evokado	b24d1b30bb36eacb823a169dfc206e19	1
\.


--
-- Name: login_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('login_id_seq', 45, true);


--
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: -
--

COPY student (id, st_name, password) FROM stdin;
2	rodolfo	King123
3	caligari	elcaligari
4	Armando C	ferrari89
5	Luis villas	Legday45
6	Charlie parker	emparedado
7	Lars ulrich	doblebobmo1
8	James Hetfield	ltdfire
9	Kirk Hammet	wahwahwah
10	robert trujillo	bassman12
11	cliff burton	ridethelightining
13	queseso	9a5b73f620426bd970bb45b00ae53a76
12	Alberto Oliarteeee	b3d03ba6689e977e206e2c7835ea3ed6
1	carlos ballarta	12f0a8c7b1f43f325fabfd270cf25bf3
\.


--
-- Name: student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('student_id_seq', 25, true);


--
-- Data for Name: student_period; Type: TABLE DATA; Schema: public; Owner: -
--

COPY student_period (id, id_student, id_period) FROM stdin;
2	2	3
3	3	2
4	4	2
5	5	1
6	6	1
7	7	3
8	8	3
9	9	2
10	10	3
\.


--
-- Name: student_period_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('student_period_id_seq', 10, true);


--
-- Data for Name: student_requests_tutoring; Type: TABLE DATA; Schema: public; Owner: -
--

COPY student_requests_tutoring (id, id_student, id_teacher, id_subject, id_tutoring, topic, date) FROM stdin;
2	4	7	6	2	variables	2017-02-27
3	10	8	10	11	trees	2017-03-03
4	8	4	5	9	verbs	2017-03-02
5	3	6	9	7	actions	2017-02-27
36	2	1	1	4	quesito	2017-06-05
37	2	1	1	4	quesito	2017-03-05
38	2	1	1	4	quesito	2017-03-08
69	4	1	1	1	test4user	2017-03-16
70	4	1	2	13	triton	2017-03-25
71	4	1	16	13	triton2	2017-03-25
72	4	1	15	13	triton3	2017-03-25
73	4	1	16	13	triton4	2017-03-25
74	4	1	16	13	triton5	2017-03-25
75	4	1	13	13	triton6	2017-03-25
76	4	1	16	13	triton7	2017-03-25
77	4	1	10	5	tritoni3	2017-03-25
78	4	1	12	5	fffff	2017-03-25
79	4	9	16	8	zariñana	2017-03-25
80	4	9	7	8	zariñana2	2017-03-30
81	4	1	11	13	tritoncito	2017-03-25
82	4	1	16	13	unforbidden	2017-03-25
83	4	1	15	13	tritong	2017-03-25
84	4	1	15	13	tritones	2017-03-25
85	4	1	12	13	yañ	2017-03-25
86	4	1	16	13	peczeit	2017-03-25
87	4	1	16	13	moya	2017-03-25
88	4	1	13	13	moyita	2017-03-25
89	4	1	13	13	dehuevos	2017-03-25
90	4	1	12	13	prankebi	2017-03-25
91	4	1	11	13	merecesserfeliz	2017-03-25
92	4	1	15	13	extraqueso	2017-03-25
93	4	1	16	13	pepino	2017-03-25
94	4	1	16	13	dehuevos	2017-03-25
95	4	1	16	13	xdd	2017-03-25
96	4	1	16	13	ghghghg	2017-03-25
97	4	1	14	13	papapa	2017-03-25
98	4	1	15	13	s	2017-11-12
99	\N	\N	\N	\N	\N	\N
\.


--
-- Name: student_requests_tutoring_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('student_requests_tutoring_id_seq', 99, true);


--
-- Data for Name: subject; Type: TABLE DATA; Schema: public; Owner: -
--

COPY subject (id, name) FROM stdin;
1	Programming
2	English for bussiness
3	Business 2
4	Math 3
5	spanish 1
6	programming 2
7	spanish 2
8	economics 3
9	English 2
10	data structures
11	Math 1
12	Trigonometry
13	Thesis I
14	guitar master 
15	shredding
16	candado
\.


--
-- Data for Name: subject_class_hours; Type: TABLE DATA; Schema: public; Owner: -
--

COPY subject_class_hours (id, id_subject, id_class) FROM stdin;
1	4	1
2	6	2
3	11	3
4	3	4
5	8	5
6	1	6
7	9	7
8	2	8
9	5	9
10	7	9
11	10	10
\.


--
-- Name: subject_class_hours_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('subject_class_hours_id_seq', 12, true);


--
-- Name: subject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('subject_id_seq', 16, true);


--
-- Data for Name: teacher; Type: TABLE DATA; Schema: public; Owner: -
--

COPY teacher (id, te_name, password) FROM stdin;
1	neil peart	jamonun
2	Vinnie col	Math12
3	Antonio sanchez	jaz77
4	Thomas Lang	germn12
5	Jojo may	ant 99
6	Eric moore	dwpliz
7	Aaron spears	detroit22
8	John boham	ledzep
9	Keith moon	horzeman
10	chad smith	thepeperman
12	Bob dylan	dcc2087f34bc7d58ce369aaced00c521
13	king diamond	4c39e90d6a5c38a3f8a9b1f05840f240
16	evokado	b24d1b30bb36eacb823a169dfc206e19
\.


--
-- Data for Name: teacher_class; Type: TABLE DATA; Schema: public; Owner: -
--

COPY teacher_class (id, id_teacher, id_class) FROM stdin;
1	1	1
2	7	2
3	2	3
4	3	4
5	5	5
6	8	6
7	6	7
8	9	8
9	4	9
10	10	9
11	8	10
12	1	12
\.


--
-- Name: teacher_class_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('teacher_class_id_seq', 15, true);


--
-- Data for Name: teacher_has_tutoring_hours; Type: TABLE DATA; Schema: public; Owner: -
--

COPY teacher_has_tutoring_hours (id, id_teacher, id_tutoring, available) FROM stdin;
1	1	1	0
2	7	2	0
3	2	3	0
4	3	4	0
5	5	5	0
6	8	6	0
7	6	7	0
8	9	8	0
9	4	9	0
10	10	10	0
11	8	11	0
12	1	3	0
13	1	5	0
14	1	5	0
15	1	13	1
\.


--
-- Name: teacher_has_tutoring_hours_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('teacher_has_tutoring_hours_id_seq', 15, true);


--
-- Name: teacher_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('teacher_id_seq', 26, true);


--
-- Data for Name: teacher_period; Type: TABLE DATA; Schema: public; Owner: -
--

COPY teacher_period (id, id_teacher, id_period, dumped_info) FROM stdin;
2	2	3	0
3	3	3	0
4	4	2	0
5	5	3	0
6	6	3	0
7	7	3	0
8	8	1	0
9	9	3	0
10	10	3	0
1	1	3	1
12	1	3	1
13	1	3	1
14	13	3	1
15	13	3	1
16	13	3	1
\.


--
-- Name: teacher_period_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('teacher_period_id_seq', 16, true);


--
-- Data for Name: teacher_subject; Type: TABLE DATA; Schema: public; Owner: -
--

COPY teacher_subject (id, id_teacher, id_subject) FROM stdin;
1	1	4
2	2	11
3	3	3
4	4	5
5	5	8
6	6	9
7	7	6
8	8	1
9	9	2
10	10	7
11	8	10
12	1	13
\.


--
-- Name: teacher_subject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('teacher_subject_id_seq', 12, true);


--
-- Data for Name: tokens; Type: TABLE DATA; Schema: public; Owner: -
--

COPY tokens (id, token, used, username, password, u_name) FROM stdin;
1	ECYRMTYFQWYZXGZM	0	A01322361@itesm.mx	c8ffe9a587b126f152ed3d89a146b445	Luis vilas
2	YIMXAWKUUFGGOHYW	1	A01322361@itesm.mx	202cb962ac59075b964b07152d234b70	Luis vilas2
3	YJZTGHJLELMDXQJI	0	A01322361@itesm.mx	202cb962ac59075b964b07152d234b70	luisvillas3
4	EGMEFCUFTNSPZJHW	0	A01322361@itesm.mx	202cb962ac59075b964b07152d234b70	luisvillas4
5	QZYEXFRBOKXQUKRN	0	A01322361@itesm.mx	202cb962ac59075b964b07152d234b70	luisvillas4
\.


--
-- Name: tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('tokens_id_seq', 5, true);


--
-- Name: academic_consulting_hours academic_consulting_hours_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY academic_consulting_hours
    ADD CONSTRAINT academic_consulting_hours_pkey PRIMARY KEY (id);


--
-- Name: academic_period academic_period_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY academic_period
    ADD CONSTRAINT academic_period_pkey PRIMARY KEY (id);


--
-- Name: class_hours class_hours_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY class_hours
    ADD CONSTRAINT class_hours_pkey PRIMARY KEY (id);


--
-- Name: login login_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY login
    ADD CONSTRAINT login_pkey PRIMARY KEY (id);


--
-- Name: student_period student_period_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY student_period
    ADD CONSTRAINT student_period_pkey PRIMARY KEY (id);


--
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY student
    ADD CONSTRAINT student_pkey PRIMARY KEY (id);


--
-- Name: student_requests_tutoring student_requests_tutoring_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY student_requests_tutoring
    ADD CONSTRAINT student_requests_tutoring_pkey PRIMARY KEY (id);


--
-- Name: subject_class_hours subject_class_hours_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY subject_class_hours
    ADD CONSTRAINT subject_class_hours_pkey PRIMARY KEY (id);


--
-- Name: subject subject_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY subject
    ADD CONSTRAINT subject_pkey PRIMARY KEY (id);


--
-- Name: teacher_class teacher_class_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY teacher_class
    ADD CONSTRAINT teacher_class_pkey PRIMARY KEY (id);


--
-- Name: teacher_has_tutoring_hours teacher_has_tutoring_hours_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY teacher_has_tutoring_hours
    ADD CONSTRAINT teacher_has_tutoring_hours_pkey PRIMARY KEY (id);


--
-- Name: teacher_period teacher_period_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY teacher_period
    ADD CONSTRAINT teacher_period_pkey PRIMARY KEY (id);


--
-- Name: teacher teacher_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY teacher
    ADD CONSTRAINT teacher_pkey PRIMARY KEY (id);


--
-- Name: teacher_subject teacher_subject_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY teacher_subject
    ADD CONSTRAINT teacher_subject_pkey PRIMARY KEY (id);


--
-- Name: tokens tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tokens
    ADD CONSTRAINT tokens_pkey PRIMARY KEY (id);


--
-- Name: student delete_student; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER delete_student AFTER DELETE ON student FOR EACH ROW EXECUTE PROCEDURE del_student();


--
-- Name: teacher delete_teacher; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER delete_teacher AFTER DELETE ON teacher FOR EACH ROW EXECUTE PROCEDURE del_teacher();


--
-- Name: teacher_has_tutoring_hours dumped_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER dumped_trigger AFTER INSERT ON teacher_has_tutoring_hours FOR EACH ROW EXECUTE PROCEDURE dumpedfun();


--
-- Name: student insert_student; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER insert_student AFTER INSERT ON student FOR EACH ROW EXECUTE PROCEDURE trig_student();


--
-- Name: teacher insert_teacher; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER insert_teacher AFTER INSERT ON teacher FOR EACH ROW EXECUTE PROCEDURE trig_teacher();


--
-- Name: student update_student; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_student AFTER UPDATE ON student FOR EACH ROW EXECUTE PROCEDURE up_student();


--
-- Name: teacher update_teacher; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_teacher AFTER UPDATE ON teacher FOR EACH ROW EXECUTE PROCEDURE up_teacher();


--
-- Name: student_period student_period_id_period_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY student_period
    ADD CONSTRAINT student_period_id_period_fkey FOREIGN KEY (id_period) REFERENCES academic_period(id) ON DELETE CASCADE;


--
-- Name: student_period student_period_id_student_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY student_period
    ADD CONSTRAINT student_period_id_student_fkey FOREIGN KEY (id_student) REFERENCES student(id) ON DELETE CASCADE;


--
-- Name: student_requests_tutoring student_requests_tutoring_id_student_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY student_requests_tutoring
    ADD CONSTRAINT student_requests_tutoring_id_student_fkey FOREIGN KEY (id_student) REFERENCES student(id) ON DELETE CASCADE;


--
-- Name: student_requests_tutoring student_requests_tutoring_id_subject_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY student_requests_tutoring
    ADD CONSTRAINT student_requests_tutoring_id_subject_fkey FOREIGN KEY (id_subject) REFERENCES subject(id) ON DELETE CASCADE;


--
-- Name: student_requests_tutoring student_requests_tutoring_id_teacher_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY student_requests_tutoring
    ADD CONSTRAINT student_requests_tutoring_id_teacher_fkey FOREIGN KEY (id_teacher) REFERENCES teacher(id) ON DELETE CASCADE;


--
-- Name: student_requests_tutoring student_requests_tutoring_id_tutoring_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY student_requests_tutoring
    ADD CONSTRAINT student_requests_tutoring_id_tutoring_fkey FOREIGN KEY (id_tutoring) REFERENCES academic_consulting_hours(id) ON DELETE CASCADE;


--
-- Name: subject_class_hours subject_class_hours_id_class_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY subject_class_hours
    ADD CONSTRAINT subject_class_hours_id_class_fkey FOREIGN KEY (id_class) REFERENCES class_hours(id) ON DELETE CASCADE;


--
-- Name: subject_class_hours subject_class_hours_id_subject_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY subject_class_hours
    ADD CONSTRAINT subject_class_hours_id_subject_fkey FOREIGN KEY (id_subject) REFERENCES subject(id) ON DELETE CASCADE;


--
-- Name: teacher_class teacher_class_id_class_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY teacher_class
    ADD CONSTRAINT teacher_class_id_class_fkey FOREIGN KEY (id_class) REFERENCES class_hours(id) ON DELETE CASCADE;


--
-- Name: teacher_class teacher_class_id_teacher_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY teacher_class
    ADD CONSTRAINT teacher_class_id_teacher_fkey FOREIGN KEY (id_teacher) REFERENCES teacher(id) ON DELETE CASCADE;


--
-- Name: teacher_has_tutoring_hours teacher_has_tutoring_hours_id_teacher_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY teacher_has_tutoring_hours
    ADD CONSTRAINT teacher_has_tutoring_hours_id_teacher_fkey FOREIGN KEY (id_teacher) REFERENCES teacher(id) ON DELETE CASCADE;


--
-- Name: teacher_has_tutoring_hours teacher_has_tutoring_hours_id_tutoring_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY teacher_has_tutoring_hours
    ADD CONSTRAINT teacher_has_tutoring_hours_id_tutoring_fkey FOREIGN KEY (id_tutoring) REFERENCES academic_consulting_hours(id) ON DELETE CASCADE;


--
-- Name: teacher_period teacher_period_id_period_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY teacher_period
    ADD CONSTRAINT teacher_period_id_period_fkey FOREIGN KEY (id_period) REFERENCES academic_period(id) ON DELETE CASCADE;


--
-- Name: teacher_period teacher_period_id_teacher_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY teacher_period
    ADD CONSTRAINT teacher_period_id_teacher_fkey FOREIGN KEY (id_teacher) REFERENCES teacher(id) ON DELETE CASCADE;


--
-- Name: teacher_subject teacher_subject_id_subject_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY teacher_subject
    ADD CONSTRAINT teacher_subject_id_subject_fkey FOREIGN KEY (id_subject) REFERENCES subject(id) ON DELETE CASCADE;


--
-- Name: teacher_subject teacher_subject_id_teacher_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY teacher_subject
    ADD CONSTRAINT teacher_subject_id_teacher_fkey FOREIGN KEY (id_teacher) REFERENCES teacher(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

