program projekt;
uses CRT,DOS,SysUtils;

type wybory=record
     glowny:byte;
     podmenu:byte;
     okazja:char;
     klawisz:char;
     end;

type flagi=record
     deszyfr:boolean;
     plik:boolean;
     podstawne:boolean;
     wroc:boolean;
     end;

const
info='Wersja 4.92 by Tomasz Pakula 2019';
kolor_podsw=1; //standardowo=1
opoznienie=20; //standardowo=50
tekst_menu : Array [1..4] of string = ('Szyfrowanie Cezara',
'Szyfrowanie Podstawne','Szyfrowanie Vigenerea','Wyjscie');
tekst_menu2 : Array [1..5] of string = ('Szyfrowanie','Odszyfrowywanie',
'Szyfrowanie z pliku','Odszyfrowywanie z pliku','Powrot do menu');
a185='╣';
a186='║';
a187='╗';
a188='╝';
a200='╚';
a201='╔';
a202='╩';
a203='╦';
a204='╠';
a205='═';
a206='╬';

var
a,b:byte;
wybor:wybory;
flaga:flagi;
tabela:array [65..90,65..90] of char;
tekst:string;
linie:byte;
linia: array of string;
dlugosc: array of byte;

{/////Procedurki\\\\\}

{ intro =================================================================}

procedure intro;
var
a,b:byte;
l1,l2:string;

begin
l1:='Witamy w';
l2:='programie szyfrujacym!';

for a:=1 to 10 do begin
    //textbackground(a);
    clrscr;
    //delay(opoznienie*2);
    end;
textbackground(black);
clrscr;
textbackground(white);
textcolor(black);

a:=0;
gotoxy(9,7);
for b:=0 to 11 do begin
	gotoxy(0,0);
    gotoxy(20-b,7);
    write(a205);
    gotoxy(0,0);
    gotoxy(21+b,7);
    write(a205);
    delay(opoznienie);
    end;

gotoxy(0,7);
gotoxy(8,7);
write(a201);
gotoxy(35,7);
write(a187);
delay(opoznienie);

for a:=1 to 5 do begin
    gotoxy(8,7+a);
    write(a186);
    gotoxy(35,7+a);
    write(a186);
    delay(opoznienie);
    end;

gotoxy(8,13);
write(a200);
gotoxy(35,13);
write(a188);
delay(opoznienie);

for a:=11 downto 0 do begin
	gotoxy(0,0);
    gotoxy(20-a,13);
    write(a205);
    gotoxy(0,0);
    gotoxy(21+a,13);
    write(a205);
    delay(opoznienie);
    end;

for a:=0 to 4 do begin
        gotoxy(9,8+a);
        write('                        ');
        delay(opoznienie*2);
        end;

textcolor(blue);
gotoxy(17,9);
for a:=1 to 8 do begin
    write(l1[a]);
    delay(opoznienie div 2);
    end;
gotoxy(10,11);
for a:=1 to 22 do begin
    write(l2[a]);
    delay(opoznienie div 2);
    end;
gotoxy(1,25);
delay(opoznienie*50);
end;

{ outro =================================================================}

procedure outro;
var
a:byte;

begin
textbackground(black);
clrscr;
textbackground(white);
textcolor(black);
gotoxy(8,7);
write(a201);
for a:=9 to 32 do write(a205);
write(a187);
for a:=8 to 12 do begin
    gotoxy(8,a);
    write(a186,'                        ',a186);
    end;
gotoxy(8,13);
write(a200);
for a:=9 to 32 do write(a205);
write(a188);

textcolor(blue);
gotoxy(14,10);
write('Do zobaczenia!');
delay(opoznienie*20);

for a:=27 downto 14 do begin
    gotoxy(a,10);
    write(' ');
    delay(opoznienie div 2);
    end;

textbackground(black);
textcolor(black);

for a:=4 downto 0 do begin
        gotoxy(9,8+a);
        write('                        ');
        delay(opoznienie*2);
        end;

for a:=0 to 12 do begin
    gotoxy(20-a,13);
    write(' ');
    gotoxy(21+a,13);
    write(' ');
    delay(opoznienie);
    end;

for a:=5 downto 1 do begin
    gotoxy(8,7+a);
    write(' ');
    gotoxy(33,7+a);
    write(' ');
    delay(opoznienie);
    end;

for a:=12 downto 0 do begin
    gotoxy(20-a,7);
    write(' ');
    gotoxy(21+a,7);
    write(' ');
    delay(opoznienie);
    end;
end;


{ Tlo ===================================================================}

procedure klir;
var a,b:byte;

begin
//textbackground(black);
//clrscr;
textbackground(white);
gotoxy(1,1);
for a:=1 to 22 do begin
    write('                                        ');
    writeln;
    end;
end;

{ Ramka =================================================================}

procedure ramka;
var a,b:byte;

begin
textcolor(black);
gotoxy(1,1);
write(a201);
for a:=2 to 39 do write(a205);
write(a187);
for a:=2 to 4 do begin
    gotoxy(1,a);
    write(a186);
    gotoxy(42,a);
    write(a186);
    end;
gotoxy(1,5);
write(a204);
for a:=2 to 39 do write(a205);
write(a185);
for a:=6 to 21 do begin
    gotoxy(1,a);
    write(a186);
    gotoxy(42,a);
    write(a186);
    end;
gotoxy(1,22);
write(a200);
for a:=2 to 39 do write(a205);
write(a188);
end;

{ Ramka flex ============================================================}

procedure ramka_flex(x:byte);
var a,b:byte;

begin
textcolor(red);
gotoxy(8,7);
write(a201);
for a:=9 to 32 do write(a205);
write(a187);
for a:=8 to 7+x do begin
    gotoxy(8,a);
    write(a186,'                        ',a186);
    end;
gotoxy(8,8+x);
write(a200);
for a:=9 to 32 do write(a205);
write(a188);
textcolor(black);
end;

{ Menu Glowne ===========================================================}

procedure menu;

begin
gotoxy(15,3);
write('Menu glowne');
gotoxy(3,7);
textcolor(green);
writeln('Wybierz jedna z opcji:');

textcolor(black);
gotoxy(3,9);
writeln(tekst_menu[1]);
gotoxy(3,11);
writeln(tekst_menu[2]);
gotoxy(3,13);
writeln(tekst_menu[3]);
textcolor(red);
gotoxy(3,20);
writeln(tekst_menu[4]);
textcolor(black);

a:=wybor.glowny;
repeat
case a of
1: begin;
   b:=9;
   gotoxy(3,b);
   textcolor(kolor_podsw);
   write(tekst_menu[a],' <-');
   end;
2: begin;
   b:=11;
   gotoxy(3,b);
   textcolor(kolor_podsw);
   write(tekst_menu[a],' <-');
   end;
3: begin;
   b:=13;
   gotoxy(3,b);
   textcolor(kolor_podsw);
   write(tekst_menu[a],' <-');
   end;
4: begin;
   b:=20;
   gotoxy(3,b);
   textcolor(kolor_podsw);
   write(tekst_menu[a],' <-');
   end;
end;
gotoxy(1,25);

wybor.klawisz:=readkey;

gotoxy(3,b);
if a=4 then textcolor(red)
else textcolor(black);
write(tekst_menu[a],'   ');

case wybor.klawisz of
'H': a:=a-1;
'P': a:=a+1;
end;

if a<1 then a:=4;
if a>4 then a:=1;

until wybor.klawisz=chr(13);
wybor.glowny:=a;
end;

{ Podmenu ===============================================================}

procedure menu2;

begin
textcolor(green);
gotoxy(3,7);
writeln('Wybierz jedna z opcji:');
textcolor(black);
gotoxy(3,9);
writeln(tekst_menu2[1]);
gotoxy(3,11);
writeln(tekst_menu2[2]);
gotoxy(3,13);
writeln(tekst_menu2[3]);
gotoxy(3,15);
writeln(tekst_menu2[4]);
textcolor(red);
gotoxy(3,20);
writeln(tekst_menu2[5]);

a:=wybor.podmenu;
repeat
case a of
1: begin;
   b:=9;
   gotoxy(3,b);
   textcolor(kolor_podsw);
   write(tekst_menu2[a],' <-');
   textcolor(black);
   end;
2: begin;
   b:=11;
   gotoxy(3,b);
   textcolor(kolor_podsw);
   write(tekst_menu2[a],' <-');
   end;
3: begin;
   b:=13;
   gotoxy(3,b);
   textcolor(kolor_podsw);
   write(tekst_menu2[a],' <-');
   end;
4: begin;
   b:=15;
   gotoxy(3,b);
   textcolor(kolor_podsw);
   write(tekst_menu2[a],' <-');
   end;
5: begin;
   b:=20;
   gotoxy(3,b);
   textcolor(kolor_podsw);
   write(tekst_menu2[a],' <-');
   end;
end;
gotoxy(1,25);

wybor.klawisz:=readkey;

gotoxy(3,b);
if a=5 then textcolor(red)
else textcolor(black);
write(tekst_menu2[a],'   ');

case wybor.klawisz of
'H': a:=a-1;
'P': a:=a+1;
end;

if a<1 then a:=5;
if a>5 then a:=1;

until wybor.klawisz=chr(13);
wybor.podmenu:=a;
end;

{ zly wybor =============================================================}

procedure zly_wybor;

begin
ramka_flex(5);
gotoxy(16,9);
write('Zly wybor!');
gotoxy(10,11);
write('Sprobuj jeszcze raz...');
gotoxy(1,25);
readkey;
end;

{ tylko litery ===========================================================}

procedure tylko_litery;
var a,b:byte;

begin
ramka_flex(5);
gotoxy(12,9);
write('Dozwolone sa tylko');
gotoxy(17,11);
write('litery!');
gotoxy(1,25);
readkey;

for a:=0 to 6 do begin
    gotoxy(8,7+a);
    for b:=8 to 33 do write(' ');
    end;
end;

{ tylko litery w pliku ===================================================}

procedure tylko_litery_plik;
var a,b:byte;

begin
ramka_flex(5);
gotoxy(11,9);
write('W pliku znajduja sie');
gotoxy(11,11);
write('niedozwolone znaki!');
gotoxy(1,25);
readkey;

for a:=0 to 6 do begin
    gotoxy(8,7+a);
    for b:=8 to 33 do write(' ');
    end;
end;

{ plik nie istnieje ======================================================}

procedure niema;

var a,b:byte;

begin
ramka_flex(5);
gotoxy(15,9);
write('Podany plik');
gotoxy(14,11);
write('nie istnieje!');
gotoxy(1,25);
readkey;

for a:=0 to 6 do begin
    gotoxy(8,7+a);
    for b:=8 to 33 do write(' ');
    end;
end;

{ Odczyt tekstu ==========================================================}

procedure odczyt;

var
f1,a,wiersz,kolumna:byte;
znak:array [1..255] of char;

begin
linie:=1;
setlength(dlugosc,1);
setlength(linia,1);
linia[1]:='';
repeat
repeat
gotoxy(3,7);
if flaga.deszyfr=false then write('Podaj tekst do zaszyfrowania:')
else if flaga.deszyfr=true then write('Podaj tekst do odszyfrowania:');

gotoxy(3,8);
write('>');
gotoxy(3,20);
textcolor(red);
write('[Spacja] Powrot');
textcolor(black);

f1:=0;
gotoxy(4,8);
for a:=4 to 39 do write(' ');
gotoxy(4,8);
textcolor(blue);

linia[1]:='';
for a:=1 to 255 do znak[a]:=' ';
a:=1;
wiersz:=8;
kolumna:=4;
repeat
repeat
znak[a]:=readkey;
until znak[a]<>'';
write(znak[a]);
if ord(znak[a])=8 then begin
   if ((wiersz>8) and (kolumna=3)) then begin
      kolumna:=39;
      dec(wiersz);
      end;
   if ((kolumna>4) or ((wiersz>8) and (kolumna>3))) then begin
      dec(a);
      dec(kolumna);
      gotoxy(kolumna,wiersz);
      write(' ');
      gotoxy(kolumna,wiersz);
      end
   else gotoxy(kolumna,wiersz);
   end
else if ord(znak[a])<>13 then begin
     inc(a);
     inc(kolumna);
     end;
if kolumna>38 then begin
   inc(wiersz);
   kolumna:=3;
   gotoxy(kolumna,wiersz);
   end;
until ord(znak[a])=13;
for b:=1 to a-1 do linia[1]:=concat(linia[1],znak[b]);

textcolor(black);
until linia[1]<>'';

if (linia[1]=' ') then begin
      flaga.wroc:=true;
      f1:=0;
      end
else begin
dlugosc[1]:=length(linia[1]);
for a:=1 to dlugosc[1] do begin
    linia[1][a]:=upcase(linia[1][a]);
    if flaga.podstawne=true then begin
       if ((ord(linia[1][a])>90) or (ord(linia[1][a])<65)) then begin
          if (linia[1][a]<>'*') then f1:=1;
          end;
       end
    else begin
         if ((ord(linia[1][a])>90) or (ord(linia[1][a])<65)) then f1:=1;
         end;
    end;
end;
if f1=1 then tylko_litery;
until f1=0;
gotoxy(3,20);
write('               ');
end;

{ Odczyt z pliku =========================================================}

procedure odczyt_plik;

var
a,b,wiersz,kolumna,f1:byte;
litera:char;
sciezka,temp:string;
znak:array [1..255] of char;
plik:text;

begin
flaga.plik:=true;
sciezka:='';
repeat
repeat
gotoxy(3,7);
writeln('Podaj sciezke do pliku:');
gotoxy(3,8);
write('>');
gotoxy(3,20);
textcolor(red);
write('[Spacja] Powrot');
textcolor(black);


gotoxy(4,8);
for a:=4 to 39 do write(' ');
gotoxy(4,8);
textcolor(blue);

sciezka:='';
for a:=1 to 255 do znak[a]:=' ';
a:=1;
wiersz:=8;
kolumna:=4;
repeat
repeat
until znak[a]<>'';
znak[a]:=readkey;
write(znak[a]);
if ord(znak[a])=8 then begin
   if ((wiersz>8) and (kolumna=3)) then begin
      kolumna:=39;
      dec(wiersz);
      end;
   if ((kolumna>4) or ((wiersz>8) and (kolumna>3))) then begin
      dec(a);
      dec(kolumna);
      gotoxy(kolumna,wiersz);
      write(' ');
      gotoxy(kolumna,wiersz);
      end
   else gotoxy(kolumna,wiersz);
   end
else if ord(znak[a])<>13 then begin
     inc(a);
     inc(kolumna);
     end;
if kolumna>38 then begin
   inc(wiersz);
   kolumna:=3;
   gotoxy(kolumna,wiersz);
   end;
until ord(znak[a])=13;
for b:=1 to a-1 do sciezka:=concat(sciezka,znak[b]);

textcolor(black);
until sciezka<>'';


if sciezka=' ' then begin
   flaga.wroc:=true;
   f1:=0;
   end
else begin

temp:='';
temp:=copy(sciezka,length(sciezka)-3,4);
if temp<>'.txt' then begin
      sciezka:=concat(sciezka,'.txt');
      end;

if fileexists(sciezka) then begin
tekst:='';
temp:='';
linie:=0;
assign(plik,sciezka);

reset(plik);
while not eof(plik) do begin
      readln(plik);
      inc(linie);
      end;
setlength(linia,linie);
setlength(dlugosc,linie);

a:=0;
reset(plik);
while not eof(plik) do begin
      while not eoln(plik) do begin
            read(plik,litera);
            temp:=concat(temp,litera);
            end;
      inc(a);
      linia[a]:='';
      linia[a]:=concat(linia[a],temp);
      temp:='';
      readln(plik);
      end;
close(plik);

f1:=0;
for b:=1 to linie do begin
    dlugosc[b]:=length(linia[b]);
    for a:=1 to dlugosc[b] do begin;
        linia[b][a]:=upcase(linia[b][a]);
        if flaga.podstawne=true then begin
           if ((ord(linia[b][a])>90) or (ord(linia[b][a])<65)) then begin;
                if (linia[b][a]<>'*') then f1:=1;
                end;
           end
        else begin
             if ((ord(linia[b][a])>90) or (ord(linia[b][a])<65)) then f1:=1;
             end;
        end;
    end;



if f1=1 then tylko_litery_plik;
end
else begin
     f1:=1;
     niema;
     end;
end;
until f1=0;
gotoxy(3,20);
write('               ');
end;

{ Zapis do pliku =========================================================}

procedure zapis;
var
a,b,c,kolumna,wiersz,f1:byte;
sciezka,temp:string;
znak:array [1..255] of char;
plik:text;

begin
sciezka:='';
repeat
ramka_flex(7);
gotoxy(12,9);
write('Czy chcesz zapisac');
gotoxy(13,10);
write('wynik do pliku?');
gotoxy(16,12);
textcolor(green);
write('[T] Tak');
gotoxy(16,13);
textcolor(red);
write('[N] Nie');
gotoxy(1,25);
textcolor(black);
wybor.okazja:=readkey;
wybor.okazja:=upcase(wybor.okazja);

if ((wybor.okazja<>'T') and (wybor.okazja<>'N')) then begin
   for b:=13 to 15 do begin
       gotoxy(8,b);
       for a:=8 to 33 do write(' ');
       end;
   zly_wybor;
   end;

until ((wybor.okazja = 'N') or (wybor.okazja = 'T'));

if wybor.okazja = 'T' then begin
   klir;
   ramka;
   gotoxy(13,3);
   write('Zapis do pliku');
   gotoxy(3,9);
   repeat
   f1:=0;
   gotoxy(3,7);
   writeln('Podaj sciezke do utworzenia pliku:');
   gotoxy(3,8);
   write('>');

   repeat
   gotoxy(4,8);
   for a:=4 to 39 do write(' ');
   gotoxy(4,8);
   textcolor(blue);
   sciezka:='';
   for a:=1 to 255 do znak[a]:=' ';
   a:=1;
   wiersz:=8;
   kolumna:=4;
   repeat
   repeat
   until znak[a]<>'';
   znak[a]:=readkey;
   write(znak[a]);
   if ord(znak[a])=8 then begin
      if ((wiersz>8) and (kolumna=3)) then begin
         kolumna:=39;
         dec(wiersz);
         end;
      if ((kolumna>4) or ((wiersz>8) and (kolumna>3))) then begin
         dec(a);
         dec(kolumna);
         gotoxy(kolumna,wiersz);
         write(' ');
         gotoxy(kolumna,wiersz);
         end
      else gotoxy(kolumna,wiersz);
      end
   else if ord(znak[a])<>13 then begin
        inc(a);
        inc(kolumna);
        end;
   if kolumna>38 then begin
      inc(wiersz);
      kolumna:=3;
      gotoxy(kolumna,wiersz);
      end;
   until ord(znak[a])=13;
   for b:=1 to a-1 do sciezka:=concat(sciezka,znak[b]);

   textcolor(black);
   until sciezka<>'';

   temp:='';
   temp:=copy(sciezka,length(sciezka)-3,4);
   if temp<>'.txt' then begin
      sciezka:=concat(sciezka,'.txt');
      end;

   c:=0;
   for a:=1 to length(sciezka) do begin
       if ((sciezka[a]='/') or (sciezka[a]='\')) then c:=a-1;
       end;
   temp:='';
   for a:=1 to c do temp:=concat(temp,sciezka[a]);

   if c<>0 then begin
      for a:=1 to length(temp) do begin
          if ((temp[a]='?') or (temp[a]='%') or (temp[a]='*')) then f1:=1;
          if ((temp[a]='|') or (temp[a]='"')) then f1:=1;
          if ((temp[a]='<') or (temp[a]='>') or (temp[a]='.')) then f1:=1;
          end;
      if f1=0 then begin
         if directoryexists(temp) then write
         else begin
              f1:=1;
              ramka_flex(5);
              gotoxy(10,9);
              write('Podany folder dla pliku');
              gotoxy(14,11);
              write('nie istnieje!');
              gotoxy(1,25);
              readkey;
              for a:=0 to 6 do begin
                  gotoxy(8,7+a);
                  for b:=8 to 33 do write(' ');
                  end;
              end;
         end
      else if f1=1 then begin
           ramka_flex(5);
           gotoxy(12,9);
           write('Niedozwolone znaki');
           gotoxy(12,11);
           write('w nazwie folderu!');
           gotoxy(1,25);
           readkey;
           for a:=0 to 6 do begin
               gotoxy(8,7+a);
               for b:=8 to 33 do write(' ');
               end;
           end;
      end;
   until f1=0;
   assign(plik,sciezka);
   rewrite(plik);
   for a:=1 to linie do begin
       write(plik,linia[a]);
       if a<linie then writeln(plik);
       end;
   close(plik);
   textcolor(green);
   gotoxy(3,13);
   write('Plik z wynikiem operacji');
   gotoxy(3,14);
   write('zostal utworzony!');
   readkey;
   end
end;

{========================================================================}

{/////Szyfrowanie Cezara\\\\\}

{========================================================================}

procedure cezar;

var
a,b,c,d:byte;
znak,ruch,tak:integer;
przesuniecie:string;

begin
klir;
ramka;
gotoxy(12,3);
writeln(tekst_menu[1]);

if flaga.plik=false then odczyt
else if flaga.plik=true then odczyt_plik;

if flaga.wroc=false then begin
gotoxy(3,12);
if flaga.deszyfr=false then write('Podaj o ile chcesz przesunac litery')
else if flaga.deszyfr=true then write('Podaj o ile przesunieto litery');
gotoxy(3,13);
write('Podaj liczby od -25 do 25 oprocz 0');
gotoxy(3,14);
write('>');

repeat
gotoxy(4,14);
for a:=4 to 39 do write(' ');
gotoxy(4,14);
textcolor(blue);
readln(przesuniecie);
textcolor(black);
val(przesuniecie,ruch,tak);
until ((ruch > -26) and (ruch < 26) and (ruch<>0) and (tak=0));

if flaga.deszyfr=true then ruch:=-ruch;

for a:=1 to linie do begin
    for b:=1 to dlugosc[a] do begin
        if linia[a][b]<>' ' then begin
           znak:=ord(linia[a][b]);
           znak:=znak+ruch;
           if znak<65 then znak:=znak+26
           else if znak>90 then znak:=znak-26;
           linia[a][b]:=chr(znak);
           end;
        end;
    end;

klir;
ramka;
gotoxy(12,3);
writeln(tekst_menu[1]);
gotoxy(3,9);
if flaga.deszyfr=false then write('Zaszyfrowany ')
else if flaga.deszyfr=true then write('Odszyfrowany ');
if flaga.plik=false then write('tekst ')
else if flaga.plik=true then write('plik ');
write('przesuniety');
gotoxy(3,10);
write('o ');
textcolor(blue);
write(przesuniecie);
textcolor(black);
write(' to:');
textcolor(blue);
gotoxy(3,12);


d:=12;
c:=0;
for a:=1 to linie do begin
    for b:=1 to dlugosc[a] do begin
        inc(c);
        if c>36 then begin
           inc(d);
           gotoxy(3,d);
           c:=1;
           end;
        write(linia[a][b]);
        end;
    end;
readkey;
zapis;
end;
end;

{========================================================================}

{/////Szyfrowanie Podstawne\\\\\}

{========================================================================}

procedure podstawne;

var
litera:char;
plik:text;
a,b,c,d,ilosc_liter,wiersze,f1:byte;
znak,kolumny,tak:integer;
litery: array of array of char;
wszystkie_litery: array of char;
//litery: array[1..100,1..100] of char;
kolu,sciezka,temp:string;

begin
flaga.podstawne:=true;
klir;
ramka;
gotoxy(10,3);
writeln(tekst_menu[2]);

if flaga.plik=false then odczyt
else if flaga.plik=true then odczyt_plik;

if flaga.wroc=false then begin
gotoxy(3,12);
if flaga.deszyfr=false then write('Podaj na ile kolumn podzielic tekst:')
else if flaga.deszyfr=true then write('Podaj na ile kolumn podzielono tekst:');
gotoxy(3,13);
write('Podaj liczbe od 2 do 10');
gotoxy(3,14);
write('>');
repeat
gotoxy(4,14);
for a:=4 to 39 do write(' ');
gotoxy(4,14);
textcolor(blue);
readln(kolu);
textcolor(black);
val(kolu,kolumny,tak);
until ((kolumny >= 2) and (kolumny <= 10) and (tak=0));

ilosc_liter:=0;
for a:=1 to linie do ilosc_liter:=ilosc_liter+dlugosc[a];

wiersze:= ilosc_liter div kolumny;
if ((ilosc_liter mod kolumny) <> 0) then inc(wiersze);

setlength(litery,wiersze,kolumny);
setlength(wszystkie_litery,kolumny*wiersze);

c:=0;
for a:=1 to linie do begin
    for b:=1 to dlugosc[a] do begin
        wszystkie_litery[c]:=linia[a][b];
        inc(c);
        end;
    end;

if flaga.deszyfr=false then begin
c:=0;
for a:=0 to wiersze-1 do begin
    for b:=0 to kolumny-1 do begin
        if c<=ilosc_liter-1 then litery[a,b]:=wszystkie_litery[c]
        else litery[a,b]:='*';
        inc(c);
        end;
    end;

c:=0;
for b:=0 to kolumny-1 do begin
    for a:=0 to wiersze-1 do begin
        wszystkie_litery[c]:=litery[a,b];
        inc(c);
        end;
    end;
    end

else if flaga.deszyfr=true then begin
c:=0;
for b:=0 to kolumny-1 do begin
    for a:=0 to wiersze-1 do begin
        if c<=ilosc_liter-1 then litery[a,b]:=wszystkie_litery[c]
        else litery[a,b]:='*';
        inc(c);
        end;
    end;
c:=0;
for a:=0 to wiersze-1 do begin
    for b:=0 to kolumny-1 do begin
        if litery[a,b]<>chr(42) then wszystkie_litery[c]:=litery[a,b];
        inc(c);
        end;
    end;
    end;


c:=0;
if linie-1>0 then begin
   for a:=1 to linie-1 do begin
       for b:=1 to dlugosc[a] do begin
           linia[a][b]:=wszystkie_litery[c];
           inc(c);
           end;
       end;
   end;

linia[linie]:='';
a:=0;
if flaga.deszyfr=false then begin
   a:=kolumny-(ilosc_liter mod kolumny);
   dlugosc[linie]:=dlugosc[linie]+a;
   end
else if flaga.deszyfr=true then begin
     for b:=1 to dlugosc[linie] do if linia[linie][b]='*' then inc(a);
     dlugosc[linie]:=dlugosc[linie]-a;
     end;

for a:=1 to dlugosc[linie] do begin;
    linia[linie]:=concat(linia[linie],wszystkie_litery[c]);
    inc(c);
    end;



klir;
ramka;
gotoxy(10,3);
write(tekst_menu[2]);
gotoxy(3,9);
if flaga.deszyfr=false then write('Zaszyfrowany ')
else if flaga.deszyfr=true then write('Odszyfrowany ');
if flaga.plik=false then write('tekst ')
else if flaga.plik=true then write('plik ');
write('z kluczem:');
gotoxy(3,10);
write('Wiersze: ');
textcolor(blue);
write(wiersze);
textcolor(black);
gotoxy(3,11);
write('Kolumny: ');
textcolor(blue);
write(kolu);
textcolor(black);
gotoxy(3,12);
write('to:');
gotoxy(3,14);
textcolor(blue);

d:=14;
c:=0;
for a:=1 to linie do begin
    for b:=1 to dlugosc[a] do begin
        inc(c);
        if c>36 then begin
           inc(d);
           gotoxy(3,d);
           c:=1;
           end;
        write(linia[a][b]);
        end;
    end;
textcolor(black);
readkey;
zapis;
end;
flaga.podstawne:=false;
end;

{========================================================================}

{/////Szyfrowanie Vinegret\\\\\}

{========================================================================}

procedure vigenere;

var
plik:text;
litera:char;
a,b,c,d,dlugosc1,dlugosc2,f1,wiersz:byte;
znak,ruch,tak:integer;
sciezka,klucz,temp:string;

begin
klir;
ramka;
gotoxy(9,3);
writeln(tekst_menu[3]);

if flaga.plik=false then odczyt
else if flaga.plik=true then odczyt_plik;

if flaga.wroc=false then begin
gotoxy(3,12);
write('Podaj slowo klucz');
gotoxy(3,13);
write('Podaj tylko litery');
gotoxy(3,14);
write('>');

repeat
gotoxy(4,14);
for a:=4 to 39 do write(' ');
gotoxy(4,14);
readln(klucz);
dlugosc2:=length(klucz);

f1:=0;
for a:=1 to dlugosc2 do begin;
    klucz[a]:=upcase(klucz[a]);
    if ((ord(klucz[a])>90) or (ord(klucz[a])<65)) then f1:=1;
    end;
until ((f1=0) and (dlugosc2>0));

if flaga.deszyfr=false then begin
b:=0;
for c:=1 to linie do begin
    for a:=1 to dlugosc[c] do begin
        inc(b);
        if b>dlugosc2 then b:=1;
        if linia[c][a]<>' ' then linia[c][a]:=tabela[ord(klucz[b]),ord(linia[c][a])];
        end;
    end;
    end

else if flaga.deszyfr=true then begin
b:=0;
for d:=1 to linie do begin;
    for a:=1 to dlugosc[d] do begin
        inc(b);
        if b>dlugosc2 then b:=1;
        if linia[d][a]<>' ' then begin
           for c:=65 to 90 do begin
               if linia[d][a]=tabela[ord(klucz[b]),c] then wiersz:=c;
               end;
           linia[d][a]:=tabela[65,wiersz];
           end;
        end;
    end;
    end;


klir;
ramka;
gotoxy(10,3);
write(tekst_menu[3]);
gotoxy(3,9);
if flaga.deszyfr=false then write('Zaszyfrowany ')
else if flaga.deszyfr=true then write('Odszyfrowany ');
if flaga.plik=false then write('tekst ')
else if flaga.plik=true then write('plik ');
write('z kluczem');
gotoxy(3,10);
textcolor(blue);
write(klucz);
textcolor(black);
write(' to:');
textcolor(blue);
gotoxy(3,12);

d:=12;
c:=0;
for a:=1 to linie do begin
    for b:=1 to dlugosc[a] do begin
        inc(c);
        if c>36 then begin
           inc(d);
           gotoxy(3,d);
           c:=1;
           end;
        write(linia[a][b]);
        end;
    end;
readkey;
zapis;
end;
end;

{ podmenu ==================================================================}

procedure podmenu;
var a:byte;

begin
repeat
flaga.plik:=false;
flaga.wroc:=false;
flaga.podstawne:=false;
flaga.deszyfr:=false;

if wybor.glowny=1 then a:=12
else a:=10;
klir;
ramka;
gotoxy(a,3);
writeln(tekst_menu[wybor.glowny]);

menu2;
if ((wybor.podmenu=2) or (wybor.podmenu=4)) then flaga.deszyfr:=true;
if ((wybor.podmenu=3) or (wybor.podmenu=4)) then flaga.plik:=true;

if wybor.podmenu<>5 then begin
   case wybor.glowny of
   1: cezar;
   2: podstawne;
   3: vigenere;
   end;
   end;

until wybor.podmenu=5;
end;

{========================================================================}

{/////Program\\\\\}

{========================================================================}

begin
intro;
//tablica znakow, dlugosc[4] to wartosc liczbowa znaku
setlength(dlugosc,4);
dlugosc[3]:=0;
for a:=65 to 90 do begin
    for b:=65 to 90 do begin
        dlugosc[4]:=b+dlugosc[3];
        if dlugosc[4]>90 then dlugosc[4]:=dlugosc[4]-26;
        tabela[a,b]:=chr(dlugosc[4]);
        end;
    inc(dlugosc[3]);
    end;
wybor.glowny:=1;
repeat
klir;
ramka;
menu;

wybor.podmenu:=1;
if ((wybor.glowny>=1) and (wybor.glowny<=3)) then podmenu;

until wybor.glowny=4;
gotoxy(1,23);
textcolor(black);
write(info);
delay(2000);
outro;
end.
