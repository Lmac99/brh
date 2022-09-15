CREATE OR REPLACE PACKAGE pkg_projeto
AS
    PROCEDURE p_inserir_projeto(
        p_nome IN projeto.nome%TYPE, p_responsavel IN projeto.responsavel%TYPE
    );
    FUNCTION f_calcula_idade (
        p_data IN DATE
    )
    RETURN INTEGER;
    FUNCTION f_calcula_idade_valida (
        p_data IN DATE
    )
    RETURN INTEGER;
    FUNCTION f_finaliza_projeto(
        p_id_projeto IN projeto.id%TYPE
    )
    RETURN projeto.fim%TYPE;
    PROCEDURE p_inserir_projeto_validado(
        p_nome IN projeto.nome%TYPE, p_responsavel IN projeto.responsavel%TYPE
    );
END;

CREATE OR REPLACE PACKAGE BODY pkg_projeto
AS
    PROCEDURE p_inserir_projeto(
        p_nome IN projeto.nome%TYPE, p_responsavel IN projeto.responsavel%TYPE
    ) 
    IS
    BEGIN
        INSERT INTO projeto (nome, responsavel, inicio) values (p_nome, p_responsavel, sysdate);
    END;
    -- -----------------------
    FUNCTION f_calcula_idade (
        p_data IN DATE
    )
    RETURN INTEGER
    IS
    v_n INTEGER;
    BEGIN
        SELECT FLOOR(MONTHS_BETWEEN(SYSDATE, p_data)/12) INTO v_n FROM DUAL;
        RETURN v_n;
    END;
    -- --------------------
    FUNCTION f_calcula_idade_valida (
        p_data IN DATE
    )
    RETURN INTEGER
    IS
    v_n INTEGER;
    e_null EXCEPTION;
    BEGIN
        IF ((p_data > SYSDATE) OR (p_data IS NULL)) 
            THEN 
                RAISE e_null;
        ELSE 
            SELECT FLOOR(MONTHS_BETWEEN(SYSDATE, p_data)/12) INTO v_n FROM DUAL;
        END IF;
        RETURN v_n;
    EXCEPTION
        WHEN e_null THEN raise_application_error(-20100, 'DATA INVÁLIDA: '|| p_data);
    END;
    -- -----------------------------
    FUNCTION f_finaliza_projeto(
        p_id_projeto IN projeto.id%TYPE
    )
    RETURN projeto.fim%TYPE
    IS
    v_data_fim projeto.fim%TYPE;
    BEGIN
        BEGIN
            SELECT projeto.fim INTO v_data_fim FROM projeto WHERE projeto.id = p_id_projeto;
            EXCEPTION WHEN no_data_found THEN dbms_output.put_line('PROJETO NÃO REGISTRADO'); RETURN NULL;
        END;
        IF (v_data_fim IS NULL) 
            THEN 
                dbms_output.put_line('PROJETO SEM DATA PARA FINALIZAR');
        END IF;
        RETURN v_data_fim;
    END;
    -- ------------------------
    PROCEDURE p_inserir_projeto_validado(
        p_nome IN projeto.nome%TYPE, p_responsavel IN projeto.responsavel%TYPE
    ) 
    IS
    e_null EXCEPTION;
    BEGIN
        IF ((LENGTH(p_nome) < 2) OR (p_nome IS NULL)) 
            THEN RAISE e_null;
        END IF;
        INSERT INTO projeto (nome, responsavel, inicio) values (p_nome, p_responsavel, sysdate);
    EXCEPTION
        WHEN e_null THEN raise_application_error(-20100, 'Nome de projeto inválido! Deve ter dois ou mais caracteres.');
        WHEN OTHERS THEN null;
    END;
END;