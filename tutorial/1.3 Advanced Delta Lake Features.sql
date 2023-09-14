-- Databricks notebook source
DESCRIBE HISTORY employees

-- COMMAND ----------

SELECT *
FROM employees VERSION AS OF 1

-- COMMAND ----------

SELECT *
FROM employees@v1

-- COMMAND ----------

DELETE FROM employees

-- COMMAND ----------

SELECT * FROM employees

-- COMMAND ----------

RESTORE TABLE employees TO VERSION AS OF 2

-- COMMAND ----------

SELECT * FROM employees

-- COMMAND ----------

DESCRIBE HISTORY employees

-- COMMAND ----------

/* Optimize */
DESCRIBE DETAIL employees

-- COMMAND ----------

OPTIMIZE employees
ZORDER BY (id)

-- COMMAND ----------

DESCRIBE DETAIL employees

-- COMMAND ----------

DESCRIBE HISTORY employees

-- COMMAND ----------

-- MAGIC %fs ls 'dbfs:/user/hive/warehouse/employees'

-- COMMAND ----------

/* Vacuum */
VACUUM employees

-- COMMAND ----------

-- MAGIC %fs ls 'dbfs:/user/hive/warehouse/employees'

-- COMMAND ----------

-- MAGIC %python spark.conf.set("spark.databricks.delta.retentionDurationCheck.enabled", False)
-- MAGIC // Required for vacuuming w/o retention time (next). NOT IN PROD!
-- MAGIC // Python seems to be the only way to update Spark conf settings after creation of Spark cluster.
-- MAGIC // Compute -> Cluster -> Config / Advanced config / Spark cluster
-- MAGIC // or %sql SET spark.databricks.delta.retentionDurationCheck.enabled = false;

-- COMMAND ----------

/* Vacuum with no retention time */

VACUUM employees RETAIN 0 HOURS

-- COMMAND ----------

/* Fails due vacuum */
SELECT * FROM employees@v1

-- COMMAND ----------

/*
DROP TABLE employees 

will remove table and accociated files permanently:

SELECT * FROM employees
-> Table or vied not found: employees exception thrown.

%fs ls 'dbfs:/user/hive/warehouse/employees' 
-> FileNotFoundException excemption thrown.

*/
