--������ �м�

-- # ���޻� �� ����
select YEAR ��, SUBSTR(��������, 5, 2) ��, ���޻�, TO_CHAR(sum(���űݾ�), '999,999,999,999,999') "�Ѹ����", TO_CHAR(round(AVG(���űݾ�)), '999,999') "��ձݾ�"
from purprod
WHERE ���޻� = 'C'
GROUP BY YEAR, SUBSTR(��������, 5, 2), ���޻�
ORDER BY YEAR, SUBSTR(��������, 5, 2), ���޻�;


-- ���尹�� : 593
select count(distinct �����ڵ�) from purprod;

--  ���� 50���� ����Ƚ�� �⵵ ���� ����Ʈ
SELECT YEAR, �����ڵ�,ROUND(SUM(���űݾ�)/1000) ���űݾ� ,count(���űݾ�) ����Ƚ�� 
FROM PURPROD P, CUSTDEMO C WHERE P.����ȣ=C.����ȣ
GROUP BY YEAR,�����ڵ�
ORDER BY ����Ƚ�� desc
FETCH FIRST 50 PERCENT ROWS ONLY;

-- # ���� ����� ���� ��Ȳ
SELECT ����ȣ, ����ʸ� FROM MEMBERSHIP
WHERE ����ȣ = ANY(SELECT ����ȣ FROM MEMBERSHIP GROUP BY ����ȣ HAVING COUNT(����ȣ) > 1);

-- ������ ���̴뿡 ���� �������� �Һ�ݾ�
select ��������, ����, ���ɴ�, count(c.����ȣ), sum(���űݾ�) from custdemo c,purprod p where c.����ȣ=p.����ȣ
group by ��������, ����, ���ɴ� order by ��������;

-- ���� ���� �̿��ϴ� ���޻�
select ���޻�,count(*) from channel group by ���޻�; 

-- ���������� ���� �湮Ƚ��
select distinct c.��������, �����ڵ�,count(�����ڵ�) from custdemo c,purprod p
where c.����ȣ=p.����ȣ group by c.��������,�����ڵ� order by count(�����ڵ�) desc,��������;

-- ���޻纰 ���� ����
select ���޻�,count(�����) from compet group by ���޻�;

-- ����ǰ
SELECT * FROM PRODCL WHERE �з� = any('������ǰ', '�ż���ǰ', '�ϻ��ǰ', '�Ǿ�ǰ/�Ƿ���', '����/��ȭ��ǰ', '�ܽ�', '��Ÿ');

-- # 2014, 2015, 2�� �ջ� ����, ������
--CREATE TABLE "�����������" AS
SELECT "2014 ���űݾ�" "2014", "2015 ���űݾ�" "2015", "2014 ���űݾ�" + "2015 ���űݾ�" "�հ�",
TO_CHAR(("2015 ���űݾ�"-"2014 ���űݾ�")/"2015 ���űݾ�"*100, '99.99') "������"
FROM 
(SELECT SUM(���űݾ�) "2014 ���űݾ�" FROM PURPROD WHERE ���� = 2014) a,
(SELECT SUM(���űݾ�) "2015 ���űݾ�" FROM PURPROD WHERE ���� = 2015) b;



-- # ���޻�, �⵵�� �Ѹ����
--CREATE TABLE "���޻纰�������Ѹ����" AS
SELECT ���޻�, ����, ����, SUM(���űݾ�) "�հ�" FROM PURPROD GROUP BY ���޻�,����,���� ORDER BY ���޻�,����;


-- # �� ���޻翡 �湮�� ���� ���ŰǼ�
--CREATE TABLE "��ȣ���޼��������Ǽ�����" AS
SELECT P.����ȣ, ���޻�, C.����, ����, COUNT(P.����ȣ) "���ŰǼ�", sum(���űݾ�) "�հ�"
FROM PURPROD P, CUSTDEMO C
WHERE P.����ȣ = C.����ȣ
GROUP BY P.����ȣ, ���޻�, C.����, ����
ORDER BY P.����ȣ, C.����;

