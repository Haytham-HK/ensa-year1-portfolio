# TP3 — OpenStack Cinder & Swift

This practical lab documents a **Cloud Computing & Virtualisation** assignment focused on OpenStack storage services.  
The work demonstrates the **Cinder block storage workflow** (volume creation, snapshotting, and reuse) and checks the **Swift/Object Store** availability from the dashboard.

## What was done

1. Created and reviewed a Cinder volume (`tp3-hk-volume`).
2. Created a volume snapshot (`tp3-hk-snap1`).
3. Created a new volume from the snapshot (`tp3-hk-from-snap`).
4. Booted and inspected an instance (`vm-tp3-hk-2`) and opened the SPICE console.
5. Verified admin/system services for Cinder (`cinder-volume`, `cinder-scheduler`).
6. Confirmed that **Object Store** is not available in the project menu in this environment.

## Technologies used

| Category | Technologies |
|---|---|
| Cloud platform | OpenStack |
| Dashboard | Horizon (Web UI) |
| Block storage | Cinder |
| Compute | Nova |
| VM access | SPICE Console |
| System context | Linux-based OpenStack host |

## Screenshots

### 1) Volumes list
![Volumes list](screens/01_dashboard_volumes_list.png)

### 2) Volume details (`tp3-hk-volume`)
![Volume details](screens/02_dashboard_volume_tp3-hk-volume_details.png)

### 3) Snapshots list
![Snapshots list](screens/03_dashboard_snapshots_list.png)

### 4) Volume from snapshot (`tp3-hk-from-snap`)
![Volume from snapshot details](screens/04_dashboard_volume_tp3-hk-from-snap_details.png)

### 5) Instance details (`vm-tp3-hk-2`)
![Instance details](screens/05_dashboard_instance_vm-tp3-hk-2_details.png)

### 6) SPICE console
![SPICE console](screens/06_dashboard_spice_console_vm-tp3-hk-2.png)

### 7) Admin system information
![Admin system information](screens/07_dashboard_admin_system_information.png)

### 8) Admin services view
![Admin services view](screens/08_dashboard_admin_services_view.png)

### 9) Project menu (no Object Store)
![Project menu without object store](screens/09_dashboard_project_menu_no_object_store.png)
