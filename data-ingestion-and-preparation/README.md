# Data Ingestion and Preparation Overview

Learn about different methods for ingesting data into the Iguazio Data Science Platform, analyzing the data, and preparing it for the next step in your data pipeline.

- [Overview](#data-ingest-overview)
  - [Platform Data Containers](#platform-data-containers)
- [Basic Flow](#data-ingest-basic-flow)
- [Reading from External Database](#data-ingest-external-dbs)
  - [Using Spark over JDBC](#data-ingest-spark-over-jdbs)
  - [Using SQLAlchemy](#data-ingest-sqlalchemy)
- [Working with Spark](#data-ingest-spark)
  - [Using Spark SQL and DataFrames](#data-ingest-spark-sql-n-dfs)
- [Working with Streams](#data-ingest-streams)
  - [Using Nuclio to Get Data from Common Streaming Engines](#data-ingest-streams-nuclio)
  - [Using the Platform's Streaming Engine](#data-ingest-streams-platform)
  - [Using Spark Streaming](#data-ingest-streams-spark)
- [Running SQL Queries on Platform Data](#data-ingest-sql)
  - [Running Full ANSI Presto SQL Queries](#data-ingest-sql-presto)
  - [Running Spark SQL Queries](#data-ingest-sql-spark)
  - [Running SQL Queries from Nuclio Functions](#data-ingest-sql-nuclio)
- [Working with Parquet Files](#data-ingest-parquet)
- [Accessing Platform NoSQL and TSDB Data Using the Frames Library](#data-ingest-frames)
- [Getting Data from AWS S3 Using curl](data-ingest-s3-curl)
- [Running Distributed Python with Dask](#data-ingest-dask)
- [Running DataFrames on GPUs using NVIDIA cuDF](#data-ingest-gpu)

<a id="data-ingest-overview"></a>
## Overview

The Iguazio Data Science Platform (**"the platform"**) allows storing data in any format.
The platform's multi-model data layer and related APIs provide enhanced support for working with NoSQL ("key-value"), time-series, and stream data.
Various steps of the data science life cycle (pipeline) might require different tools and frameworks for working with data, especially when it comes to the different mechanisms required during the research and development phase versus the operational production phase.
The platform features a wide set of methods for manipulating and managing data, of different formats, in each step of the data life cycle, using a variety of frameworks, tools, and API &mdash; such as Spark SQL and DataFrames, Spark Streaming, Presto SQL queries, pandas DataFrames, Dask, the V3IO Frames Python library, and web APIs

This document provides an overview of various methods for collecting, storing, and manipulating data in the platform, and refers to sample tutorial notebooks that demonstrate how to use these methods.<br>
For an in-depth overview of the platform and how it can be used to implement a full data science workflow, see the [**platform-overview**](../platform-overview.ipynb) tutorial notebook.<br>
For full end-to-end platform use-case application demos, see [**demos**](../demos/README.ipynb) tutorial notebooks directory.

<br><img src="../assets/images/pipeline-diagram.jpg" alt="pipeline-diagram" width="1000"/><br>

<a id="platform-data-containers"></a>
### Platform Data Containers

Data is stored within data containers in the platform's distributed file system (DFS).
All platform clusters have two predefined containers:

- <a id="default-container"></a> The default **"bigdata"** container.
- <a id="users-container"></a>The **"users"** container, which is designed to contain **&lt;username&gt;** directories that provide individual development environments for storing user-specific data.
  The platform's Jupyter Notebook, Zeppelin, and web-based shell "command-line services" automatically create such a directory for the running user of the service and set it as the home directory of the service environment.
  You can leverage the following environment variables, which are predefined in the platform's command-line services, to access this running-user directory from your code:

  - `V3IO_USERNAME` &mdash; set to the username of the running user of the Jupyter Notebook service.
  - `V3IO_HOME` &mdash; set to the running-user directory in the "users" container &mdash; **users/&lt;running user&gt;**.
  - `V3IO_HOME_URL` &mdash; set to the fully qualified `v3io` path to the running-user directory &mdash; `v3io://users/<running user>`.

The data containers and their contents are referenced differently depending on the programming interface.
For example:

- In local file-system (FS) commands you use the predefined `v3io` root data mount &mdash; `/v3io/<container name>[/<data path>]`.
  There's also a predefined local-FS `User` mount to the **users/&lt;running user&gt;** directory, and you can use the aforementioned environment variables when setting data paths.
  For example, `/v3io/users/$V3IO_USERNAME`, `/v3io/$V3IO_HOME`, and `/User` are all valid ways of referencing the **users/&lt;running user&gt;** directory from a local FS command.
- In Hadoop FS or Spark DataFrame commands you use a fully qualified path of the format `v3io://<container name>/<data path>`.
  You can also use environment variables with these interfaces.

For detailed information and examples on how to set the data path for each interface, see [Setting Data Paths](https://www.iguazio.com/docs/latest-release/tutorials/getting-started/fundamentals/#data-paths) and the examples in the platform's tutorial Jupyter notebooks.

<a id="data-ingest-basic-flow"></a>
## Basic Flow

The [**basic-data-ingestion-and-preparation**](basic-data-ingestion-and-preparation.ipynb) tutorial walks you through basic scenarios of ingesting data from external sources into the platform's data store and manipulating the data using different data formats.
The tutorial includes an example of ingesting a CSV file from an AWS S3 bucket; converting it into a NoSQL table using Spark DataFrames; running SQL queries on the table; and converting the table into a Parquet file.

<a id="data-ingest-external-dbs"></a>
## Reading Data from External Databases

You can use different methods to read data from external databases into the platform's data store, such Spark over JDBC or SQLAlchemy.

<a id="data-ingest-spark-over-jdbs"></a>
### Using Spark over JDBC

Spark SQL includes a data source that can read data from other databases using Java database connectivity (JDBC).
The results are returned as a Spark DataFrame that can easily be processed using Spark SQL, or joined with other data sources.
The [**spark-jdbc**](spark-jdbc.ipynb) tutorial includes several examples of using Spark JDBC to ingest data from various databases &mdash; such as MySQL, Oracle, and PostgreSQL.

<a id="data-ingest-sqlalchemy"></a>
### Using SQLAlchemy

The [**read-external-db**](read-external-db.ipynb) tutorial outlines how to ingest data using [SQLAlchemy](https://www.sqlalchemy.org/) &mdash; a Python SQL toolkit and Object Relational Mapper, which gives application developers the full power and flexibility of SQL &mdash; and then use Python DataFrames to work on the ingested data set.

<a id="data-ingest-spark"></a>
## Working with Spark

The platform has a default pre-deployed Spark service that enables ingesting, analyzing, and manipulating data using different [Spark](http://spark.apache.org) APIs:

- Using Spark SQL and DataFrames
- Using the Spark Streaming API &mdash; see [Using Streaming Streaming](#data-ingest-streams-spark) under "Working with Spark".

<a id="data-ingest-spark-sql-n-dfs"></a>
### Using Spark SQL and DataFrames

Spark lets you write and query structured data inside Spark programs by using either SQL or a familiar DataFrame API.
DataFrames and SQL provide a common way to access a variety of data sources.
You can use the [Spark SQL and DataFrames](https://spark.apache.org/sql/) API to ingest data into the platform, for both batch and micro-batch processing, and analyze and manipulate large data sets, in a distributed manner.

The platform's custom NoSQL Spark DataFrame implements the Spark data-source API to support a custom data source that enables reading and writing data in the platform's NoSQL store using Spark DataFrames, including enhanced features such as data pruning and filtering (predicate push down); queries are passed to the platform's data store, which returns only the relevant data.
This allows accelerated and high-speed access from Spark to data stored in the platform.

The [**spark-sql-analytics**](spark-sql-analytics.ipynb) tutorial demonstrates how to use Spark SQL and DataFrames to access objects, tables, and unstructured data that persists in the platform's data store.

For more information and examples of data ingestion with Spark DataFrames, see [Getting Started with Data Ingestion Using Spark](https://www.iguazio.com/docs/latest-release/tutorials/getting-started/data-ingestn-w-spark-qs/).<br>
For more about running SQL queries with Spark, see [Running Spark SQL Queries](#data-ingest-sql-spark) under "Running SQL Queries on Platform Data".

<a id="data-ingest-streams"></a>
## Working with Streams

The platform supports various methods for working with data streams, including the following:

- [Using Nuclio to Get Data from Common Streaming Engines](#data-ingest-streams-nuclio)
- [Using the Platform's Streaming Engine](#data-ingest-streams-platform)
- [Using Spark Streaming](#data-ingest-streams-spark)

<a id="data-ingest-streams-nuclio"></a>
### Using Nuclio to Get Data from Common Streaming Engines

The platform has a default pre-deployed Nuclio service that uses Iguazio's [Nuclio](https://nuclio.io/) serverless-framework, which provides a mechanism for analyzing and processing real-time events from various streaming engines.
Nuclio currently supports the following streaming frameworks &mdash; Kafka, Kinesis, Azure Event Hubs, platform streams (a.k.a. V3IO streams), RabbitMQ, and MQTT.

Using Nuclio functions to retrieve and analyze streaming data in real time is a very common practice when building a real-time data pipeline.
You can stream any type of data &mdash; such as telemetry (NetOps) metrics, financial transactions, web clicks, or sensors data &mdash; in any format, including images and videos. 
You can also implement your own logic within the Nuclio function to manipulate or enrich the consumed stream data and prepare it for the next step in the pipeline.

Nuclio serverless functions can sustain high workloads with very low latencies, thus making them very useful for building an event-driven applications with strict latency requirements.

For more information about Nuclio, see the platform's [serverless introduction](https://www.iguazio.com/docs/intro/latest-release/serverless/).

<a id="data-ingest-streams-platform"></a>
### Using the Platform's Streaming Engine 

The platform features a custom streaming engine and a related stream format &mdash; a platform stream (a.k.a. V3IO stream).
You can use the platform's streaming engine to write data into a queue in a real-time data pipeline, or as a standard streaming engine (similar to Kafka and Kinesis), so you don't need to use an external engine.

The platform's streaming engine is currently available via the platform's [Streaming Web API](https://www.iguazio.com/docs/latest-release/reference/api-reference/web-apis/streaming-web-api/).<br>
In addition, the platform's Spark-Streaming Integration API enables using the Spark Streaming API to work with platform streams, as explained in the next section ([Using Spark Streaming](#data-ingest-streams-spark)).

The [**stream-enrich**](../demos/stream-enrich/stream-enrich.ipynb) demo application includes an example of a Nuclio function that uses platform streams.

<a id="data-ingest-streams-spark"></a>
### Using Spark Streaming

You can use the [Spark Streaming](http://spark.apache.org/streaming/) API to ingest, consume, and analyze data using data streams.
The platform features a custom [Spark-Streaming Integration API](https://www.iguazio.com/docs/latest-release/reference/api-reference/spark-apis/spark-streaming-integration-api/) to allow using the Spark Streaming API with [platform streams](#data-ingest-streams-platform).

<!-- TODO: Add more information / add a tutorial and refer to it. -->

<a id="data-ingest-sql"></a>
## Running SQL Queries on Platform Data

You can run SQL queries on NoSQL and Parquet data in the platform's data store, using any of the following methods:

- [Running full ANSI Presto SQL queries](#data-ingest-sql-presto) using SQL magic
- [Running Spark SQL queries](#data-ingest-sql-spark)
- [Running SQL queries from Nuclio functions](#data-ingest-sql-nuclio)

<a id="data-ingest-sql-presto"></a>
### Running Full ANSI Presto SQL Queries

The platform has a default pre-deployed Presto service that enables using the [Presto](https://prestosql.io/) open-source distributed SQL query engine to run interactive SQL queries and perform high-performance low-latency interactive analytics on data that's stored in the platform.
To run a Presto query from a Jupyter notebook, all you need is to use an SQL magic command &mdash; `%sql` followed by your Presto query.
Such queries are executed as distributed queries across the platform's application nodes.
The [**basic-data-ingestion-and-preparation**](basic-data-ingestion-and-preparationipynb) tutorial demonstrates how to run Presto queries using SQL magic.

Note that for running queries on Parquet tables, you need to work with Hive tables.
The [**csv-to-hive**](csv-to-hive.ipynb) tutorial includes a script that converts a CSV file into a Hive table.

<a id="data-ingest-sql-spark"></a>
### Running Spark SQL Queries

The [**spark-sql-analytics**](spark-sql-analytics.ipynb) tutorial demonstrates how to run Spark SQL queries on data in the platform's data store.

For more information about the platform's Spark service, see [Working with Spark](#data-ingest-spark) in this document.

<a id="data-ingest-sql-nuclio"></a>
### Running SQL Queries from Nuclio Functions 

In some cases, you might need to run an SQL query as part an event-driven application.
The [**nuclio-read-via-presto**](nuclio-read-via-presto.ipynb) tutorial demonstrates how to run an SQL query from a serverless Nuclio function.

<a id="data-ingest-parquet"></a>
## Working with Parquet Files

Parquet is a columnar storage format that provides high-density high-performance file organization.<br>
The [**parquet-read-write**](parquet-read-write.ipynb) tutorial demonstrates how to create and write data to a Parquet table in the platform and read data from the table.

After you ingest Parquet files into the platform, you might want to create related Hive tables and run SQL queries on these tables.<br>
The [**parquet-to-hive**](parquet-to-hive.ipynb) tutorial demonstrates how you can do this using Spark DataFrames.

<a id="data-ingest-frames"></a>
## Accessing Platform NoSQL and TSDB Data Using the Frames Library

[V3IO Frames](https://github.com/v3io/frames) (**"Frames"**) is a multi-model open-source data-access library, developed by Iguazio, which provides a unified high-performance DataFrame API for working with data in the platform's data store.
Frames currently supports the NoSQL (key-value) and time-series (TSDB) data models via its NoSQL (`nosql`|`kv`) and TSDB (`tsdb`) backends.
The [**frames**](frames.ipynb) tutorial provides an introduction to Frames and demonstrates how to use it to work with NoSQL and TSDB data in the platform.

<a id="data-ingest-s3-curl"></a>
## Getting Data from AWS S3 Using curl

A simple way to ingest data from the Amazon Simple Storage Service (S3) into the platform's data store is to run a curl command that sends an HTTP request to the relevant AWS S3 bucket, as demonstrated in the following code cell.
For more information and examples, see the [**basic-data-ingestion-and-preparation**](basic-data-ingestion-and-preparation.ipynb#ingest-from-amazon-s3-using-curl) tutorial.
<!-- TODO: Add a reference to the XCP tool and explain how to load a bulk of data from S3. -->


```sh
%%sh
CSV_PATH="/User/examples/stocks.csv"
curl -L "iguazio-sample-data.s3.amazonaws.com/2018-03-26_BINS_XETR08.csv" > ${CSV_PATH}
```

<a id="data-ingest-dask"></a>
## Running Distributed Python Code with Dask

[Dask](https://dask.org/) is a flexible library for parallel computing in Python, which is useful for computations that don't fit into a DataFrame.
Dask exposes low-level APIs that enable you to build custom systems for in-house applications.
This helps parallelize Python processes and dramatically accelerates their performance.
The [**dask-cluster**](dask-cluster.ipynb) tutorial demonstrates how to use Dask with platform data.

<a id="data-ingest-gpu"></a>
## Running DataFrames on GPUs using NVIDIA cuDF

The platform allows you to use NVIDIA's [RAPIDS](https://rapids.ai/) open-source libraries suite to execute end-to-end data science and analytics pipelines entirely on GPUs.
[cuDF](https://docs.rapids.ai/api/cudf/stable/) is a RAPIDS GPU DataFrame library for loading, joining, aggregating, filtering, and otherwise manipulating data.
This library features a pandas-like API that will be familiar to data engineers and data scientists, who can use it to easily accelerate their workflows without going into the details of CUDA programming.
The [**gpu-cudf-vs-pd**](gpu-cudf-vs-pd.ipynb) tutorial demonstrates how to use the cuDF library and compares performance benchmarks with pandas and cuDF.

> **Note:** To use the cuDF library, you need to create a RAPIDS Conda environment.
> For more information, see the [**virtual-env**](virtual-env.ipynb) tutorial.
