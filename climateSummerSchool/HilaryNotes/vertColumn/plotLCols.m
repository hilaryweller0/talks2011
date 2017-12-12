function var_list = plotLCols(phi, wt, it)

% write a netcdf files of the data

nc = netcdf('Lw.nc', 'c');
nc('z') = size(wt,1);
nc('t') = size(wt,2);
nc{'w'} = ncdouble('z', 't');
nc{'w'}(:) = wt;
close(nc);

nc = netcdf('Lp.nc', 'c');
nc('z') = size(phi,1);
nc('t') = size(phi,2);
nc{'p'} = ncdouble('z', 't');
nc{'p'}(:) = phi;
close(nc);


sysCommand = sprintf("grdimage Lp.nc -Ctheta.cpt -JX15c/15c -R0/21/0/101 >Lp%d.eps", it);
system(sysCommand);

%sysCommand = sprintf("grdvector Agridu.nc Agridv.nc -S0.1 -Q1p/0.25c/0.25c -J -R -W -O >> Agrid%d.eps", it);
%system(sysCommand);

system(sprintf("gv Lp%d.eps", it));


