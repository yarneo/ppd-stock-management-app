--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: items; Type: TABLE; Schema: public; Owner: yarneo; Tablespace: 
--

CREATE TABLE items (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.items OWNER TO yarneo;

--
-- Name: items_id_seq; Type: SEQUENCE; Schema: public; Owner: yarneo
--

CREATE SEQUENCE items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.items_id_seq OWNER TO yarneo;

--
-- Name: items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yarneo
--

ALTER SEQUENCE items_id_seq OWNED BY items.id;


--
-- Name: items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yarneo
--

SELECT pg_catalog.setval('items_id_seq', 1, false);


--
-- Name: products; Type: TABLE; Schema: public; Owner: yarneo; Tablespace: 
--

CREATE TABLE products (
    id integer NOT NULL,
    name character varying(255),
    supplier_code character varying(255),
    ppd_code character varying(255),
    size character varying(255),
    min_quantity integer,
    item_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.products OWNER TO yarneo;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: yarneo
--

CREATE SEQUENCE products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO yarneo;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yarneo
--

ALTER SEQUENCE products_id_seq OWNED BY products.id;


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yarneo
--

SELECT pg_catalog.setval('products_id_seq', 155, true);


--
-- Name: quantities; Type: TABLE; Schema: public; Owner: yarneo; Tablespace: 
--

CREATE TABLE quantities (
    id integer NOT NULL,
    storage integer,
    amount integer,
    product_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.quantities OWNER TO yarneo;

--
-- Name: quantities_id_seq; Type: SEQUENCE; Schema: public; Owner: yarneo
--

CREATE SEQUENCE quantities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quantities_id_seq OWNER TO yarneo;

--
-- Name: quantities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yarneo
--

ALTER SEQUENCE quantities_id_seq OWNED BY quantities.id;


--
-- Name: quantities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yarneo
--

SELECT pg_catalog.setval('quantities_id_seq', 17, true);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: yarneo; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO yarneo;

--
-- Name: storages; Type: TABLE; Schema: public; Owner: yarneo; Tablespace: 
--

CREATE TABLE storages (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.storages OWNER TO yarneo;

--
-- Name: storages_id_seq; Type: SEQUENCE; Schema: public; Owner: yarneo
--

CREATE SEQUENCE storages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.storages_id_seq OWNER TO yarneo;

--
-- Name: storages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yarneo
--

ALTER SEQUENCE storages_id_seq OWNED BY storages.id;


--
-- Name: storages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yarneo
--

SELECT pg_catalog.setval('storages_id_seq', 3, true);


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: yarneo; Tablespace: 
--

CREATE TABLE transactions (
    id integer NOT NULL,
    operationtype character varying(255),
    info text,
    reason text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.transactions OWNER TO yarneo;

--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: yarneo
--

CREATE SEQUENCE transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transactions_id_seq OWNER TO yarneo;

--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yarneo
--

ALTER SEQUENCE transactions_id_seq OWNED BY transactions.id;


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yarneo
--

SELECT pg_catalog.setval('transactions_id_seq', 14, true);


--
-- Name: users; Type: TABLE; Schema: public; Owner: yarneo; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    username character varying(255),
    password_hash character varying(255),
    password_salt character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO yarneo;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: yarneo
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO yarneo;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yarneo
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yarneo
--

SELECT pg_catalog.setval('users_id_seq', 4, true);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: yarneo
--

ALTER TABLE ONLY items ALTER COLUMN id SET DEFAULT nextval('items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: yarneo
--

ALTER TABLE ONLY products ALTER COLUMN id SET DEFAULT nextval('products_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: yarneo
--

ALTER TABLE ONLY quantities ALTER COLUMN id SET DEFAULT nextval('quantities_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: yarneo
--

ALTER TABLE ONLY storages ALTER COLUMN id SET DEFAULT nextval('storages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: yarneo
--

ALTER TABLE ONLY transactions ALTER COLUMN id SET DEFAULT nextval('transactions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: yarneo
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: items; Type: TABLE DATA; Schema: public; Owner: yarneo
--

COPY items (id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: yarneo
--

COPY products (id, name, supplier_code, ppd_code, size, min_quantity, item_id, created_at, updated_at) FROM stdin;
85	280g Photo Glossy 	DNQ5GP11	PPD-20	10x15	-1	\N	2012-09-12 13:26:08	2012-09-14 14:50:50.650873
155	280g Photo Glossy	DNQ5GP11	PPD-17	A3+	5000	\N	2012-09-14 14:51:33.782499	2012-09-14 14:51:58.381029
75	280g Photo Glossy 	DNQ5GP11	PPD-15 	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 14:52:33.71555
88	280g Photo Satin	DNQ5PP11 A4	PPD-21 x	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 14:54:17.774408
41	200g Photo Satin A4	DN5SP8 current	PPD-68	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 15:37:35.568638
14	120g Double Sided Satin 	Silk-130DS A4	PPD-64	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 11:06:51.354988
11	120g Matt Coated 	KIP12-11M A4	PPD-54	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 11:13:07.767069
16	130g Brochure Paper	DUOPRINT 130	PPD-40	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 11:19:05.812595
12	120g Matt Coated 	KIP12-11M A3	PPD-55	A3	-1	\N	2012-09-12 13:26:08	2012-09-14 11:18:32.419467
18	170g Matt Coated	KIP16-10 A3	PPD-57	A3	-1	\N	2012-09-12 13:26:08	2012-09-14 11:19:33.759163
21	180g Gloss/Matt	MPM60-180B	PPD-43	A3	-1	\N	2012-09-12 13:26:08	2012-09-14 11:26:09.342948
17	170g Matt Coated	KIP16-10 A4	PPD-56	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 11:20:14.261496
24	180g  Gloss	C1704	PPD-24	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 11:22:27.396216
20	180g Gloss	C1704	PPD-41	A3	-1	\N	2012-09-12 13:26:08	2012-09-14 11:24:57.510318
45	210g Matt Double Sided	KIP20-21M	PPD-46	A3	-1	\N	2012-09-12 13:26:08	2012-09-14 14:05:16.11617
23	180g Gloss/Gloss	MIJ67-1KW	PPD-44	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 11:28:18.790227
22	180g Gloss/Matt	MPM60-180B	PPD-42	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 11:28:39.016269
38	200g Photo Gossy Card	C2004	PPD-48	10x15	-1	\N	2012-09-12 13:26:08	2012-09-14 13:40:35.4313
29	200g Satin EBAY	ILFORD 	EBAY 	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 13:45:03.593027
46	210g Matt Double Sided	KIP20-21M	PPD-47	A3 +	-1	\N	2012-09-12 13:26:08	2012-09-14 14:05:34.400737
47	210g Matt Greeting Cards		PPD-49	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 14:05:58.398898
63	260g Glossy	C2404	PPD-8	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 14:10:27.531499
44	200g Budget Brochure	KIP20 - DO NOT ORDER	PPD-53_	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 14:04:33.175825
43	210g Matt Double Sided	KIP20-21M	PPD-53	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 14:04:47.52908
64	260g Glossy 	C2404	PPD-9	A3	-1	\N	2012-09-12 13:26:08	2012-09-14 14:10:46.22405
65	260g Greeting Card 		PPD-51	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 14:11:22.58762
66	260g Greeting Card 		PPD-50	A5	-1	\N	2012-09-12 13:26:08	2012-09-14 14:11:41.180567
70	260g Satin	DN5PP10	PPD-13	A3	-1	\N	2012-09-12 13:26:08	2012-09-14 14:12:42.053356
68	260g Satin	DN5SP10	PPD-11	18x13	-1	\N	2012-09-12 13:26:08	2012-09-14 14:13:08.664828
69	260g Satin	DN5PP10	PPD-12	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 14:14:20.651415
71	260g Satin 	DN5PP10	PPD-14	A3+	-1	\N	2012-09-12 13:26:08	2012-09-14 14:14:33.541309
67	260g Satin 	DN5PP10	PPD-10	10x15	-1	\N	2012-09-12 13:26:08	2012-09-14 14:15:23.627286
74	270g Glossy	DN4GP	123	24"	-1	\N	2012-09-12 13:26:08	2012-09-14 14:16:17.378555
72	275g Satin	DN4PP9	123P-17	17"	-1	\N	2012-09-12 13:26:08	2012-09-14 14:24:28.714116
73	270g Satin	DN4PP9	123P 	24"	-1	\N	2012-09-12 13:26:08	2012-09-14 14:26:25.966072
35	200g Photo Pearl Microporous	NNQ3PP8	PPD-66 	24"	-1	\N	2012-09-12 13:26:08	2012-09-14 14:27:02.919783
83	280g Photo Glossy 	DNQ5GP11	PPD-16	A3	-1	\N	2012-09-12 13:26:08	2012-09-14 14:40:45.596685
118	Vinyl Gloss Self Adhesive 		127a 	24"	-1	\N	2012-09-12 13:26:08	2012-09-12 13:26:08
120	Vinyl Matt Self Adhesive		400	24"	-1	\N	2012-09-12 13:26:08	2012-09-12 13:26:08
123	Spray - Matt 				-1	\N	2012-09-12 13:26:08	2012-09-12 13:26:08
124	Spray - Satin 				-1	\N	2012-09-12 13:26:08	2012-09-12 13:26:08
125	Spray - Gloss				-1	\N	2012-09-12 13:26:08	2012-09-12 13:26:08
126	Envelop		ENVC5	C5	-1	\N	2012-09-12 13:26:08	2012-09-12 13:26:08
92	280g Photo Satin	DNQ5GPP11	PPD-67	10x15	-1	\N	2012-09-12 13:26:08	2012-09-14 14:49:01.806288
94	280g Photo Satin	DNQ5GPP11	PPD-23	A3+	-1	\N	2012-09-12 13:26:08	2012-09-14 14:49:51.269396
91	280g Photo Satin 	DNQ5GPP11	PPD-22	A3	-1	\N	2012-09-12 13:26:08	2012-09-14 15:24:00.241269
102	290g Art Paper	ART	PPD-61	A3	-1	\N	2012-09-12 13:26:08	2012-09-14 15:25:52.900422
103	290g Art Paper	ART A4	PPD-62	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 15:26:26.139103
96	300g Greeting card	GB800P-300	PPD-52	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 15:27:14.006541
99	Canvas	Canvas	PPD-60	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 15:28:43.710091
98	Canvas	Canvas	PPD-59	A3	-1	\N	2012-09-12 13:26:08	2012-09-14 15:29:09.35238
97	Canvas	Canvas	810	24"	20	\N	2012-09-12 13:26:08	2012-09-14 15:29:43.012332
121	Clear	OHP	PPD-34	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 15:30:32.648308
122	Clear Self Adhesive	CLR-SA	PPD-39	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 15:31:25.087098
151	Discovery Pack	ILFORD DISCOVERY	 ILPA4DISCO 	A4	10	\N	2012-09-12 13:26:08	2012-09-14 15:32:28.894208
114	Magnet Matt	MAGPM	PPD-32	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 15:33:51.703651
112	Tattoo		PPD-63	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 15:37:50.641718
104	transfer Paper	TP	PPD-1	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 15:39:39.661885
105	Transfer Paper		PPD-2	A3	-1	\N	2012-09-12 13:26:08	2012-09-14 15:39:55.194041
113	Magnt Photo Gloss	MGGA4M	PPD-31	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 15:40:30.197527
152	200g Gloss A4	ILFORD	PPD-25	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 11:33:46.881036
134	270g Glossy x 20 ILFORD	ILFORD GLOSS 270	ILGA4270-20 	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 14:18:37.627848
150	270g Pearl A3+ 20's	ILFORD PEARL A3+	ILPA3270-20 	A3+	-1	\N	2012-09-12 13:26:08	2012-09-14 14:20:42.611328
110	Transfer Paper Budget	0130981359	PPD-6	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 15:41:05.324482
111	Transfer Paper Budget	0130981359	PPD-7	A3	-1	\N	2012-09-12 13:26:08	2012-09-14 15:41:30.686922
107	Transfer Paper Dark	TP-DARK	PPD-4	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 15:42:00.437203
106	Transfer Paper Glitter	TP-Glitter	PPD-3 	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 15:42:24.914659
117	Vinyl Gloss Self Adhesive 	VGLS-SA	PPD-36	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 15:43:40.89643
116	Vinyl Gloss Self Adhesive 	VG-SA A3	PPD-35	A3	-1	\N	2012-09-12 13:26:08	2012-09-14 15:44:25.10392
119	Vinyl Matt Self Adhesive	VM-SA	PPD-38	A4	-1	\N	2012-09-12 13:26:08	2012-09-14 15:44:57.897197
15	120g Double Sided Satin 	Silk-130DS A3	PPD-65	A3	5000	\N	2012-09-12 13:26:08	2012-09-20 11:49:48.539964
\.


--
-- Data for Name: quantities; Type: TABLE DATA; Schema: public; Owner: yarneo
--

COPY quantities (id, storage, amount, product_id, created_at, updated_at) FROM stdin;
6	2	1500	15	2012-09-12 14:02:43.913992	2012-09-12 14:02:43.913992
4	1	2000	10	2012-09-12 13:59:30.001209	2012-09-12 14:20:23.368991
7	2	11000	10	2012-09-12 14:20:23.530974	2012-09-12 14:20:23.530974
8	2	111	12	2012-09-14 09:59:46.598727	2012-09-14 09:59:46.598727
9	1	123	37	2012-09-14 12:56:35.666522	2012-09-14 12:56:35.666522
10	1	44550	11	2012-09-20 11:50:29.683927	2012-09-20 11:50:29.683927
11	1	2400	12	2012-09-20 11:50:57.492026	2012-09-20 11:50:57.492026
12	1	9800	14	2012-09-20 11:51:23.318284	2012-09-20 11:51:23.318284
5	1	7900	15	2012-09-12 14:01:57.09405	2012-09-20 11:51:48.402479
16	1	49500	17	2012-09-20 11:58:10.643026	2012-09-20 11:58:10.643026
17	1	2400	18	2012-09-20 11:58:29.368191	2012-09-20 11:58:29.368191
13	3	20250	16	2012-09-20 11:52:06.753245	2012-09-20 11:59:14.536888
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: yarneo
--

COPY schema_migrations (version) FROM stdin;
20120828090407
20120828090919
20120830112411
20120904100432
20120907153419
20120913133911
\.


--
-- Data for Name: storages; Type: TABLE DATA; Schema: public; Owner: yarneo
--

COPY storages (id, name, created_at, updated_at) FROM stdin;
1	Warehouse #1	2012-09-12 11:59:46.795606	2012-09-12 11:59:46.795606
2	Packing Room	2012-09-12 11:59:52.778943	2012-09-12 11:59:52.778943
3	Warehouse #2	2012-09-12 12:02:18.340585	2012-09-12 12:02:18.340585
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: yarneo
--

COPY transactions (id, operationtype, info, reason, created_at, updated_at) FROM stdin;
1	Add Stock	Added 111 For Product: 120g Matt Coated  A3, To Storage Packing Room. 	Looks Like fun	2012-09-14 09:59:46.617791	2012-09-14 09:59:46.617791
2	Add Stock	Added 123 For Product: 200g Satin Photo Paper 24", To Storage Warehouse #1. 		2012-09-14 12:56:35.681078	2012-09-14 12:56:35.681078
3	Add Stock	Added 44550 For Product: 120g Matt Coated  A4, To Storage Warehouse #1. 		2012-09-20 11:50:29.77339	2012-09-20 11:50:29.77339
4	Add Stock	Added 2400 For Product: 120g Matt Coated  A3, To Storage Warehouse #1. 		2012-09-20 11:50:57.507643	2012-09-20 11:50:57.507643
5	Add Stock	Added 9800 For Product: 120g Double Sided Satin  A4, To Storage Warehouse #1. 		2012-09-20 11:51:23.36009	2012-09-20 11:51:23.36009
6	Add Stock	Added 6400 For Product: 120g Double Sided Satin  A3, To Storage Warehouse #1. 		2012-09-20 11:51:48.413948	2012-09-20 11:51:48.413948
7	Add Stock	Added 20250 For Product: 130g Brochure Paper A4, To Storage Warehouse #1. 		2012-09-20 11:52:06.81933	2012-09-20 11:52:06.81933
8	Add Stock	Added 20250 For Product: 170g Matt Coated A3, To Storage Warehouse #1. 		2012-09-20 11:52:37.124617	2012-09-20 11:52:37.124617
9	Add Stock	Added 29250 For Product: 170g Matt Coated A4, To Storage Warehouse #1. 		2012-09-20 11:53:34.123056	2012-09-20 11:53:34.123056
10	Remove Stock	Removed 20250 For Product: 170g Matt Coated A3,  From Storage Warehouse #1		2012-09-20 11:57:32.472642	2012-09-20 11:57:32.472642
11	Remove Stock	Removed 29250 For Product: 170g Matt Coated A4,  From Storage Warehouse #1		2012-09-20 11:57:46.4319	2012-09-20 11:57:46.4319
12	Add Stock	Added 49500 For Product: 170g Matt Coated A4, To Storage Warehouse #1. 		2012-09-20 11:58:10.652836	2012-09-20 11:58:10.652836
13	Add Stock	Added 2400 For Product: 170g Matt Coated A3, To Storage Warehouse #1. 		2012-09-20 11:58:29.378395	2012-09-20 11:58:29.378395
14	Move Stock	Moved 20250 For Product: 130g Brochure Paper A4,  From Storage Warehouse #1 To Storage Warehouse #2		2012-09-20 11:59:14.552245	2012-09-20 11:59:14.552245
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: yarneo
--

COPY users (id, username, password_hash, password_salt, created_at, updated_at) FROM stdin;
4	ppd	$2a$10$HZx9nQLKSQIT4.qOUeUc3u8hwYb5AbYbJmnMaAJgL/NzJ6z7//HiG	$2a$10$HZx9nQLKSQIT4.qOUeUc3u	2012-09-14 10:11:08.849059	2012-09-14 10:11:08.849059
\.


--
-- Name: items_pkey; Type: CONSTRAINT; Schema: public; Owner: yarneo; Tablespace: 
--

ALTER TABLE ONLY items
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);


--
-- Name: products_pkey; Type: CONSTRAINT; Schema: public; Owner: yarneo; Tablespace: 
--

ALTER TABLE ONLY products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: quantities_pkey; Type: CONSTRAINT; Schema: public; Owner: yarneo; Tablespace: 
--

ALTER TABLE ONLY quantities
    ADD CONSTRAINT quantities_pkey PRIMARY KEY (id);


--
-- Name: storages_pkey; Type: CONSTRAINT; Schema: public; Owner: yarneo; Tablespace: 
--

ALTER TABLE ONLY storages
    ADD CONSTRAINT storages_pkey PRIMARY KEY (id);


--
-- Name: transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: yarneo; Tablespace: 
--

ALTER TABLE ONLY transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: yarneo; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_products_on_item_id; Type: INDEX; Schema: public; Owner: yarneo; Tablespace: 
--

CREATE INDEX index_products_on_item_id ON products USING btree (item_id);


--
-- Name: index_quantities_on_product_id; Type: INDEX; Schema: public; Owner: yarneo; Tablespace: 
--

CREATE INDEX index_quantities_on_product_id ON quantities USING btree (product_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: yarneo; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

