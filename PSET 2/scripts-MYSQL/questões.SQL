/*QUESTÃO 1*/
SELECT funcionario.numero_departamento, ROUND(AVG(salario),2) AS media_salarial
FROM funcionario
GROUP BY numero_departamento;

/*QUESTÃO 2*/
SELECT sexo, ROUND(AVG(salario),2) AS media_salarial
FROM funcionario
GROUP BY sexo;

/*QUESTÃO 3*/
SELECT departamento.nome_departamento, CONCAT(primeiro_nome,' ', nome_meio,' ',  ultimo_nome) AS nome_completo, data_nascimento, TIMESTAMPDIFF(YEAR, data_nascimento, NOW()) AS idade, salario
FROM funcionario
INNER JOIN departamento ON funcionario.numero_departamento = departamento.numero_departamento;

/*QUESTÃO 4*/
SELECT CONCAT(primeiro_nome,' ', nome_meio,' ',  ultimo_nome) AS nome_completo, TIMESTAMPDIFF(YEAR, data_nascimento, NOW()) AS idade, salario,
CASE
WHEN salario < 35000.00 THEN ROUND((salario*0.2),2) + salario
ELSE ROUND((salario*0.15),2) + salario END reajuste_salario
FROM funcionario;

/*QUESTÃO 5*/
SELECT nome_departamento, CONCAT(primeiro_nome,' ', nome_meio,' ',  ultimo_nome) AS nome_completo, 'gerente' AS tipo, salario
FROM funcionario
INNER JOIN departamento
WHERE funcionario.cpf = departamento.cpf_gerente
UNION
SELECT DISTINCT nome_departamento, primeiro_nome, 'funcionario' AS tipo, salario 
FROM funcionario
INNER JOIN departamento
WHERE cpf != cpf_gerente AND funcionario.numero_departamento = departamento.numero_departamento
ORDER BY nome_departamento ASC, salario DESC;

/*QUESTÃO 6*/
SELECT CONCAT(primeiro_nome,' ', nome_meio,' ',  ultimo_nome) AS nome_completo, numero_departamento, dependente.nome_dependente, TIMESTAMPDIFF(YEAR, dependente.data_nascimento, NOW()) AS idade_dependente, 
CASE
WHEN dependente.sexo = 'M' THEN 'masculino'
ELSE 'feminino' END sexo
FROM funcionario
INNER JOIN dependente
WHERE funcionario.cpf = dependente.cpf_funcionario;

/*QUESTÃO 7*/


/*QUESTÃO 8*/
SELECT nome_departamento, nome_projeto, CONCAT(funcionario.primeiro_nome,' ', funcionario.nome_meio,' ', funcionario.ultimo_nome) AS nome_completo, horas
FROM funcionario
INNER JOIN departamento ON (departamento.numero_departamento = funcionario.numero_departamento)
INNER JOIN projeto ON (funcionario.numero_departamento = projeto.numero_departamento)
INNER JOIN trabalha_em ON (trabalha_em.cpf_funcionario = funcionario.cpf)
GROUP BY nome_departamento, nome_projeto, nome_completo;

/*QUESTÃO 9*/
SELECT nome_departamento, nome_projeto, SUM(horas) AS horas_total
FROM projeto
INNER JOIN departamento ON (projeto.numero_departamento = departamento.numero_departamento)
INNER JOIN trabalha_em ON (projeto.numero_projeto = trabalha_em.numero_projeto)
GROUP BY nome_departamento, nome_projeto;

/*QUESTÃO 10*/
SELECT nome_departamento, ROUND(AVG(salario),2) AS media_salarial
FROM departamento
INNER JOIN funcionario
WHERE departamento.numero_departamento = funcionario.numero_departamento
GROUP BY nome_departamento;

/*QUESTÃO 11*/
SELECT CONCAT(primeiro_nome,' ', nome_meio,' ',  ultimo_nome) AS nome_completo, nome_projeto, horas,
(horas*50) AS remuneração
FROM trabalha_em
INNER JOIN funcionario ON (funcionario.cpf = trabalha_em.cpf_funcionario)
INNER JOIN projeto ON (projeto.numero_projeto = trabalha_em.numero_projeto)
GROUP BY nome_completo, nome_projeto;

/*QUESTÃO 12*/
SELECT  CONCAT(funcionario.primeiro_nome,' ', funcionario.nome_meio,' ', funcionario.ultimo_nome) AS nome_completo, nome_departamento, nome_projeto
FROM projeto
INNER JOIN departamento ON projeto.numero_departamento = departamento.numero_departamento
INNER JOIN funcionario ON funcionario.numero_departamento = projeto.numero_departamento
INNER JOIN trabalha_em ON projeto.numero_projeto = trabalha_em.numero_projeto WHERE horas = NULL;

/*QUESTÃO 13*/
SELECT CONCAT(primeiro_nome,' ', nome_meio,' ',  ultimo_nome) AS nome_completo, sexo, TIMESTAMPDIFF(YEAR, data_nascimento, NOW()) AS idade
FROM funcionario
UNION
SELECT nome_dependente, sexo, TIMESTAMPDIFF(YEAR, data_nascimento, NOW()) AS idade
FROM dependente
ORDER BY idade DESC;

/*QUESTÃO 14*/
SELECT nome_departamento, COUNT(cpf) AS funcionario
FROM departamento
INNER JOIN funcionario ON (departamento.numero_departamento = funcionario.numero_departamento)
GROUP BY nome_departamento;

/*QUESTÃO 15*/
SELECT CONCAT(primeiro_nome,' ', nome_meio,' ',  ultimo_nome) AS nome_completo, nome_departamento, nome_projeto
FROM projeto
INNER JOIN departamento ON (projeto.numero_departamento = departamento.numero_departamento)
INNER JOIN funcionario ON (projeto.numero_departamento = funcionario.numero_departamento)
ORDER BY nome_departamento, nome_projeto;