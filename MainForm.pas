unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Net.HTTPClientComponent,
  Vcl.ComCtrls, Vcl.ExtCtrls, System.Actions, Vcl.ActnList;

type
  TGetPosts = function(Page, Login: String): TStringList;
  TfmMain = class(TForm)
    edUsername: TEdit;
    Label1: TLabel;
    edTag: TEdit;
    Label2: TLabel;
    moURLs: TMemo;
    btStart: TButton;
    pbMain: TProgressBar;
    alMain: TActionList;
    acSelectAll: TAction;
    procedure btStartClick(Sender: TObject);
    procedure acSelectAllExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

function GetPostsNew(Page, Login: String): TStringList;
var
  i, ps: Integer;
  IsLink: Boolean;
  IsAEnd: Boolean;
  URL, UserLink: String;
const
  PATTERN = '%s.livejournal.com';
begin
  Result := TStringList.Create;
  UserLink := Format(PATTERN, [Login]);
  ps := 1;
  while True do
  begin
    ps := Pos('class="j-e-title"',Page,ps);
    if ps=0 then
      Break;
    IsLink := False;
    IsAEnd := False;
    URL := '';
    for i := ps to Length(Page) do
    begin
      if IsLink and (Page[i]='"') then
        Break;
      if Page[i]='>' then
        IsAEnd := True;
      if IsAEnd and (Page[i]='"') then
      begin
        IsLink := True;
        Continue;
      end;
      if IsLink then
        URL := URL + Page[i];
    end;
    if (URL <> '') and (Pos(UserLink, URL) > 0) then Result.Add(URL);
    ps := ps + 18; // Оффсет
    Application.ProcessMessages;
    fmMain.Update;
  end;
end;

function GetPostsOld(Page, Login: String): TStringList;
var
  i, ps: Integer;
  IsLink: Boolean;
  URL, UserLink: String;
const
  PATTERN = '%s.livejournal.com';
begin
  Result := TStringList.Create;
  UserLink := Format(PATTERN, [Login]);
  ps := 1;
  while True do
  begin
    ps := Pos('class="subj-link"',Page,ps);
    if ps=0 then
      Break;
    IsLink := False;
    URL := '';
    for i := ps downto 1 do
    begin
      if IsLink and (Page[i]='"') then
        Break;
      if Page[i]='"' then
      begin
        IsLink := True;
        Continue;
      end;
      if IsLink then
        URL := Page[i] + URL;
    end;
    if (URL <> '') and (Pos(UserLink, URL) > 0) then Result.Add(URL);
    ps := ps + 18; // Оффсет
    Application.ProcessMessages;
    fmMain.Update;
  end;
end;

procedure TfmMain.acSelectAllExecute(Sender: TObject);
begin
  moURLs.SelectAll;
end;

procedure TfmMain.btStartClick(Sender: TObject);
const
  PATTERN = 'https://%s.livejournal.com/?skip=%d&tag=%s';
var
  URL, Page, LastPosts: String;
  Skip, i: Integer;
  HTTPclient: TNetHTTPClient;
  SL: TStringList;
  GetPostsFunc: TGetPosts;
begin
  moURLs.Clear;
  GetPostsFunc := GetPostsOld;
  fmMain.Enabled := False;
  pbMain.Style := pbstMarquee;
  fmMain.Cursor := crHourGlass;
  HTTPclient := TNetHTTPClient.Create(Self);
  try
    Skip := 0;
    while True do
    begin
      URL := Format(PATTERN,[edUsername.Text,Skip,edTag.Text]);
      Page := HTTPclient.Get(URL).ContentAsString;
      SL := GetPostsFunc(Page, edUsername.Text);
      if (SL.Count = 0) or (SL.Text = LastPosts) then
      begin
        if @GetPostsFunc=@GetPostsOld then
        begin
          GetPostsFunc := GetPostsNew;
          Skip := 0;
          Continue;
        end
        else
          Break;
      end;
      LastPosts := SL.Text;
      moURLs.Lines.AddStrings(SL);
      for i := 0 to 10 do
        moURLs.Perform(EM_SCROLLCARET,SB_LINEDOWN,0);
      Skip := Skip + 10;
    end;
  finally
    HTTPclient.Free;
    fmMain.Cursor := crDefault;
    pbMain.Style := pbstNormal;
    fmMain.Enabled := True;
    ShowMessage('Найдено ' + IntToStr(moURLs.Lines.Count) + ' постов');
  end;
end;

end.
