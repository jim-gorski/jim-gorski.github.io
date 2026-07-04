---
title: "Hugo May Not Be Boss"
date: 2022-03-16T16:08:29-04:00
categories:
- website
tags:
- WTF
keywords:
- tech hugo github static
#thumbnailImage: //example.com/image.jpg
---
Fun facts about using Hugo to create a static web site - learned the hard way
<!--more-->
I don't think I'm a super genius or anything, but I like computers, technology and I can find my way around most systems.
Hugo is a minimalist application to intake text and images and spit out a nice static HTML website.
It runs on go, it's very fast and it checks all the boxes for me to love it.

Then I start.
So after using the perfectly acceptable commane hugo new site <sitename> and hit enter it unpacks a nice directory structure.
But here's the catch - if you don't RTFM and then go get a theme of some sort you cannot render the site.
The icing on the cake here is the built-in HTTPS server Hugo includes to look at your site.
This is an AWESOME feature.
Unless you run the 'new' command, run the server and visit your site on localhost.
Then you get nothing...
Just a white page.
Once you go back and realize you need a theme, go online and download a theme, learn about themes and how to install them, learn that themes are in flux (git sub mods anyone).
So you fuss and fight and get the theme setup.
But still a white screen...
for an hour...
Until your dumb butt thinks to hit F5 and see the new site.
WTF is there no default theme or error message or something in Hugo.
It's enough to make a person learn golang.