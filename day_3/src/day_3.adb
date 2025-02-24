with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_IO;
with Ada.Command_Line;
with Ada.Containers.Vectors;
with GNAT.String_Split;
with day_3_supt; use day_3_supt;

with Ada.Characters.Handling;

procedure Day_3 is
   package SU renames Ada.Strings.Unbounded;
   package TIO renames Ada.Text_IO;
   package SIO renames Ada.Text_IO.Unbounded_IO;
   package CLI renames Ada.Command_Line;

   Input    : TIO.File_Type;
   Text_Line : SU.Unbounded_String;

   --  use type Str.Unbounded_String;

begin
   TIO.Put_Line (Item => "Argument Count:" & CLI.Argument_Count'Img);

   for i in 1 .. CLI.Argument_Count loop
      TIO.Put_Line (Item => CLI.Argument (Number => i));
   end loop;

   TIO.Open (File => Input,
             Mode => TIO.In_File,
             Name => CLI.Argument (Number => 1));

   while not TIO.End_Of_File (File => Input) loop
   --  Text_Line := SIO.Get_Line (File => Input);
      Text_Line := Ada.Strings.Unbounded.To_Unbounded_String
         (Ada.Text_IO.Get_Line (File => Input));

      TIO.Put_Line (SU.To_String (Text_Line));

   end loop;
end Day_3;
