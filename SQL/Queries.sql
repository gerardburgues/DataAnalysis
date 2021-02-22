create function gender_exercise_type(p_population text, p_age text)
    returns TABLE(v_population text, counting bigint, v_sexo text, v_age text, exercise_type text)
    language plpgsql
as
$$
    BEGIN
        RETURN QUERY
            SELECT
                   population,
                    count(*),
                   sexo,
                   age,
                   "trainingType"


            FROM   "transformedData"
            WHERE population = p_population AND age = p_age
                and ("trainingType" = 'Cardio'
               or "trainingType" = 'Tone'
               or "trainingType" = 'Tone/Cardio')
        GROUP BY population, sexo, age,"trainingType";

    end

$$;



/**---------------------------------------------------------------------------------------------------**/
create function where_work_out(p_population text)
    returns TABLE(v_population text, counting bigint, v_sexo text, v_age text, v_training_type text)
    language plpgsql
as
$$
BEGIN
        RETURN QUERY
            SELECT
                   population,
                    count(*),
                   sexo,
                   age,
                   "trainingType"



            FROM   "transformedData"
            WHERE population = p_population and "exerciseWhere" ='Home' and ("application" = 'Yes' or "fitnessChannel" = 'Yes')

        GROUP BY population, sexo, age, "trainingType";

    end

$$;

/**-------------------------------------------------------------------------**/
create function where_work_out_after(p_population text)
    returns TABLE(v_population text, counting bigint, v_sexo text, v_age text, v_training_type text)
    language plpgsql
as
$$
BEGIN
        RETURN QUERY
            SELECT
                   population,
                    count(*),
                   sexo,
                   age,
                   "trainingType"



            FROM   "transformedData"
            WHERE population = p_population and "exerciseWhere" ='Home' and ("application" = 'Yes' or "fitnessChannel" = 'Yes') and "afterPandemic" = 'Yes'

        GROUP BY population, sexo, age, "trainingType";

    end

$$;

/**-------------------------------------------------------------------**/

