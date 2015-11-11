<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://www.w3.org/1999/xhtml"
		xmlns:db="http://docbook.org/ns/docbook"
		xmlns:f="http://docbook.org/xslt/ns/extension"
		xmlns:h="http://www.w3.org/1999/xhtml"
		xmlns:m="http://docbook.org/xslt/ns/mode"
		xmlns:t="http://docbook.org/xslt/ns/template"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		exclude-result-prefixes="db f h m t xs"
                version="2.0">
<xsl:import
    href="http://docbook.github.com/release/latest/xslt/base/html/final-pass.xsl"/>

<xsl:param name="generate.toc" as="element()*">
  <tocparam path="article" toc="0" title="1"/>
</xsl:param>

<xsl:param name="autolabel.elements">
  <none/>
</xsl:param>

<xsl:template match="/">
  <html lang="en">
    <head>
      <meta charset="utf-8"/>
      <title>
        <xsl:value-of select="f:title(/)"/>
      </title>
      <meta name="description" content="FIXME:"/>
      <meta name="author" content="FIXME:"/>
      <meta name="apple-mobile-web-app-capable" content="yes" />
      <meta name="apple-mobile-web-app-status-bar-style"
            content="black-translucent" />
      <meta name="viewport"
            content="width=device-width, initial-scale=1.0,
                     maximum-scale=1.0, user-scalable=no, minimal-ui"/>
      <link rel="stylesheet" href="css/reveal.css"/>
      <link rel="stylesheet" href="css/theme/white.css" id="theme"/>
      <link rel="stylesheet" href="lib/css/zenburn.css"/>
      <style type="text/css">
.reveal section img { padding: 0.5em; }
.reveal .slides > section.stack { padding-top: 2em; }
      </style>
      <script>
	var link = document.createElement( 'link' );
	link.rel = 'stylesheet';
	link.type = 'text/css';
	link.href = window.location.search.match( /print-pdf/gi ) ? 'css/print/pdf.css' : 'css/print/paper.css';
	document.getElementsByTagName( 'head' )[0].appendChild( link );
      </script>
      <xsl:comment>[if lt IE 9]&gt;
      &lt;script src="lib/js/html5shiv.js">&lt;/script>
      &lt;![endif]</xsl:comment>
    </head>
    <body>
      <div class="reveal">
	<div class="slides">
          <xsl:variable name="article" as="element(h:article)">
            <xsl:apply-templates/>
          </xsl:variable>

          <section data-background="img/4x3/title-slide.png">
            <xsl:sequence select="$article/h:header/node()"/>
          </section>
          <xsl:apply-templates select="$article/h:section" mode="html-copy"/>
	</div>
      </div>
      <script src="lib/js/head.min.js"></script>
      <script src="js/reveal.js"></script>
      <script>
        // Full list of configuration options available at:
        // https://github.com/hakimel/reveal.js#configuration
        Reveal.initialize({
                           controls: true,
                           progress: false,
                           history: true,
                           center: true,
                           width: 1280,
                           height: 960,
                           transition: 'convex', // none/fade/slide/convex/concave/zoom
                           // Optional reveal.js plugins
                           dependencies: [
                                        { src: 'lib/js/classList.js', condition: function() { return !document.body.classList; } },
                                        { src: 'plugin/markdown/marked.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
                                        { src: 'plugin/markdown/markdown.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
                                        { src: 'plugin/highlight/highlight.js', async: true, condition: function() { return !!document.querySelector( 'pre code' ); }, callback: function() { hljs.initHighlightingOnLoad(); } },
                                        { src: 'plugin/zoom-js/zoom.js', async: true },
                                        { src: 'plugin/notes/notes.js', async: true }
                                ]
                        });
		</script>
    </body>
  </html>
</xsl:template>

<xsl:template match="processing-instruction(asciidoc-br)">
  <br/>
</xsl:template>

<xsl:template match="h:section" mode="html-copy">
  <xsl:copy>
    <xsl:attribute name="data-background" select="'img/4x3/normal-slide.png'"/>
    <xsl:apply-templates select="@* except @id,node()" mode="html-copy"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="h:pre" mode="html-copy">
  <xsl:copy>
    <xsl:apply-templates select="node()" mode="html-copy"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="h:li" mode="html-copy">
  <xsl:copy>
    <xsl:if test="ancestor::h:*[starts-with(@id, 'frag')]">
      <xsl:attribute name="class" select="'fragment'"/>
    </xsl:if>
    <xsl:apply-templates select="@*,node()" mode="html-copy"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="h:p[starts-with(@id, 'frag')]" mode="html-copy">
  <p class="fragment">
    <xsl:apply-templates select="@* except @class,node()" mode="html-copy"/>
  </p>
</xsl:template>

<xsl:template match="h:div[@class='sidebar']" mode="html-copy">
  <aside class="notes">
    <xsl:apply-templates select="@* except @class,node()" mode="html-copy"/>
  </aside>
</xsl:template>

<xsl:template match="h:blockquote
                     [ancestor::h:section[not(following-sibling::h:section)]]"
              mode="html-copy">
  <xsl:copy>
    <xsl:attribute name="class" select="'fragment'"/>
    <xsl:apply-templates select="@* except @class,node()" mode="html-copy"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="element()" mode="html-copy">
  <xsl:copy>
    <xsl:apply-templates select="@*,node()" mode="html-copy"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="attribute()|text()|comment()|processing-instruction()"
              mode="html-copy">
  <xsl:copy/>
</xsl:template>

</xsl:stylesheet>
