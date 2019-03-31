
# Welcome to the Iguazio Data Science Platform

<a id="document-toc"></a>
**In This Document**

- [Platform Overview](#platform-overview)
- [Data Science Workflow](#data-science-workflow)
  - [Collecting and Ingesting Data](#data-collection-and-ingestion)
  - [Exploring and Processing Data](#data-exploration-and-processing)
  - [Building and Training Models](#building-and-training-models)
  - [Deploying Models to Production](#deploying-models-to-production)
  - [Visualization, Monitoring, and Logging](#visualization-monitoring-and-logging)
- [Additional Resources](#additional-resources)
  - [Platform Documentation, Examples, and Sample Data Sets](#platform-resources)
  - [Third-Party Documentation, Examples, and Sample Data Sets](#third-party-resources)
- [Support](#support)

<a id="demo-tutorials"></a>
**End-to-End Platform Use-Case Application Demos**

See the [**demos**](demos/README.ipynb) tutorial notebooks directory for full end-to-end platform use-case application demos:

- [**stocks**](demos/stocks/read_stocks.ipynb) &mdash; combining real-time stocks data with Twitter based sentiments for smart trading
- [**netops**](demos/netops/generator.ipynb) &mdash; predictive infrastructure monitoring
- [**image_classification**](demos/image_classification/keras-cnn-dog-or-cat-classification.ipynb) &mdash; image recognition using Keras and TensorFlow
- [**nlp**](demos/nlp/nlp-example.ipynb) &mdash; natural language processing (NLP), including corrections, sentiments, and translation

<a id="platform-overview"></a>
## Platform Overview

The Iguazio Data Science Platform (**"the platform"**) is a fully integrated and secure data science platform as a service (PaaS), which simplifies development, accelerates performance, facilitates collaboration, and addresses operational challenges.
The platform incorporates the following components:

- A data science workbench that includes Jupyter Notebook, integrated analytics engines, and Python packages
- Real-time dashboards based on Grafana
- Managed data and machine-learning (ML) services over a scalable Kubernetes cluster
- A real-time serverless functions framework &mdash; Nuclio
- An extremely fast and secure data layer that supports SQL, NoSQL, time-series databases, files (simple objects), and streaming
- Integration with third-party data sources such as Amazon S3, HDFS, SQL databases, and streaming or messaging protocols

<br><img src="assets/images/igz-self-service-platform.png" alt="Self-service data science platform" width="650"/><br>

The platform uses [Kubernetes](https://kubernetes.io) (k8s) as the baseline cluster manager, and deploys various application microservices on top of Kubernetes to address different data science tasks.
Most of the provided services support scaling out and GPU acceleration and have a secure and low-latency access to the platform's shared data store and file system, enabling high performance and scalability with maximum resource efficiency.

The platform makes extensive use of [Nuclio serverless functions](https://github.com/nuclio/nuclio) to automate various tasks &mdash; such as data collection, extract-transform-load (ETL) processes, model serving, and batch jobs.
Nuclio functions describe the code and include all the required resource definitions and configuration for running the code.
The functions auto scale and can be versioned.
The platform supports various methods for generating Nuclio functions &mdash; using the graphical dashboard, Docker, Git, or Jupyter Notebook &mdash; as demonstrated in the platform tutorials.

For a more in-depth introduction to the platform, see the following resources:

- [Development Ecosystem and Managed Services](https://www.iguazio.com/docs/intro/latest-release/ecosystem)
- [Introduction video](https://www.youtube.com/watch?v=hR_Hv0_WcUw)
- [Unique data-layer architecture](https://www.iguazio.com/docs/intro/latest-release/architecture/)
- [Creating and deploying Nuclio functions with Python and Jupyter Notebook](https://github.com/nuclio/nuclio-jupyter/blob/master/README.md)

A good place to start your development is with the platform [tutorial Jupyter notebooks](https://github.com/v3io/tutorials).

- The [**GettingStarted**](GettingStarted/GettingStarted.ipynb) contains examples for performing basic tasks using the different platform APIs, as outlined in the [Data Science Workflow](#data-science-workflow) section of this introductory tutorial.
- The [**demos**](demos/README.ipynb) directory contains full end-to-end use-case application demos.

<a id="data-science-workflow"></a>
## Data Science Workflow

The Iguazio Data Science Platform provides a complete data science workflow in a single ready-to-use platform that includes all the required building blocks for creating data science applications from research to production:

- Collect, explore, and label data from various real-time or offline sources
- Run ML training and validation at scale over multiple CPUs and GPUs
- Deploy models and applications into production with serverless functions
- Log, monitor, and visualize all your data and services

<br>![](assets/images/igz-data-science-workflow.png)<br>

<a id="data-collection-and-ingestion"></a>
### Collecting and Ingesting Data

There are many ways to collect and ingest data from various sources into the platform:

- Streaming data in real time from sources such as Kafka, Kinesis, Azure Event Hubs, or Google Pub/Sub
- Loading data directly from external databases using an event-driven or periodic/scheduled implementation
- Loading files (objects), in any format (for example, CSV, Parquet, JSON, or a binary image), from internal or external sources such as Amazon S3 or Hadoop
- Importing time-series telemetry data using a Prometheus compatible scraping API
- Ingesting (writing) data directly into the system using RESTful AWS-like simple-object, streaming, or NoSQL APIs
- Using serverless functions to scrape or read data from external sources such as Twitter, weather services, or stock-trading data services

<a id="data-collection-and-ingestion-examples"></a>
#### Examples

For details and examples, see the [GettingStarted](GettingStarted/GettingStarted.ipynb#data-collection-and-ingestion) tutorial Jupyter notbeooks and the [getting-started tutorials and guides](https://www.iguazio.com/docs/tutorials/latest-release/getting-started/) in the platform documentation.
The examples include the following:

<a id="data-collection-and-ingestion-examples-by-data-sources"></a>
##### Examples By Data Source

- Ingesting data from an external SQL database to a NoSQL table using V3IO Frames &mdash; see the [ReadingFromExternalDB](GettingStarted/ReadingFromExternalDB.ipynb) notbeook.
- Ingesting data from Amazon S3 &mdash; see the [GettingStarted](GettingStarted/GettingStarted.ipynb#ingest-from-amazon-s3) notebook.
  - Ingesting data from Amazon S3 to a NoSQL table &mdash;
    - Using Spark DataFrames and curl or Botocore &mdash; see the [getting-started tutorial example](GettingStarted/GettingStarted.ipynb#getting-started-example) and [Converting a CSV File to a NoSQL Table](https://www.iguazio.com/docs/tutorials/latest-release/getting-started/ingest-n-consume-files/#convert-csv-to-nosql) tutorial, and the [SparkSQLAnalytics](GettingStarted/SparkSQLAnalytics.ipynb) notebook.
    - Using V3IO Frames and pandas DataFrames &mdash; see the [frames](GettingStarted/frames.ipynb) notebook.
- Streaming data from an external streaming engine to a NoSQL or time-series database (TSDB) table &mdash; see the [GettingStarted](GettingStarted/GettingStarted.ipynb#streaming-data-from-an-external-streaming-engine) notebook.

<a id="data-collection-and-ingestion-examples-by-api"></a>
##### Examples By API

- Ingesting data using the platform's RESTful web APIs &mdash; see the [Ingesting and Consuming Files](https://www.iguazio.com/docs/tutorials/latest-release/getting-started/ingest-n-consume-files/) and [Sending HTTP and HTTPS Requests](https://www.iguazio.com/docs/tutorials/latest-release/getting-started/fundamentals/#sending-http-requests) tutorials and the [web-API references](https://www.iguazio.com/docs/reference/latest-release/api-reference/web-apis/).
- Ingesting, consuming, and analyzing data using Spark DataFrames &mdash; see the [getting-started tutorial example](GettingStarted/GettingStarted.ipynb#getting-started-example) and [Converting a CSV File to a NoSQL Table](https://www.iguazio.com/docs/tutorials/latest-release/getting-started/ingest-n-consume-files/#convert-csv-to-nosql) tutorial, the [SparkSQLAnalytics](GettingStarted/SparkSQLAnalytics.ipynb) notebook, and the [Getting Started with Data Ingestion Using Spark](https://www.iguazio.com/docs/tutorials/latest-release/getting-started/data-ingestion-w-spark-qs/) tutorial.
- Ingesting, consuming, and analyzing data using V3IO Frames and pandas DataFrames &mdash; see the [frames](GettingStarted/frames.ipynb) notebook.
- Ingesting files (objects) from the dashboard &mdash; see the [Ingesting and Consuming Files](https://www.iguazio.com/docs/tutorials/latest-release/getting-started/ingest-n-consume-files/) tutorial.

<a id="data-collection-and-ingestion-examples-by-file-type"></a>
##### Examples By File Type

- Ingesting and using CSV files &mdash;
  - Using Spark DataFrames and curl or Botocore &mdash; see the [GettingStarted](GettingStarted/GettingStarted.ipynb), [FilesAccess](GettingStarted/FilesAccess.ipynb), and [SparkSQLAnalytics](GettingStarted/SparkSQLAnalytics.ipynb) notebooks, and the [Converting a CSV File to a NoSQL Table](https://www.iguazio.com/docs/tutorials/latest-release/getting-started/ingest-n-consume-files/#convert-csv-to-nosql) and [Getting Started with Data Ingestion Using Spark](https://www.iguazio.com/docs/tutorials/latest-release/getting-started/data-ingestion-w-spark-qs/) tutorials.
  - Using V3IO Frames &mdash; see the [frames](GettingStarted/frames.ipynb) notebook.
- Ingesting and using Parquet data files &mdash;
  - Using Spark DataFrames &mdash; see the [getting-started tutorial example](GettingStarted/GettingStarted.ipynb#getting-started-example-step-convert-data-to-parquet) and [Getting Started with Data Ingestion Using Spark](https://www.iguazio.com/docs/tutorials/latest-release/getting-started/data-ingestion-w-spark-qs/) tutorial.
  - Using pandas DataFrames &mdash; see the [ReadWriteFromParquet](GettingStarted/ReadWriteFromParquet.ipynb) notebook.
- Ingesting binary image files &mdash; see the [Ingesting and Consuming Files](https://www.iguazio.com/docs/tutorials/latest-release/getting-started/ingest-n-consume-files/) tutorial.

<a id="data-exploration-and-processing"></a>
### Exploring and Processing Data

The platform includes a wide range of integrated open-source data query and exploration tools, including the following:

- [Apache Spark](https://spark.apache.org/) data-processing engine &mdash; including the Spark SQL and Datasets, MLlib, R, and GraphX libraries &mdash; with real-time access to the platform's NoSQL data store and file system.
  For more information and examples of using Spark DataFrames to analyze data in the platform, see the [SparkSQLAnalytics](GettingStarted/SparkSQLAnalytics.ipynb) getting-started tutorial Jupyter notebook, the [Getting Started with Data Ingestion Using Spark](https://www.iguazio.com/docs/tutorials/latest-release/getting-started/data-ingestion-w-spark-qs/) tutorial, and the platform's [Spark NoSQL DataFrame reference](https://www.iguazio.com/docs/reference/latest-release/api-reference/spark-apis/spark-datasets/nosql-dataframe/).
- [Presto](http://prestodb.github.io/) distributed SQL query engine, which can be used to run interactive SQL queries over platform NoSQL tables or other object (file) data sources.
  For more information and examples of using Presto to analyze data in the platform, see the platform's [Presto reference](https://www.iguazio.com/docs/reference/latest-release/presto/overview/).
- [pandas](https://pandas.pydata.org/) Python analysis library, including structured DataFrames.
- [Dask](https://dask.org/) parallel-computing Python library, including scaled pandas DataFrames.
- [V3IO Frames](https://github.com/v3io/frames) <font color="#00BCF2">\[Tech Preview\]</font> &mdash; Iguazio's open-source data-access library, which provides a unified high-performance API for accessing NoSQL, stream, and time-series data in the platform's data store and features native integration with pandas and [NVIDIA RAPIDS](https://rapids.ai/).
- Built-in support for ML packages such as [scikit-learn](https://scikit-learn.org), [Pyplot](https://matplotlib.org/api/_as_gen/matplotlib.pyplot.html), [NumPy](http://www.numpy.org/), [PyTorch](https://pytorch.org/), and [TensorFlow](https://www.tensorflow.org/).

All these tools are integrated with the platform's Jupyter Notebook service, enabling users to access the same data through different interfaces with minimal configuration overhead.
Users can easily install additional Python packages by using the [Conda](https://anaconda.org/anaconda/conda) binary package and environment manager and the [pip](https://pip.pypa.io) Python package installer, which are both available as part of the Jupyter Notebook service.

> **Note:** You can deploy and manage application services, such as Spark and Jupyter Notebook, from the **Services** page of the platform dashboard.

Typically, data scientists use Jupyter Notebook to run the exploration phase.
You can execute code that uses different tools &mdash; such as Spark jobs or SQL queries &mdash; on the same data set from the same Jupyter notebook and without having to move the data.
The platform's unified ata model enables you to store and analyze different types of data &mdash; such as NoSQL ("key/value"), time series, stream data, and files (simple objects) &mdash; and leverage different tools for accessing and manipulating the data from a single interface.

<a id="data-exploration-and-processing-examples"></a>
#### Examples

For details and examples, see the [GettingStarted](GettingStarted/GettingStarted.ipynb#data-exploration-and-processing) platform tutorial Jupyter notebook.
The examples include the following:

- Exploring data using Spark DataFrames &mdash; see the [SparkSQLAnalytics](GettingStarted/SparkSQLAnalytics.ipynb) getting-started tutorial notebook.
- Exploring data using V3IO Frames and pandas DataFrames &mdasbh; see the [frames](GettingStarted/frames.ipynb) getting-started tutorial notebook.
- Exploring data using SQL &mdash; see the [GettingStarted](GettingStarted/GettingStarted.ipynb#data-exploration-sql) getting-started tutorial notebook.

<a id="building-and-training-models"></a>
### Building and Training Models

You can develop and test data science models in the platform's Jupyter Notebook service or in your preferred external editor.
When your model is ready, you can train it in Jupyter Notebook or by using scalable cluster resources such as Nuclio functions, Dask, Spark ML, or Kubernetes jobs.
You can find model-training examples in the platform's tutorial Jupyter notebooks:

- The [NetOps demo](demos/netops/training.ipynb) tutorial demonstrates predictive infrastructure-monitoring using scikit-learn.
- The [image-classification demo](demos/image_classification/infer.ipynb) tutorial demonstrates image recognition using TensorFlow and Keras.

If you're are a beginner, you might find the following ML guide useful &mdash; [Machine Learning Algorithms In Layman's Terms](https://towardsdatascience.com/machine-learning-algorithms-in-laymans-terms-part-1-d0368d769a7b).

<a id="deploying-models-to-production"></a>
### Deploying Models to Production

The platform allows you to easily deploy your models to production in a reproducible way by using the open-source Nuclio serverless framework.
You provide Nuclio with code or Jupyter notebooks, resource definitions (such as CPU, memory, and GPU), environment variables, package or software dependencies, data links, and trigger information.
Nuclio uses this information to automatically build the code, generate custom container images, and connect them to the relevant compute or data resources.
The functions can be triggered by a wide variety of event sources, including the most commonly used streaming and messaging protocols, HTTP APIs, scheduled (cron) tasks, and batch jobs.

Nuclio functions can be created from the platform dashboard or by using standard code IDEs, and can be deployed on your platform cluster.
A convenient way to develop and deploy Nuclio functions is by using Jupyter Notebook and Python tools.
For detailed information about Nuclio, visit the [Nuclio web site](https://nuclio.io/) and see the product [documentation](https://nuclio.io/docs/latest/).

> **Note:** Nuclio functions aren't limited to model serving: they can automate data collection, serve custom APIs, build real-time feature vectors, drive triggers, and more.

For an overview of Nuclio and how to develop, document, and deploy serverless Python Nuclio functions from Jupyter Notebook, see the [nuclio-jupyter documentation](https://github.com/nuclio/nuclio-jupyter/blob/master/README.md).
You can also find examples in the platform tutorial Jupyter notebooks; for example, the [NetOps demo](demos/netops/nuclio_infer.ipynb) tutorial demonstrates how to deploy a network-operations model as a function.

<a id="visualization-monitoring-and-logging"></a>
### Visualization, Monitoring, and Logging

Data in the platform &mdash; including collected data, internal or external telemetry and logs, and program-output data &mdash; can be analyzed and visualized in different ways simultaneously.
The platform supports multiple standard data analytics and visualization tools, including SQL, Prometheus, Grafana, and pandas.
For example, you can plot or chart data within Jupyter Notebook using [Matplotlib](https://matplotlib.org/); use your favorite BI visualization tools, such as [Tableau](https://www.tableau.com), to query data in the platform over a Java database connectivity connector (JDBC); or build real-time dashboards in Grafana.

The data analytics and visualization tools and services generate telemetry and log data that can be stored using the platform's time-series database (TSDB) service or by using external tools such as [Elasticsearch](https://www.elastic.co/products/elasticsearch).
Platform users can easily instrument code and functions to collect various statistics or logs, and explore the collected data in real time.

The [Grafana](https://grafana.com/grafana) open-source analytics and monitoring framework is natively integrated into the platform, allowing users to create dashboards that provide access to platform NoSQL tables and time-series databases from different dashboard widgets.
You can also create Grafana dashboards programmatically (for example, from Jupyter Notebook) using wizard scripts.
For information on how to create Grafana dashboards to monitor and visualize data in the platform, see [Adding a Custom Grafana Dashboard](https://www.iguazio.com/docs/tutorials/latest-release/getting-started/grafana-dashboards/).

<a id="additional-resources"></a>
## Additional Resources

<a id="platform-resources"></a>
### Platform Documentation, Examples, and Sample Data Sets

- [References](https://iguazio.com/docs/reference/latest-release/)
- [Development Ecosystem and Managed Services](https://www.iguazio.com/docs/intro/latest-release/ecosystem/)
- [Iguazio sample data sets](http://iguazio-sample-data.s3.amazonaws.com/) public Amazon S3 bucket

 <a id="third-party-resources"></a>
 ### Third-Party Documentation, Examples, and Sample Data Sets

- [10 Minutes to pandas](https://pandas.pydata.org/pandas-docs/stable/10min.html)
- [JupyterLab Tutorial](https://jupyterlab.readthedocs.io/en/stable/)
- [Machine Learning Algorithms In Layman's Terms](https://towardsdatascience.com/machine-learning-algorithms-in-laymans-terms-part-1-d0368d769a7b)
- [Registry of Open Data on AWS](https://registry.opendata.aws/)

<a id="support"></a>
## Support

The Iguazio [support team](mailto:support@iguazio.com) will be happy to assist with any questions.
