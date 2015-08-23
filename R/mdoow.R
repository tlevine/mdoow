# .globals$stopped <- FALSE
# while (!.globals$stopped) {
#     service(100)
#     Sys.sleep(0.001)
# }

mdoow <- function(loops, samp.rate = 44100, env = new.env(),
                  host = '0.0.0.0', port = 8888) {
  env$server <- startServer(host, port, app(env))
  on.exit(stopServer(env$server))

  env$ws$send(as.wave(colSums(loops), samp.rate))
}
