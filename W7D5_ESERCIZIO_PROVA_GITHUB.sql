-- 1. Elencate il numero di tracce per ogni genere in ordine discendente, escludendo quei generi che hanno meno di 10 tracce. 

select count(TrackId), GenreId, g.Name
from track as t 
join genre as g 
using (GenreId)
group by GenreId 
having not count(TrackId) <10 
order by count(TrackId) desc;

-- 2. Trovate le tre canzoni più costose

select t.TrackId
	, t.Name 
    , UnitPrice
from track AS t
order by UnitPrice desc
limit 3;

-- 3. Elencate gli artisti che hanno canzoni più lunghe di 6 minuti. 

select distinct Composer
from track 
where Milliseconds >360000;

-- 4. Individuate la durata media delle tracce per ogni genere. 

select avg(Milliseconds)
	, GenreId
    , g.Name 
from track
join genre as g 
using (GenreId)
group by GenreId;

-- 5. Elencate tutte le canzoni con la parola “Love” nel titolo, 
-- ordinandole alfabeticamente prima per genere e poi per nome

select t.TrackId
	, t.Name
    , t.GenreId
    , g.Name 
from track as t
join genre as g 
using (GenreId)
where lower(t.Name) like '%love%';

-- 6. Trovare il costo medio per ogni tipologia di media 

select avg(UnitPrice)
	,MediaTypeId
    ,m.Name
from track as t 
join mediatype as m
using(MediaTypeId)
group by MediaTypeId;

-- 7. Individuate il genere con più tracce

select count(TrackId) 
    ,t.GenreId
    ,g.Name 
from track as t
join genre as g 
using (GenreId) 
group by t.GenreId
order by count(TrackId) desc 
limit 1;

-- 8. Trovate gli artisti che hanno lo stesso numero di album dei Rolling Stones

select al.ArtistId 
	,ar.Name
	,count(al.AlbumId)
from album as al
join artist as ar
USING(ArtistId)
group by al.ArtistId
having count(al.AlbumId) = (
-- query per torvare il numero di album dei rolling stones
	select
		count(al.AlbumId)
	from album as al
	join artist as ar
	USING(ArtistId)
	where ar.name = 'The Rolling Stones'
	group by al.ArtistId);

-- 9. Trovate l’artista con l’album più costoso.

select al.Title 		as TitoloAlbum
	,sum(UnitPrice) 	as CostoAlbum
    ,ar.Name 			as Artista
from track as t 
join album as al
on t.AlbumId = al.AlbumId
join artist as ar 
on al.ArtistId = ar.ArtistId
group by t.AlbumId 
order by sum(UnitPrice) desc limit 1




-- TIP: Alcuni di questi esercizi possono essere complessi, cercate di suddividere la richiesta in piccoli step,
-- applicate un approccio logico e risolvete gli step uno alla volta prima di unificarli e giungere alla soluzione.



