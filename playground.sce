clear
xdel(winsid());
getd("C:\Users\coop2\Desktop\Code");

//Variables
Ioff=0.45; // Ion source vertical offset with respect to the target
DIT=0; // Distance between ion source and target
IDiam=1000; // Ion source diameter
TarAngle=0;// Angle between ion source and target
DTS=100;// Distance between target and substrate
Soff=0;// Offset between target normal and substrate center
SubAngle=%pi/4;//Substrate angle with respect to target normal
NEmission=1;//angular emission coefficient for sputter plume (0.5-2)
max_ionsource_particles = 1; //maximum particle
angle_array = [0:30:330]; //angles that are stored in the ion+result's second dimension ex.(:,:,2)

//ion source section
ion_results = repmat([0:2:(IDiam/2)]',1,size(angle_array, 2));
ion_results(:,:,2) = repmat(angle_array,size(ion_results(:,:,1),1),1);
for i = 1:size(ion_results(:,:,1),1)
    max_cosine_r(i) = [max_ionsource_particles * cos(ion_results(i,1,1)/max(ion_results(:,1,1)) * %pi/2)];
end
ion_results(:,:,3) = repmat(max_cosine_r', 1, size(angle_array, 2));
//plot(ion_results(:,1,1),ion_results(:,1,3),"b");

// calculating number of ions @ point P
for
    if
        
end
