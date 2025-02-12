package body day_2_supt is

   function monotonic (Series : Report_Container.Vector) return Boolean is
      Safe : Boolean := True;
   begin
      for J in 1 .. Natural (Series.Length) - 1 loop
         if Series.First_Element * Series.Element (J) < 1 then
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


   function Derivative_Vector (Series : Report_Container.Vector) return Report_Container.Vector is
      Deriv : Report_Container.Vector;
   begin
      for K in 0 .. Natural (Series.Length) - 2 loop
         Deriv.Append (Series.Element (K + 1) - Series.Element (K));
      end loop;
      return Deriv;
   end Derivative_Vector;
end day_2_supt;
