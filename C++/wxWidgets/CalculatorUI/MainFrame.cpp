#include "MainFrame.h"

class ButtonData : public wxObject
{
public:
	ButtonData(const wxString& other) : data(other)
	{  }

public:
	wxString GetData() { return data; }
private:
	wxString data;
};

MainFrame::MainFrame(const wxString& title) : wxFrame(nullptr, wxID_ANY, title){
	CreateControls();
	BindEventHandlers();
}

void MainFrame::CreateControls(){
	wxFont mainFont(wxFontInfo(wxSize(0, 24)));
	panel = new wxPanel(this);
	panel->SetFont(mainFont);

	inputField = new wxTextCtrl(panel, wxID_ANY, "", wxPoint(10, 80), wxSize(380, 80), wxTE_PROCESS_ENTER);

	numberButtons = new wxButton * [10];
	numberButtons[0] = new wxButton(panel, wxID_ANY, "0", wxPoint(10, 500), wxSize(300, 50));
	int pointY = 450;
	int pointX = 10;
	for (int i = 1; i < 10; i++){
		char number = (char)('0' + i);
		numberButtons[i] = new wxButton(panel, wxID_ANY, number, wxPoint(pointX, pointY), wxSize(100, 50));
		if (i % 3 == 0){
			pointY -= 50;
			pointX = 10;
		}
		else pointX += 100;
	}
	
	plusButton = new wxButton(panel, wxID_ANY, "+", wxPoint(310, 350), wxSize(85, 70));
	minusButton = new wxButton(panel, wxID_ANY, "-", wxPoint(310, 420), wxSize(85, 70));
	equalButton = new wxButton(panel, wxID_ANY, "=", wxPoint(310, 490), wxSize(85, 60));

	wxBoxSizer* vSizer = new wxBoxSizer(wxVERTICAL);
	wxBoxSizer* hSizer = new wxBoxSizer(wxHORIZONTAL);
	
	hSizer->Add(inputField, 3, wxEXPAND);
	vSizer->Add(hSizer, 1, wxEXPAND);
	hSizer = new wxBoxSizer(wxHORIZONTAL);

	int k = 0;
	for (int i = 9; i > 0; i--){
		hSizer->Add(numberButtons[i], 1, wxEXPAND);
		if ((i-1) % 3 == 0){
			switch (k){
				case 0: hSizer->Add(plusButton, 1, wxEXPAND); break;
				case 1: hSizer->Add(minusButton, 1, wxEXPAND); break;
				case 2: hSizer->Add(equalButton, 1, wxEXPAND); break;
			}
			vSizer->Add(hSizer, 1, wxEXPAND);
			hSizer = new wxBoxSizer(wxHORIZONTAL);
			k++;
		}	
	}
	hSizer->Add(numberButtons[0], 1, wxEXPAND);
	vSizer->Add(hSizer, 1, wxEXPAND);

	panel->SetSizerAndFit(vSizer);
}

void MainFrame::BindEventHandlers(){
	for (int i = 0; i < 10; i++)
	{
		ButtonData* btnData = new ButtonData(numberButtons[i]->GetLabel());
		numberButtons[i]->Bind(wxEVT_BUTTON, &MainFrame::OnNumberButtonClicked, this, -1, -1, btnData);
	}
	plusButton->Bind(wxEVT_BUTTON, &MainFrame::OnPlusButtonClicked, this);
	minusButton->Bind(wxEVT_BUTTON, &MainFrame::OnMinusButtonClicked, this);
	equalButton->Bind(wxEVT_BUTTON, &MainFrame::OnEqualButtonClicked, this);
}

void MainFrame::OnNumberButtonClicked(wxCommandEvent& evt){
	ButtonData* numberButton = static_cast<ButtonData*>(evt.GetEventUserData());
	inputField->WriteText(numberButton->GetData());
}

void MainFrame::OnPlusButtonClicked(wxCommandEvent& evt){
	inputField->WriteText(plusButton->GetLabel());
}

void MainFrame::OnMinusButtonClicked(wxCommandEvent& evt){
	inputField->WriteText(minusButton->GetLabel());
}

void MainFrame::OnEqualButtonClicked(wxCommandEvent& evt){
	inputField->WriteText(equalButton->GetLabel());
}