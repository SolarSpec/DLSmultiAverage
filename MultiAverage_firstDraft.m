[file,path] = uigetfile('*.dat','Select one or more input files','MultiSelect','on');
sum = 0;

if isa(file,"cell")
    for i = 1:1:size(file, 2)
        content = readtable([path, '\', file{1,i}]);
        mtrx = table2array(content);

        %First non NaN value in first column of table will tell us the index of our
        %x and y values starting position
        %The next NaN vlaue will tell us the position index of the last value + 1
        [row,col] = find(isnan(mtrx));
        indx = row(17:18,1);
        
        % Select the values we are averaging
        yvalues{1,i} = content.Var2(indx(1)+1:indx(2)-1);
        xvalues = content.Var1(indx(1)+1:indx(2)-1,1);

        %Calculate SUM
        sum = sum + yvalues{1,i};
    end

    %Calculate AVG
    avgY = sum/size(file,2);
    
    %Create new matrix to fit averaged data with x data
    emp = nan(size(mtrx));
    emp(indx(1)+1:indx(2)-1,1)= xvalues;
    emp(indx(1)+1:indx(2)-1,2)=avgY;
    
    %Write this matrix to new .dat file
    writematrix(emp,join(["averaged","_",file]));

else
    %Not for averaging. If user selects only one file, still populate
    %workspace with useful info
    content = readtable([path, '\', file]);
    mtrx = table2array(content);
    [row,col] = find(isnan(mtrx));
    indx = row(17:18,1);
end
