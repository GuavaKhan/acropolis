%this function reads in yeast.data
function [x] = readfile(filename)
	printf('\nLoading data\n');
	inpfile = filename;
	inp = fopen(inpfile, 'r');
	x = [];
	while(true)
		line = fgetl(inpfile);
		if(line == -1)
			break;
		end
		strs = parseline(line);
	endwhile
	printf('...done\n');
endfunction

function [strs] = parseline(line)
	strs = [];
	for index = 1:length(line);
		curr = '';
		c = line(index);
		if c == '['
			index += 1;
			while(c != ']')
				c = line(index);
				curr = strcat(curr, c);
			endwhile
			index += 1;
		elseif c == ','
			strs = [strs curr];
		else
			curr = strcat(curr, c)
		endif
		%printf("%s", c);
	endfor
	printf('%s\n', strs);
endfunction
