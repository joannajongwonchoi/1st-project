--�м��� �ʿ��� ���̺� ����

--'CUSTDEMO, PRODCL, PURPROD ���̺� ��ġ��'
CREATE TABLE LCL2 AS
SELECT *
FROM
(SELECT ���ε�.����ȣ, ����.����, ����.���ɴ�, ���ε�.���޻�, ���ε�.���з���, ���ε�.�з�, ���ε�.�Һз���, ���ε�.��������, ���ε�.��, ���ε�.���Žð�, ���ε�.���űݾ�, ����.����,��.��
FROM LCL "���ε�"
LEFT OUTER JOIN CUSTDEMO "����"
ON ���ε�.����ȣ = ����.����ȣ
LEFT OUTER JOIN ��� "��"
ON ���ε�.���� = ��.���� AND ���ε�.�б�=��.�б�)
ORDER BY ����ȣ, ���޻�,��������;

-- ���� 2014�� ��� 2015�� ���� ������
CREATE TABLE �������������� AS
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

--- # ���ɺ� ���� ������'
CREATE TABLE ���ɺ����������� AS
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