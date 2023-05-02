{**************************************************************************}
{                                                                          }
{    Calmira XP shell for Microsoft® Windows(TM) 3.1                       }
{    Version 3.32                                                          }
{    Copyright (C) Lionel Lowie                                            }
{                                                                          }
{    Based on Calmira Online! Release 3.3                                  }
{    Copyright (C) 1998-2002 Calmira Online!                               }
{    Copyright (C) 1997-1998 Li-Hsin Huang                                 }
{                                                                          }
{    This program is free software; you can redistribute it and/or modify  }
{    it under the terms of the GNU General Public License as published by  }
{    the Free Software Foundation; either version 2 of the License, or     }
{    (at your option) any later version.                                   }
{                                                                          }
{    This program is distributed in the hope that it will be useful,       }
{    but WITHOUT ANY WARRANTY; without even the implied warranty of        }
{    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         }
{    GNU General Public License for more details.                          }
{                                                                          }
{    You should have received a copy of the GNU General Public License     }
{    along with this program; if not, write to the Free Software           }
{    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.             }
{                                                                          }
{**************************************************************************}

unit Shutdown;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
     StdCtrls, ExtCtrls, Messages, Sysmenu, Xpbutton, Logon;



type
  TQuitDlg = class(TForm)
    CancelBtn: TXPButton;
    Label1: TLabel;
    XPLogo: TImage;
    ShutDownBalk: TImage;
    Panel1: TPanel;
    GoToDOS: TImage;
    RestartWindows: TImage;
    RebootComputer: TImage;
    RebootLabel: TLabel;
    RestartLabel: TLabel;
    ExitLabel: TLabel;
    QuitCalmira: TLabel;
    procedure CancelBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RebootComputerClick(Sender: TObject);
    procedure RestartWindowsClick(Sender: TObject);
    procedure GoToDOSClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure XPLogoDblClick(Sender: TObject);
    procedure QuitCalmiraClick(Sender: TObject);

  private
    { Private declarations }
    procedure DarkenScreen;
    procedure DrawShutDownBMP;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses Sysutils, MiscUtil, Settings, Desk, Task, IniFiles, Resource, Files,
  CompSys, Strings;

procedure TQuitDlg.FormCreate(Sender: TObject);
 begin
  XPLogo.Picture.Bitmap.Handle := LoadBitmap(HInstance, 'XPLOGOKLEIN');
  RebootComputer.Picture.Bitmap.Handle := LoadBitmap(HInstance, 'SHUTDOWN1');
  GoToDOS.Picture.Bitmap.Handle := LoadBitmap(HInstance, 'SHUTDOWN3');
  RestartWindows.Picture.Bitmap.Handle := LoadBitmap(HInstance, 'SHUTDOWN2');
  ShutDownBalk.Picture.Bitmap.Handle := LoadBitmap(HInstance, 'SHUTDOWN4');
  If IsShell then
  QuitCalmira.Visible := False
  else
  QuitCalmira.Visible := True;
 end;

procedure TQuitDlg.RebootComputerClick(Sender: TObject);
 begin
  ShowHourglass;
  Release;
  Desktop.Save;
  if ShowShutDownBMP then DrawShutDownBMP;
  ExitWindows(EW_REBOOTSYSTEM, 0);
  
 end;

procedure TQuitDlg.RestartWindowsClick(Sender: TObject);
 begin
  ShowHourglass;
  Release;
  Desktop.Save;
  if ShowShutDownBMP then DrawShutDownBMP;
  ExitWindows(EW_RESTARTWINDOWS, 0);

 end;

procedure TQuitDlg.GoToDOSClick(Sender: TObject);
 begin
  ShowHourglass;
  Release;
  Desktop.Save;
  if ShowShutDownBMP then DrawShutDownBMP;
  ExitWindows(0,0);
 
 end;


procedure TQuitDlg.DarkenScreen;
var
  Mesh: TBrush;
  oldbrush: HBrush;
  dc: HDC;
begin
  Mesh := TBrush.Create;
  Mesh.Bitmap := CreateBrushPattern(clWhite, clBlack);
  dc := GetDC(0);
  oldbrush := SelectObject(dc, Mesh.Handle);
  PatBlt(dc, 0, 0, Screen.Width, Screen.Height, $A000C9);
  SelectObject(dc, oldbrush);
  ReleaseDC(0, dc);
  Mesh.Free;
end;

procedure TQuitDlg.DrawShutDownBMP;
var
  bmpfile: TFileName;
  bmp: TBitmap;
  dc: HDC;
begin
  bmpfile := FileWritePath + 'shutdown.bmp';
  if not FileExists(bmpfile) then
    bmpfile := ApplicationPath + 'shutdown.bmp';
  if not FileExists(bmpfile) then exit;
  bmp := TBitmap.Create;
  bmp.LoadFromFile(bmpfile);
  dc := GetDC(0);
  StretchBlt(dc, 0, 0, Screen.Width, Screen.Height,
    bmp.Canvas.Handle, 0, 0, bmp.Width, bmp.Height, SRCCOPY);
  ReleaseDC(0, dc);
  bmp.Free;
end;

procedure TQuitDlg.CancelBtnClick(Sender: TObject);
 begin
  ModalResult := mrCancel;
 end;

procedure TQuitDlg.FormShow(Sender: TObject);
 begin
  SetSysModalWindow(Handle);
   { Prevent redrawing the active windows' caption }
   SetActiveWindow(Handle);
   if ShowShutDownBMP then DarkenScreen;
 end;

procedure TQuitDlg.FormClose(Sender: TObject; var Action: TCloseAction);
 begin
  Desktop.Repaint;
  Action := caFree;
end;

procedure TQuitDlg.XPLogoDblClick(Sender: TObject);
begin
 with TIniFile.Create('system.ini') do
  begin
    if IsShell then
      WriteString('Boot', 'Shell', 'progman.exe')
    else
      WriteString('Boot', 'Shell', Application.Exename);
    Free;
  end;
 ExitWindows(EW_RESTARTWINDOWS, 0);
end;

procedure TQuitDlg.QuitCalmiraClick(Sender: TObject);
begin
Desktop.Repaint;
Application.Terminate;
end;

end.

