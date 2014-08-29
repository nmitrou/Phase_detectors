function LatexTableFromData( OutputLocation, varargin )
%%
DummyVector = varargin{1};
fileID = fopen(OutputLocation,'w');
fprintf(fileID,'\\begin{tabular}{|');
for N = 1:length(DummyVector)
    fprintf(fileID,'c|'); 
end
fprintf(fileID,'}\n\\hline');
%%
FormatSpec = [];
FormatSpec2 = '& %s';
for N = 1:length(DummyVector)-1
    FormatSpec = [FormatSpec,FormatSpec2];
end
FormatSpec = ['%s',FormatSpec,'\\\\ \\hline\n'];
%%
for N = 1:nargin
    Vector = varargin{N};
    fprintf(fileID,FormatSpec,Vector{:});
end
fprintf(fileID,'\\end{tabular}');
fclose(fileID);
end

