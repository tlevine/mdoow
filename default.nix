with import <nixpkgs> {}; {
  mdoowEnv = stdenv.mkDerivation {
    name = "mdoow";
    buildInputs = [
      rPackages.devtools rPackages.httpuv rPackages.tuneR
    ];
    R_LIBS = "${rPackages.devtools}/library:${rPackages.httpuv}/library:${rPackages.tuneR}/library";
  };  
}
