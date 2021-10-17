vcl 4.0;

backend default {
    .host = "nginx";
    .port = "80";
}

sub vcl_recv {
    # Happens before we check if we have this in cache already.
    #
    # Typically you clean up the request here, removing cookies you don't need,
    # rewriting the request, etc.

    unset req.http.Authorization;
    unset req.http.Cookie;
}

sub vcl_deliver {
    # Happens when we have all the pieces we need, and are about to send the
    # response to the client.
    #
    # You can do accounting or modifying the final object here.
    unset resp.http.X-Varnish;
    unset resp.http.via;
}
