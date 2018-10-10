import vibe.vibe;

void main()
{
    import std.process : environment;
    import std.conv;

    auto settings = new HTTPServerSettings;
    immutable port = environment.get("HTTP_PLATFORM_PORT"); //Use the port IIS tells us to.
    settings.port = port ? to!ushort(port) : 8080;
    settings.bindAddresses = ["0.0.0.0"];
    listenHTTP(settings, &hello);

    logInfo("Please open http://127.0.0.1:8080/ in your browser.");
    runApplication();
}

void hello(HTTPServerRequest req, HTTPServerResponse res)
{
    res.writeBody("Hello, World!");
}
