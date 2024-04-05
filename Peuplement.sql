-- MONTBULEAU--GENTELET Titouan / DEBRY Lou-anne / DELSOL Emma

-- PEUPLEMENT

-- TABLE PATIENT

create or replace procedure Peuplement(n in number) deterministic as
    VNom varchar2(1024);
    VPrenom varchar2(1024);
    VAge number;
    VSexe number;
    VTaille number;
    VPoids number;
    VMeno number;
    VSexeBis number;
    VMenoBis number;
    VSousGroupe number;
begin
    for i in 1..n loop
    VNom:=DBMS_Random.String('U', 10);
    VPrenom:=DBMS_Random.String('U', 1) || DBMS_Random.String('l',7);
    VTaille:=round(170+20*DBMS_Random.normal());
    VPoids:=round(75+20*DBMS_Random.normal());
    VAge:=round(40+20*DBMS_Random.normal())*(365+1/4);
    VAge:=round(VAge/(365+1/4));
    if VAge<18 OR VAge>65 then
        VAge:=18+(65-18)*DBMS_Random.value();
    end if;
    if VPoids<13 then
        VPoids:=13+(250-12)*DBMS_Random.value();
    end if;
    if VTaille<55 OR VTaille>250 then
        VAge:=55+(250-55)*DBMS_Random.value();
    end if;
    VAge:=TRUNC(VAge);
    VSexe:=ROUND(DBMS_Random.value());
    if VSexe=0 then
        VMeno:=ROUND(DBMS_Random.value());
    else
        VMeno:=0;
    end if;
    VSousGroupe:=round(DBMS_Random.value(1,3));
        INSERT into Patient values(
        null,
        null,
        VNom,
        VPrenom,
        VAge,
        VSexe,
        VTaille,
        VPoids,
        sysdate,
        null,
        null,
        VMeno,
        null,
        VSousGroupe,
        null,
        null
        );
        -- On ne garde que les patients avec un IMC < 30
        DELETE FROM Patient WHERE IMCP IS null;
    end loop;
end;
/
call Peuplement(10000);
commit;






