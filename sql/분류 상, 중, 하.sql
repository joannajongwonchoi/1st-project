-- # ī�װ� ��, ��, �Ϸ� �ٽ� ������
--- # �з���� �÷� �߰�
alter table lcl2 add �з���� varchar2(50);
--��հ� ����
SELECT
(select avg(���űݾ�) from lcl2 where �з�='���Ƶ�'), 
(select avg(���űݾ�) from lcl2 where �з�='�ż���ǰ'), 
(select avg(���űݾ�) from lcl2 where �з�='������ǰ'), 
(select avg(���űݾ�) from lcl2 where �з�='�Ǿ�ǰ/�Ƿ���'),
(select avg(���űݾ�) from lcl2 where �з�='�ܽ�'),
(select avg(���űݾ�) from lcl2 where �з�='�ϻ��ǰ'), 
(select avg(���űݾ�) from lcl2 where �з�='�Ƿ�'),
(select avg(���űݾ�) from lcl2 where �з�='����/���׸���'),
(select avg(���űݾ�) from lcl2 where �з�='�м���ȭ'), 
(select avg(���űݾ�) from lcl2 where �з�='������/����'), 
(select avg(���űݾ�) from lcl2 where �з�='��ǰ'),  
(select avg(���űݾ�) from lcl2 where �з�='����������/����'), 
(select avg(���űݾ�) from lcl2 where �з�='����/��ȭ��ǰ') FROM DUAL; 

SELECT a.����ȣ, a.�з����, b.������, a.��, sum(a.���űݾ�) "�ѱ��ž�"
FROM LCL2 a 
JOIN ������ b ON a.����ȣ = b.����ȣ
where �з� = '�ż���ǰ'
GROUP BY a.����ȣ, a.�з����, b.������, a.��
ORDER BY a.����ȣ, a.�з����, b.������, a.��

update lcl2 set �з���� = '�Ƿ�_��' 
where �Һз��� =
any(select �Һз��� from lcl2 
where �з� = '�Ƿ�' group by �з����, �Һз��� 
having (sum(���űݾ�)/count(���űݾ�)) >= 212802);

update lcl2 set �з���� = '�Ƿ�_��' 
where �Һз��� =
any(select �Һз��� from lcl2 
where �з� = '�Ƿ�' group by �з����, �Һз��� 
having (sum(���űݾ�)/count(���űݾ�)) < 212802  and (sum(���űݾ�)/count(���űݾ�)) >= 141868);

update lcl2 set �з���� = '�Ƿ�_��' 
where �Һз��� =
any(select �Һз��� from lcl2 
where �з� = '�Ƿ�' group by �з����, �Һз��� 
having (sum(���űݾ�)/count(���űݾ�)) < 141868);

update lcl2 set �з���� = '�м���ȭ_��' 
where �Һз��� =
any(select �Һз��� from lcl2 
where �з� = '�м���ȭ' group by �з����, �Һз��� 
having (sum(���űݾ�)/count(���űݾ�)) >= 131170);

update lcl2 set �з���� = '�м���ȭ_��' 
where �Һз��� =
any(select �Һз��� from lcl2 
where �з� = '�м���ȭ' group by �з����, �Һз��� 
having (sum(���űݾ�)/count(���űݾ�)) < 131170  and (sum(���űݾ�)/count(���űݾ�)) >= 87447);

update lcl2 set �з���� = '�м���ȭ_��' 
where �Һз��� =
any(select �Һз��� from lcl2 
where �з� = '�м���ȭ' group by �з����, �Һз��� 
having (sum(���űݾ�)/count(���űݾ�)) < 87447);

update lcl2 set �з���� = '�ż���ǰ_��' 
where �Һз��� =
any(select �Һз��� from lcl2 
where �з� = '�ż���ǰ' group by �з����, �Һз��� 
having (sum(���űݾ�)/count(���űݾ�)) >= 10186);

update lcl2 set �з���� = '�ż���ǰ_��' 
where �Һз��� =
any(select �Һз��� from lcl2 
where �з� = '�ż���ǰ' group by �з����, �Һз��� 
having (sum(���űݾ�)/count(���űݾ�)) < 10186  and (sum(���űݾ�)/count(���űݾ�)) >= 6791);

update lcl2 set �з���� = '�ż���ǰ_��' 
where �Һз��� =
any(select �Һз��� from lcl2 
where �з� = '�ż���ǰ' group by �з����, �Һз��� 
having (sum(���űݾ�)/count(���űݾ�)) < 6791);

update lcl2 set �з���� = '�ϻ��ǰ_��' 
where �Һз��� =
any(select �Һз��� from lcl2 
where �з� = '�ϻ��ǰ' group by �з����, �Һз��� 
having (sum(���űݾ�)/count(���űݾ�)) >= 27271);

update lcl2 set �з���� = '�ϻ��ǰ_��' 
where �Һз��� =
any(select �Һз��� from lcl2 
where �з� = '�ϻ��ǰ' group by �з����, �Һз��� 
having (sum(���űݾ�)/count(���űݾ�)) < 27271  and (sum(���űݾ�)/count(���űݾ�)) >= 18180);

update lcl2 set �з���� = '�ϻ��ǰ_��' 
where �Һз��� =
any(select �Һз��� from lcl2 
where �з� = '�ϻ��ǰ' group by �з����, �Һз��� 
having (sum(���űݾ�)/count(���űݾ�)) < 18180);

commit;