from bzrlib.transport.http import wsgi

def application(environ, start_response):
    app = wsgi.make_app(
        root="/srv/repos/bzr/",
        prefix="/bzr",
        readonly=True,
        enable_logging=False)
    return app(environ, start_response)

