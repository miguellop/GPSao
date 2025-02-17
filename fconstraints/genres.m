d = [0 0;9 9];
sgB=sgr(2,...
    [10 10; 5 5],...
    d,...
    {@ft1,@ft1;...
    @ft1,@ft1;...
    },...
    {[] [];...
    [] [];...
    },...
    {@fu1,@fu1;...
    @fu2,@fu2;...
    },...
    {'media=1;desv=0.5;', 'media=1;desv=0.5;';...
    'media=1;desv=0.5;', 'media=1;desv=0.5;';...
    });

sgS=sgr(2,...
    [3 3; 3 3],...
    d,...
    {@ft1,@ft1;...
    @ft1,@ft1;...
    },...
    {[] [];...
    [] [];...hist
    },...
    {@fu1,@fu1;...
    @fu2,@fu2;...
    },...
    {'media=1;desv=0.5;', 'media=1;desv=0.5;';...
    'media=1;desv=0.5;', 'media=1;desv=0.5;';...
    });

rB=rsgr(sgB,[0 9]);
rS=rsgr(sgS,[0 9]);
%Normalización a 1 de las funciones de utilidad. El optimizador genético
%funciona mejor que los restantes.
fB = @(x) -1*frsgr(x,rB,d);
options = gaoptimset('PopulationSize', 100*length(d));
[x, fvalB] = ga(fB, length(d), [], [], [], [], d(1,:), d(2,:), [], options);
%[x, fvalB] = patternsearch(fB, unifrnd(d(1,1), d(1,2),1,length(d)), [], [], [], [], d(:,1), d(:,2));
%[x, fvalB] = simulannealbnd(fB, unifrnd(d(1,1), d(1,2),1,length(d)), d(:,1), d(:,2));
fS = @(x) -1*frsgr(x,rS,d);
[x, fvalS] = ga(fS, length(d), [], [], [], [], d(1,:), d(2,:), [], options);
%[x, fvalS] = patternsearch(fS, unifrnd(d(1,1), d(1,2),1,length(d)), [], [], [], [], d(:,1), d(:,2));
%[x, fvalB] = simulannealbnd(fS, unifrnd(d(1,1), d(1,2),1,length(d)), d(:,1), d(:,2));
fvalB = abs(fvalB); fvalS = abs(fvalS);
fB = @(x,d) frsgr(x,rB,d)./fvalB;
fS = @(x,d) frsgr(x,rS,d)./fvalS;