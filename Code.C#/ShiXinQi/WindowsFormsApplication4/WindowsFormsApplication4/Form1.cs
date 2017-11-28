using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApplication4
{
    public partial class Form1 : Form
    {
        int[] arr ;
        int n = 1;
        int count = 0;
        int[] temp = new int[10];
        string[] str;
        
        public Form1()
        {
            InitializeComponent();
        }


        //向右移动
        private void button2_Click(object sender, EventArgs e)
        {
            count++;
            if (count > 3)
            {
                textBox1.Clear();
                count = 0;
            }
            n = Convert.ToInt32(textBox3.Text.Trim());
            str = textBox2.Text.Trim().Split(',');
            arr = new int[str.Length];
            for (int i = 0; i < str.Length; i++)
            {
                arr[i] = Convert.ToInt32(str[i].Trim().ToString());
                
            }
            

            for (int i = 0; i < (arr.Length - n); i++)
            {
                temp[n + i] = arr[i];
            }
            for (int i = 0; i < n; i++)
            {
                temp[i] = arr[arr.Length - n + i];
            }
            for (int i = 0; i < arr.Length; i++)
            {
                textBox1.Text += (temp[i].ToString() + "  ");
            }
            textBox1.Text += ("\r" + "\n");
        }



        //向左移动
        private void button1_Click(object sender, EventArgs e)
        {
            count++;
            if (count > 3)
            {
                textBox1.Clear();
                count = 0;
            }
            n = Convert.ToInt32(textBox3.Text.Trim());
            str = textBox2.Text.Trim().Split(',');
            arr = new int[str.Length];
            for (int i = 0; i < str.Length; i++)
            {
                arr[i] = Convert.ToInt32(str[i].Trim().ToString());

            }
            
            for (int i = 0; i < (arr.Length - n); i++)
            {
                temp[i] = arr[n + i];
            }
            for (int i = 0; i < n; i++)
            {
                temp[arr.Length - n + i] = arr[i];
            }
            for (int i = 0; i < arr.Length; i++)
            {
                textBox1.Text += (temp[i].ToString() + "  ");
            }
            textBox1.Text += ("\r" + "\n");
        }
    }
}
