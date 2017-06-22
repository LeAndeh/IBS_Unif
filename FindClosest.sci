function[col,delta]=FindClosest (data,val) //find the first index of point in "data" whose the closest to the value "val"
//%data should be a vector

col= data==val;//%faster than "find(data==val); if isempty(col)
delta=0;
if ~or(col)
    [delta, col] = min(abs(data-val));
else
    col=find(data==val);//If the val is in data, what is its position
end
endfunction
