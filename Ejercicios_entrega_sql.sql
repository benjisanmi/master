-- 
--1. Crea el esquema de la BBDD.
-- Esto no se puede realizar a través de una consulta. 
 


--2. Muestra los nombres de todas las películas con una clasificación por edades de ‘Rʼ.
 select f.title, f.rating 
 from film f
where f.rating = 'R'; 


--3. Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40.
select concat(a.first_name,' ', a.last_name)
from actor a
where "actor_id" between 30 and 40;


--4. Obtén las películas cuyo idioma coincide con el idioma original

SELECT f.title, l."name"
from film f 
LEFT JOIN "language" l 
ON  f.language_id  = l.language_id;


--5. Ordena las películas por duración de forma ascendente

select f.title, f.length
from film f 
order by f.length ASC;


--.6. Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido
select concat(a.first_name,' ', a.last_name)
from actor a 
where a.last_name= 'ALLEN';


--7. Encuentra la cantidad total de películas en cada clasificación de la tabla “filmˮ y muestra la clasificación junto con el recuento

select c."name", COUNT(fc.film_id) as "Numero de películas en la categoría"
from film_category fc
left join category c 
on fc.category_id = c.category_id
group by c."name";

--8. Encuentra el título de todas las películas que son ‘PG-13ʼ o tienen una duración mayor a 3 horas en la tabla film.

select F.title, F.length, F.rating
from film f
where f.rating='PG-13' or F.length >180;

--9. Encuentra la variabilidad de lo que costaría reemplazar las películas.

select variance(f.replacement_cost)
from film f;

--10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
select max (f.length) as "Máxima duración de pelicula", MIN(f.length) as "mínima duración de pelicula"
from film f;

--11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día
select p.amount , p.payment_date
from payment p 
order by p.payment_date desc
limit 1 offset 2;

--12.  Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC 17ʼ ni ‘Gʼ en cuanto a su clasificación
select f.title
from film f 
where f.rating <> 'NC-17' and F.rating <> 'G';

--13. Encuentra el promedio de duración de las películas para cada  clasificación de la tabla film y muestra la clasificación junto con el promedio de duración

select F.rating, AVG(F.length)
from film f	
group by F.rating;

--14.  Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos
select F.title
from film f 
where  F.length >180;


--15. ¿Cuánto dinero ha generado en total la empresa?
select sum(i."Total")
from "Invoice" i ;

--16. Muestra los 10 clientes con mayor valor de id.
select concat(c."FirstName", c."LastName"), i."Total" 
from "Customer" c 
left join "Invoice" i 
on c."CustomerId"= i."CustomerId"
order by i."Total" desc
limit 10;


--17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igbyʼ

select concat(a.first_name, a.last_name)
from film_actor fa 
join actor a 
on fa.actor_id = a.actor_id
join film f 
on fa.film_id = f.film_id 
where f.title = 'EGG IGBY';

--18. Selecciona todos los nombres de las películas únicos.

select distinct f.title 
from film f;


-- 19.Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “filmˮ.
select f.title
from film_category fc 
inner join category c 
on fc.category_id = c.category_id
inner join film f 
on fc.film_id = f.film_id
where c."name" = 'Comedy' and f.length >180;

--20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración

select c."name", AVG(f.length)
from film_category fc 
inner join category c 
on fc.category_id = c.category_id
inner join film f 
on fc.film_id = f.film_id
group by c."name"
having avg(f.length )>110;

--21. ¿Cuál es la media de duración del alquiler de las películas?
select AVG	(R.return_date-R.rental_date)
from rental r; 

--22. Crea una columna con el nombre y apellidos de todos los actores y actrices

select concat(A.first_name, A.last_name) as "Nombre del actor/actriz"
from actor a;

--23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente
select i."InvoiceDate", count(i."Total" )
from "Invoice" i
group by i."InvoiceDate"
order by count (i."Total") desc;

--24 Encuentra las películas con una duración superior al promedio
select f.title
from film f 
where f.length > (
	select AVG(f.length)
	from film f )
;

--25. Averigua el número de alquileres registrados por mes
SELECT DATE_TRUNC('month', rental_date) AS mes, COUNT(*) AS total_alquileres
FROM rental
GROUP BY DATE_TRUNC('month', rental_date);

--26. Encuentra el promedio, la desviación estándar y varianza del total pagado
select avg (p.amount) as "promedio del total pagado", variance(p.amount)as "Varianza del total pagado", stddev(p.amount) as "Desviación estandar del total pagado"
from payment p;

--27 ¿Qué películas se alquilan por encima del precio medio?
select f.title
from film f 
where f.replacement_cost >(select AVG(f2.replacement_cost) from film f2);

