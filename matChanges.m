% This example shows how to calculate and plot both the
% fundamental TE and TM eigenmodes of an example 3-layer ridge
% waveguide using the full-vector eigenmode solver.  

% Refractive indices:
n1 = 3.34;          % Lower cladding
n2 = linspace(3.305,3.44,10);          % Core
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
nmodes = 1;         % number of modes to compute
figureCounter = 1;

neffVector = zeros(10,1);

for poop = 1:10
    [x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2(poop),n3],[h1,h2,h3], ...
                                                rh,rw,side,dx,dy); 

    % First consider the fundamental TE mode:

    [Hx,Hy,neff] = wgmodes(lambda,n2(poop),nmodes,dx,dy,eps,'000A');
    neffVector(poop) = neff;

    for loop = 1:nmodes

    fprintf(1,'neff = %.6f\n',neff(loop));

    figure(figureCounter);
    subplot(121);
    contourmode(x,y,Hx(:,:,loop));
    title(['Hx (TE mode) Mode: ',num2str(loop)]); xlabel('x'); ylabel('y'); 
    for v = edges, line(v{:}); end

    subplot(122);
    contourmode(x,y,Hy(:,:,loop));
    title(['Hy (TE mode)Mode: ',num2str(loop)]); xlabel('x'); ylabel('y'); 
    for v = edges, line(v{:}); end
    figureCounter = figureCounter + 1;
    end
    
end

    figure(figureCounter)
    plot(n2,neffVector,'-*b')
    xlabel('Core Index')
    ylabel('Neff')
    figureCounter = figureCounter + 1;