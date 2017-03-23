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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: dumpedfun(); Type: FUNCTION; Schema: public; Owner: leonvillapun
--

CREATE FUNCTION dumpedfun() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE teacher_period SET dumped_info = 1 WHERE id_teacher = NEW.id_teacher;
RETURN NEW;
END;
$$;


ALTER FUNCTION public.dumpedfun() OWNER TO leonvillapun;

--
-- Name: subject_insert(); Type: FUNCTION; Schema: public; Owner: leonvillapun
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


ALTER FUNCTION public.subject_insert() OWNER TO leonvillapun;

--
-- Name: tutoring_between(integer, date); Type: FUNCTION; Schema: public; Owner: leonvillapun
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


ALTER FUNCTION public.tutoring_between(teacher integer, day date) OWNER TO leonvillapun;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: academic_consulting_hours; Type: TABLE; Schema: public; Owner: leonvillapun
--

CREATE TABLE academic_consulting_hours (
    id integer NOT NULL,
    start_hour time without time zone,
    end_hour time without time zone,
    days character varying(10)
);


ALTER TABLE academic_consulting_hours OWNER TO leonvillapun;

--
-- Name: academic_consulting_hours_id_seq; Type: SEQUENCE; Schema: public; Owner: leonvillapun
--

CREATE SEQUENCE academic_consulting_hours_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE academic_consulting_hours_id_seq OWNER TO leonvillapun;

--
-- Name: academic_consulting_hours_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leonvillapun
--

ALTER SEQUENCE academic_consulting_hours_id_seq OWNED BY academic_consulting_hours.id;


--
-- Name: academic_period; Type: TABLE; Schema: public; Owner: leonvillapun
--

CREATE TABLE academic_period (
    id integer NOT NULL,
    period character varying(10)
);


ALTER TABLE academic_period OWNER TO leonvillapun;

--
-- Name: academic_period_id_seq; Type: SEQUENCE; Schema: public; Owner: leonvillapun
--

CREATE SEQUENCE academic_period_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE academic_period_id_seq OWNER TO leonvillapun;

--
-- Name: academic_period_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leonvillapun
--

ALTER SEQUENCE academic_period_id_seq OWNED BY academic_period.id;


--
-- Name: class_hours; Type: TABLE; Schema: public; Owner: leonvillapun
--

CREATE TABLE class_hours (
    id integer NOT NULL,
    start_hour time without time zone,
    end_hour time without time zone,
    days character varying(10)
);


ALTER TABLE class_hours OWNER TO leonvillapun;

--
-- Name: class_hours_id_seq; Type: SEQUENCE; Schema: public; Owner: leonvillapun
--

CREATE SEQUENCE class_hours_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE class_hours_id_seq OWNER TO leonvillapun;

--
-- Name: class_hours_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leonvillapun
--

ALTER SEQUENCE class_hours_id_seq OWNED BY class_hours.id;


--
-- Name: student; Type: TABLE; Schema: public; Owner: leonvillapun
--

CREATE TABLE student (
    id integer NOT NULL,
    st_name character varying(50),
    password character varying(50)
);


ALTER TABLE student OWNER TO leonvillapun;

--
-- Name: student_id_seq; Type: SEQUENCE; Schema: public; Owner: leonvillapun
--

CREATE SEQUENCE student_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE student_id_seq OWNER TO leonvillapun;

--
-- Name: student_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leonvillapun
--

ALTER SEQUENCE student_id_seq OWNED BY student.id;


--
-- Name: student_period; Type: TABLE; Schema: public; Owner: leonvillapun
--

CREATE TABLE student_period (
    id integer NOT NULL,
    id_student integer,
    id_period integer
);


ALTER TABLE student_period OWNER TO leonvillapun;

--
-- Name: student_period_id_seq; Type: SEQUENCE; Schema: public; Owner: leonvillapun
--

CREATE SEQUENCE student_period_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE student_period_id_seq OWNER TO leonvillapun;

--
-- Name: student_period_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leonvillapun
--

ALTER SEQUENCE student_period_id_seq OWNED BY student_period.id;


