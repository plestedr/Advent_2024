with Ada.Text_IO;
with Ada.Command_Line;
with Ada.Containers.Vectors;
with GNAT.String_Split;

procedure Day_2 is
   package TIO renames Ada.Text_IO;
   package CLI renames Ada.Command_Line;

   Input    : TIO.File_Type;
   package Report_Container is new Ada.Containers.Vectors (Natural, Integer);
   Report   : Report_Container.Vector;
   Delta_Report : Report_Container.Vector;

   Subs : GNAT.String_Split.Slice_Set;
   --  Subs is populated by the actual substrings.
   Separator_string : constant String := " ";
   Safe_Count : Natural := 0;

   function monotonic (Series : Report_Container.Vector) return Boolean is
      Safe : Boolean := True;
   begin
      for J in 1 .. Natural (series.Length) - 1 loop
         if Series.First_Element * series.Element (J) < 1 then
            Safe := False;
            exit;
         end if;
      end loop;
      return Safe;
   end monotonic;
 
   function slope (Series : Report_Container.Vector) return Boolean is
      Safe : Boolean := True;
   begin
      for J in 0 .. Natural (Series.Length) - 1 loop
         if abs (Series.Element (J)) > 3 or else
           abs (Series.Element (J)) < 1 then
            Safe := False;
            exit;
         end if;
      end loop;
      return Safe;
   end slope;

begin
   TIO.Put_Line (Item => "Argument Count:" & CLI.Argument_Count'Img);

   for i in 1 .. CLI.Argument_Count loop
      TIO.Put_Line (Item => CLI.Argument (Number => i));
   end loop;

   TIO.Open (File => Input,
             Mode => TIO.In_File,
             Name => CLI.Argument (Number => 1));

   while not TIO.End_Of_File (File => Input) loop

      GNAT.String_Split.Create (S          => Subs,
                                From       => TIO.Get_Line (File => Input),
                                Separators => Separator_string,
                                Mode       => GNAT.String_Split.Multiple);

      TIO.Put_Line
         ("Got" &
         GNAT.String_Split.Slice_Number'Image (GNAT.String_Split.Slice_Count (Subs)) &
         " substrings:");
      --  Report results, starting with the count of substrings created.

      for I in 1 .. GNAT.String_Split.Slice_Count (Subs) loop
         Report.Append (New_Item =>   Integer'Value (GNAT.String_Split.Slice (Subs, I)));
      end loop;

      for J in 0 .. Natural (Report.Length) - 1 loop
         TIO.Put ((Report.Element (J)'Image) & " ");
      end loop;
      for K in 0 .. Natural (Report.Length) - 2 loop
         Delta_Report.Append (Report.Element (K + 1) - Report.Element (K));
      end loop;
      for L in 0 .. Natural (Delta_Report.Length) - 1 loop
         TIO.Put ((Delta_Report.Element (L)'Image) & " ");
      end loop;
      --  TIO.Put ("  " & monotonic (Delta_Report)'Image);
      --  TIO.Put ("  " & slope (Delta_Report)'Image);
      if monotonic (Delta_Report) and then slope (Delta_Report) then
         TIO.Put (" SAFE ");
         Safe_Count := Safe_Count + 1;
      else
         TIO.Put (" NOT SAFE ");
      end if;
      TIO.Put_Line ("  ");

      Report.Clear; Delta_Report.Clear;

   end loop;

   TIO.Put_Line (Safe_Count'Image & " Reports are safe. ");

   TIO.Close (Input);

end Day_2;
