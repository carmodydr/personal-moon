---
layout: post
title: Useful Tools in Science
tags: research plots science grad-school
excerpt: A collection of some software I have found useful for research.
---

After spending five years as a physics PhD student, I have gone through many iterations in the way that I conduct my science. Nobody sat me down in the beginning and made a list of all the useful tools that would help me be a better researcher, and even if they had I doubt that I would really have appreciated what they were trying to do. To a large extent, research is all about encountering problems and teaching yourself the skills necessary to overcome them, and there is no substitute for doing this problem solving yourself. All the same, it seems a shame if I don't attempt to communicate to others the methods I have found. Though they may not be the absolute best practices, they generally work quite well for me. I'd like to share them in the hopes that it saves other starting grad students a lot of time and heartache.

Reading papers
--------------

All research starts with reading the existing literature. And if you're going to go through the trouble of collecting and reading a whole bunch of papers, you might as well take the extra effort and organize them in an efficient manner. I use **[Mendeley]**, through which I am able to categorize, tag, and annotate all of my papers. It backs things up to the web as well, so you can sync your library across devices.


Writing papers
--------------

Though it varies by discipline, all papers in physics are written using LaTeX, and having a decent editor can make the inevitable formatting and debugging process much more straightforward. At one point I was using **[Lyx]** for this, which is a WYSIWYM (What You See Is What You Mean) editor that takes care of the LaTeX tags behind the scences. I did this until I became more comfortable with the syntax of LaTeX and wanted finer control over the code, at which point I switched to **[gummi]**.

Plotting
--------

I used to do a lot of plotting using gnuplot, and I still turn to it for very quick and simple plots when I am just trying to get an idea of what the data is telling me. For everything else, there's **[matplotlib]**, the quintessential library for Python, and the **[ipython]** or **[ipython notebook]** interpreter.

Presentations
-------------

Since I use LaTeX for papers it was a straighforward decision to use it as well for presentations. Using **[Beamer]**, I can easily put together good looking presentations with little thought by way of formatting. It has it's limitations, though. I doubt that it can handle embedded video very well (though I haven't tried), and fine tuning the layout on a slide can be quite time-consuming and frustrating. But for most basic presentations it's a very worry-free tool.


Summary
=======

That's enough for now. I hope to add to and refine this list as I find the time.

[Mendeley]: http://www.mendeley.com
[gummi]: http://dev.midnightcoding.org/projects/gummi
[Lyx]: http://www.lyx.org/
[Beamer]: http://en.wikibooks.org/wiki/LaTeX/Presentations
[ipython]: http://nbviewer.ipython.org/github/ipython/ipython/blob/1.x/examples/notebooks/Part%203%20-%20Plotting%20with%20Matplotlib.ipynb
[ipython notebook]: http://ipython.org/notebook.html
[matplotlib]: http://matplotlib.org/
