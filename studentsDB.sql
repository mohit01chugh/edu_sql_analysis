PGDMP  -                    }            Students    16.4    16.4     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    26122    Students    DATABASE     �   CREATE DATABASE "Students" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE "Students";
                postgres    false            �            1255    26168    distributionstdt()    FUNCTION     8  CREATE FUNCTION public.distributionstdt() RETURNS TABLE(grade character varying, number_of_students bigint, per_students numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        ss.grade,  -- Explicitly qualify the grade column
        COUNT(*) AS number_of_students,
        (COUNT(*) * 100 / (SELECT COUNT(*) FROM student_student))::NUMERIC AS per_students
    FROM 
        student_student ss  -- Use alias ss
    GROUP BY 
        ss.grade  -- Explicitly qualify the grade column in GROUP BY
    ORDER BY 
        COUNT(*) DESC;
END;
$$;
 )   DROP FUNCTION public.distributionstdt();
       public          postgres    false            �            1255    26172    successquarter()    FUNCTION     i  CREATE FUNCTION public.successquarter() RETURNS TABLE(quarter character varying, number_of_students bigint, percentage_students numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    WITH sdtc_QuarterWise AS (
        SELECT 
            d.Quater AS quarter,
            COUNT(*) AS number_of_students
        FROM 
            student_student AS ss
        JOIN 
            date_date AS d ON ss.class_start_date = d.Date
        WHERE 
            d.year = 2017
        GROUP BY 
            d.Quater
    )
    SELECT 
        sdtc_QuarterWise.quarter,
        sdtc_QuarterWise.number_of_students,
        ROUND((sdtc_QuarterWise.number_of_students * 100.0) / (SELECT SUM(number_of_students) FROM sdtc_QuarterWise), 2)::NUMERIC AS percentage_students
    FROM 
        sdtc_QuarterWise
    ORDER BY 
        sdtc_QuarterWise.number_of_students DESC;
END;
$$;
 '   DROP FUNCTION public.successquarter();
       public          postgres    false            �            1255    26171    sucessquater()    FUNCTION     �  CREATE FUNCTION public.sucessquater() RETURNS TABLE(quarter character varying, number_of_students bigint, percentage_students numeric)
    LANGUAGE plpgsql
    AS $$
Begin
	With sdtc_QuaterWise As 
	(
	  Select d.Quarter, Count(*) as number_of_students
	  From student_student As ss
	  Join date_date As d 
	  on ss.class_start_date = d.date
	  Where d.year = 2017
	  Group by d.Quarter
	)
	
	Select Quarter, number_of_students,
	       ROUND((number_of_students * 100) / 
		   (Select SUM(number_of_students) From sdtc_QuaterWise),2)::NUMERIC 
		   as percentage_students
	From sdtc_QuaterWise
	Order by number_of_students desc;

END;
$$;
 %   DROP FUNCTION public.sucessquater();
       public          postgres    false            �            1255    26169    top5cities()    FUNCTION     �  CREATE FUNCTION public.top5cities() RETURNS TABLE(city character varying, state character varying, num_of_students bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
	Select c.city, c.state, Count(ss.student_id) As num_of_students
	From student_student As ss
	Join city_region as c 
	On ss.city_id = c.city_id
	Group by c.city, c.state
	Order by Count(ss.student_id) desc
	Limit 5;
END;
$$;
 #   DROP FUNCTION public.top5cities();
       public          postgres    false            �            1255    26173    topics()    FUNCTION     �   CREATE FUNCTION public.topics() RETURNS TABLE(grade character varying, number_of_topics bigint)
    LANGUAGE plpgsql
    AS $$
Begin
	Select 
			grade, 
			COUNT(DISTINCT Topic_id) As Number_of_Topics
	From topic_topic As t
	Group by grade;
END;
$$;
    DROP FUNCTION public.topics();
       public          postgres    false            �            1259    26126    city_region    TABLE     z   CREATE TABLE public.city_region (
    city_id integer,
    city character varying(20),
    state character varying(20)
);
    DROP TABLE public.city_region;
       public         heap    postgres    false            �            1259    26123 	   date_date    TABLE     �   CREATE TABLE public.date_date (
    date date,
    year integer,
    quarter character varying(20),
    month character varying(20)
);
    DROP TABLE public.date_date;
       public         heap    postgres    false            �            1259    26131    student_student    TABLE     �   CREATE TABLE public.student_student (
    student_id integer,
    teacher_id integer,
    student_name character varying(20),
    grade character varying(20),
    class_start_date date,
    city_id integer
);
 #   DROP TABLE public.student_student;
       public         heap    postgres    false            �            1259    26140    student_topic    TABLE     �   CREATE TABLE public.student_topic (
    student_id integer,
    topic_id integer,
    test_cleared boolean,
    percentage_mark bigint,
    test_date date
);
 !   DROP TABLE public.student_topic;
       public         heap    postgres    false            �            1259    26147    topic_topic    TABLE     �   CREATE TABLE public.topic_topic (
    topic_id integer,
    grade character varying(20),
    topic_name character varying(50)
);
    DROP TABLE public.topic_topic;
       public         heap    postgres    false            �          0    26126    city_region 
   TABLE DATA           ;   COPY public.city_region (city_id, city, state) FROM stdin;
    public          postgres    false    216   �       �          0    26123 	   date_date 
   TABLE DATA           ?   COPY public.date_date (date, year, quarter, month) FROM stdin;
    public          postgres    false    215   �       �          0    26131    student_student 
   TABLE DATA           q   COPY public.student_student (student_id, teacher_id, student_name, grade, class_start_date, city_id) FROM stdin;
    public          postgres    false    217   �!       �          0    26140    student_topic 
   TABLE DATA           g   COPY public.student_topic (student_id, topic_id, test_cleared, percentage_mark, test_date) FROM stdin;
    public          postgres    false    218   �&       �          0    26147    topic_topic 
   TABLE DATA           B   COPY public.topic_topic (topic_id, grade, topic_name) FROM stdin;
    public          postgres    false    219   I)       /           2606    26130 #   city_region city_region_city_id_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.city_region
    ADD CONSTRAINT city_region_city_id_key UNIQUE (city_id);
 M   ALTER TABLE ONLY public.city_region DROP CONSTRAINT city_region_city_id_key;
       public            postgres    false    216            1           2606    26151 $   topic_topic topic_topic_topic_id_key 
   CONSTRAINT     c   ALTER TABLE ONLY public.topic_topic
    ADD CONSTRAINT topic_topic_topic_id_key UNIQUE (topic_id);
 N   ALTER TABLE ONLY public.topic_topic DROP CONSTRAINT topic_topic_topic_id_key;
       public            postgres    false    219            �     x�5��n�0���S�&��E$R+�T�l�
Vq����_ǁ�%�ٙ]�$���~��W�N��$���8�-r�� �;n�(�,a+����g +8vl�B��1���[{*d��� 6���O�N���`���O�o��1�&�J�d'�&�R��<P)찹:�w6��=�
釸�O7+��Ō?ߣ��6��_{#�@P��!���6욹��@i/�ob�AY� [?e�>�;����@��c�>.����E�?�g�      �   �  x����n�0D��W�Xp��H9H���^Ch�I�X���5���i��o,�fv��k�v�~:��7�����㴡���`в�/
�v������^+����o�� J�����h0J��a��=�K ���׏EB���M܎�S��T>��y���3���>o�?��1ٰ[㬴�_�۱����������`��n~�{bN�]�³�ڤ�@q���
���N(
W�r�"��ٰ�j�Ȩ>F��(�Շ�"�P��`�]H�\!�r���Ɯ����	c��V��&0�i
~�@�yxO��tH�
���qH�[�R�1-��K�,ئ=��R�PVe ڈ��V�mDn��P����mX'mn�n��l#pzt�6��> ɋ6�	h��yKQ{Њ�jSQ�jFu�
��%�"�E��^{)Sw+F�\H^[��Zl�����6G��ζxO��y��M[z��+h�L�����q�P=Z����V�Pur���6�nDa]Hƿ�o6����G�      �     x����r�8����hG�D.��M��m���fgoX�Sk#KYv�}�	ȇ��8�_��@� �a�q�e޴*�ҿ_��қz,dq�w�D���;k~���e�nj�쵔MP�~�\�M�?�UU���;��'�S��� ���?k���dH&(B��[�+��$@ؔ`?��~�g@ [��H��E+ @�Nf  kN���nw��iZi" kA�W���� vUcAиQH����ٟ��Z4oﵬ����lV�1⽁�*��k@h�(&�Y)��e��'D	�~i�ҿmk��rb�Z�[;mWZ 6%�[��ֿ��N��h��mSֵ�,���F�19��c�2�n'j�FJ!�:,Z��7���{+[�i dJ˰h���M���~���~oכJ��%H����]λ��o��6��b�}��b�_��M �M�t$:��u�r�}�65x�����F�M	�1_
�3��
�͈w�����:� qs�=��bU�������U�&:�
�B�ʊQ(}�+}�Aԥ���� Q����XAٰ�e��2��9)fL1q�ؽ�1����<���ST]4h����)-:�`�=�E4q�q���3
{S°!�3��3S�\c|��K�
���}4	)��Y�g���	�*��Q�
�N�1��I�\���`��&�)�]Y���`��	E���e�L��)���y�@�R���E��4��u��$wZ�IN�||Q'��[�<�s9,j�â�X�5����v����	����ZN�ע+e����)ў�i{jyf����D;��yA��kڞ��Z�~��� �͊��ӊ	�Z�~{�`�V��Zq��}V���jŁ��[q`"Y1ʂ(`�OE%���9ME�f�S1ʁ0F����vx**m|B;<�6\+*)��<:�2�bO�a�bE��X�#V�!���V!� �SQI�\nVTb(Yv�M���nwR.z3� ��ҜF�m#k���6/���J��x�[s��lwpņ���¨�qo}oNcB��H�n�J�����V�(`�;Is��Q-��=ZJ>{�{PX8u�;u�ֺuJ���Jx39u�.�	�p���S����-<������u���)��w�<v�$�C���0�ݓ&�߇�G�T�ӯ����W��Z�)8ߋ��3.M�p������ف��f��<_ԟL�y�S�p��<�t�x�it�WFG�ﴠ�=	x���hz��$d}��׿����NC֗m�����d���_���&
��      �   I  x�e�K��0C��]z��_w�u�`JVH1�F���2������W/�gL?~b}����,�~_�%gi^�Xs����FTV��y�ؕ�,u^W鞝�����lg��V��,c^W�d��r~1�b��>�y�+'���,��ҿ�g���^��,e�3KFY�\FP�����+�Y��y�g?�(˚K��<K+gP������3e�/3gPF}�{��/�I�҃�ӗ�	�g��2s6e�K�N_�(KqV�=o���QT���l�00fEe���}0x�3ی<���#bGUY�GMY�xԐ���xT�xԅya���̻ɣ��<*��#z�w7�GIyd�ЗJg������}���|GC��6�n:}����G���#�g��GU���ea���#��>$�G�X�+��QWF���s}_�2�GM�R�O��!��<3�ؙ��.��b�C>sy���hUe�Gͳ��iUe���2�G�}��������Ȼ�C�(+Eaԗj`���<�P�}��u�t��QQFEe�Q+W_�>bF��L��ۣO_�o��Зޔ���YW�v���UC_Fd������TbФ      �   �   x�M��n� ���)�����F�!�"��E��T�~�k+�ٝow�9�g7U]'!$;���fԆ��2��������KMy&����$�կ[*{w7�����he�`�>�d}q��dU�Lk�k~�"-�*�)L4UH0��:Tl@�s�-ն�>TUo�.;�}��޷�'D%u���Ә�]�}$��*NmM��{�$o_VUŁ��~����[n     