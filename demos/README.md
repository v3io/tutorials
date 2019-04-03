
# End-to-End Platform Use-Case Application Demos

**In This Document**

- [Overview](#overview)
- [Stock Trading](#stocks-demo)
- [Predictive Infrastructure Monitoring](#netops-demo)
- [Image Recognition](#image-classification-demo)
- [Natural Language Processing (NLP)](#nlp-demo)

<a id="overview"></a>
## Overview

The **demos** tutorials directory contains full end-to-end use-case applications that demonstrate how to use the Iguazio Data Science Platform ("the platform") and related tools to address data science requirements for different industries and implementations.

<a id="stocks-demo"></a>
## Smart Stock Trading

The [**stocks**](stocks/read_stocks.ipynb) demo demonstrates a smart stock-trading application: 
the application reads stock-exchange data from an internet service; uses Twitter to analyze the market sentiment on specific stocks, in real time; and saves the data to a platform NoSQL table that is used for generating reports and analyzing and visualization the data.

<a id="netops-demo"></a>
## Predictive Infrastructure Monitoring

The [**netops**](netops/generator.ipynb) demo demonstrates predictive infrastructure monitoring: the application builds, trains, and deploys a machine-learning model for analyzing and predicting failure in network devices as part of a network operations (NetOps) flow.

<a id="image-classification-demo"></a>
## Image Recognition

The [**image_classification**](image_classification/keras-cnn-dog-or-cat-classification.ipynb) demo demonstrates image recognition: the application uses [TensorFlow](https://www.tensorflow.org/) and [Keras](https://keras.io/) to identify (recognize) and classify images.

<a id="nlp-demo"></a>
## Natural Language Processing (NLP)

The [**nlp**](nlp/nlp-example.ipynb) demo demonstrates natural language processing (NLP): the application processes natural-language text, applies corrections, calculates sentiments, and translates the text.
