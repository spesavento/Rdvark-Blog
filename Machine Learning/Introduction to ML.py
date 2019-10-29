#!/usr/bin/env python
# coding: utf-8

# ## Import Dependencies

# The __future__  statement is intended to ease migration to future versions of Python that introduce incompatible changes to the language. TensorFlow is imported as tf. It will only display errors. Numpy is imported as np. Numpy helps us to represent our data as highly performant lists.

# In[2]:


from __future__ import absolute_import, division, print_function
import tensorflow as tf
tf.logging.set_verbosity(tf.logging.ERROR)
 
import numpy as np


# ## Set up training data

# The goal of the model is to provide degrees in Fahrenheit when given degrees in Celsius.  So for supervised learning, we give a set of inputs (celsius_q) and a set of outputs (fahrenheit_a) so that the computer can find an algorithm.

# In[3]:


celsius_q = np.array([-40, -10, 0, 8, 15, 22, 38],dtype=float)
fahrenheit_a = np.array([-40, 14, 32, 46, 59, 72, 100],dtype=float) 
 
for i,c in enumerate(celsius_q):
    print("{} degrees Celsius = {} degrees Fahrenheit".format(c,
    fahrenheit_a[i]))


# Some Machine Learning terminology: <p>
#     <u>Feature</u> — The input(s) to our model. In this case, the degrees in Celsius. <p>
# <u>Labels</u> — The output our model predicts. In this case, the degrees in Fahrenheit.<p>
# <u>Example</u> — A pair of inputs/outputs used during training. 
# In our case a pair of values from celsius_q and fahrenheit_a at a specific index, such as (22,72).

# ## Create the model

# input_shape = [1] -- This specifies that the input to this layer is a single value. 
# That is, the shape is a one-dimensional array with one member. 
# Since this is the first (and only) layer, that input shape is the input shape of the entire model. 
# The single value is a floating point number, representing degrees Celsius (the feature).
# <p>
# units = 1 -- This specifies the number of neurons in the layer. The number of neurons defines how many internal variables the layer has to try to learn how to solve the problem. Since this is the final layer, it is also the size of the model’s output — a single float value representing degrees Fahrenheit (the labels). (In a multi-layered network, the size and shape of the layer would need to match the input_shape of the next layer.)

# In[9]:


l0 = tf.keras.layers.Dense(units=1, input_shape=[1])
model = tf.keras.Sequential([l0])


# ## Compile the model

# <u>Loss function</u> — A way of measuring how far off predictions are from the desired outcome. The measured difference is called the “loss”. <p>
# <u>Optimizer function</u> — A way of adjusting internal values in order to reduce the loss.

# In[11]:


model.compile(loss = 'mean_squared_error',
              optimizer = tf.keras.optimizers.Adam(0.1))


# ## Train the model

# In[12]:


history = model.fit(celsius_q, fahrenheit_a, epochs = 500,
                    verbose = False)
print("Finished training the model")


# ## Displaying training statistics

# In[14]:


import matplotlib.pyplot as plt
plt.xlabel('Epoch Number')
plt.ylabel("Loss Magnitude")
plt.plot(history.history['loss'])


# ## Use the model to predict values

# In[15]:


print(model.predict([100.0]))


# ## Looking at the layer weights

# In[16]:


print("These are the layer variables: {}".format(l0.get_weights()))


# ## Experiment

# In[19]:


l0 = tf.keras.layers.Dense(units=4, input_shape=[1])
l1 = tf.keras.layers.Dense(units=4)
l2 = tf.keras.layers.Dense(units=1)
model = tf.keras.Sequential([l0, l1, l2])
model.compile(loss='mean_squared_error',
             optimizer=tf.keras.optimizers.Adam(0.1))
model.fit(celsius_q, fahrenheit_a, epochs=500, verbose=False)
print("Finished training the model")
print(model.predict([100.0]))
print("Model predicts that 100 degrees Celsius is: {} degrees Fahrenheit".format(model.predict([100.0])))
print("These are the l0 variables: {}".format(l0.get_weights()))
print("These are the l1 variables: {}".format(l1.get_weights()))
print("These are the l2 variables: {}".format(l2.get_weights()))
 
