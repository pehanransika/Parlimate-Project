PGDMP  .                    }            parlimatedatabase    17.2    17.2     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            �           1262    16743    parlimatedatabase    DATABASE     �   CREATE DATABASE parlimatedatabase WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
 !   DROP DATABASE parlimatedatabase;
                     postgres    false                       1259    74697    answer    TABLE     �   CREATE TABLE public.answer (
    answer_id integer NOT NULL,
    answer text NOT NULL,
    answer_number integer NOT NULL,
    image_url character varying(255),
    question_id integer NOT NULL,
    number_of_votes integer
);
    DROP TABLE public.answer;
       public         heap r       postgres    false                       1259    74696    answer_answer_id_seq    SEQUENCE     �   CREATE SEQUENCE public.answer_answer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.answer_answer_id_seq;
       public               postgres    false    270            �           0    0    answer_answer_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.answer_answer_id_seq OWNED BY public.answer.answer_id;
          public               postgres    false    269            #           2604    74700    answer answer_id    DEFAULT     t   ALTER TABLE ONLY public.answer ALTER COLUMN answer_id SET DEFAULT nextval('public.answer_answer_id_seq'::regclass);
 ?   ALTER TABLE public.answer ALTER COLUMN answer_id DROP DEFAULT;
       public               postgres    false    269    270    270            �          0    74697    answer 
   TABLE DATA           k   COPY public.answer (answer_id, answer, answer_number, image_url, question_id, number_of_votes) FROM stdin;
    public               postgres    false    270   )       �           0    0    answer_answer_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.answer_answer_id_seq', 32, true);
          public               postgres    false    269            %           2606    74704    answer answer_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.answer
    ADD CONSTRAINT answer_pkey PRIMARY KEY (answer_id);
 <   ALTER TABLE ONLY public.answer DROP CONSTRAINT answer_pkey;
       public                 postgres    false    270            &           2606    74705    answer answer_question_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.answer
    ADD CONSTRAINT answer_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.question(question_id);
 H   ALTER TABLE ONLY public.answer DROP CONSTRAINT answer_question_id_fkey;
       public               postgres    false    270            �   �   x����j�0���S�lvW?��[/��r��	�;���+ɸ�҃.��͊Y$��3N
�7�JT�H�~D��J�E�f��,�^�v���IVd�z�87�1^���Vd�n�)���_�0���g���>�c�Ʊz��tM�
�
uC��>-�G(</+��}Pʜ�͖W������Ńe3��*���c0�z�Z���s�J�j��6�D.m[�2�t��?����O���~�x��G��rl���%��     