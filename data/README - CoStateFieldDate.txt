This is an explanation of the features in 'CoStateFieldData.txt'.

The features are comma separated, with the exception of Field, which is a comma-separated array enclosed in brackets. 

Column 1: The name of the company's stock. We need this to identify the rest of the features as belonging to that company.

Column 2: The U.S. state the company is headquartered in, represented as an integer from 1 to 50, in descending alphabetical order. Alabama = 1, Wyoming = 50, etc. I left the state names here for readability. (I copy-pasted an alphabetized list of states into the bottom of this file, in case anyone really wants to see it. It starts on line 101 and ends on line 150. For easy maths).

Column 3: Field. This one is long because it's inherently subjective, and companies often do business in multiple fields (look up the Wikipedia article for GE if you don't believe me). I did try to minimize the number of features, while also including sufficient features to preserve the uniqueness of each company. TL;DR, I read the Wikipedia article for each company and made necessary judgement calls to categorize them based on the products and services they offer. Each feature appears a minimum of twice. In the actual data file, a 0 indicates the company does not do business in that field, and each code (eg FS, IM, OIL, etc) appears as a 1, indicating a company does do business in that field. I use letters here for readability.

Column 4: Year founded. The actual feature is total number of quarters in operation, but that's a simple calculation we can do in the code, and we may decide later that we need the actual year for something else. So I recorded the founding year instead.



Fields:

Here is the full list of fields. In CoStateFieldData.txt, this is an array of integers 1, 0, eg [1,0,0,1,0]. Fields are identified by their position in the array. A 1 indicates the company does business in that fields, and a 0 indicates the company does not do business in that field. The array below represents the order that the fields appear in.

[FS,S,P,D,IM,AS,MD,IC,HE,PH,BBX,OIL,F,E,TC,NE,CL,E,B,CC,INS]

Financial Services 										(FS)	x9
Software															(S)		x6
Personal care 												(P)		x4
Defense 															(D)		x4
Industrial Chemicals and Materials 		(IM)	x4
Aerospace 														(AS)	x3
Medical Devices 											(MD)	x3
Integrated circuits 									(IC)	x3
Heavy Equipment 											(HE)	x3
Pharmaceuticals												(PH)	x3
Big Box Store													(BBX) x2
Oil 																	(OIL)	x2
Food																	(F)		x2
Energy																(E)		x2
Telecommunications 										(TC)	x2
Network Equipment											(NE)	x2
Clothes																(CL)	x2
Entertainment													(EN)	x2
Banking									 							(B)		x2
Credit Card														(CC)	x2
Insurance															(INS)	x2


The Data:

This data is provided again in 'CoStateFieldData.txt', which is also the file that our code should actually read.

GE,Connecticut,[0,S,0,D,0,AS,MD,IC,HE,0,0,OIL,0,E,0,0,0,0,0,0,0],1892					GE
AXP,New York 32,[FS,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,CC,0],1850					American Express
GS,New York,[FS,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,B,0,0],1869									Goldman Sachs
JPM,New York,[FS,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,B,0,INS],2000							JP Morgan Chase
V,California,[FS,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,CC,0],1958								Visa
CAT,Illinois,[FS,0,0,0,0,0,0,0,HE,0,0,0,0,0,0,0,0,0,0,0,INS],1925							Caterpillar
CVX,California,[FS,0,0,0,IM,0,0,0,0,0,0,OIL,0,0,0,0,0,0,0,0,INS],1984					Cheveron
XOM,Texas,[FS,0,0,0,IM,0,0,0,0,0,0,OIL,0,0,0,0,0,0,0,0,INS],1999							ExxonMobil
TRV,New York,[FS,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,INS],2004							Travelers
WMT,Arkansas,[FS,0,P,0,0,0,0,0,0,0,BBX,0,F,0,0,0,CL,0,0,0,0],1962							Walmart
MCD,Illinois,[FS,0,0,0,0,0,0,0,0,0,0,0,F,0,0,0,0,0,0,0,0],1940								McDonalds
INTC,California,[0,S,0,0,0,0,0,IC,0,0,0,0,0,0,0,NE,0,0,0,0,0],1968						Intel
MSFT,Washington,[0,S,0,0,0,0,0,IC,0,0,0,0,0,0,0,0,0,0,0,0,0],1975							Microsoft
CSCO,California,[0,S,0,0,0,0,0,0,0,0,0,0,0,0,0,NE,0,0,0,0,0],1984							Cisco
IBM,New York,[0,S,0,D,0,0,MD,IC,0,0,0,0,0,0,0,NE,0,0,0,0,0],1911							IBM
JNJ,New Jersey,[0,0,P,0,0,0,MD,0,0,PH,0,0,0,0,0,0,0,0,0,0,0],1886							Johnson and Johnson
PFE,New York,[0,0,P,0,0,0,0,0,0,PH,0,0,0,0,0,0,0,0,0,0,0],1849								Pfizer
PG,Ohio,[0,0,P,0,0,0,0,0,0,0,0,0,0,0,0,0,0,EN,0,0,0],1837											Proctor & Gamble
MMM,Minnesota 23,[0,0,P,0,IM,0,MD,IC,0,0,0,0,0,0,0,0,0,0,0,0,0],1902					3M
BA,Washington 47,[0,0,0,D,0,AS,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],1916						Boeing
UTX,Connecticut,[0,0,0,D,0,AS,0,0,HE,0,0,0,0,E,0,0,0,0,0,0,0],1975						United Technologies
T,Texas 43,[0,0,0,0,0,0,0,0,0,0,0,0,0,0,TC,0,0,0,0,0,0],1983									AT&T
VZ,New York,[0,0,0,0,0,0,0,0,0,0,0,0,0,0,TC,0,0,0,0,0,0],1983									Verizon Communications
DD,Delaware,[0,0,0,0,IM,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],1802									DuPont
HD,Georgia,[0,0,0,0,0,0,0,0,0,0,BBX,0,0,0,0,0,0,0,0,0,0],1978									Home Depot
MRK,New Jersey,[0,0,0,0,0,0,0,0,0,PH,0,0,0,0,0,0,0,0,0,0,0],1917							Merck & Co
NKE,Washington,[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,CL,0,0,0,0],1964							Nike
KO,Georgia,[0,0,0,0,0,0,0,0,0,0,0,0,F,0,0,0,0,0,0,0,0],1886										Coca Cola Company
UNH,Minnesota,[FS,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,INS],1977							UnitedHealth Group
DIS,California,[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,EN,0,0,0],1923							Walt Disney























Alabama
Alaska
Arizona
Arkansas
California
Colorado
Connecticut										
Delaware										
Florida										
Georgia										
Hawaii										
Idaho										
Illinois										
Indiana										
Iowa										
Kansas										
Kentucky										
Louisiana										
Maine										
Maryland										
Massachusetts										
Michigan										
Minnesota										
Mississippi										
Missouri										
Montana										
Nebraska										
Nevada										
NewHampshire										
NewJersey										
NewMexico										
NewYork										
NorthCarolina										
NorthDakota										
Ohio										
Oklahoma										
Oregon										
Pennsylvania										
RhodeIsland										
SouthCarolina										
SouthDakota										
Tennessee										
Texas										
Utah										
Vermont										
Virginia										
Washington										
WestVirginia										
Wisconsin										
Wyoming