-- # ����� �м�
SELECT a.����ȣ, a.���޻�, B.����, ���ɴ�, ��������, ������̿�Ƚ��, ����
FROM
(SELECT ����ȣ, ���޻�, COUNT(�����) "������̿�Ƚ��", SUBSTR(�̿���, 0, 4) "����" FROM COMPET
GROUP BY ����ȣ, ���޻�, SUBSTR(�̿���, 0, 4)
ORDER BY ����ȣ) a,
(SELECT * FROM ��ȣ���޼��������Ǽ�����
WHERE ���� = 2015) b,
CUSTDEMO C
WHERE a.����ȣ = b.����ȣ AND a.���޻� = b.���޻� AND a.����ȣ = c.����ȣ AND B.���� = C.����
ORDER BY a.����ȣ;

select * from compet
where �̿��� like '%2014%';

-- # ä�� �м�
SELECT a.����ȣ, �¶���, �̿�Ƚ��, sum(����) "����"
FROM CHANNEL a, ��ȣ���޼��������Ǽ����� b
WHERE a.����ȣ = b.����ȣ AND SUBSTR(�¶���, 1, 1) = b.���޻�
GROUP BY a.����ȣ, �¶���, �̿�Ƚ��
ORDER BY a.����ȣ, �¶���, �̿�Ƚ��;


-- # �ͺ� ���� �¶��� �̿�Ƚ��
select ����, sum(�̿�Ƚ��) �̿�Ƚ��
from custdemo a, channel b where a.����ȣ=b.����ȣ
group by ����;

-- # RFM �м��� ���� ���� �湮 ��¥ ���ϱ�
--SELECT *
--FROM
--(SELECT ����ȣ, ��������, SUM(���űݾ�), ROW_NUMBER() over(partition by ����ȣ order by �������� desc) "����" 
--FROM LCL GROUP BY ����ȣ, ��������)
--WHERE ���� = '1';

--- # �迭�� ��ü
SELECT ����ȣ, TO_DATE(20151231)-MAX(TO_DATE(��������)) "Recency", COUNT(���űݾ�) "Frequency", SUM(���űݾ�) "Monetary"
FROM LCL
GROUP BY ����ȣ
ORDER BY ����ȣ;

--- # ���޻� ��
SELECT ����ȣ, ���޻�, TO_DATE(20151231)-MAX(TO_DATE(��������)) "Recency", COUNT(���űݾ�) "Frequency", SUM(���űݾ�) "Monetary"
FROM LCL
GROUP BY ����ȣ, ���޻�
ORDER BY ����ȣ;


-- # ���ɴ뺰 �м�
--- # ���޻�, ����
SELECT ���޻�, ���ɴ�, COUNT(���ɴ�) "����", ROUND(avg(���űݾ�)) "��ձݾ�", SUM(���űݾ�) "�հ�" FROM LCL
GROUP BY ���޻�, ���ɴ�
ORDER BY ���޻�, ���ɴ�;

--- # ����, ����
SELECT ����, ���ɴ�, COUNT(���ɴ�) "����", ROUND(avg(���űݾ�)) "��ձݾ�", SUM(���űݾ�) "�հ�", ���� FROM LCL
GROUP BY ����, ���ɴ�, ����
ORDER BY ����, ���ɴ�, ����;


-- # �������� �м�
SELECT ��������, sum(����) "����", round(avg(��ձݾ�)) "��ձݾ�", sum(�հ�) "����"
FROM 
(SELECT ��������, ���ɴ�, COUNT(���ɴ�) "����", ROUND(avg(���űݾ�)) "��ձݾ�", SUM(���űݾ�) "�հ�", PERCENT_RANK() OVER (ORDER BY SUM(���űݾ�) DESC) "�ۼ�Ʈ" 
FROM LCL
GROUP BY ��������, ���ɴ�)
--WHERE �ۼ�Ʈ <= 0.1
GROUP BY ��������
order by ��ձݾ� desc;

-- # ���Ű��� ���� ��ǰ �� �ѱ��ž�
SELECT a.����ȣ, a.����, a.���ɴ�, a.����, a.���з���, a.�з�, b.������, a.��, sum(a.���űݾ�) "�ѱ��ž�"
FROM LCL2 a
JOIN ������ b ON a.����ȣ = b.����ȣ
WHERE ������ = '����'
GROUP BY a.����ȣ, a.����, a.���ɴ�, a.����, a.���з���, a.�з�, b.������, a.��
ORDER BY a.����ȣ, a.����, a.���ɴ�, a.����, a.���з���, a.�з�, b.������, a.��;