--28. Muestra el id de los actores que hayan participado en más de 40 películas
select  fa.actor_id
from film_actor fa 
group by fa.actor_id 
having count(fa.actor_id) >40
;

--29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible
select f.title, count (i.inventory_id) as "DISPONIBILIDAD"
from inventory i
LEFT join film f 
on i.film_id = f.film_id
group by f.title
order by "DISPONIBILIDAD" ASC;


--30. Obtener los actores y el número de películas en las que ha actuado.
select concat (a.first_name, a.last_name), count (fa.film_id)
from film_actor fa 
left join actor a 
on fa.actor_id = a.actor_id
group by concat (a.first_name, a.last_name);

--31. Obtener todas las películas y mostrar los actores que han actuado en  ellas, incluso si algunas películas no tienen actores asociados.
SELECT f.title, CONCAT(a.first_name, ' ', a.last_name) AS actor_name
FROM film f
LEFT JOIN film_actor fa ON f.film_id = fa.film_id
LEFT JOIN actor a ON fa.actor_id = a.actor_id
ORDER BY f.title, actor_name

--32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
select concat (a.first_name, a.last_name) as actor, f.title
from actor a 
left join film_actor fa  
on fa.actor_id = fa.actor_id
left join film f 
on fa.film_id = f.film_id
group  by actor , f.title;

--33. Obtener todas las películas que tenemos y todos los registros de alquiler.
select f.title, r.customer_id, r.last_update, r.rental_date, r.return_date, r.staff_id
from film f 
left join inventory i 
on f.film_id =i.film_id
left join rental r 
on i.inventory_id = r.inventory_id;

--34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
select c."FirstName" as "customer", sum (p.amount)
from "Customer" c 
inner join payment p 
on c."CustomerId" = p.customer_id
group by c."FirstName"
order by sum (p.amount) DESC 
limit 5;

--35.  Selecciona todos los actores cuyo primer nombre es 'Johnny'.
select *
from actor a 
where a.first_name = 'JOHNNY'

--36. Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido.
select A.first_name as "NOMBRE", A.last_name as "APELLIDO"
from actor a 

--37. Encuentra el ID del actor más bajo y más alto en la tabla actor
select MAX(a.actor_id), MIN(a.actor_id)
from actor a 

--38. Cuenta cuántos actores hay en la tabla “actorˮ
select count (a.actor_id)
from actor a 

--39. Selecciona todos los actores y ordénalos por apellido en orden ascendente
select *
from actor a 
order by a.last_name asc;


--40. Selecciona las primeras 5 películas de la tabla “filmˮ
select *
from film f 
limit 5;

--41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido? El nombre más repetido es Lenneth, Penelope y Julia
select a.first_name, count (a.actor_id)
from actor a 
group by a.first_name
order by count (a.actor_id) desc;

--42.  Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
select i."InvoiceId", c."FirstName"
from "Invoice" i 
left join "Customer" c 
on i."CustomerId" = c."CustomerId";

--43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres
select concat (c."FirstName", c."LastName"), i."InvoiceId"
from "Customer" c 
left join "Invoice" i 
on c."CustomerId" = i."CustomerId";

--44.  Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación
select *
from  film f 
cross join category c 
-- No aporta valor porque esta indicando que todas las peliculas tienen todas las categorias. Por lo que una única pelicula es drama, comedia, acción, animación,... y la categoría dejaría de tener sentido

--45. Encuentra los actores que han participado en películas de la categoría 'Action'
select distinct  concat (a.first_name, ' ', a.last_name) 
from actor a 
inner join film_actor fa 
on fa.actor_id = a.actor_id
inner join film f 
on fa.film_id = f.film_id
inner join  film_category fc 
on f.film_id = fc.film_id
inner join category c 
on fc.category_id =c.category_id
where c."name" = 'Action';


--46. Encuentra todos los actores que no han participado en películas
SELECT 
    a.actor_id, 
    a.first_name, 
    a.last_name
FROM actor a
LEFT JOIN film_actor fa 
ON a.actor_id = fa.actor_id
WHERE fa.film_id IS null; 

--47.  Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
select a.actor_id, concat (a.first_name, ' ',a.last_name), count (fa.film_id)
from film_actor fa 
inner join actor a 
on fa.actor_id =a.actor_id
group by a.actor_id ;


--48. Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres de los actores y el número de películas en las que han participado
create view Actor_num_peliculas as
select a.actor_id, concat (a.first_name, ' ',a.last_name), count (fa.film_id)
from film_actor fa 
inner join actor a 
on fa.actor_id =a.actor_id
group by a.actor_id ;

--49. Calcula el número total de alquileres realizados por cada cliente
select c."CustomerId", concat(c."FirstName",' ', c."LastName"), COUNT(i."InvoiceId")
from "Customer" c 
inner join "Invoice" i 
on c."CustomerId" = i."CustomerId"
group by c."CustomerId"
order by c."CustomerId";

