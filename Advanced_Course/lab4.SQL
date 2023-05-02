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









