figure

[nt, nx, ny] = size(u);

for ti = 1:nt

    pcolor(x, y, squeeze(u(ti, :, :)))
    
    shading interp
    axis equal tight
    colorbar

    subplot(1, 2, 2);
    pcolor(x, y, squeeze(v(ti, :, :)));
    shading interp
    axis equal tight
    colorbar

    drawnow

end


function [u_smooth] = smooth(u , nx, ny)
   
u_smooth = zeros(nx, ny);

for i = 2:(nx-1)

    for j = 2:(ny-1)
            
         u_smooth(i, j) = (u(i, j) +  u(i-1, j) + u(i+1, j) + u(i, j-1) + u(i, j+1))/5;


    end
end



end


