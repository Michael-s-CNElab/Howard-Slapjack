function PlotBrain(InputArr)
    InputArr = InputArr(1:32,33:64);
     for ch1 = 1:32
        for ch2 = 1:32
            if abs(InputArr(ch1, ch2)) < 2.0485
                InputArr(ch1, ch2) = 0;
            elseif InputArr(ch1, ch2) > 2.0485 && InputArr(ch1, ch2) < 2.764
                InputArr(ch1, ch2) = 1;
            elseif InputArr(ch1, ch2) > 2.764 && InputArr(ch1, ch2) < 3.674
                InputArr(ch1, ch2) = 2;
            elseif InputArr(ch1, ch2) > 3.674
                InputArr(ch1, ch2) = 3;
            elseif InputArr(ch1, ch2) < -2.0485 && InputArr(ch1, ch2) > -2.764
                InputArr(ch1, ch2) = -1;
            elseif InputArr(ch1, ch2) < -2.764 && InputArr(ch1, ch2) > -3.674
                InputArr(ch1, ch2) = -2;
            elseif InputArr(ch1, ch2) < -3.674
                InputArr(ch1, ch2) = -3;
            end
        end
    end


    load("prefab.mat")
    colortmp = InputArr;
    plotmesh(TIR, All_POS);
    hold on
    mycolors = [0 0 1; 0.5 0.5 1; 1 1 1; 1 0.5 0.5; 1 0 0];
    colormap (mycolors)
    %cm = colormap;
    Head_Connection_Plot(B_B_ELoc, ElectrodeNames, H_B_Center, B_B_plotelecopt);
    Head_Connection_Plot(B_A_ELoc, ElectrodeNames, H_A_Center, B_A_plotelecopt);
    rotate3d on;
    xlim([-200 200])
    ylim([-150 450])
    zlim([-150 300]) 
    for i = 1:32
        for j = 1:32
            A_channel = i;
            B_channel = j;
            hight = (ICD(i,j)+280)/3;
            x = linspace(B_A_ELoc(A_channel,1), B_B_ELoc(B_channel,1), 100);
            y = linspace(B_A_ELoc(A_channel,2), B_B_ELoc(B_channel,2), 100);
            z1 = linspace(B_A_ELoc(A_channel,3), hight, 50);
            z2 = linspace(hight, B_B_ELoc(B_channel,3), 50);
            z = [z1 z2];
            p = polyfit(y,z,2);
            x1 = linspace(B_A_ELoc(A_channel,2), B_B_ELoc(B_channel,2));
            f1 = polyval(p,x1);
            x2 = f1+abs(f1(1) - B_A_ELoc(A_channel,3));
            if ~isnan(colortmp(i,j))
                if colortmp(i,j) == 3
                    plot3(x, x1, x2,"LineWidth",1, "Color", '#FF0000')
                elseif colortmp(i,j) == 2
                    plot3(x, x1, x2,"LineWidth",1, "Color", '#FFC0C0')
                elseif colortmp(i,j) == 1
                    plot3(x, x1, x2,"LineWidth",1, "Color", '#FF8080')
                elseif colortmp(i,j) == -1
                    plot3(x, x1, x2,"LineWidth",1, "Color", '#8080FF')
                elseif colortmp(i,j) == -2
                    plot3(x, x1, x2,"LineWidth",1, "Color", '#C0C0FF')
                elseif colortmp(i,j) == -3
                    plot3(x, x1, x2,"LineWidth",1, "Color", '#0000FF')
                end
            end
        end
    end
    view([90 10])

end