--
-- Name: student_requests_tutoring; Type: TABLE; Schema: public; Owner: leonvillapun
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


ALTER TABLE student_requests_tutoring OWNER TO leonvillapun;

--
-- Name: subject; Type: TABLE; Schema: public; Owner: leonvillapun
--

CREATE TABLE subject (
    id integer NOT NULL,
    name character varying(50)
);


ALTER TABLE subject OWNER TO leonvillapun;

--
-- Name: teacher; Type: TABLE; Schema: public; Owner: leonvillapun
--

CREATE TABLE teacher (
    id integer NOT NULL,
    te_name character varying(50),
    password character varying(50),
    department character varying(50)
);


ALTER TABLE teacher OWNER TO leonvillapun;

--
-- Name: student_requests; Type: VIEW; Schema: public; Owner: leonvillapun
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


ALTER TABLE student_requests OWNER TO leonvillapun;

--
-- Name: student_requests_tutoring_id_seq; Type: SEQUENCE; Schema: public; Owner: leonvillapun
--

CREATE SEQUENCE student_requests_tutoring_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE student_requests_tutoring_id_seq OWNER TO leonvillapun;

--
-- Name: student_requests_tutoring_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leonvillapun
--

ALTER SEQUENCE student_requests_tutoring_id_seq OWNED BY student_requests_tutoring.id;


--
-- Name: subject_class_hours; Type: TABLE; Schema: public; Owner: leonvillapun
--

CREATE TABLE subject_class_hours (
    id integer NOT NULL,
    id_subject integer,
    id_class integer
);


ALTER TABLE subject_class_hours OWNER TO leonvillapun;

--
-- Name: subject_class_hours_id_seq; Type: SEQUENCE; Schema: public; Owner: leonvillapun
--

CREATE SEQUENCE subject_class_hours_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE subject_class_hours_id_seq OWNER TO leonvillapun;

--
-- Name: subject_class_hours_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leonvillapun
--

ALTER SEQUENCE subject_class_hours_id_seq OWNED BY subject_class_hours.id;


--
-- Name: subject_id_seq; Type: SEQUENCE; Schema: public; Owner: leonvillapun
--

CREATE SEQUENCE subject_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE subject_id_seq OWNER TO leonvillapun;

--
-- Name: subject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leonvillapun
--

ALTER SEQUENCE subject_id_seq OWNED BY subject.id;


--
-- Name: teacher_has_tutoring_hours; Type: TABLE; Schema: public; Owner: leonvillapun
--

CREATE TABLE teacher_has_tutoring_hours (
    id integer NOT NULL,
    id_teacher integer,
    id_tutoring integer,
    available smallint DEFAULT 0
);


ALTER TABLE teacher_has_tutoring_hours OWNER TO leonvillapun;

--
-- Name: teacher_available_tutoring; Type: VIEW; Schema: public; Owner: leonvillapun
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


ALTER TABLE teacher_available_tutoring OWNER TO leonvillapun;

--
-- Name: teacher_class; Type: TABLE; Schema: public; Owner: leonvillapun
--

CREATE TABLE teacher_class (
    id integer NOT NULL,
    id_teacher integer,
    id_class integer
);


ALTER TABLE teacher_class OWNER TO leonvillapun;

--
-- Name: teacher_class_id_seq; Type: SEQUENCE; Schema: public; Owner: leonvillapun
--

CREATE SEQUENCE teacher_class_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE teacher_class_id_seq OWNER TO leonvillapun;

--
-- Name: teacher_class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leonvillapun
--

ALTER SEQUENCE teacher_class_id_seq OWNED BY teacher_class.id;


--
-- Name: teacher_subject; Type: TABLE; Schema: public; Owner: leonvillapun
--

CREATE TABLE teacher_subject (
    id integer NOT NULL,
    id_teacher integer,
    id_subject integer
);


ALTER TABLE teacher_subject OWNER TO leonvillapun;

--
-- Name: teacher_classes_hours; Type: VIEW; Schema: public; Owner: leonvillapun
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


ALTER TABLE teacher_classes_hours OWNER TO leonvillapun;

