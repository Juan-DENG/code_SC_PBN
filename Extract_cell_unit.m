function OUT = Extract_cell_unit( cell_arry, label_column, start_row, end_row )
%EXTRACT_CELL_UNIT Summary of this function goes here
%   �õ� cell_arry�б�ǩΪlabel_column�����е�start_row�е�Ԫ�ػ�start_row�п�ʼ������Ԫ��
Unit_column=find((strcmp(cell_arry(1,:),label_column))==1);  % �ҵ���
if exist('end_row','var')
  OUT=cell_arry(start_row:end_row,Unit_column);
else
  OUT=cell_arry(start_row:end,Unit_column);  
end

