function Head_Connection_Plot(newElect, ElectrodeNames, HeadCenter, opt)
    
    newNames = newElect*opt.NamesDFac; % Calculate electrode label positions
    for i = 1:size(newElect,1)
        if newElect(i,:) ~= [0 0 0]  % plot radial lines to electrode sites
            if strcmpi(opt.electrodes3d, 'off')
                line([newElect(i,1) HeadCenter(1)],[newElect(i,2) HeadCenter(2)],...
                     [newElect(i,3) HeadCenter(3)],'color',opt.MarkerColor,'linewidth',1);
            end
            if opt.labelflag == 1        % plot electrode numbers
                t=text(newNames(i,1),newNames(i,2),newNames(i,3),int2str(i)); 
                set(t,'Color',opt.NamesColor,'FontSize',opt.NamesSize,'FontWeight','bold',...
                      'HorizontalAlignment','center');
                
            elseif opt.labelflag == 2   % plot electrode names
                if exist('ElectrodeNames')
                    name = sprintf('%s',ElectrodeNames(i,:));
                    t=text(newNames(i,1),newNames(i,2),newNames(i,3),name);
                    set(t,'Color',opt.NamesColor,'FontSize',opt.NamesSize,'FontWeight','bold',...
                          'HorizontalAlignment','center'); 
                else
                    fprintf('Variable ElectrodeNames not read from spline file.\n');
                end
            else               % plot electrode markers
                
                if strcmpi(opt.electrodes3d, 'off')
                    line(newElect(:,1),newElect(:,2),newElect(:,3),'marker',...
                          '.','markersize',20,'color',opt.MarkerColor,'linestyle','none');
                else
                    [xc yc zc] = cylinder( 2, 10);
                    [xs ys zs] = sphere(10);
                    xc = [ xc; -xs(7:11,:)*2  ];
                    yc = [ yc; -ys(7:11,:)*2  ];
                    zc = [ zc; zs(7:11,:)*0.2+1 ];

                    hold on;
                    cylinderSize = 3;
                    colorarray = repmat(reshape(opt.MarkerColor, 1,1,3), [size(zc,1) size(zc,2) 1]);
                    handles = surf(xc*cylinderSize, yc*cylinderSize, zc*cylinderSize, colorarray, 'edgecolor', 'none', ...
                        'backfacelighting', 'lit', 'facecolor', 'interp', 'facelighting', ...
                        'phong', 'ambientstrength', 0.3);

                    cylnderHeight = 80;
                    if newElect(i,3) < 10, addZ = -30; else addZ = 0; end
                    if newElect(i,3) < -20, addZ = -60; else addZ = 0; end
                    xx   = newElect(i,1) - ( newElect(i,1)-HeadCenter(1) ) * 0.01 * cylnderHeight;
                    xxo1 = newElect(i,1) + ( newElect(i,1)-HeadCenter(1) ) * 0.01 * cylnderHeight;
                    yy   = newElect(i,2) - ( newElect(i,2)-HeadCenter(2) ) * 0.01 * cylnderHeight;
                    yyo1 = newElect(i,2) + ( newElect(i,2)-HeadCenter(2) ) * 0.01 * cylnderHeight;
                    zz   = newElect(i,3) - ( newElect(i,3)-HeadCenter(3)-addZ ) * 0.01 * cylnderHeight;
                    zzo1 = newElect(i,3) + ( newElect(i,3)-HeadCenter(3)-addZ ) * 0.01 * cylnderHeight;
                    [xc yc zc] = adjustcylinder2( handles, [xx yy zz], [xxo1 yyo1 zzo1] );
                end
                
            end
        end
    end
    rotate3d;
end