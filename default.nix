with import <nixpkgs> {}; {
  mdoowEnv = stdenv.mkDerivation {
    name = "mdoow";
    buildInputs = [
      rPackages.htmlwidgets
      rPackages.devtools rPackages.httpuv rPackages.tuneR
    ];
    R_LIBS = "${rPackages.devtools}/library:${rPackages.httpuv}/library:${rPackages.tuneR}/library:${rPackages.htmlwidgets}/library:${rPackages.htmltools}/library:${rPackages.shiny}/library:${rPackages.xtable}/library";
  };  
}
