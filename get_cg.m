function [xcg] = get_cg(aircraft)
comp_fields = fields(aircraft.pos);
w_total = 0;
w_weighted = 0;
for i=1:length(comp)
    w = getfield(aircraft.weights,comp_fields{i});
    xpos = getfield(aircraft.pos,comp_fields{i});
    w_total = w_total + w;
    w_weighted = w_weighted + w*xpos; 
end
xcg = w_weighted/w_total;
end