-- # ������ ����� ����
SELECT ����, �����1��, �����7�� 
FROM
(SELECT b.����, sum(a.�̿�ݾ�14_1) �����1��, sum(a.�̿�ݾ�15_3) �����7��
FROM ������ a, LCL2 b 
WHERE a.����ȣ = b.����ȣ 
GROUP BY b.����);


-- # �����, ä�� ���� �̿�Ƚ��
--- # ä��
SELECT ����ȣ, SUM(�̿�Ƚ��) FROM CHANNEL
GROUP BY ����ȣ
ORDER BY SUM(�̿�Ƚ��) DESC;

SELECT COUNT(DISTINCT ����ȣ) FROM CHANNEL;

SELECT ����ȣ, COUNT(����ȣ) FROM COMPET
GROUP BY ����ȣ
ORDER BY COUNT(����ȣ) DESC;

--- # �����
SELECT COUNT(COUNT(����ȣ)) FROM COMPET
GROUP BY ����ȣ
ORDER BY COUNT(����ȣ) DESC;

-- # �б⺰ ���޻� �Ѹ���� ������
select a.���޻�, a.����, a.�б�, a.�ѱ��ž�, b.����, b.�б�, b.�ѱ��ž�, round((b.�ѱ��ž�-a.�ѱ��ž�)/b.�ѱ��ž� * 100, 2) "������"
from
(SELECT ���޻�, ����, �б�, SUM(���űݾ�) "�ѱ��ž�" FROM LCL where ���� = 2014 GROUP BY ���޻�,����,�б� ORDER BY ���޻�, ����) a,
(SELECT ���޻�, ����, �б�, SUM(���űݾ�) "�ѱ��ž�" FROM LCL where ���� = 2015 GROUP BY ���޻�,����,�б� ORDER BY ���޻�, ����) b
where a.���޻� = b.���޻� and a.�б� = b.�б�;


-- # ������ �б⺰ ���޻� �Ѹ����
SELECT ���޻�, ����, �б�, SUM(���űݾ�) "�ѱ��ž�" 
FROM LCL a
join
�б���ذ� b on a.����ȣ = b.����ȣ
where ���� = 2014
GROUP BY ���޻�, ����, �б� 
ORDER BY ���޻�, ����;


-- # ������ �б⺰ ����, ī�װ�, �Ѹ����
SELECT ���޻�, ����, �б�, ����, ���з���, SUM(���űݾ�) "�ѱ��ž�" 
FROM LCL a
join
�б���ذ� b on a.����ȣ = b.����ȣ
where ���� = 2015
GROUP BY ���޻�, ����, �б�, ����, ���з���
ORDER BY ���޻�, ����, �б�, ���з���;
-- # ���� 2014�� ��� 2015�� ���� ������
--CREATE TABLE �������������� AS
SELECT C.����ȣ, C.����, NVL(A."2014", 0) "����2014", NVL(B."2015", 0) "����2015", ROUND((NVL("2015", 0)-NVL("2014", 0))/"2014"*100, 4) "������"
FROM
(SELECT ����ȣ, ���� FROM CUSTDEMO) C
FULL OUTER JOIN
(SELECT ����ȣ, ����, SUM(���űݾ�) "2015" FROM LCL
WHERE ���� = 2015
GROUP BY ����ȣ, ����
ORDER BY ����ȣ) B
ON C.����ȣ = B.����ȣ AND C.���� = B.����
FULL OUTER JOIN
(SELECT ����ȣ, ����, SUM(���űݾ�) "2014" FROM LCL
WHERE ���� = 2014
GROUP BY ����ȣ, ����
ORDER BY ����ȣ) A
ON A.����ȣ = C.����ȣ AND A.���� = C.����;

--- # 2015�� ��Ż��
SELECT * FROM ��������������
WHERE ����2015 = 0;




