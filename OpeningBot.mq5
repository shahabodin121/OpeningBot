//+------------------------------------------------------------------+
//|                                                    CoderRobo.mq5 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright   " Telegram : Coder Robo"
#property link        " https://t.me/CoderRobo"
#property icon        "Robo.ico" 
#property description " project manager : Coder Robo "
#property description " \nThis robot is a research tool that allows you to backtest and assess the risk of your trading strategy .\n Financial markets involve a high level of risk. Please trade with caution."
#property strict

#include <Trade\Trade.mqh>


input   string General    = " --- General Setting --- ";
input   ENUM_TIMEFRAMES time_Trade = PERIOD_M15; //Timeframe for trading
input   bool befor       = false  ;  // Trade before the session opens
input   bool after       = true  ;  // Trade after the session opens
input   string trigger_ = "-- intry model --" ;
input   bool highandlow = false ;   // Use the First high or low
input   bool close =      true ;    // Use the First close
input   bool BuyStop_SellStop = false ; // Use the Buy Stop Or Sell Stop
input   int  MarginOnHighLow   = 5 ;

//-----
input   string Sessions = "-- Sessions Setting -- " ;
input   bool SyTrade      = false ; //Enable Sydney session trading
input   int SyHour        = 1 ;    //Start Sydny Hour
input   int SyMin         = 30 ;    //Start Sydny Min

input   bool ToTrade      = false ; //Enable Tokyo session trading
input   int ToHour        = 3 ;    //Start Tokyo_Hour
input   int ToyMin        = 30 ;    //Start Tokyo_Min

input   bool LnTrade      = false ; //Enable London session trading
input   int LnHour        = 10;    //Start London_Hour
input   int LnMin         = 30;    //Start London_Min

input   bool NyTrade       = false  ; //Enable New York session trading
input   int NyHour        = 16;    //Start NewYork Hour
input   int NyMin         = 30;    //Start NewYork Min

//---------------

input   string Managment  = " --- Trade Setting --- ";
input   int  MarginOnStopLoss   = 2 ;
input   double Risk       = 1 ;  // RISK to percent %
input   double   Doller      = 0.0 ; // RISK to Doller $
input   int TakeProfit    = 2; //RISK to reward : Tp
// input   int SmallStopLoss = 00 ; // Smaller Stop Loss To Persent %
input   int  Spread    =  5  ;
input   int ExpierLimit = 0 ;   // Expierton for intry - per candel
input  string  visual = " -- Color Setting -- " ;
input   color clrLine     = clrDarkBlue;  // Horizntal Line on Trade Limit
input   color clrvline = clrLavender ;    // vertical line
input   color clrText  = clrBlack ; // text Session color

//------------------------------
int magicNumber = 0 ;
string nameOB = "Session" ;
double SessionHigh = 0.0;
double SessionLow  = 0.0;
datetime SessionTime  = 0;
datetime befor_ = 0;
bool ky = false ;
bool ky2 = false ;
bool ky3 = false ;
bool ky4 = false ;
double Spread_ = 0 ;
ENUM_SYMBOL_CALC_MODE CalcMode;
int Limit = 0 ;

