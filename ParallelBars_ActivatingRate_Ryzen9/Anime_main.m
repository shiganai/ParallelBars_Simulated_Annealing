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
% legend(graphs_main.axThData,{'���̃g���N','���̃g���N','���̃g���N'},'location','best')
legend(graphs_main.axThData,{'�r�̊p�x','���p�x','���p�x'},'location','best')
% legend(graphs_main.axThData,{'���̎d����','���̎d����','���̎d����'},'location','best')
% legend(graphs_main.axThData,{'dthHand','dthShoulder','dthWaist'},'location','best')
% legend(graphs_main.axThData,{'��ɂ�����͂̐�������'},'location','best')
% graphs_main.axThData.YLim = [-360, 360];
% graphs_main.axThData.YTick = [-360:180:360];
% legend(graphs_main.axMData,{'vG(:,2) - drPB'},'location','best')
% legend(graphs_main.axMData,{'ddthHand','ddthShoulder','ddthWaist'},'location','best')
% legend(graphs_main.axMData,{'dthHand','dthShoulder','dthWaist'},'location','best')
% legend(graphs_main.axMData,{'���̎d����','���̎d����','���̎d����'},'location','best')
% legend(graphs_main.axMData,{'���s�_�̋z����','���̎d����','���̎d����','���̎d����'},'location','best')
% legend(graphs_main.axMData,{'���̃g���N','���̃g���N','���̃g���N'},'location','best')
% legend(graphs_main.axMData,{'MthHand','MthShoulder','MthWaist'},'location','best')
legend(graphs_main.axMData,{'���̓�����','���̓�����','���̓�����'},'location','best')
% legend(graphs_main.axMData,{'�d�S�܂��̃��[�����g'},'location','best')
% legend(graphs_main.axMData,{'��ɂ�����͂̐��������ɂ��g���N'},'location','best')
legend(graphs_main.axOtherData,{'dthHand','dthShoulder','dthWaist'},'location','southeast')
% legend(graphs_main.axOtherData,{'���̓�����','���̓�����','���̓�����'},'location','best')
% legend(graphs_main.axOtherData,{'rPB'},'location','best
% legend(graphs_main.axOtherData,{'�S�͊w�I�G�l���M�['},'location','best')
% legend(graphs_main.axOtherData,{'�d�S�܂��̃��[�����g'},'location','best')
% legend(graphs_main.axOtherData,{'centerMomentum', 'centerMomentum2'},'location','best')

line(graphs_main.axAnime,[-3,3],[-1.8, -1.8])