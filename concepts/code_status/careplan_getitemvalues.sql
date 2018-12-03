-- NOT SUPPORTED

DROP MATERIALIZED VIEW IF EXISTS possibleCodeStatus;
CREATE MATERIALIZED VIEW possibleCodeStatus AS

SELECT "cplitemvalue", count(*) AS "n"
FROM "careplangeneral"
GROUP BY "cplitemvalue"
ORDER BY "n" DESC;