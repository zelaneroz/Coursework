A=imread('case_polo1.png');
figure(1)
image(A);
pause(2);
ndivs = 8;
nsamps = 10000;
[ color_samps_RGB ] = sample_RGB_from_image( A,nsamps);
[ color_samps, scaled_color_samps ] = sample_colors_from_image( A,nsamps, 8 );
%color_samps = sample_colors_from_image( A,nsamps, ndivs );
figure(2)
hold on

plot3(color_samps_RGB(:,1),color_samps_RGB(:,2),color_samps_RGB(:,3),'r.')
%axis([0,1,0,0.5,0,1])
%axis([0,ndivs,0,ndivs,0,ndivs])
axis([0,200,0,200,0,200])

figure(3)
plot3(color_samps(:,1),color_samps(:,2),color_samps(:,3),'r.')
axis([0,1,0,0.5,0,1])
%axis([0,ndivs,0,ndivs,0,ndivs])
%axis([0,200,0,200,0,200])
hold on

%more images

A=imread('case_polo2.png');
figure(1)
image(A);
pause(2);

[ color_samps_RGB ] = sample_RGB_from_image( A,nsamps);
figure(2)
plot3(color_samps_RGB(:,1),color_samps_RGB(:,2),color_samps_RGB(:,3),'r.')

[ color_samps, scaled_color_samps ] = sample_colors_from_image( A,nsamps, 8 );
figure(3)
plot3(color_samps(:,1),color_samps(:,2),color_samps(:,3),'r.')

A=imread('orange_t1.png');
figure(1)
image(A);
pause(2);

[ color_samps_RGB ] = sample_RGB_from_image( A,nsamps);
figure(2)
plot3(color_samps_RGB(:,1),color_samps_RGB(:,2),color_samps_RGB(:,3),'b.')

[ color_samps, scaled_color_samps ] = sample_colors_from_image( A,nsamps, 8 );
figure(3)
plot3(color_samps(:,1),color_samps(:,2),color_samps(:,3),'b.')


A=imread('white_dress1.png ');
figure(1)
image(A);
pause(2);

[ color_samps_RGB ] = sample_RGB_from_image( A,nsamps);
figure(2)
plot3(color_samps_RGB(:,1),color_samps_RGB(:,2),color_samps_RGB(:,3),'m.')

[ color_samps, scaled_color_samps ] = sample_colors_from_image( A,nsamps, 8 );
figure(3)
plot3(color_samps(:,1),color_samps(:,2),color_samps(:,3),'m.')


A=imread('interlochen1.png ');
figure(1)
image(A);
pause(2);

[ color_samps_RGB ] = sample_RGB_from_image( A,nsamps);
figure(2)
plot3(color_samps_RGB(:,1),color_samps_RGB(:,2),color_samps_RGB(:,3),'g.')

[ color_samps, scaled_color_samps ] = sample_colors_from_image( A,nsamps, 8 );
figure(3)
plot3(color_samps(:,1),color_samps(:,2),color_samps(:,3),'g.')

A=imread('striped_shirt1.png ');
figure(1)
image(A);
pause(2);

[ color_samps_RGB ] = sample_RGB_from_image( A,nsamps);
figure(2)
plot3(color_samps_RGB(:,1),color_samps_RGB(:,2),color_samps_RGB(:,3),'k.')

[ color_samps, scaled_color_samps ] = sample_colors_from_image( A,nsamps, 8 );
figure(3)
plot3(color_samps(:,1),color_samps(:,2),color_samps(:,3),'k.')


A=imread('white_dress1.png ');
figure(1)
image(A);
pause(2);

[ color_samps_RGB ] = sample_RGB_from_image( A,nsamps);
figure(2)
plot3(color_samps_RGB(:,1),color_samps_RGB(:,2),color_samps_RGB(:,3),'c.')

[ color_samps, scaled_color_samps ] = sample_colors_from_image( A,nsamps, 8 );
figure(3)
plot3(color_samps(:,1),color_samps(:,2),color_samps(:,3),'c.')

figure(2) 
title('RGB color cube')

figure(3)
title('HSV color cube')

