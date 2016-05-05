function [ path ] = getParentDirectory( level )
path = pwd
parts = strsplit(path,'/');
parts = {parts{1:end-level}};
path = '';
for i = 1:size(parts,2)
	if isequal(parts{i},'')
		continue;
	end
	path = strcat(path,'/');
	path = strcat(path,parts{i});
end
path
end

