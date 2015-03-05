package body Neo.File.Model is
  package body Id_Tech is separate;
  --function Load  (Name : in String_2) return Record_Animation          renames Animataion.Load;
  --function Load  (Name : in String_2) return Record_Camera             renames Camera.Load;
  function Load  (Name : in String_2) return Record_Mesh               renames Mesh.Load;
  --function Load  (Name : in String_2) return Record_Map                renames Map.Load;
  --procedure Save (Name : in String_2; Item : in Record_Animation) renames Animation.Save;
  --procedure Save (Name : in String_2; Item : in Record_Camera)    renames Camera.Save;
  procedure Save (Name : in String_2; Item : in Record_Mesh)      renames Mesh.Save;
  --procedure Save (Name : in String_2; Item : in Record_Map)       renames Map.Save;
end Neo.File.Model;
