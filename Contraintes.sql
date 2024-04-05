-- MONTBULEAU--GENTELET Titouan / DEBRY Lou-anne / DELSOL Emma

-- CONTRAINTES

-- TABLE ACTE_MEDICAL

-- Séquence id acte médical

drop sequence S17;
create sequence S17 start with 1 increment by 1;

drop trigger idactemed;
create or replace trigger idactemed before insert on ACTE_MEDICAL for each row
begin
    select S17.nextval into :new.ACTEMEDID from dual;
end;
/

-- TABLE ANALYSE_SANG

drop sequence S18;
create sequence S18 start with 1 increment by 1;

drop trigger idanalysesang;
create or replace trigger id before insert on ANALYSE_DE_SANG for each row
begin
    select S18.nextval into :new.ANALYSESANGID from dual;
end;
/

-- TABLE ARC

-- Séquence id arc

drop sequence S16;
create sequence S16 start with 1 increment by 1;

drop trigger idarc;
create or replace trigger idarc before insert on ARC for each row
begin
    select S16.nextval into :new.ARCID from dual;
end;
/

-- TABLE CARNET_DE_SANTE

-- Séquence id carnet de sante

drop sequence S15;
create sequence S15 start with 1 increment by 1;

drop trigger idcarnet;
create or replace trigger idcarnet before insert on CARNET_DE_SANTE for each row
begin
    select S15.nextval into :new.CARNETID from dual;
end;
/

-- TABLE CENTRE

-- Séquence id centre

drop sequence S14;
create sequence S14 start with 1 increment by 1;

drop trigger idcentre;
create or replace trigger idcentre before insert on CENTRE for each row
begin
    select S14.nextval into :new.CENTREID from dual;
end;
/

-- TABLE DATA_MANAGER

-- Séquence id data manager

drop sequence S13;
create sequence S13 start with 1 increment by 1;

drop trigger iddata;
create or replace trigger iddatabefore insert on DATA_MANAGER for each row
begin
    select S13.nextval into :new.DMID from dual;
end;
/

-- TABLE FICHE

-- Séquence id fiche

drop sequence S12;
create sequence S12 start with 1 increment by 1;

drop trigger idfiche;
create or replace trigger idfiche before insert on FICHE for each row
begin
    select S12.nextval into :new.FICHEID from dual;
end;
/

-- TABLE LOT

-- Séquence id lot

drop sequence S11;
create sequence S11 start with 1 increment by 1;

drop trigger idlot;
create or replace trigger idlot before insert on LOT for each row
begin
    select S11.nextval into :new.LOTID from dual;
end;
/

-- TABLE PATIENT

-- Séquence id patient

drop sequence S1;
create sequence S1 start with 1 increment by 1;

drop trigger idpatient;
create or replace trigger idpatient before insert on Patient for each row
begin
    select S1.nextval into :new.PatientID from dual;
end;
/

-- Checks hors PowerAMC

alter table PATIENT
    add constraint PoidsPatient
    check(PoidsP>12);

-- Calcul IMC + "pré-tri"

drop trigger TriggerIMC;
create trigger TriggerIMC
before insert on Patient
for each row
declare CondIMC number;
begin
    if :new.TailleP is not null and :new.PoidsP is not null then
        CondIMC:=round(:new.PoidsP/(:new.TailleP/100*:new.TailleP/100));
        if CondIMC < 30 then
            :new.IMCP:=CondIMC; -- SEULS LES IMC<30 SONT DONC PRIS EN COMPTE
        end if;
    end if;
end;
/

-- TABLE PERSONNEL_MEDICAL

-- Séquence id personnel médical

drop sequence S10;
create sequence S10 start with 1 increment by 1;

drop trigger idpersonnelmedical;
create or replace trigger idpersonnelmedical before insert on PERSONNEL_MEDICAL for each row
begin
    select S10.nextval into :new.ADELI from dual;
end;
/

-- TABLE RESULTAT_TEST_EEG

-- Séquence id résultat test eeg

drop sequence S4;
create sequence S4 start with 1 increment by 1;