//-----------------------------------------
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {

   Spread_ = Spread * Point() ;

   ky = false ;
   ky2 = false ;
   ky3 = false ;
   ky4 = false ;
   SessionLow = 0;
   SessionHigh = 0;
   SessionTime = 0;
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   DeletObjects(nameOB);

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {

// ---- manager buy stop and sell stop
   CTrade T ;
   if(OrdersTotal() != 0)
     {
      //   Print(" hello  ") ;
      for(int i = 0; i < OrdersTotal(); i++)
        {
         ulong ticket = OrderGetTicket(i) ;
         bool select = OrderSelect(ticket) ;
         if(select)
           {
            if(OrderGetInteger(ORDER_MAGIC) == magicNumber)
              {
               Print(" ticket = ", ticket) ;
               bool orders = false ;
               for(int b = 0; b < OrdersTotal(); b++)
                 {
                  ulong ticket2 = OrderGetTicket(b) ;
                  bool select_ = OrderSelect(ticket2) ;
                  if(select_)
                    {
                     if(OrderGetInteger(ORDER_MAGIC) == magicNumber && ticket != ticket2)
                       {
                        Print(" ticket 2 = ", ticket2) ;
                        orders = true ;
                        break ;
                       }
                    }

                 }
               if(orders == true)
                 {
                  break ;
                 }
               else
                 {
                  T.OrderDelete(ticket);
                  magicNumber = 0 ;
                  break ;
                 }
              }
           }

        }
     }
//--- evry close
   double close15M = iClose(_Symbol, time_Trade, 0);
   datetime now    = iTime(_Symbol, time_Trade, 0);
   if(now != befor_)
     {
      befor_ = now;
      MqlDateTime timeStruct;
      datetime timeNo = TimeCurrent();
      datetime end2 = timeNo + (PeriodSeconds(time_Trade) * 7);
      TimeToStruct(timeNo, timeStruct);

      //---Expier Limit

      if(SessionTime != 0 && ExpierLimit != 0)
        {
         Limit++ ;
         if(Limit > ExpierLimit)
           {
            SessionHigh = 0;
            SessionLow  = 0;
            SessionTime = 0;
            Limit = 0 ;
            Alert("Trade Expier");
           }
        }


      //---Sydny
      if(timeStruct.hour == SyHour && timeStruct.min  == SyMin && SyTrade == true)
        {

         SessionTime =  iTime(Symbol(), time_Trade, 0);
         if(befor == false && after == true)
            SessionTime = SessionTime + (PeriodSeconds(time_Trade) * 1);

         if(befor ==  true  && after == false)
            SessionTime = SessionTime;


         Print(" ========= session time = ", SessionTime) ;
         ky  = true ;
         ky2 = false;
         ky3 = false;
         ky4 = false;
        }
     
      if(iTime(NULL, time_Trade, 0) == SessionTime && ky == true)
        {
         SessionHigh  = iHigh(NULL, time_Trade, 1);
         SessionLow   = iLow(NULL, time_Trade, 1);
         DeletObjects(nameOB);
         string SydnyH = nameOB + "SYH_" + TimeToString(TimeCurrent()) ;
         string SydnyL = nameOB + "SYL_" + TimeToString(TimeCurrent()) ;
         string SydnyT = nameOB + "SYT_" + TimeToString(TimeCurrent()) ;
         TrendCreate(0, SydnyH, 0, SessionTime - (PeriodSeconds(time_Trade) * 1), SessionHigh, end2, SessionHigh);
         TextCreate(0, SydnyT, 0, SessionTime - (PeriodSeconds(time_Trade) * 1), SessionHigh, "Sydny");
         TrendCreate(0, SydnyL, 0, SessionTime - (PeriodSeconds(time_Trade) * 1), SessionLow, end2, SessionLow);
         ky = false ;

        }
      //---Tokyo
      if(timeStruct.hour == ToHour && timeStruct.min == ToyMin && ToTrade == true)
        {
         SessionTime =  iTime(Symbol(), time_Trade, 0);
         if(befor == false && after == true)
            SessionTime = SessionTime + (PeriodSeconds(time_Trade) * 1);

         if(befor ==  true  && after == false)
            SessionTime = SessionTime;


         ky2 = true ;
         ky  = false;
         ky3 = false;
         ky4 = false;

        }
      if(iTime(NULL, time_Trade, 0) == SessionTime && ky2 == true)
        {
         SessionHigh  = iHigh(NULL, time_Trade, 1);
         SessionLow   = iLow(NULL, time_Trade, 1);


         DeletObjects(nameOB);
         string TokyoH = nameOB + "TOH_" + TimeToString(TimeCurrent()) ;
         string TokyoL = nameOB + "TOL_" + TimeToString(TimeCurrent()) ;
         string TokyoT = nameOB + "TOT_" + TimeToString(TimeCurrent()) ;
         TrendCreate(0, TokyoH, 0, SessionTime - (PeriodSeconds(time_Trade) * 1), SessionHigh, end2, SessionHigh);
         TextCreate(0, TokyoT, 0, SessionTime - (PeriodSeconds(time_Trade) * 1), SessionHigh, "Tokyo");
         TrendCreate(0, TokyoL, 0, SessionTime - (PeriodSeconds(time_Trade) * 1), SessionLow, end2, SessionLow);
         ky2 = false ;
        }

      //---London

      if(timeStruct.hour == LnHour && timeStruct.min == LnMin && LnTrade == true)
        {
         SessionTime =  iTime(Symbol(), time_Trade, 0);
         if(befor == false && after == true)
            SessionTime = SessionTime + (PeriodSeconds(time_Trade) * 1);

         if(befor ==  true  && after == false)
            SessionTime = SessionTime;

         ky3 = true ;
         ky  = false;
         ky2 = false;
         ky4 = false;

        }
      if(iTime(NULL, time_Trade, 0) == SessionTime && ky3 == true)
        {
         SessionHigh  = iHigh(NULL, time_Trade, 1);
         SessionLow   = iLow(NULL, time_Trade, 1);


         DeletObjects(nameOB);
         string LondonH = nameOB + "LNH_" + TimeToString(TimeCurrent()) ;
         string LondonL = nameOB + "LNL_" + TimeToString(TimeCurrent()) ;
         string LondonT = nameOB + "LNT_" + TimeToString(TimeCurrent()) ;
         TrendCreate(0, LondonH, 0, SessionTime - (PeriodSeconds(time_Trade) * 1), SessionHigh, end2, SessionHigh);
         TextCreate(0, LondonT, 0, SessionTime - (PeriodSeconds(time_Trade) * 1), SessionHigh, "London");
         TrendCreate(0, LondonL, 0, SessionTime - (PeriodSeconds(time_Trade) * 1), SessionLow, end2, SessionLow);
         ky3 = false ;
        }
      //---NewYork

      if(timeStruct.hour == NyHour && timeStruct.min == NyMin && NyTrade == true)
        {
         SessionTime =  iTime(Symbol(), time_Trade, 0);
         if(befor == false && after == true)
            SessionTime = SessionTime + (PeriodSeconds(time_Trade) * 1);

         if(befor ==  true  && after == false)
            SessionTime = SessionTime;

         ky4 = true ;
         ky  = false;
         ky2 = false;
         ky3 = false;

        }
      if(iTime(NULL, time_Trade, 0) == SessionTime && ky4 == true)
        {
         SessionHigh  = iHigh(NULL, time_Trade, 1);
         SessionLow   = iLow(NULL, time_Trade, 1);


         DeletObjects(nameOB);
         string NewYorkH = nameOB + "NYH_" + TimeToString(TimeCurrent()) ;
         string NewYorkL = nameOB + "NYL_" + TimeToString(TimeCurrent()) ;
         string NewYorkT = nameOB + "NYT_" + TimeToString(TimeCurrent()) ;
         TrendCreate(0, NewYorkH, 0, SessionTime - (PeriodSeconds(time_Trade) * 1), SessionHigh, end2, SessionHigh);
         TextCreate(0, NewYorkT, 0, SessionTime - (PeriodSeconds(time_Trade) * 1), SessionHigh, "NewYork");
         TrendCreate(0, NewYorkL, 0, SessionTime - (PeriodSeconds(time_Trade) * 1), SessionLow, end2, SessionLow);
         ky4 = false ;
        }

      //---Signal: (Buy && Sell) --------------- buy stop sell stop

      if(highandlow == false && close == false && BuyStop_SellStop == true  && SessionHigh != 0 && SessionLow != 0 && SessionTime != 0)
        {
         double high   = NormalizeDouble(SessionHigh + (MarginOnHighLow * Point()), Digits()) ;
         double low    = NormalizeDouble(SessionLow - (MarginOnHighLow  * Point()), Digits())  ;

         double minstop = (SymbolInfoInteger(Symbol(), SYMBOL_TRADE_STOPS_LEVEL) + 2) * Point() ;
         double slbuy = 0 ;
         double slsell = 0 ;
         double buyP = high - Ask() <= minstop ? NormalizeDouble(Ask() + minstop, Digits()) : high  ;
         double sellP = Bid() - low <= minstop ? NormalizeDouble(Bid() - minstop, Digits()) : low  ;
         magicNumber = MathRand() ;
         double tafazol_lotbuy =  NormalizeDouble(buyP - slbuy, Digits());
         double tafazol_lotsell =  NormalizeDouble(slsell - sellP, Digits());
         double tpbuy = NormalizeDouble(buyP + ((tafazol_lotbuy  * TakeProfit) + Spread_), Digits());
         double tpsell = NormalizeDouble(sellP - ((tafazol_lotsell  * TakeProfit) + Spread_), Digits());

         double LotSizebuy = 0;
         double LotSizesell = 0;
         if(Doller == 0)
           {
            LotSizebuy = PersentToLot(tafazol_lotbuy, Risk);
            LotSizesell = PersentToLot(tafazol_lotsell, Risk);
           }
         else
           {
            LotSizebuy = dollarToLot(tafazol_lotbuy, Doller);
            LotSizesell = dollarToLot(tafazol_lotsell, Doller);
           }
        string magicNumber_ = (string)magicNumber ;
         if(!T.BuyStop(LotSizebuy, buyP, Symbol(), slbuy, tpbuy , 0 , 0 , magicNumber_ ))
           {
            tafazol_lotbuy =  NormalizeDouble(Ask() - slbuy, Digits());
            tpbuy = NormalizeDouble(Ask() + ((tafazol_lotbuy  * TakeProfit) + Spread_), Digits());
            if(Doller == 0)
              {
               LotSizebuy = PersentToLot(tafazol_lotbuy, Risk);
              }
            else
              {
               LotSizebuy = dollarToLot(tafazol_lotbuy, Doller);
              }
            T.Buy(LotSizebuy,  Symbol(), Ask(),  slbuy, tpbuy, magicNumber_) ;
           }
        
         if(!T.SellStop(LotSizesell, sellP, Symbol(), slsell, tpsell , 0 , 0 ,magicNumber_ ))
           {
            tafazol_lotsell =  NormalizeDouble(slsell - Bid(), Digits());
            tpsell = NormalizeDouble(Bid() - ((tafazol_lotsell  * TakeProfit) + Spread_), Digits());
            if(Doller == 0)
              {
               LotSizesell = PersentToLot(tafazol_lotsell, Risk);
              }
            else
              {
               LotSizesell = dollarToLot(tafazol_lotsell, Doller);
              }
            T.Sell(LotSizebuy,  Symbol(), Ask(),  slbuy, tpbuy, magicNumber_) ;
           }

         SessionHigh = 0;
         SessionLow  = 0;
         SessionTime = 0;
         Limit = 0 ;

        }


      //---Signal: (Buy && Sell) --------------- Evry close close == true

      if(highandlow == false && close == true && BuyStop_SellStop == false && SessionHigh != 0 && SessionLow != 0 && SessionTime != 0)
        {
         double ClosePrice   = iClose(NULL, time_Trade, 1);
         datetime CloseTime  = iTime(NULL, time_Trade, 1);

         if(ClosePrice > SessionHigh)
           {
            //    Print("Signal : Buy");

            int start = iBarShift(_Symbol, time_Trade, SessionTime);

            for(int i = start; i >= 0; i--)
              {
               double lowSl = iLow(_Symbol, time_Trade, i);
               if(lowSl < SessionLow)
                 {
                  SessionLow = lowSl;
                 }
              }
              
            double sl = NormalizeDouble(SessionLow - Spread_, Digits())  ;
            double tafazol = NormalizeDouble((ClosePrice - sl), Digits());
            double tp = NormalizeDouble(((tafazol  * TakeProfit) + Ask()), Digits());
            double LotSize = 0;
              if(Doller == 0 && Risk != 0)
              {
               LotSize = PersentToLot(tafazol, Risk);
              }
            else
               if(Doller != 0 && Risk == 0)
                 {
                  LotSize = dollarToLot(tafazol, Doller);
                 }
            T.Buy(LotSize, Symbol(), Ask(), sl, tp) ;

            SessionHigh = 0;
            SessionLow  = 0;
            SessionTime = 0;
            Limit = 0 ;
           }

         if(ClosePrice < SessionLow)
           {

            int start = iBarShift(_Symbol, time_Trade, SessionTime);

            for(int i = start; i >= 0; i--)
              {
               double HighSl = iHigh(_Symbol, time_Trade, i);
               if(HighSl > SessionHigh)
                 {
                  SessionHigh = HighSl;
                 }
              }

            double sl = NormalizeDouble(SessionHigh + Spread_, Digits())  ;
            double tafazol = NormalizeDouble((sl - ClosePrice), Digits());
            double tp = NormalizeDouble((Bid() - (tafazol * TakeProfit)), Digits());
            double LotSize = 0;
            if(Doller == 0 && Risk != 0)
              {
               LotSize = PersentToLot(tafazol, Risk);
              }
            else
               if(Doller != 0 && Risk == 0)
                 {
                  LotSize = dollarToLot(tafazol, Doller);
                 }
            T.Sell(LotSize, Symbol(), Bid(), sl, tp) ;

            SessionLow = 0;
            SessionHigh = 0;
            SessionTime = 0;
            Limit = 0 ;
           }
        }

     }
//------Evry tike -----
//---Signal: (Buy && Sell) --------------- highandlow == true

   if(highandlow == true && close == false && BuyStop_SellStop == false && SessionHigh != 0 && SessionLow != 0 && SessionTime != 0)
     {

      if(Bid() > SessionHigh)
        {
         //    Print("Signal : Buy");

         int start = iBarShift(_Symbol, time_Trade, SessionTime);

         for(int i = start; i >= 0; i--)
           {
            double lowSl = iLow(_Symbol, time_Trade, i);
            if(lowSl < SessionLow)
              {
               SessionLow = lowSl;
              }
           }

         double sl = NormalizeDouble( SessionLow - Spread_ , Digits() );
         double tafazol =  NormalizeDouble((Ask() - sl ), Digits());
         double tp = NormalizeDouble(((tafazol  * TakeProfit) + Ask() ), Digits());

         double LotSize =  0 ;
          if(Doller == 0 && Risk != 0)
              {
               LotSize = PersentToLot(tafazol, Risk);
              }
            else
               if(Doller != 0 && Risk == 0)
                 {
                  LotSize = dollarToLot(tafazol, Doller);
                 }
         T.Buy(LotSize , Symbol() , Ask() , sl , tp );

         SessionHigh = 0;
         SessionLow  = 0;
         SessionTime = 0;
         Limit = 0 ;
        }

      if(Bid() < SessionLow)
        {
        
         int start = iBarShift(_Symbol, time_Trade, SessionTime);

         for(int i = start; i >= 0; i--)
           {
            double HighSl = iHigh(_Symbol, time_Trade, i);
            if(HighSl > SessionHigh)
              {
               SessionHigh = HighSl;
              }
           }


         double sl = NormalizeDouble((SessionHigh + Spread_ ), Digits());
         double tafazol = NormalizeDouble((sl - Bid()) + Spread_, Digits());
         double tp = NormalizeDouble((Bid() - (tafazol * TakeProfit)), Digits());
         double LotSize = 0 ;
         if(Doller == 0)
           {
            LotSize = PersentToLot(tafazol, Risk);
           }
         else
           {
            LotSize = dollarToLot(tafazol, Doller) ;
           }
         T.Sell(LotSize, Symbol() , Bid() , sl , tp ) ;
         

         SessionLow = 0;
         SessionHigh = 0;
         SessionTime = 0;
         Limit = 0 ;

        }
     }



  }
//+------------------------------------------------------------------+
//| Delete all session objects                                       |
//+------------------------------------------------------------------+
void DeletObjects(string nameleng)
  {
   int totalObjects = ObjectsTotal(0, 0);
   for(int i = totalObjects - 1; i >= 0; i--)
     {
      string name = ObjectName(0, i);
      string subname = StringSubstr(name, 0, StringLen(nameleng));
      if(subname == nameleng)
        {
         ObjectDelete(0, name);
        }
     }
  }
//+------------------------------------------------------------------+
//| Create a trend line by the given coordinates                     |
//+------------------------------------------------------------------+
bool TrendCreate(const long chart_ID = 0, const string name = "TrendLine", const int sub_window = 0,
                 datetime time1 = 0, double price1 = 0, datetime time2 = 0, double price2 = 0)
  {
   ResetLastError();
   if(!ObjectCreate(chart_ID, name, OBJ_TREND, sub_window, time1, price1, time2, price2))
     {
      //Print(__FUNCTION__,
      //      ": failed to create a trend line! Error code = ",GetLastError());
      //return(false);
     }
   ObjectSetInteger(chart_ID, name, OBJPROP_COLOR, clrLine);
   ObjectSetInteger(chart_ID, name, OBJPROP_STYLE, STYLE_SOLID);
   ObjectSetInteger(chart_ID, name, OBJPROP_WIDTH, 1);
   ObjectSetInteger(chart_ID, name, OBJPROP_BACK, false);
   ObjectSetInteger(chart_ID, name, OBJPROP_SELECTABLE, false);
   ObjectSetInteger(chart_ID, name, OBJPROP_SELECTED, false);
   ObjectSetInteger(chart_ID, name, OBJPROP_RAY, false);
   ObjectSetInteger(chart_ID, name, OBJPROP_HIDDEN, true);
   ObjectSetInteger(chart_ID, name, OBJPROP_ZORDER, 0);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creating Text object                                             |
//+------------------------------------------------------------------+
bool TextCreate(const long chart_ID = 0, const string name = "Text", const int sub_window = 0,
                datetime time = 0, double price = 0, const string text = "Text")
  {
   ResetLastError();
   if(!ObjectCreate(chart_ID, name, OBJ_TEXT, sub_window, time, price))
     {
      //Print(__FUNCTION__,
      //      ": failed to create \"Text\" object! Error code = ",GetLastError());
      //return(false);
     }
   ObjectSetString(chart_ID, name, OBJPROP_TEXT, text);
   ObjectSetString(chart_ID, name, OBJPROP_FONT, "Arial");
   ObjectSetInteger(chart_ID, name, OBJPROP_FONTSIZE, 8);
   ObjectSetInteger(chart_ID, name, OBJPROP_COLOR, clrText);
   ObjectSetInteger(chart_ID, name, OBJPROP_BACK, false);
   ObjectSetInteger(chart_ID, name, OBJPROP_SELECTABLE, false);
   ObjectSetInteger(chart_ID, name, OBJPROP_HIDDEN, true);
   ObjectSetInteger(chart_ID, name, OBJPROP_ZORDER, 0);
   ObjectSetInteger(chart_ID, name, OBJPROP_ANCHOR, ANCHOR_LOWER);
   return(true);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double PersentToLot(double tafazol_stop, double persent)
  {
   if(AccountInfoString(ACCOUNT_CURRENCY) == "")
      return 0;

   double accunt   = AccountInfoDouble(ACCOUNT_BALANCE);
   double Pips_val = SymbolInfoDouble(Symbol(), SYMBOL_TRADE_TICK_VALUE);


//-------------------
   for(int i = 0; i <= PositionsTotal(); i++)  // برای معاملات باز
     {
      if(PositionSelect(PositionGetSymbol(i)))  // انتخاب معامله باز
        {
         double sl        = NormalizeDouble(PositionGetDouble(POSITION_SL), Digits());
         double open      = NormalizeDouble(PositionGetDouble(POSITION_PRICE_OPEN), Digits());
         double lotSize   = PositionGetDouble(POSITION_VOLUME);

         double slToUsd   = 0;


         if(sl != 0)
           {
            // محاسبه تفاوت بین استاپ لاس و قیمت باز (در واحد پیپ)
            double pipDifference = MathAbs(open - sl) / SymbolInfoDouble(Symbol(), SYMBOL_POINT);

            // تبدیل پیپ‌ها به دلار
            slToUsd = pipDifference * Pips_val * lotSize;

            // محاسبه موجودی حساب با توجه به ریسک
            accunt = NormalizeDouble((accunt - slToUsd), Digits());

           }
        }
     }
//-------------------

   double RiskAccunt = accunt * (persent / 100);
   double Stop_Usd = (tafazol_stop / Point()) * Pips_val;
   double lot = RiskAccunt / Stop_Usd;


// اطمینان از محدوده حجم معاملات
   if(lot < SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MIN))
     {
      lot = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MIN); // حداقل حجم
     }
   else
      if(lot > SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MAX))
        {
         lot = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MAX); // حداکثر حجم
        }