--
-- Name: teacher_has_tutoring_hours_id_seq; Type: SEQUENCE; Schema: public; Owner: leonvillapun
--

CREATE SEQUENCE teacher_has_tutoring_hours_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE teacher_has_tutoring_hours_id_seq OWNER TO leonvillapun;

--
-- Name: teacher_has_tutoring_hours_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leonvillapun
--

ALTER SEQUENCE teacher_has_tutoring_hours_id_seq OWNED BY teacher_has_tutoring_hours.id;


--
-- Name: teacher_id_seq; Type: SEQUENCE; Schema: public; Owner: leonvillapun
--

CREATE SEQUENCE teacher_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE teacher_id_seq OWNER TO leonvillapun;

--
-- Name: teacher_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leonvillapun
--

ALTER SEQUENCE teacher_id_seq OWNED BY teacher.id;


--
-- Name: teacher_period; Type: TABLE; Schema: public; Owner: leonvillapun
--

CREATE TABLE teacher_period (
    id integer NOT NULL,
    id_teacher integer,
    id_period integer,
    dumped_info smallint DEFAULT 0
);


ALTER TABLE teacher_period OWNER TO leonvillapun;

--
-- Name: teacher_period_id_seq; Type: SEQUENCE; Schema: public; Owner: leonvillapun
--

CREATE SEQUENCE teacher_period_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE teacher_period_id_seq OWNER TO leonvillapun;

--
-- Name: teacher_period_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leonvillapun
--

ALTER SEQUENCE teacher_period_id_seq OWNED BY teacher_period.id;


--
-- Name: teacher_subject_id_seq; Type: SEQUENCE; Schema: public; Owner: leonvillapun
--

CREATE SEQUENCE teacher_subject_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE teacher_subject_id_seq OWNER TO leonvillapun;

--
-- Name: teacher_subject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leonvillapun
--

ALTER SEQUENCE teacher_subject_id_seq OWNED BY teacher_subject.id;


--
-- Name: academic_consulting_hours id; Type: DEFAULT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY academic_consulting_hours ALTER COLUMN id SET DEFAULT nextval('academic_consulting_hours_id_seq'::regclass);


--
-- Name: academic_period id; Type: DEFAULT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY academic_period ALTER COLUMN id SET DEFAULT nextval('academic_period_id_seq'::regclass);


--
-- Name: class_hours id; Type: DEFAULT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY class_hours ALTER COLUMN id SET DEFAULT nextval('class_hours_id_seq'::regclass);


--
-- Name: student id; Type: DEFAULT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY student ALTER COLUMN id SET DEFAULT nextval('student_id_seq'::regclass);


--
-- Name: student_period id; Type: DEFAULT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY student_period ALTER COLUMN id SET DEFAULT nextval('student_period_id_seq'::regclass);


--
-- Name: student_requests_tutoring id; Type: DEFAULT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY student_requests_tutoring ALTER COLUMN id SET DEFAULT nextval('student_requests_tutoring_id_seq'::regclass);


--
-- Name: subject id; Type: DEFAULT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY subject ALTER COLUMN id SET DEFAULT nextval('subject_id_seq'::regclass);


--
-- Name: subject_class_hours id; Type: DEFAULT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY subject_class_hours ALTER COLUMN id SET DEFAULT nextval('subject_class_hours_id_seq'::regclass);


--
-- Name: teacher id; Type: DEFAULT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY teacher ALTER COLUMN id SET DEFAULT nextval('teacher_id_seq'::regclass);


--
-- Name: teacher_class id; Type: DEFAULT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY teacher_class ALTER COLUMN id SET DEFAULT nextval('teacher_class_id_seq'::regclass);


--
-- Name: teacher_has_tutoring_hours id; Type: DEFAULT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY teacher_has_tutoring_hours ALTER COLUMN id SET DEFAULT nextval('teacher_has_tutoring_hours_id_seq'::regclass);


--
-- Name: teacher_period id; Type: DEFAULT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY teacher_period ALTER COLUMN id SET DEFAULT nextval('teacher_period_id_seq'::regclass);


