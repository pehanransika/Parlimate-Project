PGDMP      +                }            ParlimateNew    11.22    16.4 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    24869    ParlimateNew    DATABASE     �   CREATE DATABASE "ParlimateNew" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE "ParlimateNew";
                postgres    false                        2615    2200    public    SCHEMA     2   -- *not* creating schema, since initdb creates it
 2   -- *not* dropping schema, since initdb creates it
                postgres    false            �           0    0    SCHEMA public    ACL     Q   REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;
                   postgres    false    7                        3079    33638    pgcrypto 	   EXTENSION     <   CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;
    DROP EXTENSION pgcrypto;
                   false    7            �           0    0    EXTENSION pgcrypto    COMMENT     <   COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';
                        false    2            �           1247    58379    status_enum    TYPE     V   CREATE TYPE public.status_enum AS ENUM (
    'APPROVED',
    'DELETED',
    'HOLD'
);
    DROP TYPE public.status_enum;
       public          postgres    false    7            �            1259    25409    admin    TABLE     �   CREATE TABLE public.admin (
    adminid integer NOT NULL,
    fullname character varying(100) NOT NULL,
    phone_number character varying(15) NOT NULL,
    userid integer NOT NULL
);
    DROP TABLE public.admin;
       public            postgres    false    7            �            1259    25407    admin_adminid_seq    SEQUENCE     �   CREATE SEQUENCE public.admin_adminid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.admin_adminid_seq;
       public          postgres    false    7    214            �           0    0    admin_adminid_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.admin_adminid_seq OWNED BY public.admin.adminid;
          public          postgres    false    213            �            1259    24966    citizen    TABLE     P  CREATE TABLE public.citizen (
    citizen_id integer NOT NULL,
    user_id integer NOT NULL,
    phone_number character varying(15),
    name character varying(100),
    district character varying(255),
    address character varying(255),
    image_url character varying(255),
    province character varying,
    political_view text
);
    DROP TABLE public.citizen;
       public            postgres    false    7            �            1259    24903 
   politician    TABLE     ]  CREATE TABLE public.politician (
    politician_id integer NOT NULL,
    user_id integer NOT NULL,
    name character varying(100),
    phone_number character varying(15),
    political_party_id integer,
    profile_img_url character varying(255),
    nic_front character varying(255),
    nic_back character varying(255),
    address_line_1 character varying(255),
    address_line_2 character varying(255),
    city character varying(100),
    zip_code character varying(20),
    address character varying(255),
    district character varying,
    province character varying,
    political_view text
);
    DROP TABLE public.politician;
       public            postgres    false    7            �            1259    50356 	   all_users    VIEW     �   CREATE VIEW public.all_users AS
 SELECT 'politician'::text AS user_type,
    politician.user_id,
    politician.name
   FROM public.politician
