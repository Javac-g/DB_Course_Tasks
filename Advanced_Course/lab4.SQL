CREATE SCHEMA lab4;

CREATE TABLE "lab4.roles" (
	"id" serial NOT NULL,
	"name" varchar(25) NOT NULL,
	CONSTRAINT "roles_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "lab4.active_orders" (
	"id" serial NOT NULL,
	"order_id" integer NOT NULL,
	"client_id" integer NOT NULL,
	CONSTRAINT "active_orders_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "lab4.Product_list" (
	"id" serial NOT NULL,
	"Name" varchar(25) NOT NULL,
	"description" varchar(255) NOT NULL,
	"manufacturer" varchar(25) NOT NULL,
	"category_id" integer NOT NULL,
	CONSTRAINT "Product_list_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "lab4.order" (
	"id" serial NOT NULL,
	"discount" FLOAT NOT NULL,
	"order_date" DATE NOT NULL,
	"order_status" varchar(25) NOT NULL,
	"product_id" integer NOT NULL,
	"price_id" integer NOT NULL,
	"total_price" FLOAT NOT NULL,
	CONSTRAINT "order_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "lab4.clients" (
	"id" serial NOT NULL,
	"first_name" varchar(25) NOT NULL,
	"second_name" varchar(25) NOT NULL,
	"orders_number" integer NOT NULL,
	"role_id" integer NOT NULL,
	"email" varchar(25) NOT NULL,
	"password" varchar(25) NOT NULL,
	CONSTRAINT "clients_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "lab4.price_history" (
	"id" serial NOT NULL,
	"start_price" FLOAT NOT NULL,
	"last_price" FLOAT NOT NULL,
	"start_date" DATE NOT NULL,
	"end_date" DATE NOT NULL,
	CONSTRAINT "price_history_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "lab4.Category" (
	"id" serial NOT NULL,
	"name" varchar(25) NOT NULL,
	CONSTRAINT "Category_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);




ALTER TABLE "lab4.active_orders" ADD CONSTRAINT "active_orders_fk0" FOREIGN KEY ("order_id") REFERENCES "lab4.order"("id");
ALTER TABLE "lab4.active_orders" ADD CONSTRAINT "active_orders_fk1" FOREIGN KEY ("client_id") REFERENCES "lab4.clients"("id");

ALTER TABLE "lab4.Product_list" ADD CONSTRAINT "Product_list_fk0" FOREIGN KEY ("category_id") REFERENCES "lab4.Category"("id");

ALTER TABLE "lab4.order" ADD CONSTRAINT "order_fk0" FOREIGN KEY ("product_id") REFERENCES "lab4.Product_list"("id");
ALTER TABLE "lab4.order" ADD CONSTRAINT "order_fk1" FOREIGN KEY ("price_id") REFERENCES "lab4.price_history"("id");

ALTER TABLE "lab4.clients" ADD CONSTRAINT "clients_fk0" FOREIGN KEY ("role_id") REFERENCES "lab4.roles"("id");


INSERT INTO "lab4.roles" ("name") VALUES
('admin'),
('customer'),
('guest');
SELECT * FROM "lab4.roles";

INSERT INTO "lab4.Category" ("name") VALUES
('Smartphone'),
('Laptop'),
('TV');
SELECT * FROM "lab4.Category" ;

INSERT INTO "lab4.Product_list" ("Name", "description", "manufacturer", "category_id") VALUES
('iPhone X', 'Apple iPhone X with 64GB storage', 'Apple', 1),
('Samsung Galaxy S20', 'Samsung Galaxy S20 with 128GB storage', 'Samsung', 1),
('HP Pavilion', 'HP Pavilion 14 with Intel Core i5 processor and 8GB RAM', 'HP', 2),
('Dell XPS', 'Dell XPS 13 with Intel Core i7 processor and 16GB RAM', 'Dell', 2),
('Sony Bravia', 'Sony Bravia 55-inch 4K Smart TV', 'Sony', 3),
('LG OLED', 'LG OLED 65-inch 4K Smart TV', 'LG', 3);
SELECT * FROM "lab4.Product_list";

INSERT INTO "lab4.price_history" ("start_price", "last_price", "start_date", "end_date") VALUES
(1000, 900, '2022-01-01', '2022-03-31'),
(900, 800, '2022-04-01', '2022-04-15'),
(800, 700, '2022-04-16', '2022-05-31'),
(700, 600, '2022-06-01', '2022-06-30'),
(2000, 1700, '2022-01-01', '2022-05-31'),
(1700, 1600, '2022-06-01', '2022-06-30');
SELECT * FROM "lab4.price_history" ;

INSERT INTO "lab4.order" ("discount", "order_date", "order_status", "product_id", "price_id", "total_price") VALUES
(0.1, '2022-04-01', 'processing', 1, 1, 900),
(0.2, '2022-04-02', 'shipped', 2, 2, 800),
(0.05, '2022-04-03', 'processing', 3, 3, 650),
(0, '2022-04-04', 'delivered', 4, 4, 1300),
(0.15, '2022-04-05', 'processing', 5, 5, 1700);
SELECT * FROM "lab4.order";

INSERT INTO "lab4.clients" ("first_name", "second_name", "orders_number", "role_id", "email", "password") VALUES
('Max', 'Denisov', 2, 1, 'Max@example.com', 'password123'),
('Ivan', 'Ivanov', 3, 2, 'Ivan@example.com', '321password'),
('Denis', 'Heller', 1, 2, 'Denis@example.com', 'pass123word');
SELECT * FROM "lab4.clients" ;


INSERT INTO "lab4.active_orders" ("order_id", "client_id") VALUES
(1, 2),
(2, 3),
(3, 1),
(4, 2),
(5, 1);
 SELECT * FROM "lab4.active_orders";
 
Request for a sample of all products from the "Smartphones" category:
SELECT * FROM "lab4.Product_list" 
INNER JOIN "lab4.Category" 
ON "lab4.Product_list"."category_id" = "lab4.Category"."id" 
WHERE "lab4.Category"."name" = 'Smartphone';

Request for a sample of all orders that have the status "In processing":
SELECT * FROM "lab4.order" 
WHERE "lab4.order"."order_status" = 'processing';



Query for a sample of all orders made by a certain customer:
SELECT * FROM "lab4.active_orders" 
INNER JOIN "lab4.clients" 
ON "lab4.active_orders"."client_id" = "lab4.clients"."id" 
WHERE "lab4.clients"."first_name" = 'Max' AND "lab4.clients"."second_name" = 'Denisov';

Request for a selection of the number of orders, broken by a skin client:
SELECT "lab4.clients"."first_name", "lab4.clients"."second_name", COUNT("lab4.active_orders"."id") as order_count 
FROM "lab4.clients" 
LEFT JOIN "lab4.active_orders" 
ON "lab4.clients"."id" = "lab4.active_orders"."client_id" 
GROUP BY "lab4.clients"."id";

Request for a selection of the average price of the product for the entire history of prices:
SELECT "lab4.Product_list"."Name", AVG("lab4.price_history"."last_price") as avg_price 
FROM "lab4.Product_list" 
LEFT JOIN "lab4.price_history"
ON "lab4.Product_list"."id" = "lab4.price_history"."id" 
GROUP BY "lab4.Product_list"."id";

Request for a selection of all active requests of the singing client:
SELECT "lab4.order".* 
FROM "lab4.active_orders"
INNER JOIN "lab4.order"
ON "lab4.active_orders"."order_id" = "lab4.order"."id" 
WHERE "lab4.active_orders"."client_id" = 1;











