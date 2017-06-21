clear
xdel(winsid());
getd("C:\Users\coop2\Desktop\Code");
//Variables
Ioff=0.45; // Ion source vertical offset with respect to the target
DIT=10; // Distance between ion source and target
IDiam=10; // Ion source diameter
TarAngle=%pi/4;// Angle between ion source and target
DTS=100;// Distance between target and substrate
Soff=0;// Offset between target normal and substrate center
SubAngle=%pi/4;//Substrate angle with respect to target normal
NEmission=1;//angular emission coefficient for sputter plume (0.5-2)
IEmission=1; //ion source plume result
max_ionsource_particles = 1; //maximum particles
angle_array = [0:30:330]; //angles that are stored in the ion_source second dimension ex.(:,:,2)

//ion source section
ion_source = repmat([0:2:(IDiam/2)]',1,size(angle_array, 2));
ion_source(:,:,2) = repmat(angle_array,size(ion_source(:,:,1),1),1);
for i = 1:size(ion_source(:,:,1),1)
    max_cosine_r(i) = [max_ionsource_particles * cos(ion_source(i,1,1)/max(ion_source(:,1,1)) * %pi/2)]; //cosine distribution
end
ion_source(:,:,3) = repmat(max_cosine_r', 1, size(angle_array, 2));
plot(ion_source(:,1,1),ion_source(:,1,3),"b");

// calculating number of ions @ point P
myDelta=cos(TarAngle)*ion_source(:,:,1).*cos(ion_source(:,:,2));
myEps=sin(TarAngle)*ion_source(:,:,1).*cos(ion_source(:,:,2));
myRad=((DIT+myEps).^2+(Ioff-myDelta).^2+(ion_source(:,:,1).*sin(ion_source(:,:,2))).^2).^0.5;
Phi=acos((DIT-myEps)./myRad);

Target(:,:,1)=(cos(Phi).^IEmission)./(myRad.^2) * sin(TarAngle);
disp(Target);
