
namespace HQTCSDL_Group01
{
    partial class SelectVersionForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.Windows.Forms.TableLayoutPanel versionsPanel;
            errorVersionButton = new System.Windows.Forms.Button();
            fixVersionButton = new System.Windows.Forms.Button();
            versionsPanel = new System.Windows.Forms.TableLayoutPanel();
            versionsPanel.SuspendLayout();
            SuspendLayout();
            // 
            // versionsPanel
            // 
            versionsPanel.ColumnCount = 1;
            versionsPanel.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            versionsPanel.Controls.Add(errorVersionButton, 0, 0);
            versionsPanel.Controls.Add(fixVersionButton, 0, 1);
            versionsPanel.Dock = System.Windows.Forms.DockStyle.Fill;
            versionsPanel.Location = new System.Drawing.Point(0, 0);
            versionsPanel.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            versionsPanel.Name = "versionsPanel";
            versionsPanel.RowCount = 2;
            versionsPanel.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            versionsPanel.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            versionsPanel.Size = new System.Drawing.Size(700, 338);
            versionsPanel.TabIndex = 0;
            // 
            // errorVersionButton
            // 
            errorVersionButton.BackColor = System.Drawing.Color.FromArgb(241, 114, 40);
            errorVersionButton.Dock = System.Windows.Forms.DockStyle.Fill;
            errorVersionButton.Font = new System.Drawing.Font("Segoe UI", 20F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            errorVersionButton.ForeColor = System.Drawing.Color.White;
            errorVersionButton.Location = new System.Drawing.Point(3, 2);
            errorVersionButton.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            errorVersionButton.Name = "errorVersionButton";
            errorVersionButton.Size = new System.Drawing.Size(694, 165);
            errorVersionButton.TabIndex = 0;
            errorVersionButton.Text = "Phiên bản lỗi";
            errorVersionButton.UseVisualStyleBackColor = false;
            errorVersionButton.Click += errorVersionButton_Click;
            // 
            // fixVersionButton
            // 
            fixVersionButton.BackColor = System.Drawing.Color.FromArgb(241, 114, 40);
            fixVersionButton.Dock = System.Windows.Forms.DockStyle.Fill;
            fixVersionButton.Font = new System.Drawing.Font("Segoe UI", 20F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            fixVersionButton.ForeColor = System.Drawing.Color.White;
            fixVersionButton.Location = new System.Drawing.Point(3, 171);
            fixVersionButton.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            fixVersionButton.Name = "fixVersionButton";
            fixVersionButton.Size = new System.Drawing.Size(694, 165);
            fixVersionButton.TabIndex = 1;
            fixVersionButton.Text = "Phiên bản sửa lỗi";
            fixVersionButton.UseVisualStyleBackColor = false;
            fixVersionButton.Click += fixVersionButton_Click;
            // 
            // SelectVersionForm
            // 
            AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            ClientSize = new System.Drawing.Size(700, 338);
            Controls.Add(versionsPanel);
            Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            Name = "SelectVersionForm";
            Text = "Chọn phiên bản";
            versionsPanel.ResumeLayout(false);
            ResumeLayout(false);
        }

        #endregion

        private System.Windows.Forms.Button errorVersionButton;
        private System.Windows.Forms.Button fixVersionButton;
    }
}