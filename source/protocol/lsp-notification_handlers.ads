------------------------------------------------------------------------------
--                         Language Server Protocol                         --
--                                                                          --
--                        Copyright (C) 2018, AdaCore                       --
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

with LSP.Messages;

package LSP.Notification_Handlers is

   type Notification_Handler is limited interface;
   type Notification_Handler_Access is access all Notification_Handler'Class;

   not overriding procedure Workspace_Did_Change_Configuration
    (Self     : access Notification_Handler;
     Value    : LSP.Messages.DidChangeConfigurationParams) is null;

   not overriding procedure Text_Document_Did_Open
     (Self  : access Notification_Handler;
      Value : LSP.Messages.DidOpenTextDocumentParams) is null;

   not overriding procedure Text_Document_Did_Change
     (Self  : access Notification_Handler;
      Value : LSP.Messages.DidChangeTextDocumentParams) is null;

   not overriding procedure Text_Document_Did_Save
     (Self  : access Notification_Handler;
      Value : LSP.Messages.DidSaveTextDocumentParams) is null;

   not overriding procedure Text_Document_Did_Close
     (Self  : access Notification_Handler;
      Value : LSP.Messages.DidCloseTextDocumentParams) is null;

   not overriding procedure Exit_Notification
    (Self : access Notification_Handler) is null;

end LSP.Notification_Handlers;