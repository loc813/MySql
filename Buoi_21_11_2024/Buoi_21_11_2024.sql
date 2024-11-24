use shopee_fake;

-- lien ket cac khoa ngoai voi nhau ---

alter table products 
add constraint Fk_category_1 foreign key (categoryId) references categories(categoryId),
add constraint Fk_store_1 foreign key (storeId) references stores(storeId);

alter table images 
add constraint Fk_product_1 foreign key (productId) references products(productId);

alter table reviews 
add constraint Fk_product_2 foreign key (productId) references products(productId),
add constraint Fk_user_1 foreign key (userId) references users(userId);

alter table carts 
add constraint Fk_product_3 foreign key (productId) references products(productId),
add constraint Fk_user_2 foreign key (userId) references users(userId);

alter table order_details 
add constraint Fk_product_4 foreign key (productId) references products(productId),
add constraint Fk_order_1 foreign key (orderId) references orders(orderId);

alter table orders
add constraint Fk_user_3 foreign key (userId) references users(userId),
add constraint Fk_stored_2 foreign key (storeId) references stores(storeId);

alter table stores
add constraint Fk_users_4 foreign key (userId) references users(userId);

-- exe3 --

select * from products;

select * from orders where totalPrice > 500;

select storeName , addressStore from stores ;

select * from users where userName like '%@gmail.com';

select * from reviews where rate like '5';

select * from products where quantity < 10;

select * from products where categoryId = 1;

select count(userId) as userNumber from users;

select sum(totalPrice) as total from orders;

select  *  from products order by price desc limit 1; 

select * from stores where statusStore = 1;

select categoryName, count(productId) as number from categories c
inner join products p on p.categoryId = c.categoryId
group by categoryName;

select * from products 
where productId not in (select distinct(productId) from reviews );

select productName, sum(quantityOrder) as Total from order_details od
inner join products p on p.productId = od.productId group by productName;

select * from users 
where userId not in (select distinct userId from orders);

select storeName , count(orderId) as TotalOrder from stores s
inner join orders o on o.storeId = s.storeId group by storeName;

select p.productName, count(i.imageId) as totalImage  from products p 
inner join images i on i.productId = p.productId group by p.productName;

select p.productName , count(r.reviewId) as ReviewNumber , avg(rate) as RateAvg from products p
inner join reviews r on r.productId = p.productId group by p.productName;

select u.userName , count(r.reviewId) as NumberReview from users u
inner join reviews r on r.userId = u.userId group by u.userName order by NumberReview desc limit 1;

select p.productName , max(p.quantitySold) as BestSold from products p group by p.productName order by BestSold desc limit 3;

select p.productName, s.storeName, max(p.quantitySold) as bestSold from stores s 
inner join products p on p.storeId = s.storeId 
where p.storeId = 'S001' group by p.productName;

select productName, (price * quantity) as tonKhoValue from products
where (price * quantity) > 1000000;

select s.storeName , sum(o.totalPrice) as doanhthu from stores s
inner join orders o on o.storeId = s.storeId group by s.storeName order by doanhthu desc limit 1;

select u.userName , sum(o.totalPrice) as tienchi from users u 
inner join orders o on o.userId = u.userId group by u.userName;

select * from orders o 
join order_details od on od.orderId = o.orderId
order by o.totalPrice desc limit 1;

select o.orderId ,  round(avg(od.quantityOrder)) as soluongTB from  orders o 
inner join order_details od on od.orderId = o.orderId
group by o.orderId ;

select p.productName , count(c.quantityCart) as NumberCart from products p 
inner join carts c on c.productId = p.productId group by p.productName;

select * from products  where quantity = 0 and quantitySold > 0; 

select * from orders o 
inner join users u on u.userId = o.userId 
where u.email = 'duong@gmail.com';

select s.storeName , count(p.productId) as ProductNumber from stores s 
inner join products p on p.storeId = s.storeId  group by s.storeName; 

-- exe 4 -- 
create view expensive_products as 
select productName , price  from products where price > 500000;

select * from expensive_products;

update expensive_products 
set price = 600000
where productName = 'Product A' ;

drop view expensive_products; 

create view abc as
	select p.productName from products p 
    inner join categories c on c.categoryId = p.categoryId
    group by p.productName;

select * from abc;

-- exe 5 -- 
create index productNameIndex on products(productName); 

show index from  productNameIndex;

drop index productNameIndex on products;


delimiter $$ 
create procedure getProductByPrice(in priceInput int)
begin 
	select productName , productId , price from products
    where price > priceInput;
end $$
delimiter $$

call getProductByPrice(500000);

delimiter $$ 
create procedure getOrderDetails(in orderId int)
begin 
	select * from order_details od
    inner join orders o on o.orderId = od.orderId
    where o.orderId = od.orderId;
end $$ 
delimiter $$

call getOrderDetails(4);

drop procedure if exists getOrderDetails;

delimiter $$ 
create procedure addNewProduct(in productName varchar(100) , in price int ,in description varchar(200), in quantity int)
begin 
	insert into products(productName , price , description, quantity)
    values(productName, price , description, quantity);
end $$ 
delimiter $$ 

call addNewProduct('Roll Royces', 1000000000 , 'sieu xe dat gia bac nhat the gioi', 10);

delimiter $$
create procedure deleteProductById(in product_Id int)
begin 
	delete from products where productId = product_Id;
end $$ 
delimiter $$ 

call deleteProductById(1);

delimiter $$
create procedure searchProductByName (in Product_Name varchar(200))
begin 
	select * from products 
    where productName = product_Name;
end $$
delimiter $$

call searchProductByName('Chuột không dây 2.4ghz 1600 Dpi hình xe hơi độc đáo đẹp mắt');

delimiter $$
create procedure filterProductsByPriceRange(in minPrice int , in maxPrice int)
begin 
	select * from Products
    where price between minPrice and maxPrice;
end $$
delimiter $$

call filterProductsByPriceRange( 10000, 200000);

delimiter $$
create procedure paginateProducts(in pageNumber int, in pageSize int)
begin 
	declare offset INT;
    
    set offset = (pageNumber - 1) * pageSize;
    
    select * from products 
    limit pageSize OFFSET offset;
end $$
delimiter $$

call paginateProducts(4, 5);