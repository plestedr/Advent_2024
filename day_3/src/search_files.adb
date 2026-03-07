with Ada.Directories; use Ada.Directories;
with GNAT.Regexp;     use GNAT.Regexp;

procedure Search_Files (Pattern : String) is
  Search : Search_Type;
  Ent    : Directory_Entry_Type;
  Re     : constant Regexp := Compile (Pattern, Glob => True);

begin
  Start_Search (Search, Directory => ".", Pattern => "");
  while More_Entries (Search) loop
     Get_Next_Entry (Search, Ent);
     if Match (Simple_Name (Ent), Re) then
       --  ... --  Matched, do whatever
     end if;
  end loop;
  End_Search (Search);
end Search_Files;
