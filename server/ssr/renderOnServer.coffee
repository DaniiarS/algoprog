import Routes from '../../client/routes'
import DefaultHelmet from '../../client/components/DefaultHelmet'

React = require('react')

import { StaticRouter } from 'react-router'
import { renderToString } from 'react-dom/server';
import { matchPath, Switch, Route } from 'react-router-dom'

import { Helmet } from "react-helmet"

import logger from '../log'

renderFullPage = (html, data, helmet) ->
    return '
        <html>
        <head>
            <meta charset="UTF-8" />
            ' + helmet.title + '
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>
            <link rel="stylesheet" href="/bundle.css"/>
            <link rel="stylesheet" href="/informatics.css"/>
            <link rel="stylesheet" href="/bootstrap.min.css"/>
            <script>
                window.__INITIAL_STATE__ = ' + JSON.stringify(data) + ';
            </script>
            <script type="text/x-mathjax-config">
                MathJax.Hub.Config({
                    extensions: ["tex2jax.js"],
                    jax: ["input/TeX", "output/HTML-CSS"],
                    tex2jax: {
                        inlineMath: [ ["$","$"] ],
                        displayMath: [ ["$$","$$"] ],
                        processEscapes: true
                    },
                    "HTML-CSS": { availableFonts: ["TeX"] }
                });
            </script>
            <script type="text/javascript" src="https://cdn.rawgit.com/davidjbradshaw/iframe-resizer/master/js/iframeResizer.contentWindow.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=TeX-MML-AM_CHTML"></script>
        </head>
        <body>
            <div id="main" style="min-width: 100%; min-height: 100%">' + html + '</div>
            <script src="/bundle.js" type="text/javascript"></script>
            <!-- Yandex.Metrika counter -->
            <script type="text/javascript" >
                (function (d, w, c) {
                    (w[c] = w[c] || []).push(function() {
                        try {
                            w.yaCounter45895896 = new Ya.Metrika({
                                id:45895896,
                                clickmap:true,
                                trackLinks:true,
                                accurateTrackBounce:true,
                                webvisor:true
                            });
                        } catch(e) { }
                    });

                    var n = d.getElementsByTagName("script")[0],
                        s = d.createElement("script"),
                        f = function () { n.parentNode.insertBefore(s, n); };
                    s.type = "text/javascript";
                    s.async = true;
                    s.src = "https://mc.yandex.ru/metrika/watch.js";

                    if (w.opera == "[object Opera]") {
                        d.addEventListener("DOMContentLoaded", f, false);
                    } else { f(); }
                })(document, window, "yandex_metrika_callbacks");
            </script>
            <noscript><div><img src="https://mc.yandex.ru/watch/45895896" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
            <!-- /Yandex.Metrika counter -->
        </body>
        </html>'

export default renderOnServer = (req, res, next) =>
    component = undefined
    foundMatch = undefined
    data = undefined

    try
        Routes.some((route) ->
            match = matchPath(req.url, route)
            if (match)
                foundMatch = match
                component = route.component
                if component.loadData
                    data = component.loadData(match)
            return match
        )
        data = await data
        element = React.createElement(component, {match: foundMatch, data: data})
        context = {}
        # We have already identified the element,
        # but we need StaticRouter for Link to work
        html = renderToString(
            <div>
                <DefaultHelmet/>
                <StaticRouter context={context}>
                    {element}
                </StaticRouter>
            </div>
        )
    catch error
        logger.error(error)
        res.status(500).send('Error 500')
        return
    finally
        helmet = Helmet.renderStatic();

    res.set('Content-Type', 'text/html').status(200).end(renderFullPage(html, data, helmet))
