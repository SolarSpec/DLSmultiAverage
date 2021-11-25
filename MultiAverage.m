<<<<<<< HEAD
[file,path] = uigetfile('*.dat','Select one or more input files','MultiSelect','on');

%Format to keep all decimal places
format short
        
% Global properties used in and out of for loop
sum = 0;
sum2y = 0;
sum2z = 0;
min = 100000;

if isa(file,"cell")
    for i = 1:1:size(file, 2)
        % Open file and read all lines to create string w/ same format
        default = readlines([path, file{1,i}]);
        
        % Split at the line-breaks to find separated data blocks
        % Create new cell matrix of strings, broken at each blank line
        new = regexp(default,'\s\n\s','split');
        
        % Find which lines are empty to get indices between blocks per file
        logic = cellfun(@isempty,default);
        indices = find(logic);
        
        % Store smallest index of last line to properly average channels block
        if indices(3) < min
            min = indices(3);
        end
        
        %%g2-1 data column
        yvalues{1,i} = new(indices(1)+2:indices(2)-1,1);

        % Separate all elements of both columns into the double values to average later
        % Start with first data block g2-1
        g2 = cellfun(@split, yvalues{1,i}, 'UniformOutput', false);
        
        for indx = 1:1:size(g2)
            x(indx,1) = g2{indx,1}(1);
            y(indx,1) = str2double(g2{indx,1}(2));
        end
        
        % Select the values we are averaging
        yvalues{1,i} = y(:);
        xvalues = x(:);

        %Calculate SUM of our g2-1 column
        sum = sum + yvalues{1,i};
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%%Channel columns
        channels{1,i} = new(indices(2)+2:indices(3)-1,1);

        %Separate the two columns into the double values to average later
        CR = cellfun(@split, channels{1,i}, 'UniformOutput', false);
        
        for indx = 1:1:size(CR)
            x2(indx,1) = CR{indx,1}(1);
            y2(indx,1) = str2double(CR{indx,1}(2));
            z2(indx,1) = str2double(CR{indx,1}(3));
        end
        
        % Select the values we are averaging
        countRate = x2(:);
        channels{1,i} = y2(:);
        channels{2,i} = z2(:);
       

        %Calculate SUM of both channels
        %%MAYBE LOOP THIS AND HAVE ALL AVERAGES IN ONE VARIABLE
        sum2y = sum2y + channels{1,i};
        sum2z = sum2z + channels{2,i};
        
        
    end

    %Calculate AVG
    %%SAME THOUGHT AS ABOVE
    avgY = sum/size(file,2);
    avg2Y = sum2y/size(file,2);
    avg2Z = sum2z/size(file,2);
    
    %Turn into proper string format for given DAT file
    avgY = num2str(avgY, '%.6f');
    avgY = string(avgY);
    avgY = strtrim(avgY);
    
    avg2Y = num2str(avg2Y, '%.6f');
    avg2Y = string(avg2Y);
    avg2Y = strtrim(avg2Y);
    
    avg2Z = num2str(avg2Z, '%.6f');
    avg2Z = string(avg2Z);
    avg2Z = strtrim(avg2Z);

    %Use for loop with SIZE of cell array, format strings while exporting
    %cell arrays of each data block
    
    for i=1:size(avgY,1)
        import(i,:) = compose('%s\t%s',xvalues(i,:), avgY(i,:));
    end
    
    for i=1:size(avg2Y,1)
        import2(i,:) = compose('%s\t%s\t%s',countRate(i),avg2Y(i,:),avg2Z(i,:));
    end
    
    %Cap the end of the new data file to min of last index
    cap = min-indices(2)-1;
    import2(cap:end,:) = [];
    
    % Rewrite these specific blocks with new averaged data
    new(indices(1)+2:indices(2)-1) = import;
    new(indices(2)+2:min-1,1) = import2;

    new(min:end,:) = [];
    %Write this matrix to new .dat file
    writecell(new,join([path,"averaged","_",file(end)]));

else
    %Not for averaging. If user selects only one file, correct them
    f = msgbox("Please select more than one file");
end

=======
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

>>>>>>> 0c0d847b753063efffeeb117fb3162b0c8fb4563
