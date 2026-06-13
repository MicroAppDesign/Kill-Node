<#
.SYNOPSIS
Stop one or more running Node.js processes on Windows.
#>

# Show a message to the user before checking running Node.js processes.
Write-Host "Checking for Node.js processes..."

# Find all processes with the name "node" without showing an error if none exist.
$nodeProcesses = Get-Process -Name node -ErrorAction SilentlyContinue

# If no node processes are found, notify and stop the script.
if (-not $nodeProcesses) {
    Write-Host "No Node.js processes found." -ForegroundColor Green
    Read-Host "Press Enter to close..."
    return
}

# Display the list of found Node.js processes for the user.
Write-Host "Found the following Node.js processes:" -ForegroundColor Yellow
for ($i = 0; $i -lt $nodeProcesses.Count; $i++) {
    $proc = $nodeProcesses[$i]
    Write-Host "{0}. {1} (PID {2}) Started: {3}" -f ($i + 1), $proc.ProcessName, $proc.Id, $proc.StartTime
}

# Ask the user to choose one process, kill all, or quit.
$selection = Read-Host "Enter process number to kill, A=all, Q=quit"

if ($selection -match '^[Qq]$') {
    Write-Host "Aborted. No processes were stopped." -ForegroundColor Cyan
    Read-Host "Press Enter to close..."
    return
}

if ($selection -match '^[Aa]$') {
    Write-Host "Stopping all Node.js processes..." -ForegroundColor Green
    $nodeProcesses | Stop-Process -Force
    Write-Host "All Node.js processes have been terminated." -ForegroundColor Green
    Read-Host "Press Enter to close..."
    return
}

if ($selection -match '^[0-9]+$') {
    $index = [int]$selection - 1
    if ($index -lt 0 -or $index -ge $nodeProcesses.Count) {
        Write-Host "Invalid selection. Please choose a valid process number." -ForegroundColor Red
        Read-Host "Press Enter to close..."
        return
    }

    $chosen = $nodeProcesses[$index]
    Write-Host "Stopping Node.js process PID $($chosen.Id)..." -ForegroundColor Green
    Stop-Process -Id $chosen.Id -Force
    Write-Host "Process PID $($chosen.Id) has been terminated." -ForegroundColor Green
    Read-Host "Press Enter to close..."
    return
}

Write-Host "Invalid input. Please run the script again and enter a number, A, or Q." -ForegroundColor Red
Read-Host "Press Enter to close..."
