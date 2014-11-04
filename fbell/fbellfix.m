function [f] = fbellfix(c, r, h, norm)
%c-centros
%r-radios
%h-alturas
% ej: fbellfix([50 50;25 25],[10 20], [1 0.5]);
    d = repmat(0:100, 1, size(c,2));
    options = saoptimset('Display','off');
    d = [0 0;100 100];
    np = size(c,1);
    if norm
        [x mval] = simulannealbnd(@(x) -1.*funcion_bell(x,d,np,c,r,h,false), unifrnd(d(1,:),d(2,:)), d(1,:),d(2,:), options);
        f= @(xa, d) funcion_bell(xa, d, np, c, r, h, true, -1*mval);
    else
        f= @(xa, d) funcion_bell(xa, d, np, c, r, h, false);
    end
end

function z = funcion_bell (xa, d, npeaks, c, r, h, norm, m)
%falta pasarla a ndimensiones
    if isstruct (xa)
        x=xa.x; y=xa.y;
    else
        x=xa(:,1); y=xa(:,2);         
    end
    z = zeros(size(x));
    for i=1:npeaks
        dist = sqrt((x-c(i,1)).^2+ (y-c(i,2)).^2);
        ind = dist<r(i)/2;
        z(ind) = z(ind)+h(i)-2*h(i)*dist(ind).^2/r(i).^2;
        ind = dist>=r(i)/2 & dist<r(i);
        z(ind) = z(ind)+(2*h(i)/r(i)^2)*(dist(ind)-r(i)).^2;
    end
    if norm
        z = z/m;
    end
%     z(x<d(1,1) | y<d(1,2)) = 0;
%     z(x>d(2,1) | y>d(2,2)) = 0;
    z(x<0 | y<0) = 0;
    z(x>100 | y>100) = 0;
end
