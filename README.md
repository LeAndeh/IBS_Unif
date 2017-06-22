# IBS_Unif
IBS (ion beam sputtering) program to calculate uniformity using Scilab 6.0

What I needed to do:
1. Define a fixed sputtering source. Later, get scilab to calculate x sputtering sources based on variables from the ion source.
=> fixed sputtering source complete, attemping the all sources to target plate.

2. calculate the material coming to any point of the wafer:
- know both the distance between the source and the point on the wafer / substrate,
- know the angle between the normal of the source and the point on the wafer.
=> this is complete

3. add substrate rotation
=> not yet implemented

----------------------------------------------------------------------------------------------
#Rewritten Tasks

1. Emission Distribution of Ion Source, currently it is given a cosine distribution

2. Calculate distance and angle between points - done via pen & paper

3. For all points on the target, calculate the total ion flux (angular emission function)

4. Calculate distance and angles between points

5. For all points on the substrate, calculate total point flux

-------------------------------------------------
FindClosest.sci is a function written to aid this program.
