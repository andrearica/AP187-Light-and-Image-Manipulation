%%Raspi Versions in comment
br = imread('broad1.cr2');
He = imread('He1.cr2');
df = imread('df.cr2');
ff = imread('flatfield5.cr2'); ff = imcrop(ff,[1220,1384,239,100]);
% br = imread('ringlamp.jpg');
% He = imread('helium2.jpg');

br = br-df;
He = He-df;

ffR = ff(:,:,1);
ffG = ff(:,:,2);
ffB = ff(:,:,3);

nbr = imcrop(br,[1220,1384,239,100]); nbr=fliplr(nbr);
nHe = imcrop(He,[1220,1384,239,100]); nHe=fliplr(nHe);
% nbr = imcrop(br,[2650,1457,320,100]);% nbr=fliplr(nbr);
% nHe = imcrop(He,[2650,1457,320,100]); %nHe=fliplr(nHe);


gHe = rgb2gray(nHe); intHe = mean(gHe,1);

Rbr = nbr(:,:,1);
Gbr = nbr(:,:,2);
Bbr = nbr(:,:,3);

R = mean(Rbr,1); 
G = mean(Gbr,1);
B = mean(Bbr,1); 


%%
pixels = [29 71 112 177];
% pixels = [80 104 139 234];
wavelengths = [388 447 501 588];

p = polyfit(pixels,wavelengths,1);
%%
brWL = polyval(p,1:240);
% brWL = polyval(p,1:321);

spec = readtable('white2.csv'); I= normalize(spec.I);
nY = interp1(spec.W,I,brWL)*2.5;

% R = R/255./nY;% envelope(R,brWL,nY);
% G = G/255./nY;%envelope(G,brWL,nY);
% B = B/255./nY;% envelope(B,brWL,nY);

figure();
plot(brWL,R,'r');
hold on;
% plot(brWL,nY,'k');
plot(brWL,G,'g');
plot(brWL,B,'b');
title("Spectral Sensitivity Vivo V7");

%%
function [f] = envelope(fn,brWL,nY)

f = fn;
for i =1:length(fn)
    f(i) = (fn(i)-min(fn))/(nY(i)-min(fn));
end
end

function [f] = normalize(fn)

    f = (fn-min(fn))/(max(fn)-min(fn));

end