UNION ALL
 SELECT 'citizen'::text AS user_type,
    citizen.user_id,
    citizen.name
   FROM public.citizen;
    DROP VIEW public.all_users;
       public          postgres    false    208    208    202    202    7            �            1259    24923    announcement    TABLE     �   CREATE TABLE public.announcement (
    announcementid integer NOT NULL,
    politicianid integer NOT NULL,
    title character varying(255) NOT NULL,
    content text NOT NULL,
    datetime timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
     DROP TABLE public.announcement;
       public            postgres    false    7            �            1259    24921    announcement_announcementid_seq    SEQUENCE     �   ALTER TABLE public.announcement ALTER COLUMN announcementid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.announcement_announcementid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    204    7            �            1259    74920    answer    TABLE     �   CREATE TABLE public.answer (
    answer_id integer NOT NULL,
    answer text NOT NULL,
    answer_number integer NOT NULL,
    image_url character varying(255),
    question_id integer NOT NULL,
    number_of_votes integer
);
    DROP TABLE public.answer;
       public            postgres    false    7            �            1259    74918    answer_answer_id_seq    SEQUENCE     �   CREATE SEQUENCE public.answer_answer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.answer_answer_id_seq;
       public          postgres    false    236    7            �           0    0    answer_answer_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.answer_answer_id_seq OWNED BY public.answer.answer_id;
          public          postgres    false    235            �            1259    50142    approved_requests    TABLE     �  CREATE TABLE public.approved_requests (
    requestid integer NOT NULL,
    title character varying(255),
    description text,
    contact_no character varying(20),
    category character varying(100),
    targetamount numeric(10,2),
    attachment_url character varying(255),
    photos character varying(255),
    approval_date timestamp without time zone,
    name character varying(255),
    status character varying(20) DEFAULT 'APPROVED'::character varying,
    userid integer
);
 %   DROP TABLE public.approved_requests;
       public            postgres    false    7            �            1259    50331    approved_transfers    TABLE     >  CREATE TABLE public.approved_transfers (
    transfer_id integer NOT NULL,
    user_id integer NOT NULL,
    fundraiser_id integer NOT NULL,
    amount numeric(15,2) NOT NULL,
    currency character varying(3) NOT NULL,
    receipt_image_path character varying(255) NOT NULL,
    transfer_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    verified_by integer,
    verified_at timestamp without time zone,
    CONSTRAINT approved_transfers_currency_check CHECK (((currency)::text = ANY ((ARRAY['LKR'::character varying, 'USD'::character varying])::text[])))
);
 &   DROP TABLE public.approved_transfers;
       public            postgres    false    7            �            1259    50238    bank_transfers    TABLE     �  CREATE TABLE public.bank_transfers (
    transfer_id integer NOT NULL,
    user_id integer NOT NULL,
    fundraiser_id integer NOT NULL,
    amount numeric(15,2) NOT NULL,
    currency character varying(3) DEFAULT 'LKR'::character varying,
    receipt_image_path text NOT NULL,
    transfer_date timestamp with time zone DEFAULT now(),
    CONSTRAINT bank_transfers_currency_check CHECK (((currency)::text = ANY ((ARRAY['LKR'::character varying, 'USD'::character varying])::text[])))
);
 "   DROP TABLE public.bank_transfers;
       public            postgres    false    7            �            1259    50236    bank_transfers_transfer_id_seq    SEQUENCE     �   CREATE SEQUENCE public.bank_transfers_transfer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.bank_transfers_transfer_id_seq;
       public          postgres    false    221    7            �           0    0    bank_transfers_transfer_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.bank_transfers_transfer_id_seq OWNED BY public.bank_transfers.transfer_id;
          public          postgres    false    220            �            1259    24964    citizen_citizen_id_seq    SEQUENCE     �   ALTER TABLE public.citizen ALTER COLUMN citizen_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.citizen_citizen_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    7    208            �            1259    58433    payments    TABLE     "  CREATE TABLE public.payments (
    payment_id character varying(100) NOT NULL,
    transaction_id character varying(100) NOT NULL,
    amount numeric(10,2) NOT NULL,
    currency character varying(10) NOT NULL,
    create_time timestamp without time zone NOT NULL,
    requestid integer
);
    DROP TABLE public.payments;
       public            postgres    false    7            �            1259    66680    combined_fundraiser_total    VIEW     �  CREATE VIEW public.combined_fundraiser_total AS
 SELECT p.requestid AS fundraiser_id,
    concat('LKR ', COALESCE(p.amount, (0)::numeric)) AS payments_amount,
    concat('LKR ', COALESCE(at.amount, (0)::numeric)) AS transfers_amount,
    concat('LKR ', (COALESCE(p.amount, (0)::numeric) + COALESCE(at.amount, (0)::numeric))) AS total_amount
   FROM (public.payments p
     JOIN public.approved_transfers at ON ((p.requestid = at.fundraiser_id)));
 ,   DROP VIEW public.combined_fundraiser_total;
       public          postgres    false    222    226    226    222    7            �            1259    66698    combined_fundraiser_totals    VIEW     \  CREATE VIEW public.combined_fundraiser_totals AS
 SELECT COALESCE(pt.requestid, at.fundraiser_id) AS fundraiser_id,
    COALESCE(pt.currency, at.currency) AS payment_currency,
    COALESCE(pt.amount, (0)::numeric) AS payment_amount,
    lower(btrim((COALESCE(pt.currency, at.currency))::text)) AS payment_cleaned_currency,
        CASE
            WHEN (lower(btrim((COALESCE(pt.currency, at.currency))::text)) = 'usd'::text) THEN (COALESCE(pt.amount, (0)::numeric) * (320)::numeric)
            WHEN (lower(btrim((COALESCE(pt.currency, at.currency))::text)) = 'lkr'::text) THEN COALESCE(pt.amount, (0)::numeric)
            ELSE (0)::numeric
        END AS payment_amount_lkr,
    at.fundraiser_id AS approved_fundraiser_id,
    COALESCE(at.currency, pt.currency) AS approved_currency,
    COALESCE(at.amount, (0)::numeric) AS approved_amount,
    lower(btrim((COALESCE(at.currency, pt.currency))::text)) AS approved_cleaned_currency,
        CASE
            WHEN (lower(btrim((COALESCE(at.currency, pt.currency))::text)) = 'usd'::text) THEN (COALESCE(at.amount, (0)::numeric) * (320)::numeric)
            WHEN (lower(btrim((COALESCE(at.currency, pt.currency))::text)) = 'lkr'::text) THEN COALESCE(at.amount, (0)::numeric)
            ELSE (0)::numeric
        END AS approved_amount_lkr,
    (COALESCE(
        CASE
            WHEN (lower(btrim((COALESCE(pt.currency, at.currency))::text)) = 'usd'::text) THEN (COALESCE(pt.amount, (0)::numeric) * (320)::numeric)
            WHEN (lower(btrim((COALESCE(pt.currency, at.currency))::text)) = 'lkr'::text) THEN COALESCE(pt.amount, (0)::numeric)
            ELSE (0)::numeric
        END, (0)::numeric) + COALESCE(
        CASE
            WHEN (lower(btrim((COALESCE(at.currency, pt.currency))::text)) = 'usd'::text) THEN (COALESCE(at.amount, (0)::numeric) * (320)::numeric)
            WHEN (lower(btrim((COALESCE(at.currency, pt.currency))::text)) = 'lkr'::text) THEN COALESCE(at.amount, (0)::numeric)
            ELSE (0)::numeric
        END, (0)::numeric)) AS total_lkr
   FROM (public.payments pt
     FULL JOIN public.approved_transfers at ON ((pt.requestid = at.fundraiser_id)));
 -   DROP VIEW public.combined_fundraiser_totals;
       public          postgres    false    226    226    226    222    222    222    7            �            1259    58468    comment    TABLE     
  CREATE TABLE public.comment (
    commentid integer NOT NULL,
    userid integer NOT NULL,
    postid integer NOT NULL,
    content character varying(500) NOT NULL,
    "time" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    name character varying(255)
);
    DROP TABLE public.comment;
       public            postgres    false    7            �            1259    58466    comment_commentid_seq    SEQUENCE     �   CREATE SEQUENCE public.comment_commentid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.comment_commentid_seq;
       public          postgres    false    228    7            �           0    0    comment_commentid_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.comment_commentid_seq OWNED BY public.comment.commentid;
          public          postgres    false    227            �            1259    66708    fundraiser_totals_lkr    VIEW     �  CREATE VIEW public.fundraiser_totals_lkr AS
 WITH payment_totals AS (
         SELECT p_1.requestid,
            sum(
                CASE
                    WHEN ((p_1.currency)::text = 'USD'::text) THEN (p_1.amount * (300)::numeric)
                    ELSE p_1.amount
                END) AS amount_lkr
           FROM public.payments p_1
          GROUP BY p_1.requestid
        ), transfer_totals AS (
         SELECT at.fundraiser_id AS requestid,
            sum(
                CASE
                    WHEN ((at.currency)::text = 'USD'::text) THEN (at.amount * (300)::numeric)
                    ELSE at.amount
                END) AS amount_lkr
           FROM public.approved_transfers at
          GROUP BY at.fundraiser_id
        )
 SELECT COALESCE(p.requestid, t.requestid) AS requestid,
    (COALESCE(p.amount_lkr, (0)::numeric) + COALESCE(t.amount_lkr, (0)::numeric)) AS total_amount_lkr
   FROM (payment_totals p
     FULL JOIN transfer_totals t ON ((p.requestid = t.requestid)));
 (   DROP VIEW public.fundraiser_totals_lkr;
       public          postgres    false    226    222    222    222    226    226    7            �            1259    25019    fundraisingrequests    TABLE     �  CREATE TABLE public.fundraisingrequests (
    requestid integer NOT NULL,
    userid integer NOT NULL,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    category character varying(50) NOT NULL,
    targetamount numeric(10,2) NOT NULL,
    currency character varying(10) NOT NULL,
    datetime timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    attachment_url text,
    name text,
    contact_no character varying(15),
    photos character varying(255),
    status character varying(20) DEFAULT 'PENDING'::character varying,
    CONSTRAINT valid_status CHECK (((status)::text = ANY ((ARRAY['PENDING'::character varying, 'APPROVED'::character varying, 'DELETED'::character varying])::text[])))
);
 '   DROP TABLE public.fundraisingrequests;
       public            postgres    false    7            �            1259    25017 !   fundraisingrequests_requestid_seq    SEQUENCE     �   CREATE SEQUENCE public.fundraisingrequests_requestid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.fundraisingrequests_requestid_seq;
       public          postgres    false    210    7            �           0    0 !   fundraisingrequests_requestid_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.fundraisingrequests_requestid_seq OWNED BY public.fundraisingrequests.requestid;
          public          postgres    false    209            �            1259    25041    meetingrequest    TABLE     �  CREATE TABLE public.meetingrequest (
    meetingrequestid integer NOT NULL,
    topic character varying(255) NOT NULL,
    purposeofmeeting text,
    estimatedduration character varying(50),
    opponentname text,
    partyaffiliation text,
    discussionformat character varying(100),
    preferredhost character varying(100),
    proposaldate date NOT NULL,
    proposaltime time without time zone NOT NULL,
    politician_id integer,
    participantcount integer,
    status boolean
);
 "   DROP TABLE public.meetingrequest;
       public            postgres    false    7            �            1259    25039 #   meetingrequest_meetingrequestid_seq    SEQUENCE     �   ALTER TABLE public.meetingrequest ALTER COLUMN meetingrequestid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.meetingrequest_meetingrequestid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    7    212            �            1259    74936    meetings    TABLE     �  CREATE TABLE public.meetings (
    meetingid integer NOT NULL,
    politicianid integer NOT NULL,
    topic character varying(255) NOT NULL,
    description text,
    date date NOT NULL,
    "time" time without time zone NOT NULL,
    typeofthemeeting character varying(100) NOT NULL,
    host character varying(255),
    platform character varying(100),
    deadlinetoregister date,
    slots integer,
    availableslots integer
);
    DROP TABLE public.meetings;
       public            postgres    false    7            �            1259    74934    meetings_meetingid_seq    SEQUENCE     �   CREATE SEQUENCE public.meetings_meetingid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.meetings_meetingid_seq;
       public          postgres    false    7    238            �           0    0    meetings_meetingid_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.meetings_meetingid_seq OWNED BY public.meetings.meetingid;
          public          postgres    false    237            �            1259    74950    meetingusers    TABLE     �   CREATE TABLE public.meetingusers (
    meetingid integer NOT NULL,
    userid integer NOT NULL,
    email character varying(255)
);
     DROP TABLE public.meetingusers;
       public            postgres    false    7            �            1259    74965    meetingwishlist    TABLE     �   CREATE TABLE public.meetingwishlist (
    meetingid integer NOT NULL,
    userid integer NOT NULL,
    email character varying(255),
    "timestamp" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 #   DROP TABLE public.meetingwishlist;
       public            postgres    false    7            �            1259    25427 	   moderator    TABLE     �   CREATE TABLE public.moderator (
    moderatorid integer NOT NULL,
    fullname character varying(100) NOT NULL,
    phone_number character varying(15) NOT NULL,
    userid integer NOT NULL
);
    DROP TABLE public.moderator;
       public            postgres    false    7            �            1259    25425    moderator_moderatorid_seq    SEQUENCE     �   CREATE SEQUENCE public.moderator_moderatorid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.moderator_moderatorid_seq;
       public          postgres    false    7    216            �           0    0    moderator_moderatorid_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.moderator_moderatorid_seq OWNED BY public.moderator.moderatorid;
          public          postgres    false    215            �            1259    74983    party_profile    TABLE     T  CREATE TABLE public.party_profile (
    id integer NOT NULL,
    name character varying(255),
    founder character varying(255),
    found_year integer,
    leader character varying(255),
    general_secretary character varying(255),
    public_contact_number character varying(20),
    public_email_address character varying(255),
    ideology text,
    coalitions text,
    membership integer,
    address text,
    years_active_in_politics integer,
    seats_parliament integer,
    election_year integer,
    type_of_election character varying(100),
    number_of_votes integer,
    election_result character varying(100),
    vision_or_slogan text,
    economic_policy text,
    healthcare_policy text,
    infrastructure_policy text,
    education_policy text,
    youth_development_policy text,
    agriculture_policy text,
    image_path text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    website character varying(255),
    facebook character varying(255),
    instagram character varying(255),
    linkedin character varying(255),
    x_link character varying(255)
);
 !   DROP TABLE public.party_profile;
       public            postgres    false    7            �            1259    74981    party_profile_id_seq    SEQUENCE     �   CREATE SEQUENCE public.party_profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.party_profile_id_seq;
       public          postgres    false    7    242            �           0    0    party_profile_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.party_profile_id_seq OWNED BY public.party_profile.id;
          public          postgres    false    241            �            1259    74995    political_party_requests    TABLE     �  CREATE TABLE public.political_party_requests (
    req_id integer NOT NULL,
    name character varying NOT NULL,
    address character varying NOT NULL,
    leader character varying NOT NULL,
    email character varying NOT NULL,
    contact_no character varying NOT NULL,
    submission_date date NOT NULL,
    status character varying NOT NULL,
    password character varying NOT NULL
);
 ,   DROP TABLE public.political_party_requests;
       public            postgres    false    7            �            1259    74993 #   political_party_requests_req_id_seq    SEQUENCE     �   CREATE SEQUENCE public.political_party_requests_req_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.political_party_requests_req_id_seq;
       public          postgres    false    7    244            �           0    0 #   political_party_requests_req_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.political_party_requests_req_id_seq OWNED BY public.political_party_requests.req_id;
          public          postgres    false    243            �            1259    24885    politicalparty    TABLE     G  CREATE TABLE public.politicalparty (
    political_party_id integer NOT NULL,
    user_id integer NOT NULL,
    name character varying(100) NOT NULL,
    phone_number character varying(15),
    address character varying(255),
    logo_img character varying(255),
    no_of_members integer DEFAULT 0,
    leader character(1)
);
 "   DROP TABLE public.politicalparty;
       public            postgres    false    7            �            1259    24883 %   politicalparty_political_party_id_seq    SEQUENCE     �   ALTER TABLE public.politicalparty ALTER COLUMN political_party_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.politicalparty_political_party_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    200    7            �            1259    75006    politician_images    TABLE     �   CREATE TABLE public.politician_images (
    image_id integer NOT NULL,
    politician_id integer NOT NULL,
    image_path text NOT NULL
);
 %   DROP TABLE public.politician_images;
       public            postgres    false    7            �            1259    75004    politician_images_image_id_seq    SEQUENCE     �   CREATE SEQUENCE public.politician_images_image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.politician_images_image_id_seq;
       public          postgres    false    246    7            �           0    0    politician_images_image_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.politician_images_image_id_seq OWNED BY public.politician_images.image_id;
          public          postgres    false    245            �            1259    24901    politician_politician_id_seq    SEQUENCE     �   ALTER TABLE public.politician ALTER COLUMN politician_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.politician_politician_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    7    202            �            1259    75024    politicianprofile    TABLE     �  CREATE TABLE public.politicianprofile (
    profile_id integer NOT NULL,
    politician_id integer,
    full_name character varying(255),
    age integer,
    gender character varying(20),
    public_contact_number character varying(20),
    public_email_address character varying(255),
    district character varying(100),
    schools_attended text,
    university text,
    highest_education_qualification text,
    field_of_study text,
    educational_qualifications text,
    profession text,
    work_experience_summary text,
    party text,
    electoral_level text,
    electoral_province text,
    electoral_district text,
    electoral_division text,
    current_position text,
    current_position_in_party text,
    years_active_in_politics text,
    election_year text,
    type_of_election text,
    number_of_votes text,
    election_result text,
    vision_or_slogan text,
    economic_policy text,
    healthcare_policy text,
    infrastructure_policy text,
    education_policy text,
    youth_development_policy text,
    agriculture_policy text,
    facebook character varying(255),
    instagram character varying(255),
    linkedin character varying(255),
    x character varying(255),
    image_path text DEFAULT 'Politician/default.jpg'::text
);
 %   DROP TABLE public.politicianprofile;
       public            postgres    false    7            �            1259    75022     politicianprofile_profile_id_seq    SEQUENCE     �   CREATE SEQUENCE public.politicianprofile_profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.politicianprofile_profile_id_seq;
       public          postgres    false    248    7            �           0    0     politicianprofile_profile_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.politicianprofile_profile_id_seq OWNED BY public.politicianprofile.profile_id;
          public          postgres    false    247            �            1259    24939    post    TABLE     �   CREATE TABLE public.post (
    postid integer NOT NULL,
    userid integer NOT NULL,
    content text NOT NULL,
    datetime timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    name character varying(100),
    images character varying(255)
);
    DROP TABLE public.post;
       public            postgres    false    7            �            1259    24937    post_postid_seq    SEQUENCE     �   ALTER TABLE public.post ALTER COLUMN postid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.post_postid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    206    7            �            1259    74909    question    TABLE     �   CREATE TABLE public.question (
    question_id integer NOT NULL,
    question text NOT NULL,
    question_number integer NOT NULL,
    survey_id integer NOT NULL,
    number_of_answers integer NOT NULL
);
    DROP TABLE public.question;
       public            postgres    false    7            �            1259    74907    question_question_id_seq    SEQUENCE     �   CREATE SEQUENCE public.question_question_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.question_question_id_seq;
       public          postgres    false    234    7            �           0    0    question_question_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.question_question_id_seq OWNED BY public.question.question_id;
          public          postgres    false    233            �            1259    58361    rejected_requests    TABLE       CREATE TABLE public.rejected_requests (
    rejection_id integer NOT NULL,
    request_id integer NOT NULL,
    reason_for_reject text NOT NULL,
    rejection_date timestamp without time zone NOT NULL,
    title character varying(255),
    user_id integer
);
 %   DROP TABLE public.rejected_requests;
       public            postgres    false    7            �            1259    58359 "   rejected_requests_rejection_id_seq    SEQUENCE     �   CREATE SEQUENCE public.rejected_requests_rejection_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.rejected_requests_rejection_id_seq;
       public          postgres    false    7    225            �           0    0 "   rejected_requests_rejection_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.rejected_requests_rejection_id_seq OWNED BY public.rejected_requests.rejection_id;
          public          postgres    false    224            �            1259    75042    response    TABLE     �   CREATE TABLE public.response (
    response_id integer NOT NULL,
    survey_id integer NOT NULL,
    question_id integer NOT NULL,
    answer_id integer NOT NULL,
    user_id integer NOT NULL
);
    DROP TABLE public.response;
       public            postgres    false    7            �            1259    75040    response_response_id_seq    SEQUENCE     �   CREATE SEQUENCE public.response_response_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.response_response_id_seq;
       public          postgres    false    7    250            �           0    0    response_response_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.response_response_id_seq OWNED BY public.response.response_id;
          public          postgres    false    249            �            1259    75065    support    TABLE     u   CREATE TABLE public.support (
    support_id integer NOT NULL,
    name text[],
    email text[],
    text text[]
);
    DROP TABLE public.support;
       public            postgres    false    7            �            1259    75076    support_messages    TABLE     /  CREATE TABLE public.support_messages (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    message text NOT NULL,
    submitted_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    answer text,
    answered boolean DEFAULT false
);
 $   DROP TABLE public.support_messages;
       public            postgres    false    7            �            1259    75074    support_messages_id_seq    SEQUENCE     �   CREATE SEQUENCE public.support_messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.support_messages_id_seq;
       public          postgres    false    254    7            �           0    0    support_messages_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.support_messages_id_seq OWNED BY public.support_messages.id;
          public          postgres    false    253            �            1259    75063    support_support_id_seq    SEQUENCE     �   CREATE SEQUENCE public.support_support_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.support_support_id_seq;
       public          postgres    false    252    7            �           0    0    support_support_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.support_support_id_seq OWNED BY public.support.support_id;
          public          postgres    false    251            �            1259    41927    survey_requests    TABLE       CREATE TABLE public.survey_requests (
    surveyrequestid integer NOT NULL,
    userid integer NOT NULL,
    questiontext text NOT NULL,
    answer01 text,
    answer02 text,
    answer03 text,
    answer04 text,
    requesttime timestamp without time zone NOT NULL
);
 #   DROP TABLE public.survey_requests;
       public            postgres    false    7            �            1259    41925 #   survey_requests_surveyrequestid_seq    SEQUENCE     �   CREATE SEQUENCE public.survey_requests_surveyrequestid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.survey_requests_surveyrequestid_seq;
       public          postgres    false    7    218            �           0    0 #   survey_requests_surveyrequestid_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.survey_requests_surveyrequestid_seq OWNED BY public.survey_requests.surveyrequestid;
          public          postgres    false    217            �            1259    66703    total_amount_lkr    VIEW     �  CREATE VIEW public.total_amount_lkr AS
 WITH converted_payments AS (
         SELECT
                CASE
                    WHEN ((payments.currency)::text = 'USD'::text) THEN (payments.amount * (300)::numeric)
                    ELSE payments.amount
                END AS amount_lkr
           FROM public.payments
        ), converted_transfers AS (
         SELECT
                CASE
                    WHEN ((approved_transfers.currency)::text = 'USD'::text) THEN (approved_transfers.amount * (300)::numeric)
                    ELSE approved_transfers.amount
                END AS amount_lkr
           FROM public.approved_transfers
        ), combined_amounts AS (
         SELECT converted_payments.amount_lkr
           FROM converted_payments
        UNION ALL
         SELECT converted_transfers.amount_lkr
           FROM converted_transfers
        )
 SELECT sum(combined_amounts.amount_lkr) AS total_amount_lkr,
    count(*) AS total_transactions
   FROM combined_amounts;
 #   DROP VIEW public.total_amount_lkr;
       public          postgres    false    222    226    226    222    7            �            1259    24872    users    TABLE     	  CREATE TABLE public.users (
    user_id integer NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    user_type character varying(20) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.users;
       public            postgres    false    7            �            1259    24870    users_user_id_seq    SEQUENCE     �   ALTER TABLE public.users ALTER COLUMN user_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    198    7            u           2604    25412    admin adminid    DEFAULT     n   ALTER TABLE ONLY public.admin ALTER COLUMN adminid SET DEFAULT nextval('public.admin_adminid_seq'::regclass);
 <   ALTER TABLE public.admin ALTER COLUMN adminid DROP DEFAULT;
       public          postgres    false    214    213    214            �           2604    74923    answer answer_id    DEFAULT     t   ALTER TABLE ONLY public.answer ALTER COLUMN answer_id SET DEFAULT nextval('public.answer_answer_id_seq'::regclass);
 ?   ALTER TABLE public.answer ALTER COLUMN answer_id DROP DEFAULT;
       public          postgres    false    235    236    236            y           2604    50241    bank_transfers transfer_id    DEFAULT     �   ALTER TABLE ONLY public.bank_transfers ALTER COLUMN transfer_id SET DEFAULT nextval('public.bank_transfers_transfer_id_seq'::regclass);
 I   ALTER TABLE public.bank_transfers ALTER COLUMN transfer_id DROP DEFAULT;
       public          postgres    false    221    220    221            ~           2604    58471    comment commentid    DEFAULT     v   ALTER TABLE ONLY public.comment ALTER COLUMN commentid SET DEFAULT nextval('public.comment_commentid_seq'::regclass);
 @   ALTER TABLE public.comment ALTER COLUMN commentid DROP DEFAULT;
       public          postgres    false    228    227    228            r           2604    25022    fundraisingrequests requestid    DEFAULT     �   ALTER TABLE ONLY public.fundraisingrequests ALTER COLUMN requestid SET DEFAULT nextval('public.fundraisingrequests_requestid_seq'::regclass);
 L   ALTER TABLE public.fundraisingrequests ALTER COLUMN requestid DROP DEFAULT;
       public          postgres    false    210    209    210            �           2604    74939    meetings meetingid    DEFAULT     x   ALTER TABLE ONLY public.meetings ALTER COLUMN meetingid SET DEFAULT nextval('public.meetings_meetingid_seq'::regclass);
 A   ALTER TABLE public.meetings ALTER COLUMN meetingid DROP DEFAULT;
       public          postgres    false    238    237    238            v           2604    25430    moderator moderatorid    DEFAULT     ~   ALTER TABLE ONLY public.moderator ALTER COLUMN moderatorid SET DEFAULT nextval('public.moderator_moderatorid_seq'::regclass);
 D   ALTER TABLE public.moderator ALTER COLUMN moderatorid DROP DEFAULT;
       public          postgres    false    216    215    216            �           2604    74986    party_profile id    DEFAULT     t   ALTER TABLE ONLY public.party_profile ALTER COLUMN id SET DEFAULT nextval('public.party_profile_id_seq'::regclass);
 ?   ALTER TABLE public.party_profile ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    242    241    242            �           2604    74998    political_party_requests req_id    DEFAULT     �   ALTER TABLE ONLY public.political_party_requests ALTER COLUMN req_id SET DEFAULT nextval('public.political_party_requests_req_id_seq'::regclass);
 N   ALTER TABLE public.political_party_requests ALTER COLUMN req_id DROP DEFAULT;
       public          postgres    false    243    244    244            �           2604    75009    politician_images image_id    DEFAULT     �   ALTER TABLE ONLY public.politician_images ALTER COLUMN image_id SET DEFAULT nextval('public.politician_images_image_id_seq'::regclass);
 I   ALTER TABLE public.politician_images ALTER COLUMN image_id DROP DEFAULT;
       public          postgres    false    245    246    246            �           2604    75027    politicianprofile profile_id    DEFAULT     �   ALTER TABLE ONLY public.politicianprofile ALTER COLUMN profile_id SET DEFAULT nextval('public.politicianprofile_profile_id_seq'::regclass);
 K   ALTER TABLE public.politicianprofile ALTER COLUMN profile_id DROP DEFAULT;
       public          postgres    false    248    247    248            �           2604    74912    question question_id    DEFAULT     |   ALTER TABLE ONLY public.question ALTER COLUMN question_id SET DEFAULT nextval('public.question_question_id_seq'::regclass);
 C   ALTER TABLE public.question ALTER COLUMN question_id DROP DEFAULT;
       public          postgres    false    233    234    234            }           2604    58364    rejected_requests rejection_id    DEFAULT     �   ALTER TABLE ONLY public.rejected_requests ALTER COLUMN rejection_id SET DEFAULT nextval('public.rejected_requests_rejection_id_seq'::regclass);
 M   ALTER TABLE public.rejected_requests ALTER COLUMN rejection_id DROP DEFAULT;
       public          postgres    false    224    225    225            �           2604    75045    response response_id    DEFAULT     |   ALTER TABLE ONLY public.response ALTER COLUMN response_id SET DEFAULT nextval('public.response_response_id_seq'::regclass);
 C   ALTER TABLE public.response ALTER COLUMN response_id DROP DEFAULT;
       public          postgres    false    250    249    250            �           2604    75068    support support_id    DEFAULT     x   ALTER TABLE ONLY public.support ALTER COLUMN support_id SET DEFAULT nextval('public.support_support_id_seq'::regclass);
 A   ALTER TABLE public.support ALTER COLUMN support_id DROP DEFAULT;
       public          postgres    false    251    252    252            �           2604    75079    support_messages id    DEFAULT     z   ALTER TABLE ONLY public.support_messages ALTER COLUMN id SET DEFAULT nextval('public.support_messages_id_seq'::regclass);
 B   ALTER TABLE public.support_messages ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    254    253    254            w           2604    41930    survey_requests surveyrequestid    DEFAULT     �   ALTER TABLE ONLY public.survey_requests ALTER COLUMN surveyrequestid SET DEFAULT nextval('public.survey_requests_surveyrequestid_seq'::regclass);
 N   ALTER TABLE public.survey_requests ALTER COLUMN surveyrequestid DROP DEFAULT;
       public          postgres    false    217    218    218            ~          0    25409    admin 
   TABLE DATA           H   COPY public.admin (adminid, fullname, phone_number, userid) FROM stdin;
    public          postgres    false    214   �<      t          0    24923    announcement 
   TABLE DATA           ^   COPY public.announcement (announcementid, politicianid, title, content, datetime) FROM stdin;
    public          postgres    false    204   �<      �          0    74920    answer 
   TABLE DATA           k   COPY public.answer (answer_id, answer, answer_number, image_url, question_id, number_of_votes) FROM stdin;
    public          postgres    false    236   >      �          0    50142    approved_requests 
   TABLE DATA           �   COPY public.approved_requests (requestid, title, description, contact_no, category, targetamount, attachment_url, photos, approval_date, name, status, userid) FROM stdin;
    public          postgres    false    219   #>      �          0    50331    approved_transfers 
   TABLE DATA           �   COPY public.approved_transfers (transfer_id, user_id, fundraiser_id, amount, currency, receipt_image_path, transfer_date, verified_by, verified_at) FROM stdin;
    public          postgres    false    222   �C      �          0    50238    bank_transfers 
   TABLE DATA           �   COPY public.bank_transfers (transfer_id, user_id, fundraiser_id, amount, currency, receipt_image_path, transfer_date) FROM stdin;
    public          postgres    false    221   �D      x          0    24966    citizen 
   TABLE DATA           �   COPY public.citizen (citizen_id, user_id, phone_number, name, district, address, image_url, province, political_view) FROM stdin;
    public          postgres    false    208   �D      �          0    58468    comment 
   TABLE DATA           S   COPY public.comment (commentid, userid, postid, content, "time", name) FROM stdin;
    public          postgres    false    228   3G      z          0    25019    fundraisingrequests 
   TABLE DATA           �   COPY public.fundraisingrequests (requestid, userid, title, description, category, targetamount, currency, datetime, attachment_url, name, contact_no, photos, status) FROM stdin;
    public          postgres    false    210   �H      |          0    25041    meetingrequest 
   TABLE DATA           �   COPY public.meetingrequest (meetingrequestid, topic, purposeofmeeting, estimatedduration, opponentname, partyaffiliation, discussionformat, preferredhost, proposaldate, proposaltime, politician_id, participantcount, status) FROM stdin;
    public          postgres    false    212   �I      �          0    74936    meetings 
   TABLE DATA           �   COPY public.meetings (meetingid, politicianid, topic, description, date, "time", typeofthemeeting, host, platform, deadlinetoregister, slots, availableslots) FROM stdin;
    public          postgres    false    238   XJ      �          0    74950    meetingusers 
   TABLE DATA           @   COPY public.meetingusers (meetingid, userid, email) FROM stdin;
    public          postgres    false    239   uJ      �          0    74965    meetingwishlist 
   TABLE DATA           P   COPY public.meetingwishlist (meetingid, userid, email, "timestamp") FROM stdin;
    public          postgres    false    240   �J      �          0    25427 	   moderator 
   TABLE DATA           P   COPY public.moderator (moderatorid, fullname, phone_number, userid) FROM stdin;
    public          postgres    false    216   �J      �          0    74983    party_profile 
   TABLE DATA           �  COPY public.party_profile (id, name, founder, found_year, leader, general_secretary, public_contact_number, public_email_address, ideology, coalitions, membership, address, years_active_in_politics, seats_parliament, election_year, type_of_election, number_of_votes, election_result, vision_or_slogan, economic_policy, healthcare_policy, infrastructure_policy, education_policy, youth_development_policy, agriculture_policy, image_path, created_at, website, facebook, instagram, linkedin, x_link) FROM stdin;
    public          postgres    false    242   �J      �          0    58433    payments 
   TABLE DATA           h   COPY public.payments (payment_id, transaction_id, amount, currency, create_time, requestid) FROM stdin;
    public          postgres    false    226   K      �          0    74995    political_party_requests 
   TABLE DATA           �   COPY public.political_party_requests (req_id, name, address, leader, email, contact_no, submission_date, status, password) FROM stdin;
    public          postgres    false    244   �K      p          0    24885    politicalparty 
   TABLE DATA           �   COPY public.politicalparty (political_party_id, user_id, name, phone_number, address, logo_img, no_of_members, leader) FROM stdin;
    public          postgres    false    200   L      r          0    24903 
   politician 
   TABLE DATA           �   COPY public.politician (politician_id, user_id, name, phone_number, political_party_id, profile_img_url, nic_front, nic_back, address_line_1, address_line_2, city, zip_code, address, district, province, political_view) FROM stdin;
    public          postgres    false    202   �L      �          0    75006    politician_images 
   TABLE DATA           P   COPY public.politician_images (image_id, politician_id, image_path) FROM stdin;
    public          postgres    false    246   /O      �          0    75024    politicianprofile 
   TABLE DATA           �  COPY public.politicianprofile (profile_id, politician_id, full_name, age, gender, public_contact_number, public_email_address, district, schools_attended, university, highest_education_qualification, field_of_study, educational_qualifications, profession, work_experience_summary, party, electoral_level, electoral_province, electoral_district, electoral_division, current_position, current_position_in_party, years_active_in_politics, election_year, type_of_election, number_of_votes, election_result, vision_or_slogan, economic_policy, healthcare_policy, infrastructure_policy, education_policy, youth_development_policy, agriculture_policy, facebook, instagram, linkedin, x, image_path) FROM stdin;
    public          postgres    false    248   LO      v          0    24939    post 
   TABLE DATA           O   COPY public.post (postid, userid, content, datetime, name, images) FROM stdin;
    public          postgres    false    206   iO      �          0    74909    question 
   TABLE DATA           h   COPY public.question (question_id, question, question_number, survey_id, number_of_answers) FROM stdin;
    public          postgres    false    234   �P      �          0    58361    rejected_requests 
   TABLE DATA           x   COPY public.rejected_requests (rejection_id, request_id, reason_for_reject, rejection_date, title, user_id) FROM stdin;
    public          postgres    false    225   �P      �          0    75042    response 
   TABLE DATA           [   COPY public.response (response_id, survey_id, question_id, answer_id, user_id) FROM stdin;
    public          postgres    false    250   ^Q      �          0    75065    support 
   TABLE DATA           @   COPY public.support (support_id, name, email, text) FROM stdin;
    public          postgres    false    252   {Q      �          0    75076    support_messages 
   TABLE DATA           d   COPY public.support_messages (id, name, email, message, submitted_at, answer, answered) FROM stdin;
    public          postgres    false    254   �Q      �          0    41927    survey_requests 
   TABLE DATA           �   COPY public.survey_requests (surveyrequestid, userid, questiontext, answer01, answer02, answer03, answer04, requesttime) FROM stdin;
    public          postgres    false    218   �Q      n          0    24872    users 
   TABLE DATA           P   COPY public.users (user_id, email, password, user_type, created_at) FROM stdin;
    public          postgres    false    198   �R      �           0    0    admin_adminid_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.admin_adminid_seq', 2, true);
          public          postgres    false    213            �           0    0    announcement_announcementid_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.announcement_announcementid_seq', 126, true);
          public          postgres    false    203            �           0    0    answer_answer_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.answer_answer_id_seq', 1, false);
          public          postgres    false    235            �           0    0    bank_transfers_transfer_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.bank_transfers_transfer_id_seq', 63, true);
          public          postgres    false    220            �           0    0    citizen_citizen_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.citizen_citizen_id_seq', 53, true);
          public          postgres    false    207            �           0    0    comment_commentid_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.comment_commentid_seq', 56, true);
          public          postgres    false    227            �           0    0 !   fundraisingrequests_requestid_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.fundraisingrequests_requestid_seq', 265, true);
          public          postgres    false    209            �           0    0 #   meetingrequest_meetingrequestid_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.meetingrequest_meetingrequestid_seq', 3, true);
          public          postgres    false    211            �           0    0    meetings_meetingid_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.meetings_meetingid_seq', 1, false);
          public          postgres    false    237            �           0    0    moderator_moderatorid_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.moderator_moderatorid_seq', 2, true);
          public          postgres    false    215            �           0    0    party_profile_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.party_profile_id_seq', 1, false);
          public          postgres    false    241            �           0    0 #   political_party_requests_req_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.political_party_requests_req_id_seq', 1, false);
          public          postgres    false    243            �           0    0 %   politicalparty_political_party_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.politicalparty_political_party_id_seq', 6, true);
          public          postgres    false    199            �           0    0    politician_images_image_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.politician_images_image_id_seq', 1, false);
          public          postgres    false    245            �           0    0    politician_politician_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.politician_politician_id_seq', 32, true);
          public          postgres    false    201            �           0    0     politicianprofile_profile_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.politicianprofile_profile_id_seq', 1, false);
          public          postgres    false    247            �           0    0    post_postid_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.post_postid_seq', 135, true);
          public          postgres    false    205            �           0    0    question_question_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.question_question_id_seq', 1, false);
          public          postgres    false    233            �           0    0 "   rejected_requests_rejection_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.rejected_requests_rejection_id_seq', 70, true);
          public          postgres    false    224            �           0    0    response_response_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.response_response_id_seq', 1, false);
          public          postgres    false    249            �           0    0    support_messages_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.support_messages_id_seq', 1, false);
          public          postgres    false    253            �           0    0    support_support_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.support_support_id_seq', 1, false);
          public          postgres    false    251            �           0    0 #   survey_requests_surveyrequestid_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.survey_requests_surveyrequestid_seq', 22, true);
          public          postgres    false    217            �           0    0    users_user_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.users_user_id_seq', 219, true);
          public          postgres    false    197            �           2606    25415    admin admin_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (adminid);
 :   ALTER TABLE ONLY public.admin DROP CONSTRAINT admin_pkey;
       public            postgres    false    214            �           2606    24931    announcement announcement_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.announcement
    ADD CONSTRAINT announcement_pkey PRIMARY KEY (announcementid);
 H   ALTER TABLE ONLY public.announcement DROP CONSTRAINT announcement_pkey;
       public            postgres    false    204            �           2606    74928    answer answer_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.answer
    ADD CONSTRAINT answer_pkey PRIMARY KEY (answer_id);
 <   ALTER TABLE ONLY public.answer DROP CONSTRAINT answer_pkey;
       public            postgres    false    236            �           2606    50150 (   approved_requests approved_requests_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.approved_requests
    ADD CONSTRAINT approved_requests_pkey PRIMARY KEY (requestid);
 R   ALTER TABLE ONLY public.approved_requests DROP CONSTRAINT approved_requests_pkey;
       public            postgres    false    219            �           2606    50340 *   approved_transfers approved_transfers_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public.approved_transfers
    ADD CONSTRAINT approved_transfers_pkey PRIMARY KEY (transfer_id);
 T   ALTER TABLE ONLY public.approved_transfers DROP CONSTRAINT approved_transfers_pkey;
       public            postgres    false    222            �           2606    50249 "   bank_transfers bank_transfers_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.bank_transfers
    ADD CONSTRAINT bank_transfers_pkey PRIMARY KEY (transfer_id);
 L   ALTER TABLE ONLY public.bank_transfers DROP CONSTRAINT bank_transfers_pkey;
       public            postgres    false    221            �           2606    24973    citizen citizen_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.citizen
    ADD CONSTRAINT citizen_pkey PRIMARY KEY (citizen_id);
 >   ALTER TABLE ONLY public.citizen DROP CONSTRAINT citizen_pkey;
       public            postgres    false    208            �           2606    58477    comment comment_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (commentid);
 >   ALTER TABLE ONLY public.comment DROP CONSTRAINT comment_pkey;
       public            postgres    false    228            �           2606    25028 ,   fundraisingrequests fundraisingrequests_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public.fundraisingrequests
    ADD CONSTRAINT fundraisingrequests_pkey PRIMARY KEY (requestid);
 V   ALTER TABLE ONLY public.fundraisingrequests DROP CONSTRAINT fundraisingrequests_pkey;
       public            postgres    false    210            �           2606    25048 "   meetingrequest meetingrequest_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.meetingrequest
    ADD CONSTRAINT meetingrequest_pkey PRIMARY KEY (meetingrequestid);
 L   ALTER TABLE ONLY public.meetingrequest DROP CONSTRAINT meetingrequest_pkey;
       public            postgres    false    212            �           2606    74944    meetings meetings_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.meetings
    ADD CONSTRAINT meetings_pkey PRIMARY KEY (meetingid);
 @   ALTER TABLE ONLY public.meetings DROP CONSTRAINT meetings_pkey;
       public            postgres    false    238            �           2606    74954    meetingusers meetingusers_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.meetingusers
    ADD CONSTRAINT meetingusers_pkey PRIMARY KEY (meetingid, userid);
 H   ALTER TABLE ONLY public.meetingusers DROP CONSTRAINT meetingusers_pkey;
       public            postgres    false    239    239            �           2606    74970 $   meetingwishlist meetingwishlist_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public.meetingwishlist
    ADD CONSTRAINT meetingwishlist_pkey PRIMARY KEY (meetingid, userid);
 N   ALTER TABLE ONLY public.meetingwishlist DROP CONSTRAINT meetingwishlist_pkey;
       public            postgres    false    240    240            �           2606    25433    moderator moderator_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.moderator
    ADD CONSTRAINT moderator_pkey PRIMARY KEY (moderatorid);
 B   ALTER TABLE ONLY public.moderator DROP CONSTRAINT moderator_pkey;
       public            postgres    false    216            �           2606    74992     party_profile party_profile_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.party_profile
    ADD CONSTRAINT party_profile_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.party_profile DROP CONSTRAINT party_profile_pkey;
       public            postgres    false    242            �           2606    58437    payments payments_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (payment_id);
 @   ALTER TABLE ONLY public.payments DROP CONSTRAINT payments_pkey;
       public            postgres    false    226            �           2606    75003 6   political_party_requests political_party_requests_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.political_party_requests
    ADD CONSTRAINT political_party_requests_pkey PRIMARY KEY (req_id);
 `   ALTER TABLE ONLY public.political_party_requests DROP CONSTRAINT political_party_requests_pkey;
       public            postgres    false    244            �           2606    24893 "   politicalparty politicalparty_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.politicalparty
    ADD CONSTRAINT politicalparty_pkey PRIMARY KEY (political_party_id);
 L   ALTER TABLE ONLY public.politicalparty DROP CONSTRAINT politicalparty_pkey;
       public            postgres    false    200            �           2606    75014 (   politician_images politician_images_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.politician_images
    ADD CONSTRAINT politician_images_pkey PRIMARY KEY (image_id);
 R   ALTER TABLE ONLY public.politician_images DROP CONSTRAINT politician_images_pkey;
       public            postgres    false    246            �           2606    75016 5   politician_images politician_images_politician_id_key 
   CONSTRAINT     y   ALTER TABLE ONLY public.politician_images
    ADD CONSTRAINT politician_images_politician_id_key UNIQUE (politician_id);
 _   ALTER TABLE ONLY public.politician_images DROP CONSTRAINT politician_images_politician_id_key;
       public            postgres    false    246            �           2606    24910    politician politician_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.politician
    ADD CONSTRAINT politician_pkey PRIMARY KEY (politician_id);
 D   ALTER TABLE ONLY public.politician DROP CONSTRAINT politician_pkey;
       public            postgres    false    202            �           2606    75033 (   politicianprofile politicianprofile_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.politicianprofile
    ADD CONSTRAINT politicianprofile_pkey PRIMARY KEY (profile_id);
 R   ALTER TABLE ONLY public.politicianprofile DROP CONSTRAINT politicianprofile_pkey;
       public            postgres    false    248            �           2606    24947    post post_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_pkey PRIMARY KEY (postid);
 8   ALTER TABLE ONLY public.post DROP CONSTRAINT post_pkey;
       public            postgres    false    206            �           2606    74917    question question_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.question
    ADD CONSTRAINT question_pkey PRIMARY KEY (question_id);
 @   ALTER TABLE ONLY public.question DROP CONSTRAINT question_pkey;
       public            postgres    false    234            �           2606    58369 (   rejected_requests rejected_requests_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.rejected_requests
    ADD CONSTRAINT rejected_requests_pkey PRIMARY KEY (rejection_id);
 R   ALTER TABLE ONLY public.rejected_requests DROP CONSTRAINT rejected_requests_pkey;
       public            postgres    false    225            �           2606    75047    response response_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.response
    ADD CONSTRAINT response_pkey PRIMARY KEY (response_id);
 @   ALTER TABLE ONLY public.response DROP CONSTRAINT response_pkey;
       public            postgres    false    250            �           2606    75086 &   support_messages support_messages_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.support_messages
    ADD CONSTRAINT support_messages_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.support_messages DROP CONSTRAINT support_messages_pkey;
       public            postgres    false    254            �           2606    75073    support support_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.support
    ADD CONSTRAINT support_pkey PRIMARY KEY (support_id);
 >   ALTER TABLE ONLY public.support DROP CONSTRAINT support_pkey;
       public            postgres    false    252            �           2606    41935 $   survey_requests survey_requests_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.survey_requests
    ADD CONSTRAINT survey_requests_pkey PRIMARY KEY (surveyrequestid);
 N   ALTER TABLE ONLY public.survey_requests DROP CONSTRAINT survey_requests_pkey;
       public            postgres    false    218            �           2606    24882    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            postgres    false    198            �           2606    24880    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    198            �           2606    24932 +   announcement announcement_politicianid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.announcement
    ADD CONSTRAINT announcement_politicianid_fkey FOREIGN KEY (politicianid) REFERENCES public.politician(politician_id) ON DELETE CASCADE;
 U   ALTER TABLE ONLY public.announcement DROP CONSTRAINT announcement_politicianid_fkey;
       public          postgres    false    202    204    2969            �           2606    74929    answer answer_question_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.answer
    ADD CONSTRAINT answer_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.question(question_id);
 H   ALTER TABLE ONLY public.answer DROP CONSTRAINT answer_question_id_fkey;
       public          postgres    false    234    2999    236            �           2606    50346 8   approved_transfers approved_transfers_fundraiser_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.approved_transfers
    ADD CONSTRAINT approved_transfers_fundraiser_id_fkey FOREIGN KEY (fundraiser_id) REFERENCES public.approved_requests(requestid);
 b   ALTER TABLE ONLY public.approved_transfers DROP CONSTRAINT approved_transfers_fundraiser_id_fkey;
       public          postgres    false    219    2987    222            �           2606    50341 2   approved_transfers approved_transfers_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.approved_transfers
    ADD CONSTRAINT approved_transfers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 \   ALTER TABLE ONLY public.approved_transfers DROP CONSTRAINT approved_transfers_user_id_fkey;
       public          postgres    false    222    2965    198            �           2606    50351 6   approved_transfers approved_transfers_verified_by_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.approved_transfers
    ADD CONSTRAINT approved_transfers_verified_by_fkey FOREIGN KEY (verified_by) REFERENCES public.admin(adminid);
 `   ALTER TABLE ONLY public.approved_transfers DROP CONSTRAINT approved_transfers_verified_by_fkey;
       public          postgres    false    222    2981    214            �           2606    24974    citizen citizen_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.citizen
    ADD CONSTRAINT citizen_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.citizen DROP CONSTRAINT citizen_user_id_fkey;
       public          postgres    false    208    2965    198            �           2606    58483    comment comment_postid_fkey    FK CONSTRAINT     |   ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_postid_fkey FOREIGN KEY (postid) REFERENCES public.post(postid);
 E   ALTER TABLE ONLY public.comment DROP CONSTRAINT comment_postid_fkey;
       public          postgres    false    2973    206    228            �           2606    58478    comment comment_userid_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(user_id);
 E   ALTER TABLE ONLY public.comment DROP CONSTRAINT comment_userid_fkey;
       public          postgres    false    198    228    2965            �           2606    50105    admin fk_anmin_user    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin
    ADD CONSTRAINT fk_anmin_user FOREIGN KEY (userid) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 =   ALTER TABLE ONLY public.admin DROP CONSTRAINT fk_anmin_user;
       public          postgres    false    198    214    2965            �           2606    50255    bank_transfers fk_fundraiser    FK CONSTRAINT     �   ALTER TABLE ONLY public.bank_transfers
    ADD CONSTRAINT fk_fundraiser FOREIGN KEY (fundraiser_id) REFERENCES public.approved_requests(requestid);
 F   ALTER TABLE ONLY public.bank_transfers DROP CONSTRAINT fk_fundraiser;
       public          postgres    false    219    221    2987            �           2606    50095 .   fundraisingrequests fk_fundraisingrequest_user    FK CONSTRAINT     �   ALTER TABLE ONLY public.fundraisingrequests
    ADD CONSTRAINT fk_fundraisingrequest_user FOREIGN KEY (userid) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.fundraisingrequests DROP CONSTRAINT fk_fundraisingrequest_user;
       public          postgres    false    210    2965    198            �           2606    50100 %   meetingrequest fk_meetingrequest_user    FK CONSTRAINT     �   ALTER TABLE ONLY public.meetingrequest
    ADD CONSTRAINT fk_meetingrequest_user FOREIGN KEY (politician_id) REFERENCES public.politician(politician_id) ON UPDATE CASCADE ON DELETE CASCADE;
 O   ALTER TABLE ONLY public.meetingrequest DROP CONSTRAINT fk_meetingrequest_user;
       public          postgres    false    202    212    2969            �           2606    50110    moderator fk_moderator_user    FK CONSTRAINT     �   ALTER TABLE ONLY public.moderator
    ADD CONSTRAINT fk_moderator_user FOREIGN KEY (userid) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 E   ALTER TABLE ONLY public.moderator DROP CONSTRAINT fk_moderator_user;
       public          postgres    false    216    198    2965            �           2606    58370    rejected_requests fk_request    FK CONSTRAINT     �   ALTER TABLE ONLY public.rejected_requests
    ADD CONSTRAINT fk_request FOREIGN KEY (request_id) REFERENCES public.fundraisingrequests(requestid) ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.rejected_requests DROP CONSTRAINT fk_request;
       public          postgres    false    210    2977    225            �           2606    50250    bank_transfers fk_user    FK CONSTRAINT     z   ALTER TABLE ONLY public.bank_transfers
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 @   ALTER TABLE ONLY public.bank_transfers DROP CONSTRAINT fk_user;
       public          postgres    false    2965    198    221            �           2606    58387    approved_requests fk_user    FK CONSTRAINT     |   ALTER TABLE ONLY public.approved_requests
    ADD CONSTRAINT fk_user FOREIGN KEY (userid) REFERENCES public.users(user_id);
 C   ALTER TABLE ONLY public.approved_requests DROP CONSTRAINT fk_user;
       public          postgres    false    2965    219    198            �           2606    58488    rejected_requests fk_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.rejected_requests
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 F   ALTER TABLE ONLY public.rejected_requests DROP CONSTRAINT fk_user_id;
       public          postgres    false    198    225    2965            �           2606    74945 #   meetings meetings_politicianid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.meetings
    ADD CONSTRAINT meetings_politicianid_fkey FOREIGN KEY (politicianid) REFERENCES public.politician(politician_id);
 M   ALTER TABLE ONLY public.meetings DROP CONSTRAINT meetings_politicianid_fkey;
       public          postgres    false    2969    238    202            �           2606    74955 (   meetingusers meetingusers_meetingid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.meetingusers
    ADD CONSTRAINT meetingusers_meetingid_fkey FOREIGN KEY (meetingid) REFERENCES public.meetings(meetingid) ON UPDATE CASCADE ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.meetingusers DROP CONSTRAINT meetingusers_meetingid_fkey;
       public          postgres    false    239    238    3003            �           2606    74960 %   meetingusers meetingusers_userid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.meetingusers
    ADD CONSTRAINT meetingusers_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 O   ALTER TABLE ONLY public.meetingusers DROP CONSTRAINT meetingusers_userid_fkey;
       public          postgres    false    239    2965    198            �           2606    74971 .   meetingwishlist meetingwishlist_meetingid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.meetingwishlist
    ADD CONSTRAINT meetingwishlist_meetingid_fkey FOREIGN KEY (meetingid) REFERENCES public.meetings(meetingid) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.meetingwishlist DROP CONSTRAINT meetingwishlist_meetingid_fkey;
       public          postgres    false    238    240    3003            �           2606    74976 +   meetingwishlist meetingwishlist_userid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.meetingwishlist
    ADD CONSTRAINT meetingwishlist_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(user_id) ON DELETE CASCADE;
 U   ALTER TABLE ONLY public.meetingwishlist DROP CONSTRAINT meetingwishlist_userid_fkey;
       public          postgres    false    240    2965    198            �           2606    24896 *   politicalparty politicalparty_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.politicalparty
    ADD CONSTRAINT politicalparty_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.politicalparty DROP CONSTRAINT politicalparty_user_id_fkey;
       public          postgres    false    200    198    2965            �           2606    75017 6   politician_images politician_images_politician_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.politician_images
    ADD CONSTRAINT politician_images_politician_id_fkey FOREIGN KEY (politician_id) REFERENCES public.politician(politician_id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.politician_images DROP CONSTRAINT politician_images_politician_id_fkey;
       public          postgres    false    2969    202    246            �           2606    24916 -   politician politician_political_party_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.politician
    ADD CONSTRAINT politician_political_party_id_fkey FOREIGN KEY (political_party_id) REFERENCES public.politicalparty(political_party_id) ON DELETE SET NULL;
 W   ALTER TABLE ONLY public.politician DROP CONSTRAINT politician_political_party_id_fkey;
       public          postgres    false    2967    202    200            �           2606    24911 "   politician politician_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.politician
    ADD CONSTRAINT politician_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 L   ALTER TABLE ONLY public.politician DROP CONSTRAINT politician_user_id_fkey;
       public          postgres    false    2965    198    202            �           2606    75034 6   politicianprofile politicianprofile_politician_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.politicianprofile
    ADD CONSTRAINT politicianprofile_politician_id_fkey FOREIGN KEY (politician_id) REFERENCES public.politician(politician_id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.politicianprofile DROP CONSTRAINT politicianprofile_politician_id_fkey;
       public          postgres    false    248    202    2969            �           2606    75048     response response_answer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.response
    ADD CONSTRAINT response_answer_id_fkey FOREIGN KEY (answer_id) REFERENCES public.answer(answer_id);
 J   ALTER TABLE ONLY public.response DROP CONSTRAINT response_answer_id_fkey;
       public          postgres    false    3001    250    236            �           2606    75053 "   response response_question_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.response
    ADD CONSTRAINT response_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.question(question_id);
 L   ALTER TABLE ONLY public.response DROP CONSTRAINT response_question_id_fkey;
       public          postgres    false    250    2999    234            �           2606    75058    response response_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.response
    ADD CONSTRAINT response_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 H   ALTER TABLE ONLY public.response DROP CONSTRAINT response_user_id_fkey;
       public          postgres    false    2965    250    198            �           2606    41936 +   survey_requests survey_requests_userid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.survey_requests
    ADD CONSTRAINT survey_requests_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(user_id);
 U   ALTER TABLE ONLY public.survey_requests DROP CONSTRAINT survey_requests_userid_fkey;
       public          postgres    false    2965    198    218            ~   %   x�3�����Sp�O��5376524�420����� g��      t   �   x�e�1r!�Z{
`k���i����&_?��=I��y�| �@0��6��2�C?������8���\��d�ؔknyƮ��������QC��2����4P�،
���*�!��>Q�6K�J�Q�6k�fS��H-�R�̮���ۓ��5���R�)i��ѯ������d�ي�'J��<��D��$Y&�e��WBżg$�6I�����_Q�6���z��0�R�w9c�$�;.��/�e�      �      x������ � �      �   �  x��V�o�6�Y�+� - f�~���+�6H���t�K�FR�ӡ������qjt@$vD��w���[�r+[1'Ȧ�HS13��&F�)��*�sŸ2kE��n�F*CVR-t)M�(H�H�KސFɹb�&�T2g��cJJ���"��p)ȊWƨbJ�ɜqA*`�n����P�F�3^�����R���1W$�u�
nn)y]7r�.kC� @�1�6ׂ�f��G�M�Q��i����9g���P�uڦ����
����t�y��;�aKVȜ�0���&^Fn��Q�m�����G^F�x�E�(���8�f�d����_9���Q�|Fԟ�(�{ ñ@�e�n�
u@��x�a�.X5�[��K�(�c�4I�$�iS̜�[x~H�p�yc7���8�Ֆ�弸������Wv���΅�TX���P�%/ZVi[P9#9S�U�6L�����
���H7YYr�V�f���+BXn0����j������yi,o��Hd����=B�砻p�7�n	�	��Q��!���e[=;��:��iX�.)^[�y���MCa��Q�ƉGi�J�AkڥօEf�ԝL������|7���4� ���i|�p�{�_��^3l�4L�9 �IO�0s��uCj��^Stki�;M�G��Ɓ;v#�f�!���0<?�E�Џ�$N��E��ӻk���i���ij�88�FQ�8�K%o 7�l��T6�?H"wz��C��8�ih��w�F��O�B�W|�=3�~v<ǤU��qiL3>�Nu+(�r~��5�9�~n鮏ɣ���Z4�6 �1ʺ�Ʋ=���G`ox��=~���\�?-�cl���l��qX���TJ�K΂w5�é�B6�)�\i����u��z��7�_k1X��U䧗L�����<�9��ON�6=�_[n'B�����	X��n�K;�N��.��N{HC|FN�{ڦ|rJ͓�)��Ǐɰ���{�s��s48Nj�>KVqlz��؂t��e;<_�ؔF�%� 0�����Pl]�g��Ӣ۞�@�M��T��nfM�89~r�P�̶�w���_�VM�i�����>w�.9?߬�ZBES�\V8�5`��UUq�3ޙ�k����W��ƙ�e;�dw!6W{d~�$��˷;W{?d�q��;��w����.���W�O�+"��'�ݻb���β'\Q����nvH��Kv�|��q*,z����y(������I�J��Ǣ3�-j���m�X���"bőӽ_S2���X�ic�B/�U�j�X��0>J�/ Pz����czc65n'�Q�,�Y��b��q��J�́��;1�\���2�H;�'����iގ�@\;��aJヴ����7����\���~H��n�I�s��]��>��|�4���(G������?�S 2      �   �   x����JAE�g��?Иd�f'��|.HE����w������s.7��&UM��Ĝ����5�.��������|=���1�M��r�jٰ���B^k:<�#��t"ZF�)p��p�� �4��`^Q2�f�u��9 YmK8<X��4x6�.E&8�9|�4������^���n#�����n��(���e+��_7X0;�%����5*�|�|���7�I��      �      x������ � �      x   J  x����r�0����d2IH:v����^z�%�5Q�l.�����N�nȸn��ϫoW��@�e"3�X_]�\xD������q싯�-�},|�
���U��l����Mpy����M��5<�S��0�\����� �,�$�%�)��(,iowѠR੐*�*l����T�L_C᫈�����4(D��iJO@j�	mF0�l2���G�3�m2��L��E��PRV�����&GX���־�'�˺Z�S#NF�����54/�y�f�?�$i��׶�s[.���,f��Ѫ�b�E�.�f�u��;��o��6X�ZJ��$�U\���f�L�� `C5Pa���42v�8Z����+5I�+/�T`����B�-���%4v�bܩ�bj���9Q�m���Xt���qZI����3b�,��;f<�p�o�ߋ��
��<���~ҽ�mH9�>���[�#�("p�����U�q��S���9��}�>��k������l���7�����A˝��@��a��u��?��MƮn��x������e��+|�"���45�~�;��~��o�����}�_�Vt�rO      �   �  x�u�Oo�0��짘*���7��R[�V���z�ŁO6���wخ6a��\����yoT��\fEYf���{F�K�g!�G��<'K�ڈ��w
�SA	8
�Y��',�=!�i�֟���#D�ɒA��'��Y�G�� �����:6D���w_M=#����b�X��սT�7m�oe!d-���eBH�N�Kc2{�/�,Ms�/�F��n�}�*�WjVW�#��k��b˩�o��-�d�E���F���=�JQ=T[4��q0�>�ޟ'���6'�i����D?q��>�s���	�3�Y?��vx�or��`�3M�ߟU��y����4R��в���h tƹ	BL�����s�{	!6-�g]7�޴�W�v�����      z   (  x����j�0E��W�ĵ^��uL	�i�Y�"#��-��}em��f�+]!��0b�$,a�^']���g�3\�<�ŕ��r�C��:� ȰI�F�F��X���6%8���}(lHxgq��4!��EkK�h�iuӅ^�rm������&R�}��\7��	���t�]�$7��0	t�Q�q�'n�Ƣ�(c��x���~�4�Y[�l�P��J}�,��VH���BH7���S~���K�_���p'(�τ�Y�j�Z�B*�T�E�r8�%��ƽϟ�s����(�>14�#      |   I   x�3���ζ�����,..���a rO�L�SpK-�K�K��4202�50�52�40�21�20���j�b���� �f      �      x������ � �      �      x������ � �      �      x������ � �      �   &   x�3��J�K��,���532�024�420����� zv�      �      x������ � �      �   �   x���Mn�0F��� h�챽s�8	(��R��Z]�AY?�ӛ����S{:�	; wt�8����Ƕ0�p0dk���BDIU�������U�nj�GbA�����%�����Cړz�Ա@P���%=F�HX�����pzj�ޏ�� X��qEOQd��ۇ{zbC)t���Y�kz����oC#�8�kOA�����0/��E�Y}wIޟT��v(�^i4x�^J=}�?���>����      �      x������ � �      p   �   x��ͱ�@�z��-5!�@(���hCaC���r�^���3���nl;�O£�Zjц��Bx�^�*�����.�-5K���i��t�o��%���H��L��luP�
�jCEPC�=H 1��ُ7��)$ي|���%e��(��M����U��ֲ/      r   K  x�͖Io�0�����C���")ZhQ �^r��c���h��߱�"�l-AR��7������>7�ˑ��/����������B����u��.2`�0K1[�TBd"cc�_m
�~klV�,s��x�v�>��j�:�7h�	�aM�� i()��8���u[���>D%bV�����e�M���IT02��-��융�Mh5�æ�kIϱ$���7�kd�󀒉�a�E�#0�͢Qt)�GZ��4M{�[(�����/S,ʪ��ƪ>l�ǡaY۵���妈<Ec���`��q�;���*���N/it����$Qf��.$����B� �c�?�z�$E6<�j��j�� 
��R���c�m�lx�HΞ���[�8���Q���^��i	�f����`1u�6/�nvp�PZ��M� ���*�)�&��������'&6��s<Q���?�D��b|�q�5�1���P�K�
�|L��#�I��NhT�'$��p�[�f@�����x��C~�	��脞�R�Q��U� ��`�9R��;Zz/��IU��#N�f���9T�(O��)���q�X,� ̎       �      x������ � �      �      x������ � �      v     x�Տ�N�0���)N���v�1BHP�ntq��q��lS��I*!Q� �⳾���U������3��1�:ٷ<��oNЄa�ަ34�'�`=<ژ�6	$���F��D����h���:7?>mk���P[o}z�>���w�z��BƩ��dS�J"���l];!��O9e4�rAł`K%�✬�(�Fg G�E]�m���8��dU�_%%�Zѥ���u������[S\4���;��`T���k�����D��|�{�]?�-e�U��W���)��!���      �      x������ � �      �   �   x���=� �N�d wQ�V�L�$��XX��>j��a|3����iM���\�)�i��;D	���L!�����k��-�1ڙ5έc�Y��u|P]\R� r	UJ-/�(8�Sju�o���Ȱ���gԼ)����G�]\�����,�,�D.tB�sJ���x�      �      x������ � �      �      x������ � �      �      x������ � �      �     x���MN1F��)z jş���lٴЮ`��PO�vFj�H��$Ҽ�����RN��k9�L�9�n�x�~�8BR-,]��~�3��U�t��a½;ق-2ؕ|E��dT������M�6���=�;&���ޔ�m!�� �+z�$��k������B=�I���fꃛ��Wz��Z��Vܹ�������77��yrm�3l@H�.�[kM�{�#�x6���i�̧OB��l�l��/��A� ����/ΎշwF>Y���m�3�      n   c  x��[YR�~n���K:���������"��x�&��V�#�ɁTaHR��;�άF�l�����y�=>n�qKBб��z{�ۻ6���r'I���w��m��cC��I_���nmhmBK�V����|�� ��lꏚ� �W� _�n�_+�&j�� ��A���,ݐ�
A��)��m����g!� ���8� ���P��&�f�����������Q%�K��Z�<[Ϝi�V͍&�ɵ4k�Z���Q7�usZsB��R����37���Q���'���'�ڸ���
���y�F���\� �V��a%�h���]��F�b3�dB�V�NR�`S�Sr	.�Θ$|��� 0TT֋>���?�bm�Z�6��fw�9��}9~������RT�w���Hxύ�kQ��$�J�cj��a�VX�ʒR��=�HZ�gt+3S�۷oS�xw������)�Z��ve_��)�n�6���^��B���tNh]����һ�4�4��+Fz�b��L�AÇm���.^��F��^[���5� z�����K'�A����2�൷�<Y
�w���u��'터�0�ǜ��mL6��]��KQ����ڶB"թ��)�wioP*�B����v%��C��?A����k�VP	�fp~p PDH.8��ջ���X�ɯ�F)�%ˍ�u�� Hy0�����;�3!.X�р��e�ҧ�\�7p��|[��ҫW��F������v�2ڔ�N��T@r.V��7+���>��d]���N��dص� Z����Ԧc����b�WM�'�G�Z5U�!�J_2%D3�t��A>�.��'�E�VJ�z��tRzJ�t���eU�A_���V4�	~���
2*��I�GNq�= * lQ��E]悛 ̸V��#;��L�f� ��q�_
��sH����_���P(Ă��X�5���& صt����ȋ��= ��܀n͙�y�}+
��w�~ӏo�,`���58t���O��`�7p7ꤡ�$�#�����DW�	���Fu�$�i�9^�;oZ+ɢxR+5nKN��; 08>)�R�����߁�>t�b�m����dXa`��6 b��H�a~L)h/�h�!Z�p�=�s�L�T�6�|�c�NHw��j�4��lW�'*���H�%�9O�X��S�hwǇ�q{ߜNS�s����^���~�z�~L�Kjn�H�?��f@�34����&]{n`���y�^$�wc�0�ʝ]��+�����c�	���?��Y�_��*�����,8:7x0��i�wn8�>���&/��g �p���BE�#z��'%��C�X(aah��n{	)m�dY�ˏz��E�y�"^����}��"�"���!n��o��� ٵ�ܨind=����q�j�Z��9�7��O�-KbXeZB_)����z'�F9�<�͏��������xp�L��9���, k�����(�w�H�'Mr�"ޏ�[c������\���5lߥ�ُ{�y)%�>G��D�2�k�$7㧋i�r]��Z
�̅�ҍ�nO�O��}�ݜ� (�D)Z��V���%�Zbȴ�guސN��jnPN�Dࠠ<����Ė�$7�M�T�T?�j��n!nϔ�����~"�Jd aa%^2���A�I�ؾ��<�55L����3���(�84����~�_����>%M7�4�V���`:���A[��ճe5-�f��u�l-NS�O3Os�_
ϋz>�����B~�����j_ƶU������nf���B�k�%���|>���b�o'1�GR"td{]�:��΢YKE���΃��I䞺?L�nM8o�3�fI��hI�1���ɖb��Y��t
�������5�w�'�T6����@��S+6���q��ak�|�)i{gst1@諄�9�z2J��+IE���ZdD�aa�=�h��u�r��Q���s?�O�/��(i]OS�`�7�6,�a>AS�!t^�:qA�9��z5S%����~�)�p�ֈY4�FN:���J��	i:U���R/(�Ud�˅��9f�K4Y2ً�����π?�&�w௚���X��8�]I}�f$��VqG�����%	��p2(�S��1F��C=�ޔ�D��S=:�CR�/j�����p�-g^؏���P�y�U�;g���n��d<��P��10Ǡ����w��a�<m>�/qצ�b�!n��!]�������a˅f�mJ����J���ps"�
zd�]ʛݾ����r�K�u<y��6ۻO���K<�*�H�Ԝx�|��\gٟ�̽j�n��}��Oh��^��vF9s�-7��4��������s8�em�8e��a��}�NQ��Gҿ�<���	_c����\|p�6a��kb�Qb@�)҇	��6+/����\���Y
VA�#�h-�w�|�Hz�R���Db��I� �U�6ɾ�J,)���hd�N</ȡ�#�SY�`��Tg|��'#f}
}.%�>����.�E�.t�,VT�.���*�^�K�����z�ky�{>O����]�v?�X4_��'��H�n���O�^���px��׮[�L1!���|�v��rAy�}��gp�Kr��]�������c����Ֆ�Ƙ��s�ˮ>y�%�{U�2i�
,�|h:]���׽��I�a.�z*���<xYt�$L����ux�KZ�b��cB�&�u��ȑ%�.�`��ɐHe>�c�ȋ�;��ΐ�L?�D
�!�f���pߕ�������Θ�L�D(�*�e~�����KL2
��G��O].��%e�+���i����5?��ϧ���cג��c5�[2�ix�W�x��/�M�3{��+�"��y��9'�14����zV�T��G��}�����CG�ee9��=C'|f��m��߶ǒ��ʚ���`/?�$Us����ǔ%߂�#���@�g���;�\�i�	z��"��}�\w�zf�?��2H��o�\5�6��/��¼-?���]�?l���C��[�����I*��(}�����-�kr&ɿw�����,�A���������6��ےc�2�\
(v�z�{�Uo:��}�2�aA"�O�-���4�n�ط�t���������>H     