% sliderTimeh = t(end)/25;
% sliderTimeh = floor(length(time)/15)*(time(2)-time(1));
sliderTimeh = 0.1;

xArray = [pHand(:,1), pShoulder(:,1), pWaist(:,1), pToe(:,1), pG(:,1)];
yArray = [pHand(:,2), pShoulder(:,2), pWaist(:,2), pToe(:,2), pG(:,2)];
% thDataArray = pG(:,2) - rPB;
% thDataArray = [MthHand, MthShoulder, MthWaist];
% thDataArray = [PthHand, PthShoulder, PthWaist];
thDataArray = rad2deg([thHand, thShoulder, thWaist]);
% thDataArray = [dthHand, dthShoulder, dthWaist];
% thDataArray = FyPB;
% MDataArray = vG(:,2) - drPB;
% MDataArray = [ddthHand, ddthShoulder, ddthWaist];
% MDataArray = [PthHand, PthShoulder, PthWaist];
% MDataArray = [PrPB, PthHand, PthShoulder, PthWaist];
% MDataArray = [dthHand, dthShoulder, dthWaist];
% MDataArray = [MthHand, MthShoulder, MthWaist];
MDataArray = [MthHand_ActivatedRate, MthShoulder_ActivatedRate, MthWaist_ActivatedRate];
% MDataArray = Torque_FyPB;
% MDataArray = [momentumG];
otherDataArray = rad2deg([dthHand, dthShoulder, dthWaist]);
% otherDataArray = [MthHand_ActivatedRate, MthShoulder_ActivatedRate, MthWaist_ActivatedRate];
% otherDataArray = [rPB];
% otherDataArray = [KE];
% otherDataArray = momentumG;
% otherDataArray = [centerMomentum(:,3), centerMomentum2(:,3)];
% otherDataArray = [WthShoulder, WthWaist];

if exist('graphs_main','var')
    if isvalid(graphs_main)
        graphs_main.restartupFcn(time, xArray, yArray, thDataArray, MDataArray, otherDataArray, sliderTimeh);
    else
        graphs_main = AnimeAndData(time, xArray, yArray, thDataArray, MDataArray, otherDataArray, sliderTimeh);
    end
else
    graphs_main = AnimeAndData(time, xArray, yArray, thDataArray, MDataArray, otherDataArray, sliderTimeh);
end

graphs_main.UIFigure.Name = "graphs_main";

% legend(graphs_main.axThData,{'pG(:,2) - rPB'},'location','best')
% legend(graphs_main.axThData,{'手首のトルク','肩のトルク','腰のトルク'},'location','best')
legend(graphs_main.axThData,{'腕の角度','肩角度','腰角度'},'location','best')
% legend(graphs_main.axThData,{'手首の仕事率','肩の仕事率','腰の仕事率'},'location','best')
% legend(graphs_main.axThData,{'dthHand','dthShoulder','dthWaist'},'location','best')
% legend(graphs_main.axThData,{'手にかかる力の水平成分'},'location','best')
% graphs_main.axThData.YLim = [-360, 360];
% graphs_main.axThData.YTick = [-360:180:360];
% legend(graphs_main.axMData,{'vG(:,2) - drPB'},'location','best')
% legend(graphs_main.axMData,{'ddthHand','ddthShoulder','ddthWaist'},'location','best')
% legend(graphs_main.axMData,{'dthHand','dthShoulder','dthWaist'},'location','best')
% legend(graphs_main.axMData,{'手首の仕事率','肩の仕事率','腰の仕事率'},'location','best')
% legend(graphs_main.axMData,{'平行棒の吸収率','手首の仕事率','肩の仕事率','腰の仕事率'},'location','best')
% legend(graphs_main.axMData,{'手首のトルク','肩のトルク','腰のトルク'},'location','best')
% legend(graphs_main.axMData,{'MthHand','MthShoulder','MthWaist'},'location','best')
legend(graphs_main.axMData,{'手首の動員率','肩の動員率','腰の動員率'},'location','best')
% legend(graphs_main.axMData,{'重心まわりのモーメント'},'location','best')
% legend(graphs_main.axMData,{'手にかかる力の水平成分によるトルク'},'location','best')
legend(graphs_main.axOtherData,{'dthHand','dthShoulder','dthWaist'},'location','southeast')
% legend(graphs_main.axOtherData,{'手首の動員率','肩の動員率','腰の動員率'},'location','best')
% legend(graphs_main.axOtherData,{'rPB'},'location','best
% legend(graphs_main.axOtherData,{'全力学的エネルギー'},'location','best')
% legend(graphs_main.axOtherData,{'重心まわりのモーメント'},'location','best')
% legend(graphs_main.axOtherData,{'centerMomentum', 'centerMomentum2'},'location','best')

line(graphs_main.axAnime,[-3,3],[-1.8, -1.8])