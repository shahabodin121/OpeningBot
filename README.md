

<div dir="ltr">
    <br><br>
    <h1 align="center">OpeningBot 🤖</h1>
    <p align="center"><strong>Trading Robot for MetaTrader Platform</strong></p>
    <p>&nbsp;</p>

<h2>Introduction</h2>
<p>&nbsp;</p>
<p>&nbsp;&nbsp;This tool is an automated trading robot designed based on the Opening trading strategy. This strategy is one of the well-known methods among traders in gold, Forex, and crypto markets.</p>
<p>&nbsp;&nbsp;The robot offers various options, providing a powerful tool to test and examine different models of this strategy. The ability to assess risk and fix strategy issues through backtesting and real-time testing is one of the advantages of this robot.</p>
<p>&nbsp;&nbsp;This robot is developed for the MetaTrader platform (versions 4 and 5), which is one of the most popular platforms among traders and brokers.</p>
<br><br>

<strong>Quick Access:</strong>
<br><br>
<div align="left">
    <a href="#section1">1- Go to Developers section</a>
    <br>
    <a href="#section2">2- Go to Robot Installation section</a>
    <br>
    <a href="#section3">3- Go to Settings section</a>
    <br>
    <a href="#section4">4- A Look at the Strategy</a>
</div>
<br><br>
<hr>
<br>

<h2 id="section4">Trading Strategy</h2>

<h3>Main Idea</h3>
<p>&nbsp;&nbsp;The beginning of trading sessions usually brings new volume, news releases, order adjustments, and increased market volatility. Therefore, the price range formed around the opening time can indicate the initial balance between buyers and sellers.</p>
<p>&nbsp;&nbsp;When the price breaks out of this range, the strategy assumes that the market has likely determined its dominant direction and may continue moving in that direction.</p>

<h3>Defining the Opening Range</h3>
<p>In this strategy, a specific time period is first defined. This period can be in two forms depending on the trader's style:</p>
<ul>
    <li><b>Before market open:</b> For example, 15 or 30 minutes before the official start of the trading session.</li>
    <li><b>After market open:</b> For example, the first 5, 15, or 30 minutes after the start of the trading session.</li>
</ul>
<p>During this period, two key levels are recorded:</p>
<ul>
    <li><b>Highest price recorded during the period</b> = Opening High</li>
    <li><b>Lowest price recorded during the period</b> = Opening Low</li>
</ul>
<p>These two levels form the initial market range and are used as decision boundaries for entry.</p>

<h3>Entry Logic</h3>
<ul>
    <li><b>Breaking the range high:</b> If the price breaks above the Opening High level after the open, this breakout is considered a sign of buyer dominance and can be a Buy signal.</li>
    <li><b>Breaking the range low:</b> If the price drops below the Opening Low level, this breakout is considered a sign of seller dominance and can be a Sell signal.</li>
</ul>
<p>In many versions of this strategy, traders wait for a candle to close outside the range to reduce the chance of false breakouts.</p>
<br><br>

<h2 id="section3" align="center">OpeningBot Settings</h2>
<p>&nbsp;&nbsp;Let's review the robot's settings one by one and see what features it offers.</p>
<br>
<div align="center">
    <img src="https://github.com/shahabodin121/OpeningBot/blob/main/pic/1.jpg" alt="OpeningBot Settings" width="80%">
    <p><i>Image: OpeningBot Settings</i></p>
</div>
<hr>

<h3>1. Trading Timeframe</h3>
<p>&nbsp;&nbsp;<b>Description:</b> Select your desired timeframe for trading.</p>
<ul>
    <li>Suitable for scalping, day trading, and swing trading</li>
</ul>

<h3>2. Opening High/Low Before Open</h3>
<p>&nbsp;&nbsp;<b>Description:</b> Set this to <code>true</code> if you want to use the high and low <b>before</b> the market opening time.</p>

<h3>3. Opening High/Low After Open</h3>
<p>&nbsp;&nbsp;<b>Description:</b> Set this to <code>true</code> if you want to use the high and low <b>after</b> the market opening time.</p>

<div style="background-color: #f0f0f0; padding: 10px; border-left: 4px solid #ff9800;">
    <b>Note:</b> Options 2 and 3 <b>cannot</b> both be <code>true</code> at the same time.
</div>

<h3>4. Buffer to High/Low</h3>
<p>&nbsp;&nbsp;<b>Description:</b> This option allows you to add a buffer (in pips) to the high and low levels for a safer breakout.</p>
<ul>
    <li>Reduces false breakouts</li>
    <li>Increases entry accuracy</li>
</ul>

<h3>5. Instant Entry (Market Order)</h3>
<p>&nbsp;&nbsp;<b>Description:</b> Set this to <code>true</code> if you want to enter the market <b>instantly</b> (in the direction of the breakout) as soon as the price breaks the high or low.</p>

