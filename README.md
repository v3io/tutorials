# Iguazio Platform Getting Started Guide and Tutorials 

* [Platform Overview](#Platform-Overview)
* [Data science workflow](#Data-science-workflow-on-iguazio-platform)
  * [Data collection and ingestion](#Data-collection-and-ingestion)
  * [Data exploration and processing](#Data-Exploration-and-Processing)
  * [Building and training models](#Building-and-training-models)
  * [Models deployment to production](#Models-deployment-to-Production)
  * [Visulization, monitoring and logging](#Visulization%2C-monitoring-and-logging)
* End to end use-cases (tutorials)
  * [Combining real-time stocks data with twitter based sentiments for smart trading](demos/stocks/explore.ipynb)
  * [Predictive infrastructure monitoring](demos/netops/generator.ipynb)
  * [Image recognition (with Keras and TensorFlow)](demos/image_classification/keras-cnn-dog-or-cat-classification.ipynb)
  * [Natural language processing (corrections, sentiments, translation)](demos/nlp/nlp-example.ipynb)
* Useful links
  * [API reference](https://iguazio.com/docs/reference/latest-release/api-reference/)
  * [Development eco system](https://www.iguazio.com/docs/intro/latest-release/ecosystem/)
  * [10 Minutes to pandas](https://pandas.pydata.org/pandas-docs/stable/10min.html)
  * [Jupyter lab tutorial](https://jupyterlab.readthedocs.io/en/stable/)
  * [Machine Learning Algorithms In Layman’s Terms](https://towardsdatascience.com/machine-learning-algorithms-in-laymans-terms-part-1-d0368d769a7b)
* [Support](#Support)
* [Others](#Others)


## Platform Overview

Iguazio provides a fully integrated and secure data science PaaS which simplify development, accelerate performance, <br>
enable collaboration, and address operational challenges. The platform incorporate the following components:

•	Data science workbench (Jupyter with integrated analytics engines & Python packages) <br>
•	Real-time dashboards based on Grafana<br>
•	Managed data and ML services over scalable Kubernetes cluster <br>
•	Real-time serverless functions framework (aka [Nuclio](https://github.com/nuclio/nuclio)).<br>
•	Extremely fast and secure data layer supporting SQL, NoSQL, time series , files/objects and streaming <br>
•	Integration with 3rd party data sources (S3, HDFS, SQL DBs, Streaming/messaging protocols, etc.)<br>

<br>![](assets/images/igz-self-service-platform.png)

We use Kubernetes as the baseline cluster manager and deploy various microservices on top to address the different data-science tasks.<br>
most services support scaling out, support GPU acceleration, and have secure and low-latency access to iguazio shared database and file-system<br> 
enabling high performance and scalability at maximum resource efficiency.<br>

The platform make extensive use of [Nuclio serverless functions](https://github.com/nuclio/nuclio) to automate various tasks from data collection, ETLs, custom APIs, model serving, and batch jobs<br>
functions describe the code with all the resource definitions and configuration needed to make it run, functions auto-scale and can be versioned<br>
functions can be generated automatically in various ways (UI, Docker, Git, and Jupyter), this is demonstrated in the various tutorials. 

For more details:
* [Detailed Platform overview](PlatformComponents.pdf)
* [Introduction video](https://www.youtube.com/watch?v=hR_Hv0_WcUw)
* [Iguazio platform and unique data layer architecture](https://www.iguazio.com/docs/intro/latest-release/architecture/)
* [creating and deploying Nuclio functions from Jupyter or python](https://github.com/nuclio/nuclio-jupyter/blob/master/README.md#installing)

# Data science workflow on iguazio platform

Iguazio  enable a complete data science workflow in a single ready to use platform:
* Collect, explore and label data coming from various real-time or offline sources
* Run ML training and validation at scale over multiple CPUs and GPUs
* Deploy models and applications into production with Serverless functions
* Log, monitor, and version all your data and services 

<br><img src="assets/images/igz-data-science-workflow.png" align="middle">


Iguazio provides all the building blocks for creating data science applications from research to production. <br> 

### Data collection and ingestion

<b>For details visit the [data collection and exploration tutorial](GettingStarted/GettingStarted.ipynb)<b>

There are many ways to collect or ingest data into the system from various sources: 
* Real-time streaming from (e.g. using Kafka, Kinesis, Azure Event Hub, Google Pub/sub)
* Loading data directly from external database in an event driven or periodic/scheduled way 
* Loading data from internal or external file/object sources like S3 or Hadoop (using CSV, Parquet, Json formats)
* Importing time-series telemetry data using Prometheus compatible scraping API
* Pushing/ingesting data directly into the system via AWS like object, streaming and NoSQL RestAPIs
* By implementing custom nuclio functions which scrape data from external sources or read form external API sources (e.g. Twitter, Weather services, Stock trading data, etc.)

### Data Exploration and Processing

Iguazio provides a wide range of pre-integrated data query and exploration tools. The most common ones are: 
* [Apache Spark](https://spark.apache.org/) SQL, ML, R, Graph (with read-time access to iguazio DB and file-system)
* interactive SQL queries (using [Apache Presto](http://prestodb.github.io/) distributed processing engine over iguazio DB or file/object data sources)
* [Python Pandas](https://pandas.pydata.org/) dataframe (or Dask for “distributed Pandas like”)<br>
* Frames - Iguazio open source high speed library for data access providing unified interface for NoSQL tables, Time series tables and Streaming data<br> and native integration with Pandas and [NVIDIA RAPIDS](https://rapids.ai/).
* Built in ML packages:  Scikit learn , Pyplot , numpy, Pytorch and Tensorflow. 
<br>
All the tools are integrated with Jupyter notebook allowing access to same data through multiple tools and APIs, and with minimal configuration overhead.<br>
The Python environment has pre-deployed conda package. Users can install any packages using pip and conda. 

> Note: to deploy add-on services such as Spark use the platform `services` tab  


### Building and training models

Models can be developed and tested in the Jupyter notebooks or using external editors<br>
Once you built a model you can train it inside Jupyter or use scalable cluster resources such as Nuclio functions, Dask, Spark ML, or Kubernetes Jobs<br>
You can see examples of model training in the [predictive infrastructure monitoring tutorial](demos/netops/training.ipynb) (using Scikit Learn) or in the [image recognition tutorial]() (using TensorFlow and Keras)<br>

If you are a beginner this useful guide for [machine Learning Algorithms In Layman’s Terms](https://towardsdatascience.com/machine-learning-algorithms-in-laymans-terms-part-1-d0368d769a7b) can come in handy

### Models deployment to Production

With iguazio platform users can easily deploy their model to production in a reproducible way using the open-source nuclio serverless framework<br>
nuclio takes code (or notebooks) coupled with resource definitions (CPU, memory, GPU, ..), environment variables, package or software dependencies, data links, and trigger information. nuclio automatically builds the code, generate custom container images and wire them up to the relevant compute or data resources<br>
nuclio functions can be triggered by a wide variety of event sources including most commonly used streaming and messaging protocols, HTTP APIs, scheduled (cron) tasks, and batch jobs. read more [details about nuclio](https://github.com/nuclio/nuclio)<br>

Nuclio functions can be created in the platform UI, or using standard code IDEs and be deployed on the cluster<br>
One of the most convenient way is to develop and deploy functions is using Jupyter and the Python tools<br>

Here is a an overview of Nuclio and how to work and deploy your python code from Jupyter to a serverless function <br>
https://github.com/nuclio/nuclio-jupyter/blob/master/README.md#installing <br>
Many of the tutorials demonstrate how functions can be documented and deployed directly from a Notebook, e.g.
[deploying the network operation model as a function](demos/netops/nuclio_infer.ipynb)

Note that nuclio functions are not limited to model serving, they can automate data collection, serve custom APIs, build real-time feature vectors, drive triggers, etc.


### Visulization, monitoring and logging

Collected data, internal/external telemetry and logs, output data, etc. can be visualized in different ways simultaneously<br>
iguazio platform support multiple standard APIs (SQL, Prometheus, Grafana, Pandas, etc.) which can be used to visualize data<br>
this include plotting or charting data within Jupyter using matplotlib, using external BI tools like Tableau via the SQL/JDBC APIs, or building real-time dashbard in Grafana.<br>

The different tools and services generate telemetry and log data which can be stored in the iguazio time-series database or in external tools such as ElasticSearch<br>
users can easily instrument their code and functions to collect various statistics or logs, the same data is accessible for exploration in real-time<br>

Grafana is natively integrated into the platform, users can create dashboards programmatically using wizard scripts and access all forms of data (tabels, time-series, logs, streams) from the different dashboard widgets. 

For information on how to create charts in Grafana using Iguazio :<br>
https://www.iguazio.com/docs/tutorials/latest-release/getting-started/trial-qs/grafana-dashboards/


# Support
Our support team will be happy to help with any questions <br>
Feel free to reach out to support@iguazio.com or use the chatbox for direct communication with our experts

# Others

Sample datasets http://iguazio-sample-data.s3.amazonaws.com/ <br>
