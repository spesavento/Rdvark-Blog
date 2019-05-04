#!/usr/bin/env python
# coding: utf-8

# ## Install and import dependencies

# In[4]:


get_ipython().system('pip install -U tensorflow_datasets')


# In[5]: 


from __future__ import absolute_import, division, print_function
# Import TensorFlow and TensorFlow Datasets
import tensorflow as tf
import tensorflow_datasets as tfds
tf.logging.set_verbosity(tf.logging.ERROR) 
 
# Helper libraries
import math
import numpy as np
import matplotlib.pyplot as plt 
 
# Improve progress bar display
import tqdm
import tqdm.auto 
tqdm.tqdm = tqdm.auto.tqdm 
 
print(tf.__version__)
 
# This will go away in the future.
# If this gives an error, you might be running TensorFlow 2
# or above
# If so, the just comment out this line and run this
# cell again
tf.enable_eager_execution()


# In[6]:


dataset, metadata = tfds.load('fashion_mnist',
as_supervised=True, with_info=True)
 
train_dataset, test_dataset = dataset['train'], dataset['test']
 
class_names = ['T-shirt/top','Trouser','Pullover','Dress','Coat',
               'Sandal','Shirt','Sneaker','Bag','Ankle boot']


# In[7]:


num_train_examples = metadata.splits['train'].num_examples
num_test_examples = metadata.splits['test'].num_examples
print("Number of training examples: {}".format(num_train_examples))
print("Number of test examples: {}".format(num_test_examples))


# ## Preprocess the data

# In[8]:


def normalize(images, labels):
  images = tf.cast(images, tf.float32)
  images /= 255
  return images, labels 
 
# The map function applies the normalize function to each
# element in the train and test datasets 
 
train_dataset = train_dataset.map(normalize)
test_dataset = test_dataset.map(normalize)


# In[9]:


# Take a single image, and remove the color dimension by reshaping
for image, label in test_dataset.take(1):
  break
image = image.numpy().reshape((28,28)) 
 
# Plot the image - voila a piece of fashion clothing
plt.figure()
plt.imshow(image, cmap=plt.cm.binary)
plt.colorbar()
plt.grid(False)
plt.show()


# In[10]:


plt.figure(figsize=(10,10))
i = 0
for (image, label) in test_dataset.take(25):
  image = image.numpy().reshape((28,28))
  plt.subplot(5,5,i+1)
  plt.xticks([])
  plt.yticks([])
  plt.grid(False)
  plt.imshow(image, cmap=plt.cm.binary)
  plt.xlabel(class_names[label])
  i += 1
plt.show()


# ## Build the model

# In[11]:


model = tf.keras.Sequential([
    tf.keras.layers.Flatten(input_shape=(28, 28, 1)),
    tf.keras.layers.Dense(128, activation=tf.nn.relu),
    tf.keras.layers.Dense(10,  activation=tf.nn.softmax)
])


# In[19]:


optimizer = tf.train.AdamOptimizer(learning_rate=1e-4, beta1=0.99, epsilon=0.1)
model.compile(optimizer, loss='sparse_categorical_crossentropy', metrics=['accuracy'])


# ## Train the model

# In[22]:


BATCH_SIZE = 32
train_dataset = train_dataset.repeat().shuffle(num_train_examples).batch(BATCH_SIZE)
test_dataset = test_dataset.batch(BATCH_SIZE)
 
model.fit(train_dataset, epochs=5,
  steps_per_epoch=math.ceil(num_train_examples/BATCH_SIZE))


# ## Evaluate the model

# In[23]:


test_loss, test_accuracy = model.evaluate(test_dataset,
  steps=math.ceil(num_test_examples/32)) 
 
print('Accuracy on test dataset:', test_accuracy)


# ## Make predictions and explore

# In[24]:


for test_images, test_labels in test_dataset.take(1):
  test_images = test_images.numpy()
  test_labels = test_labels.numpy()
  predictions = model.predict(test_images)
 
predictions.shape


# In[25]:


predictions[0]


# In[26]:


np.argmax(predictions[0])
 
test_labels[0]


# In[30]:


def plot_image(i, predictions_array, true_labels, images):
  predictions_array, true_label, img = predictions_array[i],
  true_labels[i], images[i]
  plt.grid(False)
  plt.xticks([])
  plt.yticks([]) 
 
  plt.imshow(img[...,0], cmap=plt.cm.binary) 
 
  predicted_label = np.argmax(predictions_array)
  if predicted_label == true_label: color = 'blue'
  else: color = 'red'
  plt.xlabel("{} {:2.0f}% ({})".format(class_names[predicted_label],
                                100*np.max(predictions_array),
                                class_names[true_label]),
                                color=color)
 
def plot_value_array(i, predictions_array, true_label):
  predictions_array, true_label = predictions_array[i],true_label[i]
  plt.grid(False)
  plt.xticks([])
  plt.yticks([])
  thisplot = plt.bar(range(10), predictions_array, color="#777777")
  plt.ylim([0, 1])
  predicted_label = np.argmax(predictions_array)
  thisplot[predicted_label].set_color('red')
  thisplot[true_label].set_color('blue')


# In[38]:


i = 0
plt.figure(figsize=(6,3))
plt.subplot(1,2,1)
plot_image(i, predictions, test_labels, test_images)
plt.subplot(1,2,2)
plot_value_array(i, predictions,  test_labels)


# In[ ]:


i = 12
plt.figure(figsize=(6,3))
plt.subplot(1,2,1)
plot_image(i, predictions, test_labels, test_images)
plt.subplot(1,2,2)
plot_value_array(i, predictions,  test_labels)


# In[ ]:


# Plot the first X test images, their predicted label,
# and the true label
# Color correct predictions in blue, incorrect predictions in red
num_rows = 5
num_cols = 3
num_images = num_rows*num_cols
plt.figure(figsize=(2*2*num_cols, 2*num_rows))
for i in range(num_images):
  plt.subplot(num_rows, 2*num_cols, 2*i+1)
  plot_image(i, predictions, test_labels, test_images)
  plt.subplot(num_rows, 2*num_cols, 2*i+2)
  plot_value_array(i, predictions, test_labels)


# In[ ]:


# Grab an image from the test dataset
img = test_images[0]
print(img.shape)


# In[ ]:


# Add the image to a batch where it's the only member.
img = np.array([img])
print(img.shape)


# In[ ]:


predictions_single = model.predict(img)
print(predictions_single)


# In[ ]:


plot_value_array(0, predictions_single, test_labels)
_ = plt.xticks(range(10), class_names, rotation=45)
 
np.argmax(predictions_single[0])