<h3>6. Entry on Candle Close</h3>
<p>&nbsp;&nbsp;<b>Description:</b> Set this to <code>true</code> if you want to enter after the <b>first close</b> above the high or below the low.</p>
<ul>
    <li>Gives a more valid breakout signal with candle close</li>
    <li>Reduces false signals</li>
</ul>

<h3>7. Entry with Buy Stop / Sell Stop</h3>
<p>&nbsp;&nbsp;<b>Description:</b> Set this to <code>true</code> if you want to enter with <code>Buy Stop</code> / <code>Sell Stop</code> orders.</p>
<ul>
    <li>Places a <b>Buy Stop</b> above the high</li>
    <li>Places a <b>Sell Stop</b> below the low simultaneously</li>
</ul>

<div style="background-color: #f0f0f0; padding: 10px; border-left: 4px solid #f44336;">
    <b>Note:</b> Options 5, 6, and 7 <b>cannot</b> all be <code>true</code> at the same time.
</div>

<h3 id="section1">8. Sydney Session</h3>
<p>&nbsp;&nbsp;<b>Description:</b> Set this to <code>true</code> if you want to trade the <b>Sydney</b> market open.</p>

<h3>9. Sydney Open Hour</h3>
<p>&nbsp;&nbsp;<b>Description:</b> If option 8 is active, specify the <b>hour</b> of the Sydney open.</p>

<h3>10. Sydney Open Minute</h3>
<p>&nbsp;&nbsp;<b>Description:</b> If option 8 is active, specify the <b>minute</b> of the Sydney open.</p>

<h3>11. Tokyo Session</h3>
<p>&nbsp;&nbsp;<b>Description:</b> Set this to <code>true</code> if you want to trade the <b>Tokyo</b> market open.</p>

<h3>12. Tokyo Open Hour</h3>
<p>&nbsp;&nbsp;<b>Description:</b> If option 11 is active, specify the <b>hour</b> of the Tokyo open.</p>

<h3>13. Tokyo Open Minute</h3>
<p>&nbsp;&nbsp;<b>Description:</b> If option 11 is active, specify the <b>minute</b> of the Tokyo open.</p>

<h3>14. London Session</h3>
<p>&nbsp;&nbsp;<b>Description:</b> Set this to <code>true</code> if you want to trade the <b>London</b> market open.</p>

<h3>15. London Open Hour</h3>
<p>&nbsp;&nbsp;<b>Description:</b> If option 14 is active, specify the <b>hour</b> of the London open.</p>

<h3>16. London Open Minute</h3>
<p>&nbsp;&nbsp;<b>Description:</b> If option 14 is active, specify the <b>minute</b> of the London open.</p>

<h3>17. New York Session</h3>
<p>&nbsp;&nbsp;<b>Description:</b> Set this to <code>true</code> if you want to trade the <b>New York</b> market open.</p>

<h3>18. New York Open Hour</h3>
<p>&nbsp;&nbsp;<b>Description:</b> If option 17 is active, specify the <b>hour</b> of the New York open.</p>

<hr>

<div align="center">
    <img src="https://github.com/shahabodin121/OpeningBot/blob/main/pic/2.jpg" alt="OpeningBot Advanced Settings" width="80%">
    <p><i>Image: OpeningBot Advanced Settings</i></p>
</div>

<hr>

<h3>19. New York Open Minute</h3>
<p>&nbsp;&nbsp;<b>Description:</b> If option 17 is active, specify the <b>minute</b> of the New York open.</p>

<h3>20. Stop Loss Depth</h3>
<p>&nbsp;&nbsp;<b>Description:</b> This option allows you to increase the stop loss depth (in pips).</p>
<ul>
    <li>Increases tolerance for volatility</li>
    <li>Reduces premature exits</li>
</ul>

<h3>21. Risk as Percentage of Balance</h3>
<p>&nbsp;&nbsp;<b>Description:</b> Specifies what <b>percentage</b> of your balance to risk per trade.</p>
<ul>
    <li>Input: percentage (e.g., 1, 2, 5)</li>
</ul>

<h3>22. Risk in Dollars</h3>
<p>&nbsp;&nbsp;<b>Description:</b> Specifies how <b>many dollars</b> to risk per trade.</p>
<ul>
    <li>Input: dollar amount (e.g., 100, 500)</li>
</ul>

<div style="background-color: #fff3cd; padding: 10px; border-left: 4px solid #ff9800;">
    <b>Note:</b> Options 21 and 22 <b>cannot</b> both have values at the same time. The one you're not using should be set to <b>0</b>.
</div>

<h3>23. Take Profit</h3>
<p>&nbsp;&nbsp;<b>Description:</b> This option specifies the Risk/Reward ratio.</p>
<p>&nbsp;&nbsp;<b>Calculation:</b> The distance from stop loss to entry (risk) multiplied by this value determines the take profit.</p>
<ul>
    <li>Input: multiplier (e.g., 2, 3, 5)</li>
