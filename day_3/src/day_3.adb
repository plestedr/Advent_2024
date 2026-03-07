with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_IO;
with Ada.Command_Line;
--  with Ada.Containers.Vectors;
with GNAT.String_Split;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;

with day_3_supt; use day_3_supt;

--  with Ada.Characters.Handling;

procedure Day_3 is
   package SU renames Ada.Strings.Unbounded;
   package TIO renames Ada.Text_IO;
   package SIO renames Ada.Text_IO.Unbounded_IO;
   package CLI renames Ada.Command_Line;
   package GSS renames GNAT.String_Split;

   Input    : TIO.File_Type;
   Text_Line : SU.Unbounded_String;

   Subs : GSS.Slice_Set;
   --  Subs is populated by the actual substrings.

   Seps : constant String := "mul(";

begin
   TIO.Put_Line (Item => "Argument Count:" & CLI.Argument_Count'Img);

   for i in 1 .. CLI.Argument_Count loop
      TIO.Put_Line (Item => CLI.Argument (Number => i));
   end loop;

   TIO.Open (File => Input,
             Mode => TIO.In_File,
             Name => CLI.Argument (Number => 1));

   while not TIO.End_Of_File (File => Input) loop
      Text_Line := SU.To_Unbounded_String
         (TIO.Get_Line (File => Input));
      TIO.Put_Line (SU.To_String (Text_Line));
   end loop;
   TIO.Close (File => Input);

   GSS.Create (S => Subs,
               From       => (SU.To_String (Text_Line)),
               Separators => Seps,
               Mode       => GSS.Multiple);
   --  Create the split, using Multiple mode to treat strings of multiple
   --  whitespace characters as a single separator.
   --  This populates the Subs object.

   --  Report results, starting with the count of substrings created.

   for I in 1 .. GSS.Slice_Count (Subs) loop
      --  Loop though the substrings.
      declare
         Sub : constant String := GSS.Slice (Subs, I);
         --  Pull the next substring out into a string object for
         --  easy handling.
      begin
         TIO.Put_Line (GSS.Slice_Number'Image (I) &
                   " -> " &
                   Sub &
                   " (length" & Positive'Image (Sub'Length) &
                   ")");
         --  Output the individual substrings, and their length.
      end;
   end loop;

end Day_3;
