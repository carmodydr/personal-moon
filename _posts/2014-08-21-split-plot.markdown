---
layout: post
title: "Making a split plot"
excerpt: "Making a split plot in python with 'subplots'"
tags: plots python
---

I'm going to try documenting a bit of my work here as I work through it, just as an experiment.

The task: I want to make a split plot in python. I have a time series of data that mostly contains values between 0 and 10, but has a small section in which the values are on the order of 600. Merely plotting everything on the same scale yields this:

![figure](/assets/img/posts/split-plot-1.png)

While restricting the y domain from 0 to 7 shows a lot of the structure in the data, but cuts out the high value segment, which I'd like to leave in to make a point.

![figure](/assets/img/posts/split-plot-2.png)

To get the best of both worlds, I'd like to create a split plot, containing both low and high values, in a way that enables us to see both.

Turns out, this is quite easy to do, and there is an example given [here](http://matplotlib.org/examples/pylab_examples/broken_axis.html).

I can use the `subplots` command, choosing two rows (for the different y scales), one column (the continues time series), and sharing the same x domain.

	ax1,ax2 = subplots(2,1, sharex=True)
	plot(datanrg8023[:,0],datanrg8023[:,1])
	plot(datanrg8023[:,0],datanrg8023[:,2])
	xlim(0,131.657)
	ylim(0.0,7.0)

This generates this plot:

![figure](/assets/img/posts/split-plot-3.png)

The data is only being plotted on the lower plot. After reading through the documentation a bit, I can see that I am implementing the 'subplot' command incorrectly, assigning the wrong objects to the 'ax1' and 'ax2' variables. Changing it to 

	f,(ax1,ax2) = subplots(2,1, sharex=True)
	ax1.plot(datanrg8023[:,0],datanrg8023[:,1])
	ax1.plot(datanrg8023[:,0],datanrg8023[:,2])
	ax2.plot(datanrg8023[:,0],datanrg8023[:,1])
	ax2.plot(datanrg8023[:,0],datanrg8023[:,2])
	xlim(0,131.657)
	ax1.semilogy()
	ax1.set_ylim(10,1000)
	ax2.set_ylim(0.0,7.0)

I get the plot:

![figure](/assets/img/posts/split-plot-4.png)

Here I've also made the y-axis of the upper plot a log-scale to better suit the range of scales it covers. This is the essence of the plot that I want, though I can add a few more things to make it a little prettier (all taken from the link given above).

Removing the middle x-axes:

	ax1.spines['bottom'].set_visible(False)
	ax2.spines['top'].set_visible(False)
	ax1.xaxis.tick_top()
	ax.tick_params(labeltop='off') 
	ax2.xaxis.tick_bottom()

And adding some diagonal slashes to indicate the plot break:

	d = .015 
	kwargs = dict(transform=ax1.transAxes, color='k', clip_on=False)
	ax1.plot((-d,+d),(-d,+d), **kwargs)   
	ax1.plot((1-d,1+d),(-d,+d), **kwargs)  

	kwargs.update(transform=ax2.transAxes)  
	ax2.plot((-d,+d),(1-d,1+d), **kwargs)   
	ax2.plot((1-d,1+d),(1-d,1+d), **kwargs) 

I get this final plot,

![figure](/assets/img/posts/split-plot-5.png)

