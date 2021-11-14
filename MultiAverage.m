[file,path] = uigetfile('*.dat','Select one or more input files','MultiSelect','on');
sum = 0;

if isa(file,"cell")

    for i = 1:1:size(file, 2)
        %Open file and read all lines to create string w/ same format
        default = readlines([path, file{1,i}]);
        
        %Split at the line breaks to find separated data blocks
        new = regexp(default,'\s\n\s','split');
        
        %Find which lines are empty to get indices of yvalues
        logic = cellfun(@isempty,default);
        indices = find(logic);
        yvalues{1,i} = new(indices(1)+2:indices(2)-1,1);

        %Separate the two columns into the double values to average later
        newStr = cellfun(@split, yvalues{1,i}, 'UniformOutput', false);

        for indx = 1:1:size(newStr)
            x(indx,1) = str2double(newStr{indx,1}(1));
            y(indx,1) = str2double(newStr{indx,1}(2));
        end
        
        % Select the values we are averaging
        yvalues{1,i} = y(:);
        xvalues = x(:);

        %Calculate SUM
        sum = sum + yvalues{1,i};
        
    end

    %Calculate AVG
    avgY = sum/size(file,2);
    avgY = string(avgY);
    
    %Turn into proper string format then convert into cell
    xvalues = string(xvalues);
    import = strcat(xvalues,'     ',avgY);
    %Use for loop with numel() of cell array and then sprintf every single
    %val
    for i=1:numel(avgY)
        import(i) = sprintf('%s \t %s',xvalues(i), avgY(i));
    end
    cellery = cellstr(import);
    
    %Create new matrix to fit averaged data with x data
    new(indices(1)+2:indices(2)-1) = cellery;


    %Write this matrix to new .dat file
    writecell(new,join([path,"averaged","_",file(end)]));

else
    %Not for averaging. If user selects only one file, correct them
    f = msgbox("Please select more than one file");
end

