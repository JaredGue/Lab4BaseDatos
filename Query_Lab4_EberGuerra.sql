/*Detalle de todos los clientes, si han echo una compra y	de cuenta a sido*/
Select * from SalesLT.Customer
Select * from SalesLT.SalesOrderDetail


Select SalesLT.Customer.FirstName +  ' ' +SalesLT.Customer.LastName as [Nombre Cliente],
		SalesLT.SalesOrderHeader.TotalDue as [Total Pagado]

from
	SalesLT.Customer inner join SalesLT.SalesOrderHeader
	on Customer.CustomerID = SalesOrderHeader.CustomerID
	
/*Detalle de todos los clientes, con el costo de la compra*/
Select SalesLT.Customer.FirstName +  ' ' +SalesLT.Customer.LastName as [Nombre Cliente],
		ISNULL(SalesLT.SalesOrderHeader.TotalDue,0) as [Total Pagado]

from
	SalesLT.Customer full outer join SalesLT.SalesOrderHeader
	on Customer.CustomerID = SalesOrderHeader.CustomerID
	
/*Nombre de los clientes, Total pagado, Direccion de la facturacion*/
Select Customer.FirstName + ' ' + Customer.LastName as [Nombre Cliente],
SalesOrderHeader.TotalDue as [Total pagado],
Address.AddressID as [Direccion de Factura]
from
	SalesLT.Customer inner join SalesLT.SalesOrderHeader
	on Customer.CustomerID = SalesOrderHeader.CustomerID
	inner join SalesLT.Address
	on SalesOrderHeader.BillToAddressID = Address.AddressID

/*Direcciones de las empresas "Future Bikes" y	 “Futuristic Bikes”*/
Select Customer.CompanyName as [Nombre Compañia],
	   Address.AddressLine1 as [Direccion]
from
	SalesLT.Customer inner join SalesLT.CustomerAddress
	on Customer.CustomerID = CustomerAddress.CustomerID
	inner join SalesLT.Address
	on CustomerAddress.AddressID = Address.AddressID
	where Customer.CompanyName like '%Bikes'
	and Customer.CompanyName like 'Futur%'

/*CantidadProducto, Nombre Producto, Precio de lista cliente con ID 29796 , Cuantos Productos compro*/
Select count(1) as NumeroComprados
from(
	Select Customer.CustomerID as [ID],
	SalesOrderDetail.OrderQty as [Cantidad Producto],
	Product.Name as [Nombre Producto],
	Product.ListPrice as [Precio Lista]
	from
		SalesLT.Customer inner join SalesLT.SalesOrderHeader
		on Customer.CustomerID = SalesOrderHeader.CustomerID
		inner join SalesLT.SalesOrderDetail
		on SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
		inner join SalesLT.Product
		on SalesOrderDetail.ProductID = Product.ProductID
		where Customer.CustomerID = 29796
) as Comprados


/*Nombre Compañia, Direccion Clientes sea Vancouver*/
Select Customer.CompanyName as [Nombre Compañia],
Address.City as [Ciudad]
from
	SalesLT.Customer inner join SalesLT.CustomerAddress
	on Customer.CustomerID = CustomerAddress.CustomerID
	inner join SalesLT.Address
	on CustomerAddress.AddressID = Address.AddressID
	where Address.City like 'Vancouver%'

/*Total productos con un precio de listado menor a 1200*/
Select count(1) as TotalProductos
from(
	Select 
	Product.ProductID as [Id Producto]
	from
		SalesLT.Product inner join SalesLT.SalesOrderDetail
		on Product.ProductID = SalesOrderDetail.ProductID
		inner join SalesLT.SalesOrderHeader
		on SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID
		where Product.ListPrice < 1200
   ) as Productos

/*Nombre Compañia, con compras menores a 25000*/
Select Customer.CompanyName as [Nombre Compañia]
from
	SalesLT.Customer inner join SalesLT.SalesOrderHeader
	on Customer.CustomerID = SalesOrderHeader.CustomerID
	where SalesOrderHeader.TotalDue < 25000

/*Total Camisas  de manga larga talla XL ('Long-Sleeve Logo Jersey, XL') ha comprado la empresa 'Action Bicycle Specialists'*/
Select count(1) as TotalCamisasXL
from(
	Select Product.Name as [Nombre],
	Customer.CompanyName as [Nombre Compañia]

	from 
		SalesLT.Customer inner join SalesLT.SalesOrderHeader
		on Customer.CustomerID = SalesOrderHeader.CustomerID
		inner join SalesLT.SalesOrderDetail
		on SalesOrderHeader.SalesOrderID = SalesLT.SalesOrderDetail.SalesOrderID
		inner join SalesLT.Product
		on SalesOrderDetail.ProductID = Product.ProductID
		where Product.Name like 'Long-Sleeve Logo Jersey, XL%'
		and Customer.CompanyName like 'Action Bicycle Specialists%'
) as Camisas

/*Numero de orden, precio unitario de un producto en especifico*/
declare @IDProducto int
declare @IDOrder int
set @IDProducto =707
set @IDOrder =71782

Select SalesOrderDetail.SalesOrderID as [Numero orden],
SalesOrderDetail.UnitPrice as [Precio unitario]
from
	SalesLT.SalesOrderDetail inner join SalesLT.Product
	on SalesOrderDetail.ProductID = Product.ProductID
	where SalesOrderDetail.SalesOrderID= @IDOrder
	and Product.ProductID = @IDProducto

/*Utilizando el SubTotal, ordenarlo de menor a mayor las ordenes, Mostrar Nombre Compañia, SubTotal, Peso*/
Select Customer.CompanyName as [Nombre Compañia],
SalesOrderHeader.SubTotal as [Sub Total],
ISNULL(Product.Weight,0) as [Peso]
from
	SalesLT.Customer inner join SalesLT.SalesOrderHeader
	on Customer.CustomerID = SalesOrderHeader.CustomerID
	inner join SalesLT.SalesOrderDetail
	on SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
	inner join SalesLT.Product
	on SalesOrderDetail.ProductID = Product.ProductID
Order by SalesOrderHeader.SubTotal ASC

/*Cuantos articulos de la categoria Gloves se han vendido, en un direccion registrada en Londres*/
Select count(1) as TotalArticulos
from(
	Select ProductCategory.ProductCategoryID as [Codigo Producto] 
	from
	SalesLT.Address inner join SalesLT.SalesOrderHeader
	on Address.AddressID = SalesOrderHeader.ShipToAddressID
	inner join SalesLT.SalesOrderDetail
	on SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
	inner join SalesLT.Product
	on SalesOrderDetail.ProductID = Product.ProductID
	inner join SalesLT.ProductCategory
	on Product.ProductCategoryID = ProductCategory.ProductCategoryID
	where Address.City like 'London%'
	and ProductCategory.Name like 'Gloves%'
)as Articulos

Select * from SalesLT.ProductCategory
Select * from SalesLT.Product
Select * from SalesLT.SalesOrderDetail
Select * from SalesLT.SalesOrderHeader
Select * from SalesLT.Customer
