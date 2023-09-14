-- Databricks notebook source
-- MAGIC %md
-- MAGIC # Set Up Delta Tables
-- MAGIC
-- MAGIC ## Learning objectives
-- MAGIC
-- MAGIC CTAS statements
-- MAGIC Table Constraints
-- MAGIC Cloning Delta Lake Tables
-- MAGIC
-- MAGIC ## CTAS (Create Table As Statement)
-- MAGIC
-- MAGIC `CREATE TABLE` _ `AS SELECT` statement 
-- MAGIC
-- MAGIC ```sql
-- MAGIC CREATE TABLE table_1 AS SELECT * FROM tb1;
-- MAGIC ```
-- MAGIC
-- MAGIC Automatically infers schema infromation from query results.
-- MAGIC - does not support manual declaration
-- MAGIC
-- MAGIC ## CTAS - Filtering and Renaminf Columns
-- MAGIC
-- MAGIC ```sql
-- MAGIC CREATE TABLE tb2
-- MAGIC    AS SELECT col_1, col_3 AS new_col_3 FROM tb1;
-- MAGIC ```
-- MAGIC
-- MAGIC ## CTAS - Additional options
-- MAGIC
-- MAGIC ```sql
-- MAGIC CREATE TABLE new_table
-- MAGIC    COMMENT "My comment"
-- MAGIC    PARTITIONED BY (co1_1, col_2)
-- MAGIC    LOCATION "/some/path"
-- MAGIC    AS SELECT col_1, col_2, col_3, col_4 FROM original_table;
-- MAGIC ```
-- MAGIC
-- MAGIC ## CREATE TABLE vs. CTAS
-- MAGIC
-- MAGIC CREATE TABLE:
-- MAGIC - manual schema declaration
-- MAGIC - creates empty table
-- MAGIC  - neds `INSERT INTO` statement for inputting the data.
-- MAGIC
-- MAGIC CTAS:
-- MAGIC - does `not` support manual schema declaration
-- MAGIC  - automatically infers the schema
-- MAGIC - Table is created with data.
-- MAGIC
-- MAGIC ## Table constraints
-- MAGIC
-- MAGIC `NOT NULL` constraints.
-- MAGIC `CHECK` constraints.
-- MAGIC
-- MAGIC `ALTER TABLE` table_name `ADD CONSTRAINT` constraint_name constraint_details
-- MAGIC
-- MAGIC Example:
-- MAGIC
-- MAGIC ```sql
-- MAGIC ALTER TABLE orders ADD CONSTRAINT valid_date CHECK(date >'2020-01-01');
-- MAGIC ```
-- MAGIC
-- MAGIC ## Cloning Delta Lakje Tables
-- MAGIC
-- MAGIC `DEEP CLONE' or `SHALLOW CLONE`
-- MAGIC
-- MAGIC ### Deep Cloning
-- MAGIC
-- MAGIC Fully copies data and metadata from the soyurce table to the target.
-- MAGIC
-- MAGIC ```sql
-- MAGIC CREATE TABLE table_clone
-- MAGIC    DEEP CLONE source_table;
-- MAGIC ```
-- MAGIC
-- MAGIC Copies incrementally, so can syncronise changes.
-- MAGIC Copies all the data, so can take a while with large datasets.
-- MAGIC
-- MAGIC ### Shallow Cloning
-- MAGIC
-- MAGIC Quicly create a copy of a table.
-- MAGIC - copies only delta transaction logs.
-- MAGIC
-- MAGIC ```sql
-- MAGIC CREATE TABLE table_clone
-- MAGIC    SHALLOW CLONE source_table;
-- MAGIC ```
-- MAGIC
-- MAGIC No data is moving during the shallow cloning. Used for examlple for testing applied changes without risiking modifying the data in the current table.
-- MAGIC
-- MAGIC ### Cloning Delta Lake Tables
-- MAGIC
-- MAGIC Useful to set up tables for testing in development.
-- MAGIC
-- MAGIC In either case, data modifications will not affect the source.
-- MAGIC
-- MAGIC
-- MAGIC