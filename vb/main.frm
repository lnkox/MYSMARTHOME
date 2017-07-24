VERSION 5.00
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   7260
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   6900
   LinkTopic       =   "Form1"
   ScaleHeight     =   7260
   ScaleWidth      =   6900
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton set_json 
      Caption         =   "set_json"
      Height          =   615
      Left            =   3240
      TabIndex        =   11
      Top             =   1920
      Width           =   3015
   End
   Begin VB.CommandButton json 
      Caption         =   "json"
      Height          =   615
      Left            =   1560
      TabIndex        =   10
      Top             =   2040
      Width           =   1215
   End
   Begin VB.TextBox set_info_txt 
      Height          =   375
      Left            =   4680
      TabIndex        =   9
      Text            =   "1"
      Top             =   1080
      Width           =   495
   End
   Begin VB.CommandButton set_info_btn 
      Caption         =   "set_info"
      Height          =   375
      Left            =   5280
      TabIndex        =   8
      Top             =   1080
      Width           =   1455
   End
   Begin VB.TextBox cur_ans 
      Height          =   375
      Left            =   600
      TabIndex        =   7
      Text            =   "Text1"
      Top             =   2880
      Width           =   5775
   End
   Begin VB.TextBox ans_txt 
      Height          =   3495
      Left            =   600
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   6
      Top             =   3360
      Width           =   5775
   End
   Begin VB.CommandButton get_info_btn 
      Caption         =   "get_info"
      Height          =   375
      Left            =   5280
      TabIndex        =   5
      Top             =   600
      Width           =   1455
   End
   Begin VB.TextBox get_info_txt 
      Height          =   375
      Left            =   4680
      TabIndex        =   4
      Text            =   "1"
      Top             =   600
      Width           =   495
   End
   Begin VB.TextBox command_txt 
      Height          =   375
      Left            =   4680
      TabIndex        =   3
      Text            =   "65"
      Top             =   120
      Width           =   495
   End
   Begin VB.CommandButton send_comand_btn 
      Caption         =   "send_comand"
      Height          =   375
      Left            =   5280
      TabIndex        =   2
      Top             =   120
      Width           =   1455
   End
   Begin VB.CommandButton Close_connect_btn 
      Caption         =   "Close connect"
      Height          =   375
      Left            =   1320
      TabIndex        =   1
      Top             =   120
      Width           =   1215
   End
   Begin VB.CommandButton Conect_btn 
      Caption         =   "Connect"
      Height          =   375
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   1095
   End
   Begin MSWinsockLib.Winsock Winsock 
      Left            =   480
      Top             =   480
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
      Protocol        =   1
      RemoteHost      =   "255.255.255.255"
      RemotePort      =   2201
      LocalPort       =   1407
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Close_connect_btn_Click()
Winsock.Close
End Sub

Private Sub Conect_btn_Click()
Winsock.Connect "192.168.0.22", 80

End Sub

Private Sub get_info_btn_Click()
Winsock.SendData Chr(154) & Chr(Int(get_info_txt.Text))
End Sub

Private Sub json_Click()
Winsock.SendData "{'module':1,'port':23,'data':[48.756080,2.302038]}"
End Sub

Private Sub send_comand_btn_Click()
Winsock.SendData Chr(153) & Chr(Int(command_txt.Text)) & Chr(Int(command_txt.Text) + 22)
End Sub

Private Sub set_info_btn_Click()
Winsock.SendData Chr(155) & Chr(Int(set_info_txt)) & "qwerty" & Chr(156)
End Sub

Private Sub set_json_Click()
Winsock.SendData "{'get_id':1}"
End Sub

Private Sub Winsock_DataArrival(ByVal bytesTotal As Long)
    Dim strData As String
    Winsock.GetData strData
    cur_ans = Asc(strData)
    ans_txt.Text = ans_txt.Text & strData
End Sub

