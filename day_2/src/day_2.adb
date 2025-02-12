with Ada.Text_IO;
with Ada.Command_Line;
with Ada.Containers.Vectors;
with GNAT.String_Split;
with day_2_supt; use day_2_supt;

procedure Day_2 is
   package TIO renames Ada.Text_IO;
   package CLI renames Ada.Command_Line;

   Input    : TIO.File_Type;
   Report   : Report_Container.Vector;
   Delta_Report : Report_Container.Vector;
   Damp_Vector : Report_Container.Vector;
   Damp_Derivative : Report_Container.Vector;

   Subs : GNAT.String_Split.Slice_Set;
   --  Subs is populated by the actual substrings.
   Separator_string : constant String := " ";
   Safe_Count : Natural := 0;

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

      --  Creat derivative vector
      --  for K in 0 .. Natural (Report.Length) - 2 loop
      --     Delta_Report.Append (Report.Element (K + 1) - Report.Element (K));
      --  end loop;

      Delta_Report := Derivative_Vector (Report);

      for L in 0 .. Natural (Delta_Report.Length) - 1 loop
         TIO.Put ((Delta_Report.Element (L)'Image) & " ");
      end loop;

      if monotonic (Delta_Report) and then slope (Delta_Report) then
         TIO.Put (" SAFE ");
         Safe_Count := Safe_Count + 1;
      else
         Dampener_loop:
         for J in 0 .. Natural (Report.Length) - 1 loop
            Damp_Vector := Report;
            Damp_Vector.Delete (Index => J, Count => 1);
            Damp_Derivative := Derivative_Vector (Damp_Vector);
            if monotonic (Damp_Derivative) and then slope (Damp_Derivative) then
               Safe_Count := Safe_Count + 1;
               TIO.Put (" SAFE by removing element " & J'Image );
               exit Dampener_loop;
            else
                  if J = Natural (Report.Length) - 1 then
                     TIO.Put (" NOT SAFE ");
                  end if;
            end if;

         end loop Dampener_loop;

         --  TIO.Put (" NOT SAFE ");
      end if;
      TIO.Put_Line ("  ");

      Report.Clear; Delta_Report.Clear;

   end loop;

   TIO.Put_Line (Safe_Count'Image & " Reports are safe. ");

   TIO.Close (Input);

end Day_2;
