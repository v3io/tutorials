
# Welcome to the Iguazio Data Science Platform

- [Platform Overview](#platform-overview)
- [Data Science Workflow](#data-science-workflow)
  - [Collecting and Ingesting Data](#data-collection-and-ingestion)
  - [Exploring and Processing Data](#data-exploration-and-processing)
  - [Building and Training Models](#building-and-training-models)
  - [Deploying Models to Production](#deploying-models-to-production)
  - [Visualization, Monitoring, and Logging](#visualization-monitoring-and-logging)
- [End-to-End Use-Case Applications](#end-to-end-use-case-applications)
  - [Smart Stock Trading](demos/stocks/read-stocks.ipynb)
  - [Predictive Infrastructure Monitoring](demos/netops/generator.ipynb)
  - [Image Recognition](demos/image-classification/keras-cnn-dog-or-cat-classification.ipynb)
  - [Natural Language Processing (NLP)](demos/nlp/nlp-example.ipynb)
  - [Stream Enrichment](demos/stream-enrich/stream-enrich.ipynb)
- [Jupyter Notebook Basics](#jupyter-notebook-basics)
  - [Creating Virtual Environments in Jupyter Notebook](#creating-virtual-environments-in-jupyter-notebook)
  - [Sync notebooks](#sync-notebooks)
- [Additional Resources](#additional-resources)
  - [Platform Documentation, Examples, and Sample Data Sets](#platform-resources)
  - [Third-Party Documentation, Examples, and Sample Data Sets](#third-party-resources)
- [Support](#support)

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

- [Components, Services, and Development Ecosystem](https://www.iguazio.com/docs/intro/latest-release/ecosystem)
- [Introduction video](https://www.youtube.com/watch?v=hR_Hv0_WcUw)
- [Unique data-layer architecture](https://www.iguazio.com/docs/intro/latest-release/architecture/)
- [Creating and deploying Nuclio functions with Python and Jupyter Notebook](https://github.com/nuclio/nuclio-jupyter/blob/master/README.md)

A good place to start your development is with the platform [tutorial Jupyter notebooks](https://github.com/v3io/tutorials).

- The [**getting-started**](getting-started/collect-n-explore.ipynb) directory contains information and code examples to help you quickly get started using the platform.
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

- Streaming data in real time from sources such as Kafka, Kinesis, Azure Event Hubs, or Google Pub/Sub.
- Loading data directly from external databases using an event-driven or periodic/scheduled implementation.
  See the explanation and examples in the [**read-external-db**](getting-started/read-external-db.ipynb#ingest-from-external-db-to-no-sql-using-frames) tutorial.
- Loading files (objects), in any format (for example, CSV, Parquet, JSON, or a binary image), from internal or external sources such as Amazon S3 or Hadoop.
  See, for example, the [**file-access**](getting-started/file-access.ipynb) tutorial.
- Importing time-series telemetry data using a Prometheus compatible scraping API.
- Ingesting (writing) data directly into the system using RESTful AWS-like simple-object, streaming, or NoSQL APIs.
  See the platform's [Web-API References](https://www.iguazio.com/docs/reference/latest-release/api-reference/web-apis/).
- Scraping or reading data from external sources &mdash; such as Twitter, weather services, or stock-trading data services &mdash; using serverless functions.
  See, for example, the [**stocks**](demos/stocks/read-stocks.ipynb) demo use-case application.

For more information and examples of data collection and ingestion wcollect-n-exploreith the platform, see the [**collect-n-explore**](getting-started/collect-n-explore.ipynb#gs-data-collection-and-ingestion) tutorial Jupyter notebook.

<a id="data-exploration-and-processing"></a>
### Exploring and Processing Data

The platform includes a wide range of integrated open-source data query and exploration tools, including the following:

- [Apache Spark](https://spark.apache.org/) data-processing engine &mdash; including the Spark SQL and Datasets, MLlib, R, and GraphX libraries &mdash; with real-time access to the platform's NoSQL data store and file system.
  See the platform's [Spark APIs reference](https://www.iguazio.com/docs/reference/latest-release/api-reference/spark-apis/) and the examples in the [**spark-sql-analytics**](getting-started/spark-sql-analytics.ipynb) tutorial.
- [Presto](http://prestodb.github.io/) distributed SQL query engine, which can be used to run interactive SQL queries over platform NoSQL tables or other object (file) data sources.
  See the platform's [Presto reference](https://www.iguazio.com/docs/reference/latest-release/presto/).
- [pandas](https://pandas.pydata.org/) Python analysis library, including structured DataFrames.
- [Dask](https://dask.org/) parallel-computing Python library, including scaled pandas DataFrames.
- [V3IO Frames](https://github.com/v3io/frames) &mdash; Iguazio's open-source data-access library, which provides a unified high-performance API for accessing NoSQL, stream, and time-series data in the platform's data store and features native integration with pandas and [NVIDIA RAPIDS](https://rapids.ai/).
  See, for example, the [**frames**](getting-started/frames.ipynb) tutorial.
- Built-in support for ML packages such as [scikit-learn](https://scikit-learn.org), [Pyplot](https://matplotlib.org/api/_as_gen/matplotlib.pyplot.html), [NumPy](http://www.numpy.org/), [PyTorch](https://pytorch.org/), and [TensorFlow](https://www.tensorflow.org/).

All these tools are integrated with the platform's Jupyter Notebook service, allowing users to access the same data from Jupyter through different interfaces with minimal configuration overhead.
Users can easily install additional Python packages by using the [Conda](https://anaconda.org/anaconda/conda) binary package and environment manager and the [pip](https://pip.pypa.io) Python package installer, which are both available as part of the Jupyter Notebook service.
This design, coupled with the platform's unified data model, enables users to store and access data using different formats &mdash; such as NoSQL ("key/value"), time series, stream data, and files (simple objects) &mdash; and leverage different tools and APIs for accessing and manipulating the data, all from a single development environment (namely, Jupyter Notebook).

> **Note:** You can deploy and manage application services, such as Spark and Jupyter Notebook, from the **Services** page of the platform dashboard.

For more information and examples of data exploration with the platform, see the [**collect-n-explore**](getting-started/collect-n-explore.ipynb#gs-data-exploration-and-processing) tutorial Jupyter notebook.

<a id="building-and-training-models"></a>
### Building and Training Models

You can develop and test data science models in the platform's Jupyter Notebook service or in your preferred external editor.
When your model is ready, you can train it in Jupyter Notebook or by using scalable cluster resources such as Nuclio functions, Dask, Spark ML, or Kubernetes jobs.
You can find model-training examples in the platform's tutorial Jupyter notebooks:

- The [NetOps demo](demos/netops/training.ipynb) tutorial demonstrates predictive infrastructure-monitoring using scikit-learn.
- The [image-classification demo](demos/image-classification/infer.ipynb) tutorial demonstrates image recognition using TensorFlow and Keras.

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
You can also find examples in the platform tutorial Jupyter notebooks; for example, the [NetOps demo](demos/netops/infer.ipynb) tutorial demonstrates how to deploy a network-operations model as a function.

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

<a id="end-to-end-use-case-applications"></a>
## End-to-End Use-Case Applications

Iguazio provides full end-to-end use-case applications that demonstrate how to use the Iguazio Data Science Platform and related tools to address data science requirements for different industries and implementations.
The applications are provided in the **demos** directory of the platform's tutorial Jupyter notebooks and cover the following use cases; for more detailed descriptions, see the demos README ([notebook](demos/README.ipynb) / [Markdown](demos/README.md)):

- <a id="stocks-use-case-app"></a>**Smart stock trading** ([**stocks**](demos/stocks/read-stocks.ipynb)) &mdash; the application reads stock-exchange data from an internet service into a time-series database (TSDB); uses Twitter to analyze the market sentiment on specific stocks, in real time; and saves the data to a platform NoSQL table that is used for generating reports and analyzing and visualization the data in a Grafana dashboard.
- <a id="netops-use-case-app"></a>**Predictive infrastructure monitoring** ([**netops**](demos/netops/generator.ipynb)) &mdash; the application builds, trains, and deploys a machine-learning model for analyzing and predicting failure in network devices as part of a network operations (NetOps) flow. The goal is to identify anomalies for device metrics &mdash; such as CPU, memory consumption, or temperature &mdash; which can signify an upcoming issue or failure.
- <a id="image-recog-use-case-app"></a>**Image recognition** ([**image-classification**](demos/image-classification/keras-cnn-dog-or-cat-classification.ipynb)) &mdash; the application builds and trains an ML model that identifies (recognizes) and classifies images by using Keras, TensorFlow, and scikit-learn.
- <a id="nlp-use-case-app"></a>**Natural language processing (NLP)** ([**nlp**](demos/nlp/nlp-example.ipynb)) &mdash; the application processes natural-language textual data &mdash; including spelling correction and sentiment analysis &mdash; and generates a Nuclio serverless function that translates any given text string to another (configurable) language.
- <a id="stream-enrich-use-case-app"></a>**Stream enrichment** ([**stream-enrich**](demos/stream-enrich/stream-enrich.ipynb)) &mdash; the application demonstrates a typical stream-based data-engineering pipeline, which is required in many real-world scenarios: data is streamed from an event streaming engine; the data is enriched, in real time, using data from a NoSQL table; the enriched data is saved to an output data stream and then consumed from this stream.

<a id="jupyter-notebook-basics"></a>
## Jupyter Notebook Basics

The platform's Jupyter Notebook service displays the JupyterLab UI, which consists of a collapsible left sidebar, a main work area (on the right), and a top menu bar.
For details, see the [JupyterLab documentation](https://jupyterlab.readthedocs.io/en/stable/user/interface.html#the-jupyterlab-interface).

The main work area (on the right) contains tabs of documents and activities &mdash; for creating, viewing, editing, and running  interactive notebooks, shell terminals, or consoles, as well as viewing and editing other common file types.
To create a new notebook or terminal, select the **New Launcher** option (`+` icon) from the top action toolbar in the left sidebar.

The top menu bar exposes available top-level actions, such as exporting a notebook in a different format.

The left-sidebar menu contains commonly used tabs, including a **File Browser** (directory icon) for browsing files.<br>
The root file-browser directory of the platform's Jupyter Notebook service contains the following files and directories:

- **v3io** directory, which displays the contents of the `v3io` platform cluster data mount for browsing the contents of the cluster's data containers.
  You can also browse the contents of the data containers from the **Data** page of the platform dashboard.
- The contents of the running-user home directory &mdash; **users/&lt;running user&gt;**.
  This directory contains the platform's [tutorial Jupyter notebooks](https://github.com/v3io/tutorials):

  - [**welcome.ipynb**](../welcome.ipynb) / [**README.md**](../README.md) &mdash; the current document, which provides a short introduction to the platform and how to use it to implement a full data science workflow.
  - **getting-started** &mdash; a directory containing getting-started tutorials that explain and demonstrate how to perform different platform operations using the platform APIs and integrated tools.
  - **demos** &mdash; a directory containing [end-to-end application use-case demos](#end-to-end-use-case-applications).

For information about the predefined data containers and how to reference data in these containers, see [Platform Data Containers](getting-started/collect-n-explore.ipynb/#platform-data-containers) in the **collect-n-explore** tutorial notebook.

<a id="creating-virtual-environments-in-jupyter-notebook"></a>
### Creating Virtual Environments in Jupyter Notebook

A virtual environment is a named, isolated, working copy of Python that maintains its own files, directories, and paths so that you can work with specific versions of libraries or Python itself without affecting other Python projects.
Virtual environments make it easy to cleanly separate projects and avoid problems with different dependencies and version requirements across components.
See the [virutal-env](getting-started/virutal-env.ipynb) tutorial notebook for step-by-step instructions for using conda to create your own Python virtual environments, which will appear as custom kernels in Jupyter Notebook.

<a id="sync-notebooks"></a>
### Sync notebooks with the latest notebooks from Git

At any point in time you can sync the demo notebooks from git to get the latest versions

Note that the sync would not overwrite any new files that had been created by the user


```python
!chmod +x /v3io/${V3IO_HOME}/get_demos.sh
!/v3io/${V3IO_HOME}/get_demos.sh iguazio
```

<a id="additional-resources"></a>
## Additional Resources

<a id="platform-resources"></a>
### Platform Documentation, Examples, and Sample Data Sets

- [References](https://iguazio.com/docs/reference/latest-release/)
- [Components, Services, and Development Ecosystem](https://www.iguazio.com/docs/intro/latest-release/ecosystem/)
- [Iguazio sample data-set](http://iguazio-sample-data.s3.amazonaws.com/) public Amazon S3 bucket

 <a id="third-party-resources"></a>
 ### Third-Party Documentation, Examples, and Sample Data Sets

- [10 Minutes to pandas](https://pandas.pydata.org/pandas-docs/stable/10min.html)
- [JupyterLab Tutorial](https://jupyterlab.readthedocs.io/en/stable/)
- [Machine Learning Algorithms In Layman's Terms](https://towardsdatascience.com/machine-learning-algorithms-in-laymans-terms-part-1-d0368d769a7b)
- [Registry of Open Data on AWS](https://registry.opendata.aws/)

<a id="support"></a>
## Support

The Iguazio [support team](mailto:support@iguazio.com) will be happy to assist with any questions.
