using System;
using System.Windows.Forms;
using System.Threading;

namespace HQTCSDL_Group01
{
    public partial class SelectVersionForm : Form
    {
        public SelectVersionForm()
        {
            InitializeComponent();
        }

        private void errorVersionButton_Click(object sender, EventArgs e)
        {
            Thread thread = new Thread(() =>
            {
                new ErrorVersionForm().ShowDialog();
            });
            thread.Start();
        }

        private void fixVersionButton_Click(object sender, EventArgs e)
        {
            Thread thread = new Thread(() =>
            {
                new FixVersionForm().ShowDialog();
            });
            thread.Start();
        }
    }
}
