with Ada.Text_IO;
with Ada.Command_Line;
with Ada.Containers.Vectors;
with GNAT.String_Split;

package day_2_supt is

   package Report_Container is new Ada.Containers.Vectors (Natural, Integer);

   function Derivative_Vector (Series : Report_Container.Vector) return Report_Container.Vector;

   function monotonic (Series : Report_Container.Vector) return Boolean;
   function slope (Series : Report_Container.Vector) return Boolean;

end day_2_supt;
