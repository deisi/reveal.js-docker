FROM node
MAINTAINER Janosch Deurer <janosch.deurer@geonautik.de>

# Install
RUN apt-get update && apt-get install -y \
  git

# Install revealjs
RUN mkdir -p /revealjs
WORKDIR /revealjs
RUN git clone --depth=1 https://github.com/hakimel/reveal.js.git .
RUN npm install

RUN mkdir -p /revealjs/presentations

# Add index html for redirect (dirty fix)
ADD ./index.html /revealjs/index.html

# Add demo presentation to give a usage example
ADD ./demo_presentation /revealjs/demo_presentation


#################
#Install Plugins
#################

# Install MathJax
RUN git clone --depth=1 https://github.com/mathjax/MathJax.git /revealjs/MathJax

# Install plugins
RUN git clone --depth=1 https://github.com/rajgoel/reveal.js-plugins /tmp/pl &&mv -v /tmp/pl/* /revealjs/plugin && rm -r /tmp/pl

# Install Menu
RUN git clone --depth=1 https://github.com/denehyg/reveal.js-menu.git /revealjs/plugin/menu

# Install vis.js
RUN mkdir -p /revealjs/plugin/visjs && git clone --depth=1 https://github.com/almende/vis.git /revealjs/plugin/visjs


ADD ./docker-entrypoint.sh /
RUN chmod u+x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