//  Print("Lot size = ", lot);
   return NormalizeDouble(lot, 2);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Ask()
  {


   return SymbolInfoDouble(Symbol(), SYMBOL_ASK) ;

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Bid()
  {


   return SymbolInfoDouble(Symbol(), SYMBOL_BID) ;

  }
//+------------------------------------------------------------------+
//| Create the vertical line                                         |
//+------------------------------------------------------------------+
bool VLineCreate(const long            chart_ID = 0,      // chart's ID
                 const string          name = "VLine",    // line name
                 const int             sub_window = 0,    // subwindow index
                 datetime              time = 0,          // line time
                 const color           clr = clrRed,      // line color
                 const ENUM_LINE_STYLE style = STYLE_SOLID, // line style
                 const int             width = 1,         // line width
                 const bool            back = false,      // in the background
                 const bool            selection = false,  // highlight to move
                 const bool            ray = true,        // line's continuation down
                 const bool            hidden = true,     // hidden in the object list
                 const long            z_order = 0)       // priority for mouse click
  {
//--- if the line time is not set, draw it via the last bar
   if(!time)
      time = TimeCurrent();
//--- reset the error value
   ResetLastError();
//--- create a vertical line
   if(!ObjectCreate(chart_ID, name, OBJ_VLINE, sub_window, time, 0))
     {
      Print(__FUNCTION__,
            ": failed to create a vertical line! Error code = ", GetLastError());
      return(false);
     }
//--- set line color
   ObjectSetInteger(chart_ID, name, OBJPROP_COLOR, clr);
//--- set line display style
   ObjectSetInteger(chart_ID, name, OBJPROP_STYLE, style);
//--- set line width
   ObjectSetInteger(chart_ID, name, OBJPROP_WIDTH, width);
//--- display in the foreground (false) or background (true)
   ObjectSetInteger(chart_ID, name, OBJPROP_BACK, back);
//--- enable (true) or disable (false) the mode of moving the line by mouse
//--- when creating a graphical object using ObjectCreate function, the object cannot be
//--- highlighted and moved by default. Inside this method, selection parameter
//--- is true by default making it possible to highlight and move the object
   ObjectSetInteger(chart_ID, name, OBJPROP_SELECTABLE, selection);
   ObjectSetInteger(chart_ID, name, OBJPROP_SELECTED, selection);
//--- enable (true) or disable (false) the mode of displaying the line in the chart subwindows
   ObjectSetInteger(chart_ID, name, OBJPROP_RAY, ray);
//--- hide (true) or display (false) graphical object name in the object list
   ObjectSetInteger(chart_ID, name, OBJPROP_HIDDEN, hidden);
//--- set the priority for receiving the event of a mouse click in the chart
   ObjectSetInteger(chart_ID, name, OBJPROP_ZORDER, z_order);
//--- successful execution
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double dollarToLot(double tafazol_stop, double dollar)
  {
//for take profit
   double Pips_val = SymbolInfoDouble(Symbol(), SYMBOL_TRADE_TICK_VALUE) ;
   double hade_sood =  MathAbs(dollar) ;
   double tpToust = NormalizeDouble((tafazol_stop / Point()) * Pips_val, 0);
   double lot =   hade_sood  /  tpToust ;
   if(lot < SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MIN) || lot > SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MAX))
     {
      if(lot < SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MIN))
        {
         lot = SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MIN) ;
        }
      else
         lot = SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MAX) ;
     }

// // // Print(" lot ", lot);
   lot = NormalizeDouble(lot, 3) ;
   lot = MathRound(lot * 1000) / 1000 ;
   lot = NormalizeDouble(lot, 2) ;
   return lot ;

  }
//+------------------------------------------------------------------+
