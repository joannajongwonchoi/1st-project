'RFM �м��� ���� ���� �湮 ��¥ ���ϱ�'

-- # RFM �м��� ���� ���� �湮 ��¥ ���ϱ�
--SELECT *
--FROM
--(SELECT ����ȣ, ��������, SUM(���űݾ�), ROW_NUMBER() over(partition by ����ȣ order by �������� desc) "����" 
--FROM LCL GROUP BY ����ȣ, ��������)
--WHERE ���� = '1';

--- # ���޻� ��
SELECT ����ȣ, ���޻�, TO_DATE(20151231)-MAX(TO_DATE(��������)) "Recency", COUNT(���űݾ�) "Frequency"
FROM LCL
GROUP BY ����ȣ, ���޻�, �б�
ORDER BY ����ȣ;

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

--- # 2014�� ���� RFM �迭�� ��ü
SELECT ����ȣ, TO_DATE(20141231)-MAX(TO_DATE(��������)) "Recency", COUNT(���űݾ�) "Frequency", SUM(���űݾ�) "Monetary"
FROM LCL
WHERE ���� = 2014
GROUP BY ����ȣ
ORDER BY ����ȣ;

--- # 2015�� ���� RFM �迭�� ��ü
SELECT ����ȣ, TO_DATE(20151231)-MAX(TO_DATE(��������)) "Recency", COUNT(���űݾ�) "Frequency", SUM(���űݾ�) "Monetary"
FROM LCL
WHERE ���� = 2015
GROUP BY ����ȣ
ORDER BY ����ȣ;