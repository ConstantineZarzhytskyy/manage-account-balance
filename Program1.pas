program account;
var f: text;
    balance: real;
    status: boolean;
procedure changeStatus();
begin
  assign(f,'account.txt');
 
  reset(f);
  readln(f, status);
  readln(f, balance);
  close(f);  
    
  assign(f,'account.txt');  
  rewrite(f);
  status := not status;
  writeln(f, status);
  writeln(f, balance);
  
  close(f);
end;    
    
procedure writeInFile(var money: real);
begin
  assign(f,'account.txt');
  rewrite(f);
  
  writeln(f, status);
  writeln(f, money);
  
  close(f);
end;
    
function connect(): boolean;
var status: boolean;
begin
  assign(f,'account.txt');
  reset(f);
  
  readln(f,status);
  readln(f,balance);
    
  close(f);
  
  result := status;
end;

procedure disconnect();
begin
  changeStatus();
end;

procedure sub(var value: real);
begin
  balance := balance - value;
  writeInFile(balance);
  writeln('balance = ' + balance);
end;

procedure add(var value: real);
begin
  balance := balance + value;
  writeInFile(balance);
  writeln('balance = ' + balance);
end;

procedure proccess();
var
    operation: char;
    money: real;
    str: String;
begin
  while (true) do
    begin
      Write('Enter value to change account balance = ');readln(str);
      operation := str[1]; 
         
      case operation of 
        '+': begin
          money := StrToFloat(str.Substring(1, (str.Length - 1)));
          add(money);
        end;
        
        '-': begin
          money := StrToFloat(str.Substring(1, (str.Length - 1)));
          sub(money);
        end;
        
        '0': begin
          break
        end;
      end;
    end;
end;

begin 
  if (connect()) then
    begin
      Writeln('Connected complete!');
      changeStatus();
      proccess();
      disconnect();
    end
   else
    begin
     Writeln('Connected failed!');
     writeln('You are haven`t access to account!!!');
    end;
  readln();
end.