--
-- Name: teacher_subject id; Type: DEFAULT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY teacher_subject ALTER COLUMN id SET DEFAULT nextval('teacher_subject_id_seq'::regclass);


--
-- Data for Name: academic_consulting_hours; Type: TABLE DATA; Schema: public; Owner: leonvillapun
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
\.


--
-- Name: academic_consulting_hours_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leonvillapun
--

SELECT pg_catalog.setval('academic_consulting_hours_id_seq', 32, true);


--
-- Data for Name: academic_period; Type: TABLE DATA; Schema: public; Owner: leonvillapun
--

COPY academic_period (id, period) FROM stdin;
1	EM16
2	AD16
3	EM17
\.


--
-- Name: academic_period_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leonvillapun
--

SELECT pg_catalog.setval('academic_period_id_seq', 3, true);


--
-- Data for Name: class_hours; Type: TABLE DATA; Schema: public; Owner: leonvillapun
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
\.


--
-- Name: class_hours_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leonvillapun
--

SELECT pg_catalog.setval('class_hours_id_seq', 79, true);


--
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: leonvillapun
--

COPY student (id, st_name, password) FROM stdin;
1	carlos ballarta	quesito
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
\.


--
-- Name: student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leonvillapun
--

SELECT pg_catalog.setval('student_id_seq', 14, true);


--
-- Data for Name: student_period; Type: TABLE DATA; Schema: public; Owner: leonvillapun
--

COPY student_period (id, id_student, id_period) FROM stdin;
1	1	3
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
-- Name: student_period_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leonvillapun
--

SELECT pg_catalog.setval('student_period_id_seq', 10, true);


--
-- Data for Name: student_requests_tutoring; Type: TABLE DATA; Schema: public; Owner: leonvillapun
--

COPY student_requests_tutoring (id, id_student, id_teacher, id_subject, id_tutoring, topic, date) FROM stdin;
1	1	5	8	5	intro theme	2017-02-28
2	4	7	6	2	variables	2017-02-27
4	8	4	5	9	verbs	2017-03-02
5	3	6	9	7	actions	2017-02-27
6	3	10	3	6	Everything	2017-03-22
\.


--
-- Name: student_requests_tutoring_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leonvillapun
--

SELECT pg_catalog.setval('student_requests_tutoring_id_seq', 6, true);


--
-- Data for Name: subject; Type: TABLE DATA; Schema: public; Owner: leonvillapun
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
\.


--
-- Data for Name: subject_class_hours; Type: TABLE DATA; Schema: public; Owner: leonvillapun
--

COPY subject_class_hours (id, id_subject, id_class) FROM stdin;
1	4	1
2	6	2
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
-- Name: subject_class_hours_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leonvillapun
--

SELECT pg_catalog.setval('subject_class_hours_id_seq', 12, true);


--
-- Name: subject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leonvillapun
--

SELECT pg_catalog.setval('subject_id_seq', 79, true);


--
-- Data for Name: teacher; Type: TABLE DATA; Schema: public; Owner: leonvillapun
--

COPY teacher (id, te_name, password, department) FROM stdin;
1	neil peart	jamonun	math
2	Vinnie col	Math12	math
3	Antonio sanchez	jaz77	Economics
4	Thomas Lang	germn12	Spanish
5	Jojo may	ant 99	Economics
6	Eric moore	dwpliz	english
7	Aaron spears	detroit22	TI
8	John boham	ledzep	TI
9	Keith moon	horzeman	english
10	chad smith	thepeperman	spanish
11	Hitler	heil	Fascism
\.


--
-- Data for Name: teacher_class; Type: TABLE DATA; Schema: public; Owner: leonvillapun
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
\.


--
-- Name: teacher_class_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leonvillapun
--

SELECT pg_catalog.setval('teacher_class_id_seq', 42, true);


--
-- Data for Name: teacher_has_tutoring_hours; Type: TABLE DATA; Schema: public; Owner: leonvillapun
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
\.


--
-- Name: teacher_has_tutoring_hours_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leonvillapun
--

SELECT pg_catalog.setval('teacher_has_tutoring_hours_id_seq', 25, true);