drop trigger idresultattesteeg;
create or replace trigger idtesultattesteeg before insert on RESULTAT_TEST_EEG for each row
begin
    select S4.nextval into :new.RESULTATTESTEEGID from dual;
end;
/

alter table RESULTAT_TEST_EEG
    add constraint ResultatEEG 
    check (RESULTATTESTEEG between 0 and 9);

-- TABLE RESULTAT_TEST_EFFORT

-- Séquence id résultat test effort

drop sequence S6;
create sequence S6 start with 1 increment by 1;

drop trigger idresultattesteffort;
create or replace trigger idtesultattesteffort before insert on RESULTAT_TEST_EFFORT for each row
begin
    select S6.nextval into :new.RESULTATTESTEFFORT from dual;
end;
/

-- TABLE RESULTATS_ANALYSE_SANG

-- Séquence id résultat analyse

drop sequence S2;
create sequence S2 start with 1 increment by 1;

drop trigger idresultatanalyse;
create or replace trigger idresultatanalyse before insert on RESULTATS_ANALYSE_SANG for each row
begin
    select S2.nextval into :new.RESULTATANALYSESANGID from dual;
end;
/

alter table RESULTATS_ANALYSE_SANG
    add constraint ResultatGlycémie
    check (GLYCEMIE between 0.7 and 1);

alter table RESULTATS_ANALYSE_SANG
    add constraint ResultatCholestérol
    check (CHOLESTEROL between 0 and 2);

alter table RESULTATS_ANALYSE_SANG
    add constraint ResultatPlaquette 
    check (PLAQUETTE between 150000 and 300000);

alter table RESULTATS_ANALYSE_SANG
    add constraint ResultatLeucocytes 
    check (LEUCOCYTE between 4000 and 11000);

alter table RESULTATS_ANALYSE_SANG
    add constraint ResultatHémoglobine
    check (HEMOGLOBINE between 120 and 180);

alter table RESULTATS_ANALYSE_SANG
    add constraint ResultatAlbumine 
    check (ALBUMINE between 39 and 50);

-- TABLE TEST_EEG

-- Séquence id test eeg

drop sequence S3;
create sequence S3 start with 1 increment by 1;

drop trigger idtesteeg;
create or replace trigger idtesteeg before insert on TEST_EEG for each row
begin
    select S3.nextval into :new.RESULTATANALYSESANGID from dual;
end;
/

drop trigger dateEEG;
create or replace trigger dateEEG before insert on Test_EEG for each row
begin
    if :new.DATETESTEEG>sysdate then
        raise_application_error(-20001, 'Date invalide');
    end if;
end;
/

-- TABLE TEST_EFFORT

-- Séquence id test effort 

drop sequence S5;
create sequence S5 start with 1 increment by 1;

drop trigger idtesteffort;
create or replace trigger idtesteffort before insert on TEST_EFFORT for each row
begin
    select S5.nextval into :new.TESTEFFORTID from dual;
end;
/

-- TABLE TEST_GRIPPE

-- Séquence id test grippe

drop sequence S7;
create sequence S7 start with 1 increment by 1;

drop trigger idtestgrippe;
create or replace trigger idtestgrippe before insert on TEST_GRIPPE for each row
begin
    select S7.nextval into :new.TESTGRIPPEID from dual;
end;
/

-- TABLE TEST_PCR_COVID

-- Séquence id test pcr covid

drop sequence S8;
create sequence S8 start with 1 increment by 1;

drop trigger idtestpcrcovid;
create or replace trigger idtestpcrcovid before insert on TEST_PCR_COVID for each row
begin
    select S8.nextval into :new.TESTPCRCOVIDID from dual;
end;
/

-- TABLE TRAITEMENT_CONCOMITTANT

-- Séquence id traitement concomittant

drop sequence S9;
create sequence S9 start with 1 increment by 1;

drop trigger idtraitementconcomittant;
create or replace trigger idtraitementconcomittant before insert on TRAITEMENT_CONCOMITTANT for each row
begin
    select S9.nextval into :new.TRAITCONCOID from dual;
end;
/
