-- # ���ɺ� ���� ������
--CREATE TABLE ���ɺ����������� AS
SELECT A.����, A.���ɴ�, A."����" ����14, B."����" ����15, A.��ձݾ� "��ձݾ�14", B.��ձݾ� "��ձݾ�15", A."�հ�" "����14", B.�հ� "����15", ROUND((B.����-A.����)/A.����*100, 2) "����������", ROUND((B.�հ�-A.�հ�)/A.�հ�*100, 2) "����������"
FROM
(SELECT ����, ���ɴ�, COUNT(���ɴ�) "����", ROUND(avg(���űݾ�)) "��ձݾ�", SUM(���űݾ�) "�հ�" FROM LCL
WHERE ���� = 2014
GROUP BY ����, ���ɴ�
ORDER BY ����, ���ɴ�) A,
(SELECT ����, ���ɴ�, COUNT(���ɴ�) "����", ROUND(avg(���űݾ�)) "��ձݾ�", SUM(���űݾ�) "�հ�" FROM LCL
WHERE ���� = 2015
GROUP BY ����, ���ɴ�
ORDER BY ����, ���ɴ�) B
where A.���� = B.���� AND A.���ɴ� = B.���ɴ�;

SELECT * FROM ���ɺ�����������;

--- # �����ջ�, ���ɺ� ���� ������
SELECT a.*, round((b.����15-b.����14)/b.����14*100, 2) "����������", round((b.����15-b.����14)/b.����14*100, 2) "����������"
FROM
(SELECT ���ɴ�, SUM(����14) "����14", SUM(����15) "����15", AVG(��ձݾ�14) "��ձݾ�14", AVG(��ձݾ�15) "��ձݾ�15", SUM(����14) "����14", SUM(����15) "����15" FROM ���ɺ�����������
GROUP BY ���ɴ�
ORDER BY ���ɴ�) a,
(SELECT ���ɴ�, SUM(����14) "����14", SUM(����15) "����15", AVG(��ձݾ�14) "��ձݾ�14", AVG(��ձݾ�15) "��ձݾ�15", SUM(����14) "����14", SUM(����15) "����15" FROM ���ɺ�����������
GROUP BY ���ɴ�
ORDER BY ���ɴ�) b
where a.���ɴ� = b.���ɴ�;




-- # ���Ű��� ���� ��ǰ �� �ѱ��ž�
SELECT a.����ȣ, ����, ����, �б�, ���з���, �з�, ������, sum(���űݾ�) "�ѱ��ž�"
FROM LCL a
JOIN ������ b ON a.����ȣ = b.����ȣ
WHERE ������ = '����'
GROUP BY a.����ȣ, ����, ����, �б�, ���з���, �з�, ������
ORDER BY a.����ȣ, ����, �б�, ���з���, �з�;


SELECT ����, �б�, sum(���űݾ�) "�ѱ��ž�"
FROM LCL a
JOIN ������ b ON a.����ȣ = b.����ȣ
WHERE ������ = '����' and �б� = any('1�б�', '3�б�', '4�б�')
GROUP BY ����, �б�
ORDER BY ����, �б�;


-- # ���� 2014�� ��� 2015�� ���� ������
--CREATE TABLE �������������� AS
SELECT C.����ȣ, C.����, NVL(A."2014", 0) "����2014", NVL(B."2015", 0) "����2015", ROUND((NVL("2015", 0)-NVL("2014", 0))/"2014"*100, 4) "������"
FROM
(SELECT ����ȣ, ���� FROM CUSTDEMO) C
FULL OUTER JOIN
(SELECT ����ȣ, ����, SUM(���űݾ�) "2015" FROM LCL
WHERE ���� = 2015
GROUP BY ����ȣ, ����
ORDER BY ����ȣ) B
ON C.����ȣ = B.����ȣ AND C.���� = B.����
FULL OUTER JOIN
(SELECT ����ȣ, ����, SUM(���űݾ�) "2014" FROM LCL
WHERE ���� = 2014
GROUP BY ����ȣ, ����
ORDER BY ����ȣ) A
ON A.����ȣ = C.����ȣ AND A.���� = C.����;

--- # 2015�� ��Ż��
SELECT * FROM ��������������
WHERE ����2015 = 0;

