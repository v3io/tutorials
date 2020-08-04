# Model Deployment with Streaming

This demo shows how to deploy a model with streaming information. It is comprised of several steps:

![Model deployment with streaming Real-time operational Pipeline](../../assets/images/model-deployment-with-streaming.png)

These steps are covered by the following notebooks:

- [**0. Setup**](0-setup.ipynb) - Creates the project and the relevant streams.
- [**1. Event generator**](1-event-generator.ipynb) — Generates events for the training and serving. 
- [**2. incoming event handler**](2-incoming-event-handler.ipynb) - Receive data from the input. This is a common input stream for all the data. This way, one can easily replace the event source data (in this case we have a data generator) without affecting the rest of this flow.
- [**2a. Stream to parquet**](2a-stream-to-parquet.ipynb) - Store all incoming data to parquet files.
- [**3a. Enrichment table**](3a-enrichment-table.ipynb) - Create an enrichment table (lookup values).
- [**3b. Enrich stream**](3b-enrich-stream.ipynb) - Enrich the stream using the enrichment table.
- [**4. Stream to features**](4-stream-to-features.ipynb) - Update aggregation features using the incoming event handler.
- [**5. Training**](5-training.ipynb) - Train a model using a snapshot of the data.
- [**6. Serving**](6-serving.ipynb) - Serve the model and process the data from the enriched stream and aggregation features.
  
  The demo covers the use case of 1st-day churn. However, it is easy to replace the data, related features and training model and reuse the same workflow for different business cases.