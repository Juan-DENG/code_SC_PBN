function OUT = Extract_cell_unit( cell_arry, label_column, start_row, end_row )
%EXTRACT_CELL_UNIT Summary of this function goes here
%   得到 cell_arry中标签为label_column的列中第start_row行的元素或start_row行开始的所有元素
Unit_column=find((strcmp(cell_arry(1,:),label_column))==1);  % 找到列
if exist('end_row','var')
  OUT=cell_arry(start_row:end_row,Unit_column);
else
  OUT=cell_arry(start_row:end,Unit_column);  
end

