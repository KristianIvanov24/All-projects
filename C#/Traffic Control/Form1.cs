using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;

namespace Контрол_по_автотранспорта
{
    public partial class Form1 : Form
    {      

        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string dvijenie;      
            string danuk;
            string godina = txtGodina.Text;
            int godinaa = int.Parse(godina);
            if (string.IsNullOrWhiteSpace(txtNomer.Text) || string.IsNullOrWhiteSpace(txtShasi.Text) || string.IsNullOrWhiteSpace(txtMarka.Text) || string.IsNullOrWhiteSpace(txtImena.Text) || string.IsNullOrWhiteSpace(txtGodina.Text))
            {
                MessageBox.Show("Имате непопълнено поле!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
            else
            {
                if(!(char.IsLetter(txtNomer.Text[0]) && char.IsLetter(txtNomer.Text[1]) && char.IsDigit(txtNomer.Text[2]) && char.IsDigit(txtNomer.Text[3]) && char.IsDigit(txtNomer.Text[4]) && char.IsDigit(txtNomer.Text[5])))
                {
                    MessageBox.Show("Грешен регистрационен номер!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }
                if (!txtShasi.Text.All(Char.IsDigit))
                {
                    MessageBox.Show("Грешно въведен номер на шаси!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }
                else
                    if(txtShasi.Text.Length!=10)
                    {
                        MessageBox.Show("Грешно въведен номер на шаси!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        return;
                    }
                if (!txtGodina.Text.All(Char.IsDigit))
                {
                    MessageBox.Show("Грешно въведена година на производство!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }
            }
            if (godinaa >= 1995)
            {
                dvijenie = "Автомобилът е в движение!";
                danuk = "Данък-" + (50 + (2020 - godinaa) + "лв.");
            }
            else
            {
                dvijenie = "Автомобилът е спрян от движение!";
                danuk = "Данък- 50лв.";
            }
            StreamWriter Myfile = new StreamWriter("Автомобили.txt", true, Encoding.GetEncoding(1251));
            Myfile.WriteLine(txtNomer.Text + ", " + txtShasi.Text + ", " + txtMarka.Text + ", " + txtImena.Text + ", " + txtGodina.Text + ", " + dvijenie);
            StreamWriter File = new StreamWriter("Данък.txt", true, Encoding.GetEncoding(1251));
            File.WriteLine(txtImena.Text + ", " + txtNomer.Text + ", " + danuk);
            txtNomer.Clear();
            txtShasi.Clear();
            txtMarka.Clear();
            txtImena.Clear();
            txtGodina.Clear();
            Myfile.Close();
            File.Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            richTextBox1.Clear();
            StreamReader myFile = new StreamReader("Автомобили.txt", Encoding.GetEncoding(1251));
            StreamReader File = new StreamReader("Данък.txt", Encoding.GetEncoding(1251));
            string fileLine = "";
            string fileLine2 = "";
            while (fileLine != null && fileLine2 != null)
            {
                fileLine = myFile.ReadLine();
                fileLine2 = File.ReadLine();
                if (fileLine != null && chAll.Checked)
                {
                    richTextBox1.Text += fileLine + '\n';
                }
                if (fileLine != null && chStop.Checked && fileLine.IndexOf("Автомобилът е спрян от движение!") > -1)
                {
                    richTextBox1.Text += fileLine + '\n';
                }
                if (fileLine2 != null && chDanuk.Checked)
                {
                    richTextBox1.Text += fileLine2 + '\n';
                }
            }
            myFile.Close();

        }
        private void button3_Click(object sender, EventArgs e)
        {
            richTextBox1.Clear();
        }
    }
 }
