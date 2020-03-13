% This example shows how to calculate and plot both the
% fundamental TE and TM eigenmodes of an example 3-layer ridge
% waveguide using the full-vector eigenmode solver.  

% Refractive indices:
n1 = 3.34;          % Lower cladding
n2 = 3.44;          % Core
n3 = 1.00;          % Upper cladding (air)

% Layer heights:
h1 = 2.0;           % Lower cladding
h2 = 1.3;           % Core thickness
h3 = 0.5;           % Upper cladding

% Horizontal dimensions:
rh = 1.1;           % Ridge height
rw = 1.0;           % Ridge half-width
side = 1.5;         % Space on side

% Grid size:
dx = 0.0125;        % grid size (horizontal)
dy = 0.0125;        % grid size (vertical)

lambda = 1.55;      % vacuum wavelength
nmodes = 10;         % number of modes to compute

[x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2,n3],[h1,h2,h3], ...
                                            rh,rw,side,dx,dy); 

% First consider the fundamental TE mode:

[Hx,Hy,neff] = wgmodes(lambda,n2,nmodes,dx,dy,eps,'000A');

figureCounter = 1;
for loop = 1:nmodes

fprintf(1,'neff = %.6f\n',neff(loop));

figure(figureCounter);
subplot(121);
contourmode(x,y,Hx(:,:,loop));
title(['Hx (TE mode) Mode: ',num2str(loop)]); xlabel('x'); ylabel('y'); 
for v = edges, line(v{:}); end
figureCounter = figureCounter + 1;

subplot(122);
contourmode(x,y,Hy(:,:,loop));
title(['Hy (TE mode)Mode: ',num2str(loop)]); xlabel('x'); ylabel('y'); 
for v = edges, line(v{:}); end
figureCounter = figureCounter + 1;
end

% Next consider the fundamental TM mode
% (same calculation, but with opposite symmetry)

[Hx,Hy,neff] = wgmodes(lambda,n2,nmodes,dx,dy,eps,'000S');

for loop = 1:10
fprintf(1,'neff = %.6f\n',neff(loop));

figure(figureCounter);
subplot(121);
contourmode(x,y,Hx(:,:,loop));
title(['Hx (TM mode)Mode: ',num2str(loop)]); xlabel('x'); ylabel('y'); 
for v = edges, line(v{:}); end
figureCounter = figureCounter + 1;

subplot(122);
contourmode(x,y,Hy(:,:,loop));
title(['Hy (TM mode)Mode: ',num2str(loop)]); xlabel('x'); ylabel('y'); 
for v = edges, line(v{:}); end
figureCounter = figureCounter + 1;
end
