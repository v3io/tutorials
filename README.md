# Welcome to the Iguazio Data Science Platform

- [Platform Overview](#platform-overview)
- [Data Science Workflow](#data-science-workflow)
  - [Collecting and Ingesting Data](#data-collection-and-ingestion)
  - [Exploring and Processing Data](#data-exploration-and-processing)
  - [Building and Training Models](#building-and-training-models)
  - [Deploying Models to Production](#deploying-models-to-production)
  - [Visualization, Monitoring, and Logging](#visualization-monitoring-and-logging)
- [End-to-End Use-Case Applications](#end-to-end-use-case-applications)
  
  Pre-deployed demos &mdash;
  - [Natural language processing (NLP)](demos/nlp/nlp-example.ipynb)
  - [Stream enrichment](demos/stream-enrich/stream-enrich.ipynb)
  - [Smart stock trading](demos/stocks/01-gen-demo-data.ipynb)
  - [Location-based recommendations](demos/location-based-recommendations/01-generate-stores-and-customers.ipynb)
  - [Real-time-user-segmentation](demos/slots-stream/real-time-user-segmentation.ipynb)
  
  Additional demos (see the [download instructions](#mlrun-demos-download)) &mdash;
  - [XGBoost classification](demos/xgboost/train_xgboost_serverless.ipynb)
  - [LightGBM classification](demos/lightgbm/README.md)
  - [Face recognition](demos/faces/README.md)
  - [Serverless Spark](demos/spark/mlrun_sparkk8s.ipynb)
  - [Image recognition](demos/image_classification/README.md)
  - [Predictive infrastructure monitoring](demos/netops/README.md)
- [Jupyter Notebook Basics](#jupyter-notebook-basics)
  - [Creating Virtual Environments in Jupyter Notebook](#creating-virtual-environments-in-jupyter-notebook)
  - [Updating the Tutorial Notebooks](#update-notebooks)
- [Additional Resources](#additional-resources)
  - [Platform Documentation, Examples, and Sample Data Sets](#platform-resources)
  - [Third-Party Documentation, Examples, and Sample Data Sets](#third-party-resources)
- [Support](#support)

<a id="platform-overview"></a>
## Platform Overview

The Iguazio Data Science Platform (**"the platform"**) is a fully integrated and secure data science platform as a service (PaaS), which simplifies development, accelerates performance, facilitates collaboration, and addresses operational challenges.
The platform incorporates the following components:

- A data science workbench that includes Jupyter Notebook, integrated analytics engines, and Python packages
- Model management with experiments tracking and automated pipeline capabilities
- Managed data and machine-learning (ML) services over a scalable Kubernetes cluster
- A real-time serverless functions framework &mdash; Nuclio
- An extremely fast and secure data layer that supports SQL, NoSQL, time-series databases, files (simple objects), and streaming
- Integration with third-party data sources such as Amazon S3, HDFS, SQL databases, and streaming or messaging protocols
- Real-time dashboards based on Grafana

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
- [Creating and deploying Nuclio functions with Python and Jupyter Notebook](https://github.com/nuclio/nuclio-jupyter/blob/master/README.md)
<!-- [c-arch-page-update] IG-14804 TODO: When the doc architecture page is updated, return this link after the intro video: -->
<!-- - [Unique data-layer architecture](https://www.iguazio.com/docs/intro/latest-release/architecture/) -->

A good place to start your development is with the platform [tutorial Jupyter notebooks](https://github.com/v3io/tutorials), which are available in the home directory of the platform's Jupyter Notebook service; see especially the [getting-started examples](getting-started/collect-n-explore.ipynb) and full [use-case demo applications](demos/README.ipynb).
You can find a tutorials overview in the [Jupyter Notebook Basics](#jupyter-notebook-basics) section of this document.

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

For more information and examples of data collection and ingestion with the platform, see the [**getting-started-basic**](getting-started/getting-started-basic.ipynb#gs-data-collection-and-ingestion) tutorial Jupyter notebook.

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

- The [NetOps demo](demos/netops/03-training.ipynb) tutorial demonstrates predictive infrastructure-monitoring using scikit-learn.
- The [image-classification demo](demos/image-classification/01-image-classification.ipynb) tutorial demonstrates image recognition using TensorFlow and Horovod with MLRun.

If you're are a beginner, you might find the following ML guide useful &mdash; [Machine Learning Algorithms In Layman's Terms](https://towardsdatascience.com/machine-learning-algorithms-in-laymans-terms-part-1-d0368d769a7b).

<a id="experiment-tracking"></a>
#### Experiment Tracking

One of the most important and challenging areas of managing a data science environment is the ability to track experiments.
Data scientists need a simple way to track and view current and historical experiments along with the metadata that is associated with each experiment.
This capability is critical for comparing different runs, and eventually helps to determine the best model and configuration for production deployment.
The platform leverages the open-source [MLRun](https://github.com/mlrun/mlrun) library to help tackle these challenges.
You can find examples of using MLRun in the [MLRun demos](#mlrun-demos-download).

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
You can also find examples in the platform tutorial Jupyter notebooks; for example, the [NetOps demo](demos/netops/04-infer.ipynb) tutorial demonstrates how to deploy a network-operations model as a function.

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

Iguazio provides full end-to-end use-case applications (demos) that demonstrate how to use the Iguazio Data Science Platform and related tools to address data science requirements for different industries and implementations.
Some of the demos are pre-deployed with the platform and available in the **demos** tutorial-notebooks directory.<br>
<a id="mlrun-demos-download"></a>You can get additional demos from the [MLRun demos repository](https://github.com/mlrun/demos) by running the following code.
> **Note:** Some of the MLRun demos are still works in progress.


```python
# Get MLRun demos
!chmod +x /User/get-demos.sh
!/User/get-demos.sh
```

The downloaded demos include the following applications; for more details, see [**demos/README-MLRUN.md**](demos/README-MLRUN.md) (which is created as part of the download):

- <a id="xgboost-demo"></a>**XGBoost classification** ([**xgboost**](demos/xgboost/train_xgboost_serverless.ipynb)) &mdash; uses XGBoost to perform binary classification on the Iris data set (a popular machine-learning use case), and runs parallel model training with hyperparameters.
- <a id="lightgbm-demo"></a>**LightGBM classification** ([**lightgbm**](demos/lightgbm/README.md)) &mdash; uses LightGBM to perform binary classification on the HIGGS data set (a popluar machine-learning competition use case), and runs parallel model training with hyperparameters.
- <a id="face-reco-demo"></a>**Face recognition** ([**faces**](demos/faces/README.md)) &mdash; implements real-time capture of face images, image recognition, and location tracking of identities.
- <a id="serverless-spark-demo"></a>**Serverless Spark** ([**spark**](demos/spark/mlrun_sparkk8s.ipynb)) &mdash; demonstrates how to run the same Spark job locally and as a distributed MLRun job over Kubernetes.
  The Spark function can be incorporated as a step in various data-preparation and machine-learning scenarios.
- <a id="image-recog-demo"></a>**Image recognition** ([**image_classification**](demos/image_classification/README.md)) &mdash; builds and trains an ML model that identifies (recognizes) and classifies images by using Keras, TensorFlow, and scikit-learn.
- <a id="netops-demo"></a>**Predictive infrastructure monitoring** ([**netops**](demos/netops/README.md)) &mdash; builds, trains, and deploys a machine-learning model for analyzing and predicting failure in network devices as part of a network operations (NetOps) flow.
  The goal is to identify anomalies for device metrics &mdash; such as CPU, memory consumption, or temperature &mdash; which can signify an upcoming issue or failure.

The pre-deployed demos include the following use-cases applications; for more details, see [**demos/README.md**](demos/README.md) (available also as a [notebook](demos/README.ipynb):

- <a id="nlp-demo"></a>**Natural language processing (NLP)** ([**nlp**](demos/nlp/nlp-example.ipynb)) &mdash; processes natural-language textual data &mdash; including spelling correction and sentiment analysis &mdash; and generates a Nuclio serverless function that translates any given text string to another (configurable) language.
- <a id="stream-enrich-demo"></a>**Stream enrichment** ([**stream-enrich**](demos/stream-enrich/stream-enrich.ipynb)) &mdash; implements a typical stream-based data-engineering pipeline, which is required in many real-world scenarios: data is streamed from an event streaming engine; the data is enriched, in real time, using data from a NoSQL table; the enriched data is saved to an output data stream and then consumed from this stream.
- <a id="stocks-demo"></a>**Smart stock trading** ([**stocks**](demos/stocks/01-gen-demo-data.ipynb)) &mdash; reads stock-exchange data from an internet service into a time-series database (TSDB); uses Twitter to analyze the market sentiment on specific stocks, in real time; and saves the data to a platform NoSQL table that is used for generating reports and analyzing and visualizing the data on a Grafana dashboard.
- <a id="location-based-recommendations-demo"></a>**Location-based recommendations** ([**location-based-recommendations**](demos/location-based-recommendations/01-generate-stores-and-customers.ipynb)) &mdash; generates real-time product purchase recommendations for users of a credit-card company based on the users' physical location.
- <a id="real-time-user-segmentation-demo"></a>**Real-time user segmentation** ([**slots-stream**](demos/slots-stream/real-time-user-segmentation.ipynb)) &mdash; builds a stream-event processor on a sliding time window for tagging and untagging users based on programmatic rules of user behavior.

<a id="jupyter-notebook-basics"></a>
## Jupyter Notebook Basics

The platform's Jupyter Notebook service displays the JupyterLab UI, which consists of a collapsible left sidebar, a main work area (on the right), and a top menu bar.
For details, see the [JupyterLab documentation](https://jupyterlab.readthedocs.io/en/stable/user/interface.html#the-jupyterlab-interface).

The main work area (on the right) contains tabs of documents and activities &mdash; for creating, viewing, editing, and running  interactive notebooks, shell terminals, or consoles, as well as viewing and editing other common file types.
To create a new notebook or terminal, select the **New Launcher** option (`+` icon) from the top action toolbar in the left sidebar.

The top menu bar exposes available top-level actions, such as exporting a notebook in a different format.

The left-sidebar menu contains commonly used tabs, including a **File Browser** (directory icon) for browsing files.<br>
The home directory of the platform's Jupyter Notebook service contains the following files and directories:

- **v3io** directory, which displays the contents of the `v3io` platform cluster data mount for browsing the contents of the cluster's data containers.
  You can also browse the contents of the data containers from the **Data** page of the platform dashboard.
- The contents of the running-user home directory &mdash; **users/&lt;running user&gt;**.
  This directory contains the platform's [tutorial Jupyter notebooks](https://github.com/v3io/tutorials):

  - **welcome.ipynb** / [**README.md**](../README.md) &mdash; the current document, which provides a short introduction to the platform and how to use it to implement a full data science workflow.
  - [**getting-started**]() &mdash; a directory containing getting-started tutorials that explain and demonstrate how to perform different platform operations using the platform APIs and integrated tools.
  - [**demos**](demos/README.ipynb) &mdash; a directory containing [end-to-end application use-case demos](#end-to-end-use-case-applications).
  - Scripts and related notebooks for [updating the tutorial notebooks](#update-notebooks) and [downloading additional demo applications](#mlrun-demos-download).

For information about the predefined data containers and how to reference data in these containers, see [Platform Data Containers](getting-started/collect-n-explore.ipynb/#platform-data-containers) in the [**getting-started-basic**](getting-started/getting-started-basic.ipynb) tutorial notebook.

<a id="creating-virtual-environments-in-jupyter-notebook"></a>
### Creating Virtual Environments in Jupyter Notebook

A virtual environment is a named, isolated, working copy of Python that maintains its own files, directories, and paths so that you can work with specific versions of libraries or Python itself without affecting other Python projects.
Virtual environments make it easy to cleanly separate projects and avoid problems with different dependencies and version requirements across components.
See the [virutal-env](getting-started/virutal-env.ipynb) tutorial notebook for step-by-step instructions for using conda to create your own Python virtual environments, which will appear as custom kernels in Jupyter Notebook.

<a id="update-notebooks"></a>
### Updating the Tutorial Notebooks to the Latest Version

You can use the provided **igz-tutorials-get.sh** script to update the tutorial notebooks to the latest stable version available on [GitHub](https://github.com/v3io/tutorials/).
For details, see the [**update-tutorials.ipynb**](update-tutorials.ipynb) notebook.

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
