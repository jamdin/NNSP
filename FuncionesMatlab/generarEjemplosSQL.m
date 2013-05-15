function Ej=generarEjemplosSQL(liga)

ptas=encontrarPaths;
switch liga
        case 'Espana'
            path=ptas{1};
            Equipos=textread([ptas{1} '\' 'AllTeams.txt'],'%s');
            datab='PartidosEspana';
            temp='0506%0607%0708%0809%0910%1011%1112%1213';
            prefijo='SP';
            ppt=38;
            dir='EjemplosSPSQL2';
            
        case 'Inglaterra'
            path=ptas{2};
            Equipos=textread([ptas{2} '\' 'AllTeams.txt'],'%s');
            datab='PartidosInglaterra';
            temp='0506%0607%0708%0809%0910%1011%1112%1213';
            prefijo='EP';
            ppt=38;
            
        case 'Alemania'
            path=ptas{3};
            Equipos=textread([ptas{3} '\' 'AllTeams.txt'],'%s');
            temp='0607%0708%0809%0910%1011%1112%1213';
            datab='PartidosAlemania';
            prefijo='DP';
            ppt=34;
            
        case 'Italia'
            path=ptas{4};
            Equipos=textread([ptas{4} '\' 'AllTeams.txt'],'%s');
            datab='PartidosItalia';
            temp='0506%0607%0708%0809%0910%1011%1112%1213';
            prefijo='IP';
            ppt=38;
            
        case 'Francia'
           path=ptas{5};
           temp='0708%0809%0910%1011%1112%1213';
            Equipos=textread([ptas{5} '\' 'AllTeams.txt'],'%s');
            datab='PartidosFrancia';
            prefijo='FP';
            ppt=38;

end

% r=regexp(temp,'%','split');
Ejloc=[];
Ejvis=[];
Ejdir=[];
    for j=1:size(Equipos,1)%For de los equipos

        nombreEquipo=char(Equipos(j))
        datosequipo=teamData(datab,nombreEquipo);
        
        offset=2*ppt+1;
        for fila=offset:size(datosequipo,1)%desde el offset de 2 temporadas
        disp([num2str(fila),'/',num2str(size(datosequipo,1)) ])
        [Eloc,Evis,Edir,ag]=generarDatosSQL(datab,datosequipo,fila,nombreEquipo);
        
        if ag==1
            
        Ejloc=[Ejloc;Eloc];
        Ejvis=[Ejvis;Evis];
        Ejdir=[Ejdir;Evis];
        
        size(Eloc)
        size(Evis)
        size(Edir)
        
        end
        
        end
    end
    

save (dir,'Ejloc','Ejvis','Ejdir');
end
