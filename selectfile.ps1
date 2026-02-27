Add-Type -AssemblyName System.Windows.Forms

$form = New-Object System.Windows.Forms.Form
$form.Text = "Metatrader 5 Configure"
$form.Size = New-Object System.Drawing.Size(400, 150)
$form.StartPosition = "CenterScreen"

$label = New-Object System.Windows.Forms.Label
$label.Text = "Please select Metatrader 5 Executable(*.exe)"
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(10, 8)
$form.Controls.Add($label)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10, 26)
$textBox.Width = 280
$form.Controls.Add($textBox)

$buttonBrowse = New-Object System.Windows.Forms.Button
$buttonBrowse.Text = "Browse"
$buttonBrowse.Location = New-Object System.Drawing.Point(290, 23)
$buttonBrowse.Add_Click({
        $openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
        $openFileDialog.Filter = "Executables (*.exe)|*.exe"
        if ($openFileDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
            $textBox.Text = $openFileDialog.FileName
        }
    })
$form.Controls.Add($buttonBrowse)

$buttonOK = New-Object System.Windows.Forms.Button
$buttonOK.Text = "OK"
$buttonOK.Location = New-Object System.Drawing.Point(112, 80)
$buttonOK.Add_Click({
        if ([string]::IsNullOrWhiteSpace($textBox.Text)) {
            [System.Windows.Forms.MessageBox]::Show("Please select Metatrader executable")
        }
        else {
            Write-Host "$($textBox.Text)"
            $form.Close()
        }
    })

$form.Controls.Add($buttonOK)
$buttonCancel = New-Object System.Windows.Forms.Button
$buttonCancel.Text = "Cancel"
$buttonCancel.Location = New-Object System.Drawing.Point(190, 80)
$buttonCancel.Add_Click({ $form.Close() })
$form.Controls.Add($buttonCancel)

$form.Add_Shown({ $form.Activate() })
[void]$form.ShowDialog()
