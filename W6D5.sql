-- 1.Esponi l’anagrafica dei prodotti indicando per ciascun prodotto anche la sua sottocategoria (DimProduct, DimProductSubcategory)
SELECT 
	*
from dimproduct AS p
left outer join dimproductsubcategory AS psc
ON p.ProductSubcategoryKey = psc.ProductSubcategoryKey

;

-- 2.Esponi l’anagrafica dei prodotti
-- indicando per ciascun prodotto la sua sottocategoria 
-- e la sua categoria (DimProduct, DimProductSubcategory, DimProductCategory)

select*
from dimproduct AS p
left outer join dimproductsubcategory AS psc
ON p.ProductSubcategoryKey = psc.ProductSubcategoryKey
left outer join dimproductcategory AS pc
ON psc.ProductCategoryKey = pc.ProductCategoryKey;

-- 3.Esponi l’elenco dei soli prodotti venduti (DimProduct, FactResellerSales)

select DISTINCT ProductKey
from	factresellersales 


-- 4.Esponi l’elenco dei prodotti non venduti 
-- (considera i soli prodotti finiti cioè quelli per i quali il campo FinishedGoodsFlag è uguale a 1)

select d.ProductKey, f.ProductKey
from dimproduct	as d
left outer join factresellersales as f
on d.productkey = f.productkey 
where FinishedGoodsFlag = 1 
and f.ProductKey IS NUll

-- 5.Esponi l’elenco delle transazioni di vendita (FactResellerSales) 
-- indicando anche il nome del prodotto venduto (DimProduct)

select f.salesordernumber
    , d.englishproductname  
from FactResellerSales as f
join DimProduct as d
on f.ProductKey = d.Productkey 

-- 6.Esponi l’elenco delle transazioni di vendita 
-- indicando la categoria di appartenenza di ciascun prodotto venduto.

select 
	f.productkey
    ,dp.productkey
    ,EnglishProductName
    ,ProductCategoryKey
    ,SalesAmount
from FactResellerSales as f
join dimproduct as dp
on f.productkey = dp.productkey 
join  dimproductsubcategory as dpsub 
on dp.ProductSubcategoryKey= dpsub. ProductSubcategoryKey

-- 7.Esplora la tabella DimReseller

select *
from dimreseller

-- 8.Esponi in output l’elenco dei reseller indicando
-- per ciascun reseller, anche la sua area geografica.

select 
	ResellerKey
    ,EnglishCountryRegionName
from dimreseller as dr
left outer join dimgeography as dg
on dr.GeographyKey = dg.GeographyKey

-- 9-Esponi l’elenco delle transazioni di vendita. 
-- Il result set deve esporre i campi: SalesOrderNumber, SalesOrderLineNumber, OrderDate, UnitPrice, Quantity, TotalProductCost. 
-- Il result set deve anche indicare il nome del prodotto, il nome della categoria del prodotto, il nome del reseller e l’area geografica.

select *
from FactResellerSales

select 
    SalesOrderNumber
    ,SalesOrderLineNumber
    ,OrderDate 
    ,UnitPrice
    ,OrderQuantity
    ,TotalProductCost
from FactResellerSales as f
join dimproduct as dp
on f.productkey = dp.productkey 
join dimproductsubcategory as dpsub 
on dp.ProductSubcategoryKey = dpsub.ProductSubcategoryKey
join dimproductcategory as dpc 
on dpc.ProductCategoryKey = dpsub.ProductSubcategoryKey
join dimreseller as dr
on dr.ResellerKey = f.ResellerKey
join dimgeography as dg
on dr.ResellerKey = dg.GeographyKey
