// aimed at calculating optimal position for IBS system based on : sputtering distribution, distance target-substrate, offset target substrate, angle target, (angle ion source to target). 
 
clear
xdel(winsid());
getd("C:\Users\coop2\Desktop\Code");
//Variables
Ioff=0.45; // Ion source vertical offset with respect to the target
DIT=0; // Distance between ion source and target
IDiam=0; // Ion source diameter
TarAngle=0;// Angle between ion source and target
DTS=100;// Distance between target and substrate
Soff=0;// Offset between target normal and substrate center
SubAngle=%pi/4;//Substrate angle with respect to target normal
NEmission=1;//angular emission coefficient for sputter plume (0.5-2)


// Step 1 create sputter source based on ion source emission profile and flight trajectory or point source



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
