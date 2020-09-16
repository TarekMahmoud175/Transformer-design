clear
%Getting Inputs
frequency                    = input('Enter Frequency in Hz  \n ');
PowerRating                  = input("Enter Power Rating (S) in KVA \n ");
hv                           = input('Enter voltage on high voltage side in kv \n');
lv                           = input('Enter voltage on low voltage side in kv \n');
hvConnectionType             = input("Enter High voltage side connection type \n","s");
lvConnectionType             = input("Enter low voltage side connection type  \n","s");
offLoadTapChangerPercentage  = input("Enter off-load tap changer percentage ex: 1,2,3  \n");
duct                         = input("Enter duct value \n");
twoC                         = input("Enter distance from HV to HV \n");
noOfSteps                    = input('Enter Number Of Steps \n');
pi                           = input("Enter iron losses \n");
%************************************************************
question = input("Do you have max allowable temprature rise ? \n ","s");
if strcmp(question , "yes") == 1
    maxAllowableTempRise = input("Enter max allowable temprature rise \n");
else
    ambientTemp          = input("Enter ambient temp \n ");
    maxTemp              = input("Enter Max temprature allowed \n");
    maxAllowableTempRise = maxTemp - ambientTemp;
end
%*******************************************************************************
%assumptions if needed
lvTapChangerTurns = 0 ;
%*************start Of core design*****************************************
%get E turn
E_turn = Eturn(PowerRating);
%getting current density and magnetic field density
[delta , Bm] = GettingSpecificValues();
%calc area of iron
Ai = CalcAreaOfIron(E_turn ,Bm , frequency );
%calc window factor (k window)
K_w = windowConstant(hv,PowerRating);
%calc Area of Window
Aw = CalcAreaWindow( PowerRating , Ai , Bm , delta,K_w,frequency);
%*************calc dimensions*********
%calc steps dimensions
[a, b , c ,d ,e] = calcDimensions(Ai , noOfSteps);
%calc window dimensions
[Ww , Hw] = calcWindowDimenssions(Aw);
%calc yoke height
Hy = calaculateYokeHeight(a);
%calc total height
Height = CoreHeight(Hw , Hy);
%Calc D
D = CalcD(Ww , d);
%calc Width of core
Width = calcWidth(D , a);
%*************end of core design****************************
%********************************************************************************************************************************
%*************start of winding design***********************
%low voltage side
%calc current
lvsCurrent                          = calcCurrent(lvConnectionType,PowerRating,lv);
%calc number of turns
lvsNoTurns                           = calcNoTurns(lvConnectionType,E_turn,lv);
%calc CSA and shape of conductor
[lvsCSA , lvshape]                    = calcCSA(lvsCurrent,delta);
%calc conductor dimension based on shape
[lvcondWidth,lvcondHeight,lvcondDiameter] = calcConductorDimensions(lvsCSA , lvshape);
%calc former dimensions
[lvFormerWidth,lvFormerHeight]        = calcFormerDimensions(lvshape,d,lvcondWidth,lvcondHeight,lvcondDiameter,lvTapChangerTurns,lvsNoTurns);
%********************************************************************************************************************************
%high voltage side
%calc hvs current
hvsCurrent                                 = calcCurrent(hvConnectionType,PowerRating,hv);
%calc number of turns
hvsNoTurns                                 = calcNoTurns(hvConnectionType,E_turn,hv);
%calc tap changer
hvTapChangerTurns                          = calcTapChangerTurns(hvsNoTurns,offLoadTapChangerPercentage);
%calc CSA
[hvsCSA , hvshape]                         = calcCSA(hvsCurrent,delta);
%calc conductor dimensions
[hvcondWidth,hvcondHeight,hvcondDiameter]  = calcConductorDimensions(hvsCSA , hvshape);
%calc former dimensions
[hvFormerWidth,hvFormerHeight]             = calcFormerDimensions(hvshape,d,hvcondWidth,hvcondHeight,hvcondDiameter,hvTapChangerTurns,hvsNoTurns);
%calc Din , Dout
[Din,Dout]                                 = calcDinDout(duct,hvFormerWidth,lvFormerWidth);
%check the Hvlc 
checkHVlc                                  = checkHvLc(hvFormerHeight,twoC,Hw);
%*****************************************end of winding design*********************************************************************
%*************************************************************************************************************************************
%********************************************************* parameter design****************************************************************************
% Req calculations
%calc L mean turns of low voltage
dCM= d .*100;
LMeanTurnsLV = caclLMeanTurns(dCM,lvFormerWidth);
%calc resistance of low
Rlv          = calcR(lvsNoTurns,LMeanTurnsLV,lvsCSA);
%calc L mean turns of high voltage
LMeanTurnsHV = caclLMeanTurns(Din,Dout);
%calc resistance of high voltage
Rhv          = calcR(hvsNoTurns,LMeanTurnsHV,hvsCSA);
%calc  equivelant resistance referred to high voltage
Req          = calcReq(Rlv,Rhv,lvsNoTurns,hvsNoTurns);
%*********************************************************
%Xeq calculations
%calculate coil length
coilLength = calcCoilLength(hvFormerHeight,lvFormerHeight);
%L Mean Turns between hv and lv
lMeanTurnsBetweenHVandLV = calcLMeanTurnsHVandLV(d,Dout);
%calc Xeq  referred to hv side
Xeq                      =  calcXeq(frequency,coilLength,lMeanTurnsBetweenHVandLV,lvcondWidth,hvcondDiameter,duct,hvsNoTurns);
%calc Zeq
Zeq                      =  calcZeq(Xeq,Req);
%check zpu
CheckZpu                 =  checkZpu(Zeq,PowerRating,hv);
%********************************************************************************************************************************
%calc tank dimensions
[x,y,z]   = calcTankDimensions(Dout,Width,Height,a,hv);
%calc shape
[tankShape,ThetaRiseMax,Ntupes,Stube]= DesignTankShape(x,y,z,maxAllowableTempRise,pi,hvsCurrent,Req);
%*********************************************************************************************************************************
%printing results
disp("****************Core design results**********************************");
fprintf("Area of iron = %5f m^2 \n",Ai);
fprintf("Area of window = %5f m^2 \n",Aw);
fprintf("d = %5f m \n",d);
fprintf("a = %5f m \n",a);
fprintf("Height of Yoke = %5f m\n",Hy);
fprintf("Height of window = %5f m \n",Hw);
fprintf("Width of window = %5f m \n",Ww);
fprintf("D = %5f \n",D);
fprintf("Height of core = %5f m \n",Height);
fprintf("Width of core = %5f  m \n",Width);
disp("**************************************************************************");
disp("****************Winding design results**********************************");
disp("low voltage winding : ");
fprintf("low voltage winding current = %5f A \n",lvsCurrent);
fprintf("low voltage winding number of turns = %5f turn \n",lvsNoTurns);
fprintf("low voltage winding cross section area = %5f mm^2 \n",lvsCSA);
fprintf("low voltage winding SHape of conductor is %5s \n" , lvshape)
fprintf("low voltage winding conductor width  = %5f cm \n", lvcondWidth);
fprintf("low voltage winding conductor height = %5f cm \n",lvcondHeight);
fprintf("low voltage winding former height = %5f cm \n",lvFormerHeight);
fprintf("low voltage winding outer width = %5f cm \n",lvFormerWidth);
disp("high voltage winding : ");
fprintf("high voltage winding current = %5f A \n",hvsCurrent);
fprintf("high voltage winding number of turns = %5f turn \n",hvsNoTurns);
fprintf("high voltage winding cross section area = %5f mm^2 \n",hvsCSA);
fprintf("high voltage winding SHape of conductor is %5s \n" , hvshape)
fprintf("high voltage winding conductor diameter  = %5f cm \n", hvcondDiameter);
fprintf("high voltage winding former height = %5f cm \n",hvFormerHeight);
fprintf("high voltage winding former width= %5f cm \n",hvFormerWidth);
fprintf("Din = %5f cm  \n", Din);
fprintf("Dout = %5f cm \n", Dout);
fprintf("Check of HV coil height: %5s \n",checkHVlc);
disp("**************************************************************************");
disp("Parameters design :")
fprintf("Equivelant resistance referred to high voltage side = %5f ohm \n",Req);
fprintf("Equivelant reactance referred to high voltage side = %5f ohm  \n",Xeq);
fprintf("Equivelant Impedance referred to high voltage side = %5f ohm  \n",Zeq);
fprintf("check of Zeq: %5s \n",CheckZpu);
disp("**************************************************************************");
disp("****************Tank design results**********************************");
disp("Tank dimensions ;");
fprintf("x = %5f m \n",x);
fprintf("y = %5f m \n",y);
fprintf("z = %5f m \n",z);
disp("Tank Shape");
fprintf("Maximum temprature rise = %5.0f c \n", ThetaRiseMax );
fprintf("Tank with %5s \n" ,tankShape);
fprintf("Number of tubes used = %5.0f tubes \n",Ntupes);
fprintf("Stube =%5.0f m^2 \n",Stube);