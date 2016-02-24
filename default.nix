with import <nixpkgs> {}; {
  mdoowEnv = stdenv.mkDerivation {
    name = "mdoow";
    buildInputs = [
      rPackages.devtools rPackages.multicore
    ];
    R_LIBS = "${rPackages.devtools}/library:${rPackages.multicore}/library";
  };  
}
