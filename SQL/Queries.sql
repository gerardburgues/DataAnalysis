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

/**-------------------------------JORDI------------------------------------**/

create function Age_use( )
    returns TABLE(v_age TEXT, count bigint, v_price text)
    language plpgsql
as
$$
BEGIN
        RETURN QUERY
            SELECT
                   age,
                   count(*)
                    price



            FROM   "transformedData";

    end

$$;

/**---------------------------------Jordi-------------------------------------------**/

create function population_use( )
    returns TABLE(v_population TEXT, count bigint, v_price text)
    language plpgsql
as
$$
BEGIN
        RETURN QUERY
            SELECT
                population,
                count(*),
                price


            FROM   "transformedData"
        group by population, price;
    end

$$;

/**---------------------------------Jordi-------------------------------------------**/

create function influencer_use( )
    returns TABLE(v_age text,count bigint,fitnessInfluencer text)
    language plpgsql
as
$$
BEGIN
        RETURN QUERY
            SELECT
                age,
                count(*),
            "fitnessChannel"



            FROM   "transformedData"
        group by age, "fitnessChannel";
    end

$$;
/**---------------------------------Jordi-------------------------------------------**/

create function age_app( )
    returns TABLE(v_age text,count bigint,app text)
    language plpgsql
as
$$
BEGIN
        RETURN QUERY
            SELECT
                age,
                count(*),
                   "individualSpace"




            FROM   "transformedData"
        group by age, "individualSpace";
    end

$$;

/**---------------------------------Jordi-------------------------------------------**/

create function app_use_training( )
    returns TABLE(v_age text,count bigint,v_application text)
    language plpgsql
as
$$
BEGIN
        RETURN QUERY
            SELECT
                age,
                count(*),
            "application"



            FROM   "transformedData"
        group by age, "application";
    end

$$;


/**---------------------------------Jordi-------------------------------------------**/

create function classes_age( )
    returns TABLE(v_age text,count bigint,v_classes text)
    language plpgsql
as
$$
BEGIN
        RETURN QUERY
            SELECT
                age,
                count(*),
            "classes"



            FROM   "transformedData"
        group by age, "classes";
    end

$$;