--
-- Name: teacher_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leonvillapun
--

SELECT pg_catalog.setval('teacher_id_seq', 11, true);


--
-- Data for Name: teacher_period; Type: TABLE DATA; Schema: public; Owner: leonvillapun
--

COPY teacher_period (id, id_teacher, id_period, dumped_info) FROM stdin;
2	3	3	1
3	3	3	1
5	2	3	0
4	6	3	1
1	1	3	1
\.


--
-- Name: teacher_period_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leonvillapun
--

SELECT pg_catalog.setval('teacher_period_id_seq', 12, true);


--
-- Data for Name: teacher_subject; Type: TABLE DATA; Schema: public; Owner: leonvillapun
--

COPY teacher_subject (id, id_teacher, id_subject) FROM stdin;
1	1	4
3	3	3
4	4	5
5	5	8
6	6	9
7	7	6
8	8	1
9	9	2
10	10	7
\.


--
-- Name: teacher_subject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leonvillapun
--

SELECT pg_catalog.setval('teacher_subject_id_seq', 36, true);


--
-- Name: academic_consulting_hours academic_consulting_hours_pkey; Type: CONSTRAINT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY academic_consulting_hours
    ADD CONSTRAINT academic_consulting_hours_pkey PRIMARY KEY (id);


--
-- Name: academic_period academic_period_pkey; Type: CONSTRAINT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY academic_period
    ADD CONSTRAINT academic_period_pkey PRIMARY KEY (id);


--
-- Name: class_hours class_hours_pkey; Type: CONSTRAINT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY class_hours
    ADD CONSTRAINT class_hours_pkey PRIMARY KEY (id);


--
-- Name: student_period student_period_pkey; Type: CONSTRAINT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY student_period
    ADD CONSTRAINT student_period_pkey PRIMARY KEY (id);


--
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY student
    ADD CONSTRAINT student_pkey PRIMARY KEY (id);


--
-- Name: student_requests_tutoring student_requests_tutoring_pkey; Type: CONSTRAINT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY student_requests_tutoring
    ADD CONSTRAINT student_requests_tutoring_pkey PRIMARY KEY (id);


--
-- Name: subject_class_hours subject_class_hours_pkey; Type: CONSTRAINT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY subject_class_hours
    ADD CONSTRAINT subject_class_hours_pkey PRIMARY KEY (id);


--
-- Name: subject subject_pkey; Type: CONSTRAINT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY subject
    ADD CONSTRAINT subject_pkey PRIMARY KEY (id);


--
-- Name: teacher_class teacher_class_pkey; Type: CONSTRAINT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY teacher_class
    ADD CONSTRAINT teacher_class_pkey PRIMARY KEY (id);


--
-- Name: teacher_has_tutoring_hours teacher_has_tutoring_hours_pkey; Type: CONSTRAINT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY teacher_has_tutoring_hours
    ADD CONSTRAINT teacher_has_tutoring_hours_pkey PRIMARY KEY (id);


--
-- Name: teacher_period teacher_period_pkey; Type: CONSTRAINT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY teacher_period
    ADD CONSTRAINT teacher_period_pkey PRIMARY KEY (id);


--
-- Name: teacher teacher_pkey; Type: CONSTRAINT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY teacher
    ADD CONSTRAINT teacher_pkey PRIMARY KEY (id);


--
-- Name: teacher_subject teacher_subject_pkey; Type: CONSTRAINT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY teacher_subject
    ADD CONSTRAINT teacher_subject_pkey PRIMARY KEY (id);


--
-- Name: teacher_has_tutoring_hours dumped_trigger; Type: TRIGGER; Schema: public; Owner: leonvillapun
--

CREATE TRIGGER dumped_trigger AFTER INSERT ON teacher_has_tutoring_hours FOR EACH ROW EXECUTE PROCEDURE dumpedfun();


--
-- Name: student_period student_period_id_period_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY student_period
    ADD CONSTRAINT student_period_id_period_fkey FOREIGN KEY (id_period) REFERENCES academic_period(id) ON DELETE CASCADE;


