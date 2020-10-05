# Welcome to the Iguazio Data Science Platform

An initial introduction to the Iguazio Data Science Platform and the platform tutorials

- [Platform Overview](#platform-overview)
- [Data Science Workflow](#data-science-workflow)
- [The Tutorial Notebooks](#the-tutorial-notebooks)
- [Getting-Started Tutorial](#getting-started-tutorial)
- [End-to-End Use-Case Applications](#end-to-end-use-case-applications)
- [Additional Platform Resources](#platform-resources)
- [Miscellaneous](#misc)

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

<br><img src="./assets/images/igz-self-service-platform.png" alt="Self-service data science platform" width="650"/><br>

<a id="data-science-workflow"></a>
## Data Science Workflow

The platform provides a complete data science workflow in a single ready-to-use platform that includes all the required building blocks for creating data science applications from research to production:

- Collect, explore, and label data from various real-time or offline sources
- Run ML training and validation at scale over multiple CPUs and GPUs
- Deploy models and applications into production with serverless functions
- Log, monitor, and visualize all your data and services

![Data Science Workflow](./assets/images/igz-data-science-workflow.gif)

<a id="the-tutorial-notebooks"></a>
## The Tutorial Notebooks

The home directory of the platform's running-user directory (**/User/&lt;running user&gt;**) contains pre-deployed tutorial Jupyter notebooks with code samples and documentation to assist you in your development &mdash; including a [**demos**](demos/README.ipynb) directory with end-to-end use-case applications (see the next section) and a [**data-ingestion-and-preparation**](data-ingestion-and-preparation/README.ipynb) directory with documentation and examples for performing data ingestion and preparation tasks.

> **Note:**
> - To view and run the tutorials from the platform, you first need to create a Jupyter Notebook service.
> - The **welcome.ipynb** notebook and main **README.md** file provide the same introduction in different formats.

<a id="getting-started-tutorial"></a>
## Getting-Started Tutorial

Start out by running the getting-started tutorial to familiarize yourself with the platform and experience firsthand some of its main capabilities.<br>
<br>
<a href="getting-started-tutorial/getting-started-tutorial.ipynb"><img src="./assets/images/view-tutorial-button.png" alt="View tutorial"/></a>

<a id="end-to-end-use-case-applications"></a>
## End-to-End Use-Case Applications

Iguazio provides full end-to-end use-case applications (demos) that demonstrate how to use the platform and related tools to address data science requirements for different industries and implementations.

<a id="predeployed-demos"></a>
### Pre-Deployed Platform Demos

The platform comes pre-deployed with the following end-to-end use-case demos, which are available in the [**MLRun demos repository**](https://github.com/mlrun/demos):

- <a id="demo-sklearn-pipe"></a>[**scikit-learn pipeline**](https://github.com/mlrun/demos/blob/master/sklearn-pipe/) &mdash; builds a full end-to-end pipeline using [scikit-learn](https://scikit-learn.org) and the UCI [Iris data set](http://archive.ics.uci.edu/ml/datasets/iris).
- <a id="demo-image-classification"></a>[**Image classification with distributed training**](https://github.com/mlrun/demos/tree/master/horovod-pipe) &mdash; implements an end-to-end image-classification solution using [TensorFlow](https://www.tensorflow.org/) (versions 1 or 2), [Keras](https://keras.io/), [Horovod](https://eng.uber.com/horovod/), and [Nuclio](https://nuclio.io/).
- <a id=demo-face-recognition/>[**Face reconition**](https://github.com/mlrun/demos/tree/master/faces) &mdash; real-time capture, recognition, and classification of face images over a video stream, as well as location tracking of identities using [PyTorch](https://pytorch.org/), Image identification and tracking using [OpenCV](https://opencv.org/) and labeling application for tagging unidentified faces using [Streamlit](https://www.streamlit.io/)
- <a id=demo-churn/>[**Customer churn prediction**](https://github.com/mlrun/demos/tree/master/churn) &mdash;  analyses of customer-churn data using the Kaggle [Telco Customer Churn data set](https://www.kaggle.com/blastchar/telco-customer-churn), model training and validation using [XGBoost](https://xgboost.readthedocs.io/), and model serving using real-time Nuclio serverless functions.

You can update the demos repository by running the following command


```python
!git -C /User/demos pull origin
```

<a id="additional-demos"></a>
### Additional Demos

You can download additional demos from GitHub &mdash; for example:

- <a id="network-operations-demo"></a>[**Network operations**](https://github.com/mlrun/demo-network-operations) &mdash; error prediction based on network device telematry. Training pipeline to create a new model, serving with streaming and concept drift to monitor the model performance.
- <a id="stocks-demo"></a>[**Smart stock trading**](https://github.com/mlrun/demo-stocks) &mdash; reads stock-exchange data from an internet service into a time-series database (TSDB) and performs real-time market-sentiment analysis on specific stocks; the data is saved to a platform NoSQL table for generating reports and analyzing and visualizing the data on a Grafana dashboard.
- <a id="model-deployment-with-streaming"></a>[**Model deployment with streaming**](https://github.com/mlrun/demo-model-deployment-with-streaming) &mdash; deploy model and calculate features in a streaming pipeline to address low latency processing, such as 1<sup>st</sup> day churn. This demo leverages Nuclio to use the same feature calculation function in training and in serving.

You can download the additional demos from their respective repositories by executing the following command:


```python
# Get additional demos
!/User/get-additional-demos.sh
```

<a id="platform-resources"></a>
## Additional Platform Resources

- [Introduction video](https://www.youtube.com/watch?v=8OmAN4wd7To)
- [In-depth platform overview](platform-overview.ipynb) with a break down of the steps for developing a full data science workflow from development to production
- [Platform components, services, and development ecosystem introduction](https://www.iguazio.com/docs/latest-release/intro/ecosystem/)
- [References](https://iguazio.com/docs/latest-release/reference/)
- [MLRun documentation](https://mlrun.readthedocs.io/)
- [nuclio-jupyter SDK](https://github.com/nuclio/nuclio-jupyter/blob/master/README.md) for creating and deploying Nuclio functions with Python and Jupyter Notebook

<a id="misc"></a>
## Miscellaneous

<a id="creating-virtual-environments-in-jupyter-notebook"></a>
### Creating Virtual Environments in Jupyter Notebook

A virtual environment is a named, isolated, working copy of Python that maintains its own files, directories, and paths so that you can work with specific versions of libraries or Python itself without affecting other Python projects.
Virtual environments make it easy to cleanly separate projects and avoid problems with different dependencies and version requirements across components.
See the [virtual-env](virtual-env.ipynb) tutorial notebook for step-by-step instructions for using conda to create your own Python virtual environments, which will appear as custom kernels in Jupyter Notebook.

<a id="update-notebooks"></a>
### Updating the Tutorial Notebooks to the Latest Version

You can use the provided **igz-tutorials-get.sh** script to update the tutorial notebooks to the latest stable version available on [GitHub](https://github.com/v3io/tutorials/).
For details, see the [**update-tutorials.ipynb**](update-tutorials.ipynb) notebook.

<a id="v3io-dir"></a>
### The v3io Directory

The **v3io** directory that you see in the file browser of the Jupyter UI displays the contents of the `v3io` data mount for browsing the platform data containers.
For information about the predefined data containers and data mounts and how to reference data in these containers, see [Platform Data Containers](data-ingestion-and-preparation/README.ipynb#platform-data-containers).

<a id="support"></a>
### Support

The Iguazio [support team](mailto:support@iguazio.com) will be happy to assist with any questions.
