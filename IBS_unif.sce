// aimed at calculating optimal position for IBS system based on : sputtering distribution, distance target-substrate, offset target substrate, angle target, (angle ion source to target). 
 
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

// Step 1 create sputter source based on ion source emission profile and flight trajectory or point source
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

//ion_sourcedim3 sum for each point P in Target?
//implement a check for each respective Phi of ion_sourcedim3 does not match the set value, do not sum?
// for -> if should work iterated over the size of _____???? size of what
//
//link target sum to the rest of program, but how
//probably need to write a hook into, or would I replace the Substrate hypermatrix? as it is r x phi x deposition
//phi would be replaced by well, Phi; probably via a for loop iterating over the size of the matrix dimensions


//step 2 summ revieved flux over all sources 
PointR=[0.1:5:50.1];
SAStep=%pi/8;
PointAngle=[0:SAStep:2*%pi-SAStep];
Substrate=PointR'*ones(1,size(PointAngle,2));// hypermatrix (n x m x 3)with r,phi,deposition
Substrate(:,:,2)=ones(size(PointR,2),1)*PointAngle;


//2.1 find angle and distance to source
delta=cos(SubAngle)*Substrate(:,:,1).*cos(Substrate(:,:,2));
eps=sin(SubAngle)*Substrate(:,:,1).*cos(Substrate(:,:,2));
r=((DTS+eps).^2+(Soff-delta).^2+(Substrate(:,:,1).*sin(Substrate(:,:,2))).^2).^0.5;
Teta=acos((DTS-eps)./r); 

Substrate(:,:,3)= (cos(Teta).^NEmission)./(r.^2) * sin(SubAngle);


//Step 3, substrate rotation
avg_Substrate = sum(Substrate(:,:,3),2) / size(Substrate(:,:,3),2)
/*  sum(Substrate(:,:,3),2)  */
UnifProfile=[PointR',avg_Substrate];
plot(UnifProfile(:,1),UnifProfile(:,2),'r')
