from __future__ import print_function
import os
import sys
import json
import keras
from keras.datasets import mnist
from keras.models import Sequential
from keras.layers import Conv2D, MaxPooling2D, Dropout, Flatten, Dense, Activation, BatchNormalization
from keras.preprocessing.image import ImageDataGenerator
from keras import backend as K
import tensorflow as tf
import horovod.keras as hvd
import pandas as pd
from sklearn.model_selection import train_test_split

# Get the images path
DATA_PATH = sys.argv[1]
HOROVOD_DIR = sys.argv[2]

epochs = 6
batch_size = 64

# Define image parameters
IMAGE_WIDTH=128
IMAGE_HEIGHT=128
IMAGE_SIZE=(IMAGE_WIDTH, IMAGE_HEIGHT)
IMAGE_CHANNELS=3 # RGB color

# Create a file-names list (JPG image-files only)
filenames = [file for file in os.listdir(DATA_PATH + "/cats_n_dogs/") if file.endswith('jpg')]
categories = []

# Create a categories and prediction classes map
categories_map = {
    'dog': 1,
    'cat': 0,
}

# Create a pandas DataFrame for the full sample
for filename in filenames:
    category = filename.split('.')[0]
    categories.append([categories_map[category]])

df = pd.DataFrame({
    'filename': filenames,
    'category': categories
})
df['category'] = df['category'].astype('str');

# Prepare, test, and train the data
train_df, validate_df = train_test_split(df, test_size=0.20, random_state=42)
train_df = train_df.reset_index(drop=True)
validate_df = validate_df.reset_index(drop=True)
train_df['category'] = train_df['category'].astype('str');
total_train = train_df.shape[0]
total_validate = validate_df.shape[0]

total_train = train_df.shape[0]
total_validate = validate_df.shape[0]

# Horovod: initialize Horovod.
hvd.init()

# Horovod: pin GPU to be used to process local rank (one GPU per process).
config = tf.ConfigProto()
config.gpu_options.allow_growth = True
config.gpu_options.visible_device_list = str(hvd.local_rank())
K.set_session(tf.Session(config=config))


model = Sequential()

model.add(Conv2D(32, (3, 3), activation='relu', input_shape=(IMAGE_WIDTH, IMAGE_HEIGHT, IMAGE_CHANNELS)))
model.add(BatchNormalization())
model.add(MaxPooling2D(pool_size=(2, 2)))
model.add(Dropout(0.25))

model.add(Conv2D(64, (3, 3), activation='relu'))
model.add(BatchNormalization())
model.add(MaxPooling2D(pool_size=(2, 2)))
model.add(Dropout(0.25))

model.add(Conv2D(128, (3, 3), activation='relu'))
model.add(BatchNormalization())
model.add(MaxPooling2D(pool_size=(2, 2)))
model.add(Dropout(0.25))

model.add(Flatten())
model.add(Dense(512, activation='relu'))
model.add(BatchNormalization())
model.add(Dropout(0.5))
model.add(Dense(1, activation='sigmoid'))


# Horovod: adjust learning rate based on number of GPUs.
opt = keras.optimizers.Adadelta(lr=1.0 * hvd.size())

# Horovod: add Horovod Distributed Optimizer.
opt = hvd.DistributedOptimizer(opt)

model.compile(loss='binary_crossentropy',
              optimizer=opt,
              metrics=['accuracy'])

model.summary()

callbacks = [
    # Horovod: broadcast initial variable states from rank 0 to all other processes.
    # This is necessary to ensure consistent initialization of all workers when
    # training is started with random weights or restored from a checkpoint.
    hvd.callbacks.BroadcastGlobalVariablesCallback(0),

    # Horovod: average metrics among workers at the end of every epoch.
    # Note: This callback must be in the list before the ReduceLROnPlateau,
    # TensorBoard or other metrics-based callbacks.
    hvd.callbacks.MetricAverageCallback(),

    # Horovod: using `lr = 1.0 * hvd.size()` from the very beginning leads to worse final
    # accuracy. Scale the learning rate `lr = 1.0` ---> `lr = 1.0 * hvd.size()` during
    # the first five epochs. See https://arxiv.org/abs/1706.02677 for details.
    hvd.callbacks.LearningRateWarmupCallback(warmup_epochs=5, verbose=1),

    # Reduce the learning rate if training plateaues.
    keras.callbacks.ReduceLROnPlateau(patience=10, verbose=1),
]

# Horovod: save checkpoints only on worker 0 to prevent other workers from corrupting them.
if hvd.rank() == 0:
    callbacks.append(keras.callbacks.ModelCheckpoint(HOROVOD_DIR + '/checkpoints/checkpoint-{epoch}.h5'))

# Set up ImageDataGenerators to do data augmentation for the training images.
train_datagen = ImageDataGenerator(
    rotation_range=15,
    rescale=1./255,
    shear_range=0.1,
    zoom_range=0.2,
    horizontal_flip=True,
    width_shift_range=0.1,
    height_shift_range=0.1
)
train_generator = train_datagen.flow_from_dataframe(
    train_df,
    DATA_PATH + "/cats_n_dogs/",
    x_col = 'filename',
    y_col = 'category',
    target_size = IMAGE_SIZE,
    class_mode = 'binary',
    batch_size = batch_size
)

validation_datagen = ImageDataGenerator(rescale=1./255)
validation_generator = validation_datagen.flow_from_dataframe(
    validate_df,
    DATA_PATH + "/cats_n_dogs/",
    x_col = 'filename',
    y_col = 'category',
    target_size = IMAGE_SIZE,
    class_mode = 'binary',
    batch_size = batch_size
)

# Train the model
history = model.fit_generator(
    train_generator,
    steps_per_epoch=total_train // batch_size,
    callbacks=callbacks,
    epochs=epochs,
    verbose=1,
    validation_data=validation_generator,
    validation_steps=total_validate // batch_size
)

# Save the model
model.save(HOROVOD_DIR + '/cats_dogs.hd5')

print(pd.DataFrame(history.history))

