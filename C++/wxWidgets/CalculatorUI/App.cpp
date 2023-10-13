#include "App.h"
#include "MainFrame.h"

wxIMPLEMENT_APP(App);

bool App::OnInit(){
	MainFrame* mainFrame = new MainFrame("Calculator");
	mainFrame->SetClientSize(400, 600);
	mainFrame->SetMinSize(wxSize(400, 600));
	mainFrame->Center();
	mainFrame->Show();
	return true;
}