--
-- Name: student_period student_period_id_student_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY student_period
    ADD CONSTRAINT student_period_id_student_fkey FOREIGN KEY (id_student) REFERENCES student(id) ON DELETE CASCADE;


--
-- Name: student_requests_tutoring student_requests_tutoring_id_student_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY student_requests_tutoring
    ADD CONSTRAINT student_requests_tutoring_id_student_fkey FOREIGN KEY (id_student) REFERENCES student(id) ON DELETE CASCADE;


--
-- Name: student_requests_tutoring student_requests_tutoring_id_subject_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY student_requests_tutoring
    ADD CONSTRAINT student_requests_tutoring_id_subject_fkey FOREIGN KEY (id_subject) REFERENCES subject(id) ON DELETE CASCADE;


--
-- Name: student_requests_tutoring student_requests_tutoring_id_teacher_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY student_requests_tutoring
    ADD CONSTRAINT student_requests_tutoring_id_teacher_fkey FOREIGN KEY (id_teacher) REFERENCES teacher(id) ON DELETE CASCADE;


--
-- Name: student_requests_tutoring student_requests_tutoring_id_tutoring_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY student_requests_tutoring
    ADD CONSTRAINT student_requests_tutoring_id_tutoring_fkey FOREIGN KEY (id_tutoring) REFERENCES academic_consulting_hours(id) ON DELETE CASCADE;


--
-- Name: subject_class_hours subject_class_hours_id_class_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY subject_class_hours
    ADD CONSTRAINT subject_class_hours_id_class_fkey FOREIGN KEY (id_class) REFERENCES class_hours(id) ON DELETE CASCADE;


--
-- Name: subject_class_hours subject_class_hours_id_subject_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY subject_class_hours
    ADD CONSTRAINT subject_class_hours_id_subject_fkey FOREIGN KEY (id_subject) REFERENCES subject(id) ON DELETE CASCADE;


--
-- Name: teacher_class teacher_class_id_class_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY teacher_class
    ADD CONSTRAINT teacher_class_id_class_fkey FOREIGN KEY (id_class) REFERENCES class_hours(id) ON DELETE CASCADE;


--
-- Name: teacher_class teacher_class_id_teacher_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY teacher_class
    ADD CONSTRAINT teacher_class_id_teacher_fkey FOREIGN KEY (id_teacher) REFERENCES teacher(id) ON DELETE CASCADE;


--
-- Name: teacher_has_tutoring_hours teacher_has_tutoring_hours_id_teacher_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY teacher_has_tutoring_hours
    ADD CONSTRAINT teacher_has_tutoring_hours_id_teacher_fkey FOREIGN KEY (id_teacher) REFERENCES teacher(id) ON DELETE CASCADE;


--
-- Name: teacher_has_tutoring_hours teacher_has_tutoring_hours_id_tutoring_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY teacher_has_tutoring_hours
    ADD CONSTRAINT teacher_has_tutoring_hours_id_tutoring_fkey FOREIGN KEY (id_tutoring) REFERENCES academic_consulting_hours(id) ON DELETE CASCADE;


--
-- Name: teacher_period teacher_period_id_period_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY teacher_period
    ADD CONSTRAINT teacher_period_id_period_fkey FOREIGN KEY (id_period) REFERENCES academic_period(id) ON DELETE CASCADE;


--
-- Name: teacher_period teacher_period_id_teacher_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY teacher_period
    ADD CONSTRAINT teacher_period_id_teacher_fkey FOREIGN KEY (id_teacher) REFERENCES teacher(id) ON DELETE CASCADE;


--
-- Name: teacher_subject teacher_subject_id_subject_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY teacher_subject
    ADD CONSTRAINT teacher_subject_id_subject_fkey FOREIGN KEY (id_subject) REFERENCES subject(id) ON DELETE CASCADE;


--
-- Name: teacher_subject teacher_subject_id_teacher_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leonvillapun
--

ALTER TABLE ONLY teacher_subject
    ADD CONSTRAINT teacher_subject_id_teacher_fkey FOREIGN KEY (id_teacher) REFERENCES teacher(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

