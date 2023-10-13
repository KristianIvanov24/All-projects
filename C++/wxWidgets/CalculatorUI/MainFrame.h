#pragma once
#include <wx/wx.h>

class MainFrame : public wxFrame
{
public:
	MainFrame(const wxString& title);
private:
	void CreateControls();
	void BindEventHandlers();

	void OnNumberButtonClicked(wxCommandEvent& evt);
	void OnPlusButtonClicked(wxCommandEvent& evt);
	void OnMinusButtonClicked(wxCommandEvent& evt);
	void OnEqualButtonClicked(wxCommandEvent& evt);

	wxPanel* panel;
	wxButton** numberButtons;
	wxButton* plusButton;
	wxButton* minusButton;
	wxButton* equalButton;
	wxTextCtrl* inputField;
};

