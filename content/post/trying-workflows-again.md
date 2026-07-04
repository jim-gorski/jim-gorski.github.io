---
title: "Trying Workflows Again"
date: 2022-03-29T14:55:05-04:00
tags:
- WTF
- website
keywords:
- tech
#thumbnailImage: //example.com/image.jpg
---
So some kind soul on Reddit suggested the .nojekyll empty file in the root directory
<!--more-->
I've got it in the repo and in the static folder so hopefully it will stop the jekyll action that's blocking my hugo actions.
This post gets pushed and github does the rest like magic.  Fingers crossed.

EDIT: So I had actions restricted to only my repo which blocked the hugo actions pulled from peaceiris.
Having changed those permissions I may be able to do this!