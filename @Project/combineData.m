function combined_data = combineData(indexarray,project)
% COMBINEDATA combines the selected data from selected checkboxes which
% have indecies that are in indexarray

d1=[];d2=[];d3=[];d4=[];d5=[];d6=[];d7=[];d8=[];
for i = 1:length(indexarray)
    switch indexarray(i)
        case 1
            d1 = project.Audio1.Data;
        case 2
            d2 = project.Vocal2.Data;
        case 3
            d3=project.GuitarPiano.Data;
        case 4
            d4 = project.Drums.Data;
        case 5
            d5 = project.Audio2.Data;
        case 6
            d6 = project.Vocal2Eff.Data;
        case 7
            d7 = project.GuitarPianoEff.Data;
        case 8
            d8 = project.DrumsEff.Data;
    end
end
data = {d1, d2, d3, d4,d5,d6,d7,d8};
lengths = [ length(d1), length(d2), length(d3), length(d4),length(d5),length(d6),length(d7),length(d8)];
maxlength = max(lengths);
for i = 1:8
    if length(data{i}) ~= maxlength
        diff = maxlength - length(data{i});
        z = zeros(diff,2);
        data{i} = [data{i};z];
    end
end
combined_data = data{1}+data{2}+data{3}+data{4}+data{5}+data{6}+data{7}+data{8};

end