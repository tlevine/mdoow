with import <nixpkgs> {}; {
  mdoowEnv = stdenv.mkDerivation {
    name = "mdoow";
    buildInputs = [ rPackages.devtools ];
    R_LIBS = "${rPackages.devtools}/library";
  };  
}