-- 50.Calcula la duración total de las películas en la categoría 'Action'.
select sum(f.length)
from film_category fc 
inner join film f 
on fc.film_id = f.film_id
inner join category c 
on fc.category_id = c.category_id
where c."name" = 'Action';

--51. Crea una tabla temporal llamada “cliente_rentas_temporalˮ para almacenar el total de alquileres por cliente.
create temporary table cliente_rentas_temporal as 
select c."CustomerId", concat(c."FirstName",' ', c."LastName"), COUNT(i."InvoiceId")
from "Customer" c 
inner join "Invoice" i 
on c."CustomerId" = i."CustomerId"
group by c."CustomerId"
order by c."CustomerId";

--52. Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las películas que han sido alquiladas al menos 10 veces.
CREATE TEMPORARY TABLE peliculas_alquiladas AS
SELECT 
    f.film_id,
    f.title,
    COUNT(r.rental_id) AS veces_alquilada
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
HAVING COUNT(r.rental_id) >= 10;


--53.  Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sandersʼ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.
select f.title
from customer c 
inner join rental r 
on c.customer_id = r.customer_id
inner join inventory i 
on r.inventory_id = i.inventory_id
inner join film f 
on i.film_id = f.film_id
where r.return_date is null and c.first_name = 'TAMMY' and C.last_name = 'SANDERS';

--54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fiʼ. Ordena los resultados alfabéticamente por apellido
select distinct  a.first_name, a.last_name
from film_actor fa 
inner join film f 
on fa.film_id = f.film_id
inner join film_category fc 
on f.film_id = fc.film_id 
inner join category c 
on fc.category_id = c.category_id
inner join actor a 
on fa.actor_id = a.actor_id
where c."name" = 'Sci-Fi'
order by a.last_name;

--55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaperʼ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido
select distinct a.first_name, a.last_name
from film f 
inner join film_actor fa 
on f.film_id =fa.film_id
inner join actor a 
on fa.actor_id = a.actor_id
inner join inventory i 
on f.film_id  = i.film_id
inner join rental r 
on i.inventory_id = r.inventory_id
WHERE r.rental_date > (
    SELECT MIN (r2.rental_date)
    FROM film f2
    JOIN inventory i2 ON f2.film_id = i2.film_id
    JOIN rental r2 ON i2.inventory_id = r2.inventory_id
    WHERE f2.title = 'SPARTACUS CHEAPER'
)
ORDER BY a.last_name;

--56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Musicʼ.
SELECT a.first_name, a.last_name
FROM actor a
WHERE a.actor_id NOT IN (
    SELECT DISTINCT fa.actor_id
    FROM film_actor fa
    JOIN film_category fc ON fa.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    WHERE c.name = 'Music'
);


--57.  Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
select f.title, (r.return_date - r.rental_date)
from rental r
inner join inventory i 
on r.inventory_id = i.inventory_id
inner join film f 
on i.film_id = f.film_id
where interval '8 days' < (r.return_date - r.rental_date);
;

--58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animationʼ.
select f.title
from film f 
inner join film_category fc 
on f.film_id = fc.film_id
inner join category c 
on fc.category_id = c.category_id
where c."name" = 'Animation';

-- 59.Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Feverʼ. Ordena los resultados alfabéticamente por título de película.
select f.title, f.length
from film f 
where f.length = (
	select f2.length 
	from film f2 
	where f2.title = 'DANCING FEVER'
)
order by F.title;


--60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.
select  c.customer_id,c.first_name, c.last_name,  count(distinct i.film_id)
from rental r 
inner join inventory i 
on r.inventory_id = i.inventory_id
inner join customer c 
on r.customer_id = c.customer_id
group by c.customer_id 
having count (distinct i.film_id) < 7
order by c.last_name;



--61.  Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
select c.category_id, c."name" ,  count( r.rental_id)
from rental r 
inner join inventory i 
on r.inventory_id = i.inventory_id
inner join film f 
on i.film_id = f.film_id
inner join film_category fc 
on f.film_id = fc.film_id
inner join category c 
on fc.category_id = c.category_id
group by c.category_id;


--62. Encuentra el número de películas por categoría estrenadas en 2006.
select C."name", count (f.film_id)
from film f 
inner join film_category fc 
on f.film_id = fc.film_id
inner join category c 
on fc.category_id = c.category_id
where f.release_year = 2006
group by c."name";

--63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
select *
from "Employee" e  
cross join store s2 ; 


--64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas
select c.customer_id, concat(c.first_name, ' ', c.last_name), count (i.film_id)
from customer c 
inner join rental r 
on c.customer_id = r.customer_id
inner join inventory i 
on r.inventory_id = i.inventory_id
group by c.customer_id; 



































