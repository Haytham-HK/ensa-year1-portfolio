# TP4 — OpenStack Nova (Calcul IA / VM)

This practical work documents our OpenStack **Nova** lab for deploying and using a VM for AI-oriented tasks.

## What we done

1. Created and verified an OpenStack instance (`vm-ai-hk`) from Horizon (**Project → Compute → Instances**).
2. Associated a **Floating IP** and connected to the VM with **SSH**.
3. Installed Python libraries and executed a simple linear regression script (`numpy`, `matplotlib`) to generate a result plot.
4. Installed and validated **TensorFlow** and **PyTorch** in the VM environment.
5. Created a VM **snapshot** and confirmed the generated image in Horizon.
6. Checked telemetry services from CLI and Horizon; **Ceilometer/Gnocchi metrics were not available** in this environment.
7. Copied the generated regression plot with **SCP**.

## Technologies used

| Category | Tools / Services |
|---|---|
| Cloud platform | OpenStack |
| Compute | Nova |
| Dashboard | Horizon |
| VM OS | Ubuntu |
| Access | SSH, SCP |
| AI/Python stack | Python 3, NumPy, Matplotlib, TensorFlow, PyTorch |
| CLI checks | OpenStack CLI |

## Screenshots

### 1) Instances list (active VM)
![Instances list](screens%20/01_dashboard_instances_list_active.png)

### 2) VM details (`vm-ai-hk`)
![VM details](screens%20/02_dashboard_instance_vm-ai-hk_details.png)

### 3) Floating IP association
![Floating IP association](screens%20/03_dashboard_floating_ip_association.png)

### 4) SSH connection success
![SSH connection](screens%20/04_ssh_vm_connection_success.png)

### 5) Regression script execution output
![Regression script output](screens%20/05_regression_script_output.png)

### 6) Regression plot generated
![Regression plot](screens%20/06_regression_plot_file_or_display.png)

### 7) TensorFlow installation/version and run result
![TensorFlow result](screens%20/07_tensorflow_version_and_training_result.png)

### 8) PyTorch installation/version and run result
![PyTorch result](screens%20/08_pytorch_version_and_training_result.png)

### 9) Snapshot creation (`vm-ai-hk-snap1`)
![Snapshot creation](screens%20/09_dashboard_snapshot_vm-ai-hk-snap1.png)

### 10) Snapshot image visible in image list
![Image list snapshot](screens%20/10_dashboard_image_list_snapshot_active.png)

### 11) CLI services check (no Ceilometer/Gnocchi)
![No Ceilometer Gnocchi in services](screens%20/11_cli_service_list_no_ceilometer_gnocchi.png)

### 12) Horizon monitoring metrics tab not available
![No monitoring metrics tab](screens%20/12_dashboard_no_monitoring_metrics_tab.png)

### 13) SCP copy of regression plot
![SCP copy plot](screens%20/13_cli_scp_copy_regression_plot.png)
