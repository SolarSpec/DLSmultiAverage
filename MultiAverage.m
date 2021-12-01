[file,path] = uigetfile('*.dat','Select one or more input files','MultiSelect','on');

%Format to keep all decimal places
format short

% Set large possible index of end of file
min = 1000000;
sz = size(file,2);

if isa(file,"cell")
    for i = 1:1:sz
        % Open file and read all lines to create string w/ same format
        default = readlines([path, file{1,i}]);

        % Extract scattering angle for display
        AngleTxt = regexp(default,'Scattering angle:	');     % Get cell array to see where Scattering angle is.
        AngleInd = cellfun(@isempty,AngleTxt)==0;               % Make logical array to extract line index.
        Angle = str2double(extractAfter(default(AngleInd),'Scattering angle:	'));
        app.ScatteringangleEditField.Value = Angle;             % Display angle.

        % Split at the line-breaks to find separated data blocks
        % Create new cell matrix of strings, broken at each blank line
        new = regexp(default,'\s\n\s','split');

        % Find which lines are empty to get indices between blocks per file
        logic = cellfun(@isempty,default);
        indices = find(logic);

        % Store smallest index of last line to administer cutoff and properly average the channels block
        if indices(3) < min
            min = indices(3);
        end
        
        % Separate each block into its own cell array
        data{1,i} = new(indices(1)+2:indices(2)-1,1);   % g2-1 data column
        data{2,i} = new(indices(2)+2:indices(3)-1,1);   % Channel columns


        %%Separate every element of each column into doubles to average later
        %%Keep first column of both blocks untouched
        
        % Have both split blocks in new cell arrays containing
        % the split cell arrays
        for q = 1:2
            splitCells{1,q} = cellfun(@split, data{q,i}, 'UniformOutput', false);
        end

        % Turn into doubles respective to each block's size
        for indx = 1:1:size(splitCells{1,1})
            lagTime(indx,1) = splitCells{1,1}{indx,1}(1);
            g2(indx,1) = str2double(splitCells{1,1}{indx,1}(2));
        end
        
        for indx = 1:1:size(splitCells{1,2})
            countRate(indx,1) = splitCells{1,2}{indx,1}(1);
            y2(indx,1) = str2double(splitCells{1,2}{indx,1}(2));
            z2(indx,1) = str2double(splitCells{1,2}{indx,1}(3));
        end

        % Select the values we are averaging for 1st block
        lag = lagTime(:);
        data{1,i} = g2(:);
        
        % Select the values we are averaging for 2nd block
        count = countRate(:);
        data{2,i} = y2(:);
        data{3,i} = z2(:);
        
        % Correlation plot
        xvaluesPlot = str2double(lagTime);
        plot(app.Corr,xvaluesPlot,data{1,i});
        
        % Separate channel plots
        x2plot = str2double(countRate);
        plot(app.CHA,x2plot,y2);
        plot(app.CHB,x2plot,z2);

        % Pop up dialogue box
        selection = uiconfirm(app.UIFigure,'Do you want to add this trace to the final average?',...
            'Add to average?','Options',{'Yes','No'}); 
        selection_str = convertCharsToStrings(selection);
        
        if selection_str == 'Yes'

            % Create new cell array to hold the sums of each
            % column. Set with zeros in order to add
            sum = cell(3,1);
            sum(:,1) = {0};

            for rows = 1:3
                sum{rows,1} = sum{rows,1} + data{rows,i};
            end

        else
            sz = sz - 1;
        end
%                     
%                     d = dialog('Position',[101 22 449 221],'Name','Add to Average?');
% 
%                     uicontrol('Parent',d,...
%                                'Style','text',...
%                                'Position',[20 80 210 40],...
%                                'String','Do you want to add this trace to the final average?',...
%                                'FontSize', 22); %Text asking question
%                 
%                     yes = uicontrol('Parent',d,...
%                                'Position',[45 20 70 25],...
%                                'String','Yes',...
%                                'Callback',@yesCallback); % Yes button
% 
%                     uicontrol('Parent',d,...
%                                'Position',[105 20 70 25],...
%                                'String','No',...
%                                'Callback','delete(gcf)'); % No button
% 
%                     uiwait(d);

    end %End loop cycling through files
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Now that we've looked at every file, calculate average of
    % each column. Create new cell array to hold avgs. Set w/ 0
    avgY = cell(3,1);
    avgY(:,1) = {0};

    for rows = 1:3
        avgY{rows,1} = sum{rows,1}./sz;
        avgY{rows,1} = num2str(avgY{rows,1}, '%.6f');
        avgY{rows,1} = string(avgY{rows,1});
        avgY{rows,1} = strtrim(avgY{rows,1});
    end

    % Format each block uniquely back into strings
    
    for i=1:size(avgY{1,1},1)
        import(i,:) = compose('%s\t%s',lag(i,:), avgY{1,1}(i,:));
    end

    for i=1:size(avgY{2,1},1)
        import2(i,:) = compose('%s\t%s\t%s',count(i,:),avgY{2,1}(i,:),avgY{3,1}(i,:));
    end

    % Cap the end of the new data file to the minimum of the final index
    cap = min-indices(2)-1;
    import2(cap:end,:) = []; %Erase previous entries off of first read

    % Rewrite these specific blocks with new averaged data
    new(indices(1)+2:indices(2)-1) = import;
    new(indices(2)+2:min-1,1) = import2;

    new(end,:) = [];
    %Write this matrix to new .dat file
    writecell(new,join([path,"averaged","_",file(end)]));

else
    %Not for averaging. If user selects only one file, correct them
    f = msgbox("Please select more than one file");
end
