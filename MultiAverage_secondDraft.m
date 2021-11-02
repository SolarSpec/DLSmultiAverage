[file,path] = uigetfile('*.dat','Select one or more input files','MultiSelect','on');
sum = 0;

if isa(file,"cell")
    for i = 1:1:size(file, 2)
        %Open file and palce all data points into 2 columns
        f = fopen([path, file{1,i}]);
        data = textscan(f,'%s %s %s');
        fclose(f);
        
        %Create a matrix out of these string values. The data with a 3rd
        %column will float down 1 row and only have the 1 value
        mtrx = [data{:}];
        tst = str2double(mtrx);
        

        %%First non NaN value in first column of table will tell us the index of our
        %%x and y values starting position
        %%The next NaN value will tell us the position index of the last value + 1
        
        %Set NaN values to zero in order to operate logically on array
        tst(isnan(tst)) = 0;
        k = find(~tst(:,1));
        
        %The largest gap between index's will be the values just outside of
        %the data we want
        [~, indx] = max(diff(k));
        
        % Select the values we are averaging
        yvalues{1,i} = tst(k(indx)+1:k(indx+1)-1,2);
        xvalues = tst(k(indx)+1:k(indx+1)-1,1);

        %Calculate SUM
        sum = sum + yvalues{1,i};
        
    end

    %Calculate AVG
    avgY = sum/size(file,2);
    
    %Create new matrix to fit averaged data with x data
    for i=1:numel(avgY)
        mtrx{k(indx)+i,2} = avgY(i);
    end
    out = mtrx;

%     %Write this matrix to new .dat file
    writecell(out,join([path,"averaged","_",file(end)]),'Delimiter', 'space');

else
    %Not for averaging. If user selects only one file, still populate
    %workspace with useful info
    f = readtable([path, '\', file]);
    mtrx = table2array(f);
    [row,col] = find(isnan(mtrx));
    indx = row(17:18,1);
end
