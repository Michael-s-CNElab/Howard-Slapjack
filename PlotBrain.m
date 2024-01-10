function PlotBrain(InputArr)
    InputArr = round(rescale(InputArr, 1, 256));
    load("prefab.mat")
    plotmesh(TIR, All_POS);
    mycolor = customcolormap([0 0.5 1], {'#0000ff', '#ffffff', '#ff0000'});
    colormap (mycolor)
    colorbar
    hold on
    %cm = colormap;
    Head_Connection_Plot(B_B_ELoc, ElectrodeNames, H_B_Center, B_B_plotelecopt);
    Head_Connection_Plot(B_A_ELoc, ElectrodeNames, H_A_Center, B_A_plotelecopt);
    rotate3d on;
    xlim([-200 200])
    ylim([-150 450])
    zlim([-150 300]) 
    for A_channel = 1:32
        for B_channel = 1:32
            if isnan(InputArr(A_channel, B_channel))
                break
            else
                hight = (ICD(A_channel,B_channel)+280)/3;
                x = linspace(B_A_ELoc(A_channel,1), B_B_ELoc(B_channel,1), 100);
                y = linspace(B_A_ELoc(A_channel,2), B_B_ELoc(B_channel,2), 100);
                z1 = linspace(B_A_ELoc(A_channel,3), hight, 50);
                z2 = linspace(hight, B_B_ELoc(B_channel,3), 50);
                z = [z1 z2];
                p = polyfit(y,z,2);
                x1 = linspace(B_A_ELoc(A_channel,2), B_B_ELoc(B_channel,2));
                f1 = polyval(p,x1);
                x2 = f1+abs(f1(1) - B_A_ELoc(A_channel,3));
                
                plot3(x, x1, x2,"LineWidth",1, "Color", mycolor(InputArr(A_channel, B_channel), :));
            end
        end
    end
    view([90 10])
end
