-- Databricks notebook source
CREATE TABLE managed_default
  (width INT, length INT, height INT);
 
INSERT INTO managed_default
  VALUES (3,2,1);

-- COMMAND ----------

DESCRIBE EXTENDED managed_default;

-- COMMAND ----------

CREATE TABLE external_default
  (width INT, length INT, height INT)
  LOCATION 'dbfs:/mnt/demo/external_default';

INSERT INTO external_default
   VALUES (3,2,1);

-- COMMAND ----------

DESCRIBE EXTENDED external_default;

-- COMMAND ----------

/*
DROP TABLE managed_table;

%fs ls 'dbfs:/user/hive/warehouse/managed_default'
-> FileNotFoundException

DROP TABLE external_table;

%fs ls 'dbfs:/mnt/demo/external_default'
-> data directory and data file still exist.

*/


-- COMMAND ----------

CREATE SCHEMA new_default;

-- COMMAND ----------

DESCRIBE DATABASE EXTENDED new_default;

-- COMMAND ----------

USE new_default;
CREATE TABLE tb1 (w INT, l INT, h INT);

INSERT INTO tb1 VALUES(1,2,3);

-- COMMAND ----------

DESCRIBE EXTENDED tb1;