-- 1�� ���� �ִ� �湮ȸ�� ����� ����
SELECT YEAR, �����ڵ�,ROUND(SUM(���űݾ�)/1000) ���űݾ� ,count(���űݾ�) ����Ƚ�� 
FROM PURPROD P, CUSTDEMO C WHERE P.����ȣ=C.����ȣ
GROUP BY YEAR,�����ڵ�
HAVING SUM(���űݾ�) > (SELECT AVG(���űݾ�) FROM PURPROD)
ORDER BY ����Ƚ�� desc;

-- # ���� ����� ���� ��Ȳ
SELECT ����ȣ, ����ʸ� FROM MEMBERSHIP
WHERE ����ȣ = ANY(SELECT ����ȣ FROM MEMBERSHIP GROUP BY ����ȣ HAVING COUNT(����ȣ) > 1);

--- # 2015�� ���Ű��� �� Ȯ���ϱ�
SELECT DISTINCT B.����ȣ, B.����, B.���޻�, B.���з���, COUNT(B.���з���) "����Ƚ��", B.�з�, B.����
FROM �������������� A, LCL B
WHERE 
A.����ȣ = B.����ȣ AND A.���� = B.����
AND ������ < 5.41
GROUP BY B.����ȣ, B.����, B.���޻�, B.���з���, B.�з�, B.����
ORDER BY ����ȣ, �з�;

-- # �б� ���� �� ������
--- # 8�б� ��� ������ ��
select ����ȣ
from
(SELECT ����ȣ, ����, �б�, count(����ȣ) "�б⺰����Ƚ��" FROM lcl
where �б� = any('1�б�', '2�б�', '3�б�', '4�б�')
group by ����ȣ, ����, �б�
order by ����ȣ)
group by ����ȣ
having count(����ȣ) = 8
order by ����ȣ;

--- # 8�б� ���� ��� ������ �� ��
select count(count(����ȣ))
from
(SELECT ����ȣ, ����, �б�, count(����ȣ) "�б⺰����Ƚ��" FROM lcl
where �б� = any('1�б�', '2�б�', '3�б�', '4�б�')
group by ����ȣ, ����, �б�
order by ����ȣ)
group by ����ȣ
having count(����ȣ) = 8
order by ����ȣ;


-- # �ݱ� ���� �� ������
--- # �ݱ� ���� ��� ������ �� ��
select ����ȣ
from
(select ����ȣ, count(����ȣ)
from
(SELECT ����ȣ, ���� FROM lcl
where �б� = any('1�б�', '2�б�')
group by ����ȣ, ����
order by ����ȣ)
group by ����ȣ
having count(����ȣ) = 2
intersect
select ����ȣ, count(����ȣ)
from
(SELECT ����ȣ, ���� FROM lcl
where �б� = any('3�б�', '4�б�')
group by ����ȣ, ����
order by ����ȣ)
group by ����ȣ
having count(����ȣ) = 2
order by ����ȣ);

--- # �ݱ� ���� ��� ������ �� ��
select count(*)
from
(select ����ȣ, count(����ȣ)
from
(SELECT ����ȣ, ���� FROM lcl
where �б� = any('1�б�', '2�б�')
group by ����ȣ, ����
order by ����ȣ)
group by ����ȣ
having count(����ȣ) = 2
intersect
select ����ȣ, count(����ȣ)
from
(SELECT ����ȣ, ���� FROM lcl
where �б� = any('3�б�', '4�б�')
group by ����ȣ, ����
order by ����ȣ)
group by ����ȣ
having count(����ȣ) = 2
order by ����ȣ);

-- # ������ 2014, 2015 ���� �ѱ��ž� ��
select *
from
(select sum(sum(���űݾ�)) "2014"
from �б���ذ� b
join LCL a on b.����ȣ = a.����ȣ
where ���� = 2014
group by b.����ȣ),
(select sum(sum(���űݾ�)) "2015"
from �б���ذ� b
join LCL a on b.����ȣ = a.����ȣ
where ���� = 2015
group by b.����ȣ);


--- # ������� ����ȣ
select ����ȣ from lcl
minus
select ����ȣ from �б���ذ�;


