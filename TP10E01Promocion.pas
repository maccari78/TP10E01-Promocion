program TP10E01Promocion; {Danilo Maccari 05-08-2016}

USES
  SysUtils;

TYPE
  TNombres = Array [0 .. 99] of String;
  TEliminados = Array [0 .. 99] of String;

VAR
  Nombre: TNombres;
  UltimoNombre: Integer;
  Eliminado: TEliminados;
  UltimoEliminado: Integer;
  Respuesta: Char;

FUNCTION BuscarNombre (Buscado: String; Nombre: TNombres; Ultimo: Integer): Integer;

VAR
  i: Integer;

begin
  BuscarNombre:= -1;
  for i:= 0 to Ultimo do
    if (Buscado = Nombre [i]) then
    BuscarNombre:= i;
end;

PROCEDURE Ordena (Ultimo: Integer; VAR Nombre: TNombres);

VAR
  i, j: Integer;
  Aux: String;

begin
  for i:= 0 to Ultimo - 1 do
    for j:= i + 1 to Ultimo do
      if Nombre [j] < Nombre [i] then
        begin
          Aux:= Nombre [i];
          Nombre [i]:= Nombre [j];
          Nombre [j]:= Aux;
        end;
  Writeln ();
  Write ('La lista ordenada de nombres es: ');
  Writeln ();
end;

PROCEDURE Muestra (Nombre: TNombres; Ultimo: Integer);

VAR
  i: Integer;

begin
  for i:= 0 to Ultimo do
    if Nombre [i] <> ' ' then
      Writeln ('El nombre ', i, ' es: ', Nombre [i]);
end;

PROCEDURE Alta (VAR Nombre: TNombres; VAR Ultimo: Integer);

VAR
  NuevoNombre: String;

begin
  Writeln ();
  Write ('Ingrese el nombre nuevo ("S": Sale sin registrar): ');
  Readln (NuevoNombre);
  if NuevoNombre <> 'S' then
    begin
      Ultimo:= Ultimo + 1;
      Nombre [Ultimo]:= NuevoNombre;
    end;
end;

PROCEDURE Baja (VAR Nombre: TNombres; VAR Eliminados: TEliminados;
                VAR Ultimo: Integer; VAR UltimoEliminado: Integer);

VAR
  QuitaNombre: String;
  i, Encontrado: Integer;

begin
  Writeln ();
  Write ('Ingrese el nombre que desea quitar: ');
  Readln (QuitaNombre);
  Encontrado:= BuscarNombre (QuitaNombre, Nombre, Ultimo);
  if Encontrado > -1 then
    begin
      Eliminados [UltimoEliminado]:= Nombre [Encontrado];
      UltimoEliminado:= UltimoEliminado + 1;

      for i:= Encontrado + 1 to Ultimo do
          Nombre [i - 1]:= Nombre [i];

      Ultimo:= Ultimo - 1;
    end
  else
    begin
      Writeln ();
      Write ('El nombre ', QuitaNombre, ' no esta en la lista');
      Writeln ();
    end
end;

PROCEDURE Muestra2 (Eliminado: TEliminados; UltimoEliminado: Integer);

VAR
  i, j: Integer;
  Aux2: String;

begin
    for i:= 0 to UltimoEliminado do
      for j:= i + 1 to UltimoEliminado do
        if Eliminado [j] < Eliminado [i] then
          begin
            Aux2:= Eliminado [i];
            Eliminado [i]:= Eliminado [j];
            Eliminado [j]:= Aux2;
          end;
  for i:= 1 to UltimoEliminado do
    if Eliminado [i] <> ' ' then
      Writeln ('El nombre eliminado ', i, ' es: ', Eliminado [i]);
end;

FUNCTION PideTarea (): Char;

VAR
  Resp: Char;

begin
  Writeln ();
  Resp:= ' ';
  begin
    Write (' (A) Alta, (B) Baja, (O) Ordenar, (S) Salir : ');
    Readln (Resp);
  end;
  Case Resp of
    'A', 'a': Alta (Nombre, UltimoNombre);
    'B', 'b': Baja (Nombre, Eliminado, UltimoNombre, UltimoEliminado);
    'O', 'o': Ordena (UltimoNombre, Nombre);
    'S', 's': Writeln ('Hasta luego');
  end;
  PideTarea:= Resp;
end;

begin                                                       {PROGRAMA PRINCIPAL}
  Writeln ('Lista desordenada de nombres es: ');
  Nombre [0]:= 'Juan';
  Nombre [1]:= 'Andres';
  Nombre [2]:= 'Javier';
  Nombre [3]:= 'Tomas';
  Nombre [4]:= 'Avigail';
  Nombre [5]:= 'Lucia';
  Nombre [6]:= 'Yago';
  Nombre [7]:= 'Osvaldo';
  Nombre [8]:= 'Benicio';
  Nombre [9]:= 'Gaston';
  UltimoNombre:= 9;
  UltimoEliminado:= 0;
  Writeln ();
  Muestra (Nombre, UltimoNombre);
  Writeln ();
  repeat
    Respuesta:= PideTarea ();
    Writeln ();
    Muestra (Nombre, UltimoNombre);
    Writeln ();
    Muestra2 (Eliminado, UltimoEliminado);
  until (Respuesta = 'S') or (Respuesta = 's');
end.
