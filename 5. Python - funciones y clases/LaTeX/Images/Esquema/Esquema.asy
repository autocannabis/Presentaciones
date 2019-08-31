settings.outformat="pdf";
unitsize(4cm);

//General
real a = 1;
real h = 0.5;
real LF1 = 0.5;
real tolerancia = 0.125;
label("Entradas", (0,0), align=W);
draw((0,0) -- (LF1,0), arrow=Arrow);

//Cerebro
draw(box((LF1,-h/2), (LF1+a,h/2)), blue);
label("Cerebro", (LF1 + a/2, 0), blue);

//Actuadores
real ref = a+2*LF1;
draw((a+LF1,0) -- (ref, 0), arrow=Arrow, blue);
draw(box((ref,-h/2), (ref + a,h/2)), red);
label("Actuadores", (ref+a/2,0), red);

//Sensores
draw((2*LF1+a, -(h+LF1)) -- (LF1 + a, -(h+LF1)) , arrow=Arrow, green);
draw(box((2*LF1+a,-(h/2+LF1+h)), (2*LF1+2*a,-(h/2+LF1))), green);
label("Sensores", (2*LF1 + 3*a/2,-(h+LF1)), green);

//Base de datos
//material m  = material(gray(0.5), black, RoyalBlue*0.25 + white*0.75, black);
draw((LF1 + a/2, -(h/2+LF1)) -- (LF1 + a/2, -h/2) , arrow=Arrow, lightblue);
draw(box((LF1,-(h/2+LF1+h)), (LF1+a,-(h/2+LF1))), lightblue);
label("Base de datos", (LF1 + a/2,-(h+LF1)), lightblue);

//Caja negra
ref = 2*LF1+2*a + tolerancia;
real media = ((h/2 + tolerancia) - (-(h/2+LF1+h) - tolerancia))/2;
draw(box((LF1 - tolerancia, -(h/2+LF1+h) - tolerancia), (ref,h/2 + tolerancia)));
real y = -media+h/2;
draw((ref,y) -- (ref+LF1,y), arrow=Arrow);
label("Salidas", (ref+LF1,y), align=E);