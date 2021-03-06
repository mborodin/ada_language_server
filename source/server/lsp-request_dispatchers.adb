------------------------------------------------------------------------------
--                         Language Server Protocol                         --
--                                                                          --
--                     Copyright (C) 2018-2019, AdaCore                     --
--                                                                          --
-- This is free software;  you can redistribute it  and/or modify it  under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  This software is distributed in the hope  that it will be useful, --
-- but WITHOUT ANY WARRANTY;  without even the implied warranty of MERCHAN- --
-- TABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public --
-- License for  more details.  You should have  received  a copy of the GNU --
-- General  Public  License  distributed  with  this  software;   see  file --
-- COPYING3.  If not, go to http://www.gnu.org/licenses for a complete copy --
-- of the license.                                                          --
------------------------------------------------------------------------------

with Ada.Exceptions;

with GNATCOLL.JSON;

package body LSP.Request_Dispatchers is

   --------------
   -- Dispatch --
   --------------

   function Dispatch
     (Self    : in out Request_Dispatcher;
      Method  : LSP.Types.LSP_String;
      Stream  : access Ada.Streams.Root_Stream_Type'Class;
      Handler : not null LSP.Message_Handlers.Request_Handler_Access)
        return LSP.Messages.ResponseMessage'Class
   is
      Cursor : Maps.Cursor := Self.Map.Find (Method);
   begin
      if not Maps.Has_Element (Cursor) then
         Cursor := Self.Map.Find (LSP.Types.Empty_LSP_String);
      end if;

      return Maps.Element (Cursor) (Stream, Handler);
   exception
      when E : others =>
         --  Unexpected exception, reply to client with an error
         return LSP.Messages.ResponseMessage'
           (Is_Error => True,
            jsonrpc  => <>,
            id       => <>,
            error    =>
              (Is_Set => True,
               Value => (code => LSP.Messages.InternalError,
                         data => GNATCOLL.JSON.Create_Object,
                         message => LSP.Types.To_LSP_String
                           (Ada.Exceptions.Exception_Information (E)))));
   end Dispatch;

   --------------
   -- Register --
   --------------

   procedure Register
     (Self   : in out Request_Dispatcher;
     Method : LSP.Types.LSP_String;
      Value  : Parameter_Handler_Access) is
   begin
      Self.Map.Insert (Method, Value);
   end Register;

end LSP.Request_Dispatchers;
