SELECT "cplitemvalue", count(*) AS "n"
FROM "careplangeneral"
GROUP BY "cplitemvalue"
ORDER BY "n" DESC