-- # ������, ��������� �߿䵵 ��
--- # ��������� 2014, 2015 �ջ� �ѱ��ž�
select sum(sum(���űݾ�))
from lcl a
join
(select ����ȣ from lcl
minus
select ����ȣ from �б���ذ�) b on a.����ȣ = b.����ȣ
group by a.����ȣ;

--- # �������� 2014, 2015 �ջ� �ѱ��ž�
select sum(sum(���űݾ�))
from lcl a
join �б���ذ� b on a.����ȣ = b.����ȣ
group by a.����ȣ;

--- # ��������� 2014, 2015 ��վ�
select avg(avg(���űݾ�))
from lcl a
join
(select ����ȣ from lcl
minus
select ����ȣ from �б���ذ�) b on a.����ȣ = b.����ȣ
group by a.����ȣ;

--- # �������� 2014, 2015 ��վ�
select avg(avg(���űݾ�))
from lcl a
join �б���ذ� b on a.����ȣ = b.����ȣ
group by a.����ȣ;

select a.����ȣ, ����, �б�, sum(���űݾ�) "�ѱ��űݾ�"
from lcl a
join �б���ذ� b on a.����ȣ = b.����ȣ
group by a.����ȣ, ����, �б�
order by a.����ȣ, ����, �б�;

select a.����ȣ, ����, �б�, sum(���űݾ�) "�ѱ��űݾ�"
from lcl a
join
(select ����ȣ from lcl
minus
select ����ȣ from �б���ذ�) b on a.����ȣ = b.����ȣ
group by a.����ȣ, ����, �б�
order by a.����ȣ, ����, �б�;

-- # �ű�, ����, ��Ż ��ձݾ�
--- # �������� ���� 0% ���� ���������� ������ ��ձ��ž�
SELECT round(sum(����2015)/count(*)) FROM ��������������
where ������ > 0;

--- # �������� ���� 5.14% ���� ���������� �������� ��ձ��ž�
SELECT round(sum(����2015)/count(*)) FROM ��������������
where ������ > 5.14;

--- # �������� �ű԰��� ��ձ��ž�
SELECT round(SUM(����2015)/count(*)) FROM ��������������
WHERE ����2014 = 0;

-- # �������� ��Ż���� ��ձ��ž�
SELECT round(SUM(����2014)/count(*)) FROM ��������������
WHERE ����2015 = 0;

-- # �б⸦ ����� �ٲ㼭 ���̺� ����
--create table ���
--(
--���� number,
--�б� varchar2(10),
--�� varchar2(10)
--);
--
--insert into ���(����,�б�,��) values(2014,'1�б�','1��');
--insert into ���(����,�б�,��) values(2014,'2�б�','2��');
--insert into ���(����,�б�,��) values(2014,'3�б�','3��');
--insert into ���(����,�б�,��) values(2014,'4�б�','4��');
--insert into ���(����,�б�,��) values(2015,'1�б�','5��');
--insert into ���(����,�б�,��) values(2015,'2�б�','6��');
--insert into ���(����,�б�,��) values(2015,'3�б�','7��');
--insert into ���(����,�б�,��) values(2015,'4�б�','8��');

select a.����ȣ, a.����, a.�б�, b.�� from lcl a
join
��� b on a.���� = b.���� and a.�б� =  b.�б�
where b.�б�='3�б�';



-- # ���Ű��� ���� ��ǰ �� �ѱ��ž�
SELECT a.����ȣ, a.����, a.���ɴ�, d.����, a.���з���, a.�з�, b.������, c.��, sum(a.���űݾ�) "�ѱ��ž�"
FROM LCL a
JOIN ������ b ON a.����ȣ = b.����ȣ
JOIN ��� c ON a.���� = c.���� AND a.�б� = c.�б�
JOIN CUSTDEMO d ON a.����ȣ = d.����ȣ AND a.���� = d.���� AND a.���ɴ� = d.���ɴ� AND a.�������� = d.��������
WHERE ������ = '����'
GROUP BY a.����ȣ, a.����, a.���ɴ�, d.����, a.���з���, a.�з�, b.������, c.��
ORDER BY a.����ȣ, a.����, a.���ɴ�, d.����, a.���з���, a.�з�, b.������, c.��;