</ul>

<h3>24. Spread</h3>
<p>&nbsp;&nbsp;<b>Description:</b> This option factors in the spread (in pips) when calculating stop loss and take profit.</p>
<ul>
    <li>Compensates for spread in calculations</li>
    <li>Increases entry and exit accuracy</li>
</ul>

<h3>25. Buy Stop / Sell Stop Expiry</h3>
<p>&nbsp;&nbsp;<b>Description:</b> This option is used for <code>Buy Stop / Sell Stop</code> orders and sets an <b>expiry</b> for them.</p>
<p>&nbsp;&nbsp;You can specify <b>how many candles</b> after placement the order should be removed if not triggered.</p>
<ul>
    <li>Auto-removal of expired orders</li>
    <li>Input: number of candles (e.g., 3, 5, 10)</li>
</ul>

<h3>26. High/Low Range Color</h3>
<p>&nbsp;&nbsp;<b>Description:</b> Color of the high and low range that the robot uses for entry.</p>
<ul>
    <li>Adjustable for each market</li>
    <li>Visual display of the trading range</li>
</ul>

<h3>27. Vertical Lines</h3>
<p>&nbsp;&nbsp;<b>Description:</b> Display vertical lines for market opening times.</p>
<ul>
    <li>Visual display of key times</li>
    <li>Identifies time zones</li>
</ul>

<h3>28. Market Names Color</h3>
<p>&nbsp;&nbsp;<b>Description:</b> Color of market names for better display on the chart.</p>
<ul>
    <li>Sydney</li>
    <li>Tokyo</li>
    <li>London</li>
    <li>New York</li>
</ul>

<h2 id="section2" align="center">Installation and Execution Guide for MetaTrader 5</h2>

<h3>Installation</h3>

<p>
    <strong>1- Download the Executable File</strong> – First, download the robot's executable file from the link below.
    <br>
    <a href="https://github.com/shahabodin121/OpeningBot/raw/refs/heads/main/OpeningBot.ex5">Download Link</a>
    <br>
    Then copy the file from the download location.
</p>

<p>
    <br><br>
    <strong>2- Open Data Folder</strong> – Open MetaTrader 5 and from the File tab, select Open Data Folder.
    <br><br>
</p>
<div align="center">
    <img align="center" src="https://github.com/shahabodin121/OpeningBot/blob/main/pic/4.jpg" alt="Open Data Folder image" width="40%">
</div>

<p>
    <br><br>
    <strong>3- Enter the MQL5 Folder</strong>.
    <br><br>
</p>
<div align="center">
    <img align="center" src="https://github.com/shahabodin121/OpeningBot/blob/main/pic/5.jpg" alt="MQL5 folder image" width="60%">
</div>

<p>
    <br><br>
    <strong>4- Enter the Experts Folder</strong>.
    <br><br>
</p>
<div align="center">
    <img align="center" src="https://github.com/shahabodin121/OpeningBot/blob/main/pic/6.jpg" alt="Experts folder image" width="60%">
</div>

<p>
    <br><br>
    <strong>5- Paste the File</strong> – Right-click in this folder and select Paste to place the robot's executable file there.
    <br><br>
</p>
<div align="center">
    <img align="center" src="https://github.com/shahabodin121/OpeningBot/blob/main/pic/7.jpg" alt="Paste file image" width="60%">
</div>

<p><strong>Result:</strong> The robot has been successfully installed.</p>

<br><br>

<h2>How to Run the Robot</h2>

<p>
    <br><br>
    <strong>1- Open Navigator</strong> – From the View tab, select Navigator.
    <br><br>
</p>
<div align="center">
    <img align="center" src="https://github.com/shahabodin121/OpeningBot/blob/main/pic/8.jpg" alt="Navigator image" width="40%">
</div>

<p>
    <br><br>
    <strong>2- Run OpeningBot</strong> – After Navigator opens, in the Expert Advisors section, double-click OpeningBot to run it.
    <br><br>
</p>
<div align="center">
    <img align="center" src="https://github.com/shahabodin121/OpeningBot/blob/main/pic/9.jpg" alt="Running OpeningBot image" width="60%">
</div>

<p>
    <br><br>
    <strong>3- Common Tab (Basic Settings)</strong> – After double-clicking, the initial Common page opens.
    <br><br>
</p>
<div align="center">
    <img align="center" src="https://github.com/shahabodin121/OpeningBot/blob/main/pic/10.jpg" alt="Common tab image" width="60%">
</div>

<p>
    <strong>Important Notes:</strong>
    <br>
    - Make sure options A and B are enabled so the robot can trade.
    <br>
    - The Inputs tab takes you to the robot's settings, which are explained in detail in the settings section.
</p>

<p><strong>Note:</strong> To change trading parameters, after enabling options A and B, go to the Inputs tab and apply your desired settings.</p>

</div>
