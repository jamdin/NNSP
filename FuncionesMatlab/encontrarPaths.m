function [paths,pathAG]=encontrarPaths()
    cd ..
        
    pathEsp=[pwd '\DatosEsp1\'];
    pathIng=[pwd '\DatosIng1\'];
    pathAle=[pwd '\DatosAle1\'];
    pathIta=[pwd '\DatosIta1\'];
    pathFra=[pwd '\DatosFra1\'];
    paths={pathEsp;pathIng;pathAle;pathIta;pathFra};
    pathAG=[pwd '\AlgoritmoGenetico\'];
    cd FuncionesMatlab
end