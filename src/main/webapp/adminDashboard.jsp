<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | User & Agent Management</title>

    <!-- CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.32/dist/sweetalert2.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/datatables.net-bs5@1.13.6/css/dataTables.bootstrap5.min.css">

    <style>
        :root {
            --primary-dark: #0A192F;
            --primary-medium: #112240;
            --primary-light: #1E3A8A;
            --accent-blue: #3B82F6;
            --accent-cyan: #06B6D4;
            --accent-green: #10B981;
            --accent-red: #EF4444;
            --accent-yellow: #F59E0B;
            --text-white: #F8FAFC;
            --text-light: #CBD5E1;
            --text-muted: #94A3B8;
            --border-color: rgba(203, 213, 225, 0.1);
            --gradient-start: rgba(10, 25, 47, 0.95);
            --gradient-end: rgba(17, 34, 64, 0.95);
            --sidebar-width: 250px;
            --header-height: 60px;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, var(--gradient-start), var(--gradient-end));
            color: var(--text-light);
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* Layout Components */
        .admin-wrapper {
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            width: var(--sidebar-width);
            background: var(--primary-medium);
            border-right: 1px solid var(--border-color);
            position: fixed;
            height: 100vh;
            z-index: 1000;
            overflow-y: auto;
            transition: all 0.3s ease;
        }

        .sidebar.collapsed {
            width: 70px;
        }

        .main-content {
            flex: 1;
            margin-left: var(--sidebar-width);
            transition: all 0.3s ease;
            padding: calc(var(--header-height) + 20px) 20px 20px;
            position: relative;
        }

        .main-content.expanded {
            margin-left: 70px;
        }

        .header {
            height: var(--header-height);
            background: var(--primary-dark);
            border-bottom: 1px solid var(--border-color);
            display: flex;
            align-items: center;
            padding: 0 20px;
            position: fixed;
            top: 0;
            right: 0;
            left: var(--sidebar-width);
            z-index: 999;
            transition: all 0.3s ease;
        }

        .header.expanded {
            left: 70px;
        }

        /* Sidebar Components */
        .sidebar-header {
            padding: 20px 15px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid var(--border-color);
        }

        .logo-container {
            display: flex;
            align-items: center;
        }

        .logo-text {
            color: var(--text-white);
            font-weight: 700;
            font-size: 1.25rem;
            margin-left: 10px;
            transition: opacity 0.3s ease;
        }

        .sidebar.collapsed .logo-text {
            display: none;
        }

        .nav-menu {
            list-style: none;
            padding: 0;
            margin: 15px 0;
        }

        .nav-item {
            margin: 5px 0;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            color: var(--text-light);
            text-decoration: none;
            border-left: 3px solid transparent;
            transition: all 0.3s ease;
        }

        .nav-link i {
            font-size: 1.1rem;
            margin-right: 10px;
            min-width: 20px;
            text-align: center;
        }

        .nav-link:hover, .nav-link.active {
            background: rgba(30, 58, 138, 0.3);
            color: var(--text-white);
            border-left-color: var(--accent-blue);
        }

        .nav-text {
            transition: opacity 0.3s ease;
        }

        .sidebar.collapsed .nav-text {
            display: none;
        }

        .sidebar-footer {
            padding: 15px;
            border-top: 1px solid var(--border-color);
            font-size: 0.75rem;
            color: var(--text-muted);
            text-align: center;
            transition: all 0.3s ease;
        }

        .sidebar.collapsed .sidebar-footer {
            display: none;
        }

        /* Content Components */
        .content-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .page-title {
            color: var(--text-white);
            font-weight: 600;
            margin: 0;
        }

        .content-card {
            background: rgba(17, 34, 64, 0.7);
            border-radius: 12px;
            border: 1px solid var(--border-color);
            margin-bottom: 20px;
            overflow: hidden;
            backdrop-filter: blur(10px);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .content-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }

        .card-header {
            background: rgba(30, 58, 138, 0.3);
            padding: 15px 20px;
            border-bottom: 1px solid var(--border-color);
            font-weight: 600;
            color: var(--text-white);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-body {
            padding: 20px;
        }

        /* Dashboard Widgets */
        .stat-widget {
            background: rgba(30, 58, 138, 0.3);
            border-radius: 12px;
            border: 1px solid var(--border-color);
            padding: 20px;
            height: 100%;
            position: relative;
            overflow: hidden;
            transition: transform 0.3s ease;
        }

        .stat-widget:hover {
            transform: translateY(-5px);
        }

        .stat-widget .icon {
            position: absolute;
            top: -10px;
            right: -10px;
            font-size: 5rem;
            opacity: 0.1;
            color: var(--text-white);
        }

        .stat-widget .counter {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--text-white);
        }

        .stat-widget .label {
            font-size: 1rem;
            color: var(--text-muted);
        }

        .stat-widget .change {
            display: flex;
            align-items: center;
            margin-top: 10px;
            font-size: 0.875rem;
        }

        .stat-widget .change i {
            margin-right: 5px;
        }

        .change.positive {
            color: var(--accent-green);
        }

        .change.negative {
            color: var(--accent-red);
        }

        /* Forms & Inputs */
        .form-control, .form-select {
            background: rgba(10, 25, 47, 0.5);
            border: 1px solid var(--border-color);
            color: var(--text-white);
            border-radius: 8px;
            padding: 0.75rem 1rem;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--accent-cyan);
            box-shadow: 0 0 0 2px rgba(6, 182, 212, 0.2);
            background: rgba(10, 25, 47, 0.7);
            color: var(--text-white);
        }

        .form-control::placeholder {
            color: var(--text-muted);
        }

        /* Button Styling */
        .btn-primary {
            background: linear-gradient(135deg, var(--accent-blue), var(--accent-cyan));
            border: none;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, var(--accent-cyan), var(--accent-blue));
        }

        .btn-success {
            background: var(--accent-green);
            border: none;
        }

        .btn-danger {
            background: var(--accent-red);
            border: none;
        }

        .btn-warning {
            background: var(--accent-yellow);
            border: none;
        }

        .btn-action {
            width: 32px;
            height: 32px;
            padding: 0;
            border-radius: 6px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s ease;
            margin-right: 5px;
        }

        /* Table Styling */
        .table {
            color: var(--text-light);
            margin-bottom: 0;
        }

        .table th {
            font-weight: 600;
            color: var(--text-white);
            border-bottom-color: var(--border-color);
        }

        .table td {
            border-color: var(--border-color);
            vertical-align: middle;
        }

        /* Status Badges */
        .badge {
            padding: 5px 10px;
            font-weight: 500;
            border-radius: 20px;
        }

        .badge-active {
            background-color: rgba(16, 185, 129, 0.2);
            color: var(--accent-green);
            border: 1px solid rgba(16, 185, 129, 0.3);
        }

        .badge-inactive {
            background-color: rgba(239, 68, 68, 0.2);
            color: var(--accent-red);
            border: 1px solid rgba(239, 68, 68, 0.3);
        }

        .badge-pending {
            background-color: rgba(245, 158, 11, 0.2);
            color: var(--accent-yellow);
            border: 1px solid rgba(245, 158, 11, 0.3);
        }

        /* Modal Styling */
        .modal-content {
            background: var(--primary-medium);
            color: var(--text-light);
            border: 1px solid var(--border-color);
            border-radius: 12px;
        }

        .modal-header {
            border-bottom-color: var(--border-color);
            background: rgba(30, 58, 138, 0.3);
        }

        .modal-footer {
            border-top-color: var(--border-color);
        }

        /* User/Agent Card */
        .user-card {
            background: var(--primary-dark);
            border-radius: 12px;
            border: 1px solid var(--border-color);
            padding: 20px;
            height: 100%;
            transition: transform 0.3s ease;
        }

        .user-card:hover {
            transform: translateY(-5px);
        }

        .user-avatar {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--accent-blue), var(--accent-cyan));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2rem;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .user-name {
            color: var(--text-white);
            font-weight: 600;
            font-size: 1.1rem;
            margin-bottom: 5px;
        }

        .user-role {
            color: var(--accent-blue);
            font-size: 0.875rem;
            margin-bottom: 15px;
        }

        .user-info {
            margin-bottom: 15px;
        }

        .user-info-item {
            display: flex;
            margin-bottom: 8px;
            font-size: 0.875rem;
        }

        .user-info-label {
            color: var(--text-muted);
            width: 80px;
        }

        .user-info-value {
            color: var(--text-light);
        }

        .user-actions {
            display: flex;
            justify-content: space-between;
        }

        /* DataTables Overrides */
        .dataTables_wrapper .dataTables_length, 
        .dataTables_wrapper .dataTables_filter, 
        .dataTables_wrapper .dataTables_info, 
        .dataTables_wrapper .dataTables_processing, 
        .dataTables_wrapper .dataTables_paginate {
            color: var(--text-light);
        }

        .dataTables_wrapper .dataTables_length select, 
        .dataTables_wrapper .dataTables_filter input {
            background: rgba(10, 25, 47, 0.5);
            border: 1px solid var(--border-color);
            color: var(--text-white);
            border-radius: 8px;
            padding: 5px 10px;
        }

        .dataTables_wrapper .dataTables_paginate .paginate_button {
            color: var(--text-light) !important;
            border: 1px solid var(--border-color);
            background: rgba(10, 25, 47, 0.5);
            border-radius: 4px;
            margin: 0 2px;
        }

        .dataTables_wrapper .dataTables_paginate .paginate_button.current {
            background: var(--accent-blue) !important;
            border-color: var(--accent-blue) !important;
            color: white !important;
        }

        .dataTables_wrapper .dataTables_paginate .paginate_button:hover {
            background: var(--accent-blue) !important;
            border-color: var(--accent-blue) !important;
            color: white !important;
        }

        /* Animation Classes */
        .fade-in {
            animation: fadeIn 0.5s forwards;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Media Queries */
        @media (max-width: 991.98px) {
            .sidebar {
                transform: translateX(-100%);
                position: fixed;
                z-index: 1040;
            }
            
            .sidebar.mobile-active {
                transform: translateX(0);
            }
            
            .main-content, .header {
                margin-left: 0 !important;
                left: 0;
                width: 100%;
            }
            
            .toggle-sidebar-btn {
                display: block;
            }
        }
        
        @media (max-width: 767.98px) {
            .user-actions .btn {
                padding: 0.25rem 0.5rem;
                font-size: 0.875rem;
            }
            
            .content-header {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .content-header .btn {
                margin-top: 10px;
            }
        }
        
        /* Animations and effects */
        .pulse {
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% {
                box-shadow: 0 0 0 0 rgba(59, 130, 246, 0.4);
            }
            70% {
                box-shadow: 0 0 0 10px rgba(59, 130, 246, 0);
            }
            100% {
                box-shadow: 0 0 0 0 rgba(59, 130, 246, 0);
            }
        }
        
        .spin {
            animation: spin 2s linear infinite;
        }
        
        @keyframes spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }
        
        /* User Status Indicator */
        .status-indicator {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            display: inline-block;
            margin-right: 5px;
        }
        
        .status-active {
            background-color: var(--accent-green);
            box-shadow: 0 0 5px var(--accent-green);
        }
        
        .status-inactive {
            background-color: var(--accent-red);
        }
        
        .status-pending {
            background-color: var(--accent-yellow);
        }
    </style>
</head>

<body>
    <div class="admin-wrapper">
        <!-- Sidebar Navigation -->
        <aside class="sidebar" id="sidebar">
            <div class="sidebar-header">
                <div class="logo-container">
                    <i class="bi bi-shield-lock-fill text-primary fs-4"></i>
                    <span class="logo-text">Admin Panel</span>
                </div>
                <button class="btn btn-sm text-light d-none d-lg-block" id="toggleSidebar">
                    <i class="bi bi-chevron-left"></i>
                </button>
            </div>
            
            <ul class="nav-menu">
                <li class="nav-item">
                    <a href="#" class="nav-link active" data-page="dashboard">
                        <i class="bi bi-speedometer2"></i>
                        <span class="nav-text">Dashboard</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link" data-page="users">
                        <i class="bi bi-people-fill"></i>
                        <span class="nav-text">User Management</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link" data-page="agents">
                        <i class="bi bi-person-badge-fill"></i>
                        <span class="nav-text">Agent Management</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="bi bi-graph-up"></i>
                        <span class="nav-text">Analytics</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="bi bi-gear-fill"></i>
                        <span class="nav-text">Settings</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="bi bi-box-arrow-right"></i>
                        <span class="nav-text">Logout</span>
                    </a>
                </li>
            </ul>
            
            <div class="sidebar-footer">
                <p>&copy; 2025 Admin System</p>
                <p>Version 1.0.0</p>
            </div>
        </aside>

        <!-- Main Content Area -->
        <div class="main-content" id="mainContent">
            <!-- Header -->
            <header class="header" id="header">
                <div class="d-flex align-items-center me-auto">
                    <button class="btn btn-sm text-light d-lg-none me-3" id="mobileSidebarToggle">
                        <i class="bi bi-list fs-5"></i>
                    </button>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb mb-0">
                            <li class="breadcrumb-item"><a href="#" class="text-decoration-none text-info">Home</a></li>
                            <li class="breadcrumb-item active" id="currentPage" aria-current="page">Dashboard</li>
                        </ol>
                    </nav>
                </div>

                <div class="d-flex align-items-center">
                    <div class="me-3">
                        <span><i class="bi bi-clock me-1"></i> <%= "2025-03-28 08:45:43" %> (UTC)</span>
                    </div>
                    <div class="dropdown">
                        <button class="btn btn-link text-decoration-none text-light dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-person-circle fs-5 me-2"></i>
                            <span><%= "IT24103866" %></span>
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end" style="background: var(--primary-medium);">
                            <li><a class="dropdown-item text-light" href="#"><i class="bi bi-person-fill me-2"></i>Profile</a></li>
                            <li><a class="dropdown-item text-light" href="#"><i class="bi bi-gear me-2"></i>Settings</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-light" href="#"><i class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
                        </ul>
                    </div>
                </div>
            </header>

            <!-- Dashboard Content -->
            <div id="dashboardContent" class="content-section fade-in">
                <div class="content-header">
                    <h2 class="page-title">Dashboard Overview</h2>
                    <button class="btn btn-primary pulse">
                        <i class="bi bi-arrow-clockwise me-2"></i> Refresh Data
                    </button>
                </div>
                
                <!-- Stats Overview -->
                <div class="row g-3 mb-4">
                    <div class="col-md-6 col-xl-3">
                        <div class="stat-widget">
                            <i class="bi bi-people-fill icon"></i>
                            <div class="counter">2,581</div>
                            <div class="label">Total Users</div>
                            <div class="change positive">
                                <i class="bi bi-arrow-up"></i> 12% from last month
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-xl-3">
                        <div class="stat-widget">
                            <i class="bi bi-person-badge-fill icon"></i>
                            <div class="counter">87</div>
                            <div class="label">Active Agents</div>
                            <div class="change positive">
                                <i class="bi bi-arrow-up"></i> 5% from last month
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-xl-3">
                        <div class="stat-widget">
                            <i class="bi bi-check-circle-fill icon"></i>
                            <div class="counter">94%</div>
                            <div class="label">User Satisfaction</div>
                            <div class="change positive">
                                <i class="bi bi-arrow-up"></i> 3% from last month
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-xl-3">
                        <div class="stat-widget">
                            <i class="bi bi-exclamation-triangle-fill icon"></i>
                            <div class="counter">7</div>
                            <div class="label">Active Issues</div>
                            <div class="change negative">
                                <i class="bi bi-arrow-up"></i> 2 new since yesterday
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recent Activity Card -->
                <div class="row g-3 mb-4">
                    <div class="col-md-7">
                        <div class="content-card h-100">
                            <div class="card-header">
                                <div>Recent Activity</div>
                                <button class="btn btn-sm btn-outline-light">
                                    View All
                                </button>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>User</th>
                                                <th>Action</th>
                                                <th>Time</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>John Smith</td>
                                                <td>Created new user account</td>
                                                <td>Today, 08:15</td>
                                                <td><span class="badge badge-active">Completed</span></td>
                                            </tr>
                                            <tr>
                                                <td>Sarah Johnson</td>
                                                <td>Updated agent profile</td>
                                                <td>Today, 07:42</td>
                                                <td><span class="badge badge-active">Completed</span></td>
                                            </tr>
                                            <tr>
                                                <td>Michael Brown</td>
                                                <td>Password reset</td>
                                                <td>Yesterday, 16:30</td>
                                                <td><span class="badge badge-pending">Pending</span></td>
                                            </tr>
                                            <tr>
                                                <td>Emily Davis</td>
                                                <td>Deactivated account</td>
                                                <td>Yesterday, 15:10</td>
                                                <td><span class="badge badge-inactive">Cancelled</span></td>
                                            </tr>
                                            <tr>
                                                <td>Robert Wilson</td>
                                                <td>Permission update</td>
                                                <td>Yesterday, 14:05</td>
                                                <td><span class="badge badge-active">Completed</span></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-5">
                        <div class="content-card h-100">
                            <div class="card-header">
                                <div>System Notifications</div>
                                <button class="btn btn-sm btn-outline-light">
                                    Mark All Read
                                </button>
                            </div>
                            <div class="card-body p-0">
                                <div class="list-group list-group-flush" style="background: transparent;">
                                    <div class="list-group-item border-bottom" style="background: transparent; border-color: var(--border-color);">
                                        <div class="d-flex">
                                            <div class="me-3">
                                                <div class="bg-danger rounded-circle d-flex justify-content-center align-items-center" 
                                                    style="width: 40px; height: 40px;">
                                                    <i class="bi bi-exclamation-triangle-fill text-white"></i>
                                                </div>
                                            </div>
                                            <div>
                                                <h6 class="mb-1 text-white">System Alert</h6>
                                                <p class="mb-1 small">Unusual login activity detected from IP 203.45.67.89</p>
                                                <small class="text-muted">2 hours ago</small>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="list-group-item border-bottom" style="background: transparent; border-color: var(--border-color);">
                                        <div class="d-flex">
                                            <div class="me-3">
                                                <div class="bg-warning rounded-circle d-flex justify-content-center align-items-center" 
                                                    style="width: 40px; height: 40px;">
                                                    <i class="bi bi-info-circle-fill text-white"></i>
                                                </div>
                                            </div>
                                            <div>
                                                <h6 class="mb-1 text-white">Maintenance Notice</h6>
                                                <p class="mb-1 small">Scheduled maintenance in 24 hours. System may be unavailable for 30 minutes.</p>
                                                <small class="text-muted">5 hours ago</small>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="list-group-item border-bottom" style="background: transparent; border-color: var(--border-color);">
                                        <div class="d-flex">
                                            <div class="me-3">
                                                <div class="bg-success rounded-circle d-flex justify-content-center align-items-center" 
                                                    style="width: 40px; height: 40px;">
                                                    <i class="bi bi-check-circle-fill text-white"></i>
                                                </div>
                                            </div>
                                            <div>
                                                <h6 class="mb-1 text-white">Update Successful</h6>
                                                <p class="mb-1 small">User management system updated to version 2.4.1</p>
                                                <small class="text-muted">Yesterday</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Stats -->
                <div class="row g-3">
                    <div class="col-md-4">
                        <div class="content-card h-100">
                            <div class="card-header">
                                User Distribution
                            </div>
                            <div class="card-body">
                                <canvas id="userDistributionChart" height="200"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="content-card h-100">
                            <div class="card-header">
                                User Registration
                            </div>
                            <div class="card-body">
                                <canvas id="userRegistrationChart" height="200"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="content-card h-100">
                            <div class="card-header">
                                Quick Actions
                            </div>
                            <div class="card-body">
                                <div class="mb-3">
                                    <button class="btn btn-primary w-100 mb-3">
                                        <i class="bi bi-person-plus-fill me-2"></i>Add New User
                                    </button>
                                    <button class="btn btn-success w-100 mb-3">
                                        <i class="bi bi-person-badge-fill me-2"></i>Add New Agent
                                    </button>
                                    <button class="btn btn-info w-100 mb-3">
                                        <i class="bi bi-file-earmark-pdf-fill me-2"></i>Export Reports
                                    </button>
                                    <button class="btn btn-warning w-100">
                                        <i class="bi bi-gear-fill me-2"></i>System Settings
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- User Management Content -->
            <div id="usersContent" class="content-section d-none">
                <div class="content-header">
                    <h2 class="page-title">User Management</h2>
                    <div>
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUserModal">
                            <i class="bi bi-person-plus-fill me-2"></i>Add New User
                        </button>
                    </div>
                </div>

                <div class="content-card mb-4">
                    <div class="card-header">
                        <div>All Users</div>
                        <div>
                            <button class="btn btn-sm btn-outline-light me-2">
                                <i class="bi bi-filter me-1"></i>Filter
                            </button>
                            <button class="btn btn-sm btn-outline-light">
                                <i class="bi bi-download me-1"></i>Export
                            </button>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table id="usersTable" class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Role</th>
                                        <th>Status</th>
                                        <th>Last Login</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>USR001</td>
                                        <td>John Smith</td>
                                        <td>john.smith@example.com</td>
                                        <td>Admin</td>
                                        <td><span class="status-indicator status-active"></span> Active</td>
                                        <td>2025-03-28 06:30:12</td>
                                        <td>
                                            <button class="btn btn-sm btn-info btn-action" data-bs-toggle="modal" data-bs-target="#editUserModal">
                                                <i class="bi bi-pencil-fill"></i>
                                            </button>
                                            <button class="btn btn-sm btn-warning btn-action" data-bs-toggle="modal" data-bs-target="#resetPasswordModal">
                                                <i class="bi bi-key-fill"></i>
                                            </button>
                                            <button class="btn btn-sm btn-danger btn-action delete-user-btn" data-user-id="USR001">
                                                <i class="bi bi-trash-fill"></i>
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>USR002</td>
                                        <td>Sarah Johnson</td>
                                        <td>sarah.j@example.com</td>
                                        <td>User</td>
                                        <td><span class="status-indicator status-active"></span> Active</td>
                                        <td>2025-03-28 05:45:36</td>
                                        <td>
                                            <button class="btn btn-sm btn-info btn-action" data-bs-toggle="modal" data-bs-target="#editUserModal">
                                                <i class="bi bi-pencil-fill"></i>
                                            </button>
                                            <button class="btn btn-sm btn-warning btn-action" data-bs-toggle="modal" data-bs-target="#resetPasswordModal">
                                                <i class="bi bi-key-fill"></i>
                                            </button>
                                            <button class="btn btn-sm btn-danger btn-action delete-user-btn" data-user-id="USR002">
                                                <i class="bi bi-trash-fill"></i>
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>USR003</td>
                                        <td>Michael Brown</td>
                                        <td>michael.brown@example.com</td>
                                        <td>User</td>
                                        <td><span class="status-indicator status-inactive"></span> Inactive</td>
                                        <td>2025-03-27 14:22:09</td>
                                        <td>
                                            <button class="btn btn-sm btn-info btn-action" data-bs-toggle="modal" data-bs-target="#editUserModal">
                                                <i class="bi bi-pencil-fill"></i>
                                            </button>
                                            <button class="btn btn-sm btn-warning btn-action" data-bs-toggle="modal" data-bs-target="#resetPasswordModal">
                                                <i class="bi bi-key-fill"></i>
                                            </button>
                                            <button class="btn btn-sm btn-danger btn-action delete-user-btn" data-user-id="USR003">
                                                <i class="bi bi-trash-fill"></i>
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>USR004</td>
                                        <td>Emily Davis</td>
                                        <td>emily.d@example.com</td>
                                        <td>User</td>
                                        <td><span class="status-indicator status-pending"></span> Pending</td>
                                        <td>2025-03-28 02:15:48</td>
                                        <td>
                                            <button class="btn btn-sm btn-info btn-action" data-bs-toggle="modal" data-bs-target="#editUserModal">
                                                <i class="bi bi-pencil-fill"></i>
                                            </button>
                                            <button class="btn btn-sm btn-warning btn-action" data-bs-toggle="modal" data-bs-target="#resetPasswordModal">
                                                <i class="bi bi-key-fill"></i>
                                            </button>
                                            <button class="btn btn-sm btn-danger btn-action delete-user-btn" data-user-id="USR004">
                                                <i class="bi bi-trash-fill"></i>
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>USR005</td>
                                        <td>Robert Wilson</td>
                                        <td>robert.w@example.com</td>
                                        <td>Admin</td>
                                        <td><span class="status-indicator status-active"></span> Active</td>
                                        <td>2025-03-27 23:10:57</td>
                                        <td>
                                            <button class="btn btn-sm btn-info btn-action" data-bs-toggle="modal" data-bs-target="#editUserModal">
                                                <i class="bi bi-pencil-fill"></i>
                                            </button>
                                            <button class="btn btn-sm btn-warning btn-action" data-bs-toggle="modal" data-bs-target="#resetPasswordModal">
                                                <i class="bi bi-key-fill"></i>
                                            </button>
                                            <button class="btn btn-sm btn-danger btn-action delete-user-btn" data-user-id="USR005">
                                                <i class="bi bi-trash-fill"></i>
                                            </button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Agent Management Content -->
            <div id="agentsContent" class="content-section d-none">
                <div class="content-header">
                    <h2 class="page-title">Agent Management</h2>
                    <div>
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addAgentModal">
                            <i class="bi bi-person-plus-fill me-2"></i>Add New Agent
                        </button>
                    </div>
                </div>

                <div class="content-card mb-4">
                    <div class="card-header">
                        <div>All Agents</div>
                        <div>
                            <button class="btn btn-sm btn-outline-light me-2">
                                <i class="bi bi-filter me-1"></i>Filter
                            </button>
                            <button class="btn btn-sm btn-outline-light">
                                <i class="bi bi-download me-1"></i>Export
                            </button>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table id="agentsTable" class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Name</th>
                                        <th>Department</th>
                                        <th>Performance</th>
                                        <th>Status</th>
                                        <th>Cases Handled</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>AGT001</td>
                                        <td>David Miller</td>
                                        <td>Customer Support</td>
                                        <td>
                                            <div class="progress" style="height: 8px; width: 100px;">
                                                <div class="progress-bar bg-success" role="progressbar" style="width: 92%" aria-valuenow="92" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                            <small>92%</small>
                                        </td>
                                        <td><span class="status-indicator status-active"></span> Online</td>
                                        <td>325</td>
                                        <td>
                                            <button class="btn btn-sm btn-info btn-action" data-bs-toggle="modal" data-bs-target="#editAgentModal">
                                                <i class="bi bi-pencil-fill"></i>
                                            </button>
                                            <button class="btn btn-sm btn-primary btn-action" data-bs-toggle="modal" data-bs-target="#viewPerformanceModal">
                                                <i class="bi bi-graph-up"></i>
                                            </button>
                                            <button class="btn btn-sm btn-danger btn-action delete-agent-btn" data-agent-id="AGT001">
                                                <i class="bi bi-trash-fill"></i>
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>AGT002</td>
                                        <td>Jennifer Lee</td>
                                        <td>Technical Support</td>
                                        <td>
                                            <div class="progress" style="height: 8px; width: 100px;">
                                                <div class="progress-bar bg-info" role="progressbar" style="width: 78%" aria-valuenow="78" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                            <small>78%</small>
                                        </td>
                                        <td><span class="status-indicator status-active"></span> Online</td>
                                        <td>218</td>
                                        <td>
                                            <button class="btn btn-sm btn-info btn-action" data-bs-toggle="modal" data-bs-target="#editAgentModal">
                                                <i class="bi bi-pencil-fill"></i>
                                            </button>
                                            <button class="btn btn-sm btn-primary btn-action" data-bs-toggle="modal" data-bs-target="#viewPerformanceModal">
                                                <i class="bi bi-graph-up"></i>
                                            </button>
                                            <button class="btn btn-sm btn-danger btn-action delete-agent-btn" data-agent-id="AGT002">
                                                <i class="bi bi-trash-fill"></i>
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>AGT003</td>
                                        <td>Richard Taylor</td>
                                        <td>Sales</td>
                                        <td>
                                            <div class="progress" style="height: 8px; width: 100px;">
                                                <div class="progress-bar bg-warning" role="progressbar" style="width: 65%" aria-valuenow="65" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                            <small>65%</small>
                                        </td>
                                        <td><span class="status-indicator status-inactive"></span> Offline</td>
                                        <td>175</td>
                                        <td>
                                            <button class="btn btn-sm btn-info btn-action" data-bs-toggle="modal" data-bs-target="#editAgentModal">
                                                <i class="bi bi-pencil-fill"></i>
                                            </button>
                                            <button class="btn btn-sm btn-primary btn-action" data-bs-toggle="modal" data-bs-target="#viewPerformanceModal">
                                                <i class="bi bi-graph-up"></i>
                                            </button>
                                            <button class="btn btn-sm btn-danger btn-action delete-agent-btn" data-agent-id="AGT003">
                                                <i class="bi bi-trash-fill"></i>
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>AGT004</td>
                                        <td>Susan Martinez</td>
                                        <td>Customer Support</td>
                                        <td>
                                            <div class="progress" style="height: 8px; width: 100px;">
                                                <div class="progress-bar bg-success" role="progressbar" style="width: 88%" aria-valuenow="88" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                            <small>88%</small>
                                        </td>
                                        <td><span class="status-indicator status-active"></span> Online</td>
                                        <td>287</td>
                                        <td>
                                            <button class="btn btn-sm btn-info btn-action" data-bs-toggle="modal" data-bs-target="#editAgentModal">
                                                <i class="bi bi-pencil-fill"></i>
                                            </button>
                                            <button class="btn btn-sm btn-primary btn-action" data-bs-toggle="modal" data-bs-target="#viewPerformanceModal">
                                                <i class="bi bi-graph-up"></i>
                                            </button>
                                            <button class="btn btn-sm btn-danger btn-action delete-agent-btn" data-agent-id="AGT004">
                                                <i class="bi bi-trash-fill"></i>
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>AGT005</td>
                                        <td>Thomas Anderson</td>
                                        <td>Technical Support</td>
                                        <td>
                                            <div class="progress" style="height: 8px; width: 100px;">
                                                <div class="progress-bar bg-danger" role="progressbar" style="width: 55%" aria-valuenow="55" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                            <small>55%</small>
                                        </td>
                                        <td><span class="status-indicator status-pending"></span> Away</td>
                                        <td>124</td>
                                        <td>
                                            <button class="btn btn-sm btn-info btn-action" data-bs-toggle="modal" data-bs-target="#editAgentModal">
                                                <i class="bi bi-pencil-fill"></i>
                                            </button>
                                            <button class="btn btn-sm btn-primary btn-action" data-bs-toggle="modal" data-bs-target="#viewPerformanceModal">
                                                <i class="bi bi-graph-up"></i>
                                            </button>
                                            <button class="btn btn-sm btn-danger btn-action delete-agent-btn" data-agent-id="AGT005">
                                                <i class="bi bi-trash-fill"></i>
                                            </button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- MODALS -->
    <!-- Add User Modal -->
    <div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addUserModalLabel">Add New User</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="addUserForm">
                        <div class="mb-3">
                            <label for="firstName" class="form-label">First Name</label>
                            <input type="text" class="form-control" id="firstName" required>
                        </div>
                        <div class="mb-3">
                            <label for="lastName" class="form-label">Last Name</label>
                            <input type="text" class="form-control" id="lastName" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email Address</label>
                            <input type="email" class="form-control" id="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="role" class="form-label">Role</label>
                            <select class="form-select" id="role" required>
                                <option value="">Select a role</option>
                                <option value="Admin">Administrator</option>
                                <option value="User">Regular User</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" required>
                        </div>
                        <div class="mb-3">
                            <label for="confirmPassword" class="form-label">Confirm Password</label>
                            <input type="password" class="form-control" id="confirmPassword" required>
                        </div>
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="sendWelcomeEmail">
                            <label class="form-check-label" for="sendWelcomeEmail">Send welcome email</label>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" id="saveUserBtn">Save User</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Edit User Modal -->
    <div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editUserModalLabel">Edit User</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="editUserForm">
                        <div class="mb-3">
                            <label for="editFirstName" class="form-label">First Name</label>
                            <input type="text" class="form-control" id="editFirstName" value="John" required>
                        </div>
                        <div class="mb-3">
                            <label for="editLastName" class="form-label">Last Name</label>
                            <input type="text" class="form-control" id="editLastName" value="Smith" required>
                        </div>
                        <div class="mb-3">
                            <label for="editEmail" class="form-label">Email Address</label>
                            <input type="email" class="form-control" id="editEmail" value="john.smith@example.com" required>
                        </div>
                        <div class="mb-3">
                            <label for="editRole" class="form-label">Role</label>
                            <select class="form-select" id="editRole" required>
                                <option value="Admin" selected>Administrator</option>
                                <option value="User">Regular User</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="editStatus" class="form-label">Status</label>
                            <select class="form-select" id="editStatus" required>
                                <option value="Active" selected>Active</option>
                                <option value="Inactive">Inactive</option>
                                <option value="Pending">Pending</option>
                            </select>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" id="updateUserBtn">Update User</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Reset Password Modal -->
    <div class="modal fade" id="resetPasswordModal" tabindex="-1" aria-labelledby="resetPasswordModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="resetPasswordModalLabel">Reset Password</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>You are about to reset the password for user: <strong>John Smith</strong></p>
                    <form>
                        <div class="mb-3">
                            <label for="newPassword" class="form-label">New Password</label>
                            <input type="password" class="form-control" id="newPassword" required>
                        </div>
                        <div class="mb-3">
                            <label for="confirmNewPassword" class="form-label">Confirm New Password</label>
                            <input type="password" class="form-control" id="confirmNewPassword" required>
                        </div>
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="notifyPasswordReset">
                            <label class="form-check-label" for="notifyPasswordReset">Send notification email</label>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" id="resetPasswordBtn">Reset Password</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Add Agent Modal -->
    <div class="modal fade" id="addAgentModal" tabindex="-1" aria-labelledby="addAgentModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addAgentModalLabel">Add New Agent</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="addAgentForm">
                        <div class="mb-3">
                            <label for="agentFirstName" class="form-label">First Name</label>
                            <input type="text" class="form-control" id="agentFirstName" required>
                        </div>
                        <div class="mb-3">
                            <label for="agentLastName" class="form-label">Last Name</label>
                            <input type="text" class="form-control" id="agentLastName" required>
                        </div>
                        <div class="mb-3">
                            <label for="agentEmail" class="form-label">Email Address</label>
                            <input type="email" class="form-control" id="agentEmail" required>
                        </div>
                        <div class="mb-3">
                            <label for="agentDepartment" class="form-label">Department</label>
                            <select class="form-select" id="agentDepartment" required>
                                <option value="">Select a department</option>
                                <option value="Customer Support">Customer Support</option>
                                <option value="Technical Support">Technical Support</option>
                                <option value="Sales">Sales</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="agentPassword" class="form-label">Password</label>
                            <input type="password" class="form-control" id="agentPassword" required>
                        </div>
                        <div class="mb-3">
                            <label for="agentConfirmPassword" class="form-label">Confirm Password</label>
                            <input type="password" class="form-control" id="agentConfirmPassword" required>
                        </div>
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="agentSendWelcomeEmail">
                            <label class="form-check-label" for="agentSendWelcomeEmail">Send welcome email</label>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" id="saveAgentBtn">Save Agent</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Edit Agent Modal -->
    <div class="modal fade" id="editAgentModal" tabindex="-1" aria-labelledby="editAgentModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editAgentModalLabel">Edit Agent</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="editAgentForm">
                        <div class="mb-3">
                                                        <label for="editAgentFirstName" class="form-label">First Name</label>
                            <input type="text" class="form-control" id="editAgentFirstName" value="David" required>
                        </div>
                        <div class="mb-3">
                            <label for="editAgentLastName" class="form-label">Last Name</label>
                            <input type="text" class="form-control" id="editAgentLastName" value="Miller" required>
                        </div>
                        <div class="mb-3">
                            <label for="editAgentEmail" class="form-label">Email Address</label>
                            <input type="email" class="form-control" id="editAgentEmail" value="david.miller@example.com" required>
                        </div>
                        <div class="mb-3">
                            <label for="editAgentDepartment" class="form-label">Department</label>
                            <select class="form-select" id="editAgentDepartment" required>
                                <option value="Customer Support" selected>Customer Support</option>
                                <option value="Technical Support">Technical Support</option>
                                <option value="Sales">Sales</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="editAgentStatus" class="form-label">Status</label>
                            <select class="form-select" id="editAgentStatus" required>
                                <option value="Online" selected>Online</option>
                                <option value="Away">Away</option>
                                <option value="Offline">Offline</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="editAgentPerformanceTarget" class="form-label">Performance Target (%)</label>
                            <input type="number" class="form-control" id="editAgentPerformanceTarget" value="90" min="0" max="100" required>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" id="updateAgentBtn">Update Agent</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Agent Performance Modal -->
    <div class="modal fade" id="viewPerformanceModal" tabindex="-1" aria-labelledby="viewPerformanceModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="viewPerformanceModalLabel">Agent Performance: David Miller</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <div class="card" style="background-color: rgba(30, 58, 138, 0.3); border: 1px solid var(--border-color);">
                                <div class="card-body">
                                    <h6 class="card-title">Performance Summary</h6>
                                    <div class="mb-3">
                                        <label class="form-label">Overall Rating</label>
                                        <div class="progress" style="height: 10px;">
                                            <div class="progress-bar bg-success" role="progressbar" style="width: 92%" aria-valuenow="92" aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                        <div class="d-flex justify-content-between mt-1">
                                            <small>Rating: 92%</small>
                                            <small>Target: 90%</small>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-6">
                                            <p class="mb-1">Total Cases:</p>
                                            <h5>325</h5>
                                        </div>
                                        <div class="col-6">
                                            <p class="mb-1">Avg. Response Time:</p>
                                            <h5>2.3 mins</h5>
                                        </div>
                                        <div class="col-6 mt-3">
                                            <p class="mb-1">Resolution Rate:</p>
                                            <h5>95%</h5>
                                        </div>
                                        <div class="col-6 mt-3">
                                            <p class="mb-1">Satisfaction Score:</p>
                                            <h5>4.8/5</h5>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card" style="background-color: rgba(30, 58, 138, 0.3); border: 1px solid var(--border-color);">
                                <div class="card-body">
                                    <h6 class="card-title">Monthly Performance</h6>
                                    <canvas id="agentMonthlyChart" height="200"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <div class="card" style="background-color: rgba(30, 58, 138, 0.3); border: 1px solid var(--border-color);">
                                <div class="card-body">
                                    <h6 class="card-title">Recent Cases</h6>
                                    <div class="table-responsive">
                                        <table class="table table-sm">
                                            <thead>
                                                <tr>
                                                    <th>Case ID</th>
                                                    <th>Customer</th>
                                                    <th>Issue Type</th>
                                                    <th>Status</th>
                                                    <th>Date</th>
                                                    <th>Resolution Time</th>
                                                    <th>Rating</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>CS-2025</td>
                                                    <td>Mark Wilson</td>
                                                    <td>Account Issue</td>
                                                    <td><span class="badge badge-active">Resolved</span></td>
                                                    <td>2025-03-28</td>
                                                    <td>1.5 hrs</td>
                                                    <td>5/5</td>
                                                </tr>
                                                <tr>
                                                    <td>CS-2022</td>
                                                    <td>Anna Smith</td>
                                                    <td>Technical Issue</td>
                                                    <td><span class="badge badge-active">Resolved</span></td>
                                                    <td>2025-03-27</td>
                                                    <td>2.3 hrs</td>
                                                    <td>4/5</td>
                                                </tr>
                                                <tr>
                                                    <td>CS-2017</td>
                                                    <td>Robert Johnson</td>
                                                    <td>Billing Issue</td>
                                                    <td><span class="badge badge-active">Resolved</span></td>
                                                    <td>2025-03-26</td>
                                                    <td>1.1 hrs</td>
                                                    <td>5/5</td>
                                                </tr>
                                                <tr>
                                                    <td>CS-2010</td>
                                                    <td>Lisa Brown</td>
                                                    <td>Account Issue</td>
                                                    <td><span class="badge badge-active">Resolved</span></td>
                                                    <td>2025-03-25</td>
                                                    <td>0.8 hrs</td>
                                                    <td>5/5</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Generate Full Report</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.32/dist/sweetalert2.all.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.0/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/datatables.net@1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/datatables.net-bs5@1.13.6/js/dataTables.bootstrap5.min.js"></script>

    <script>
        // Update the current UTC time
        const currentDateTime = '<%= "2025-03-28 08:50:35" %>';
        const currentUser = '<%= "IT24103866" %>';
        
        document.addEventListener('DOMContentLoaded', function() {
            // Initialize DataTables
            $('#usersTable').DataTable({
                responsive: true,
                pageLength: 10,
                language: {
                    search: "",
                    searchPlaceholder: "Search users..."
                }
            });
            
            $('#agentsTable').DataTable({
                responsive: true,
                pageLength: 10,
                language: {
                    search: "",
                    searchPlaceholder: "Search agents..."
                }
            });
            
            // Sidebar Toggle for Desktop
            const sidebar = document.getElementById('sidebar');
            const mainContent = document.getElementById('mainContent');
            const header = document.getElementById('header');
            const toggleSidebar = document.getElementById('toggleSidebar');
            
            toggleSidebar.addEventListener('click', function() {
                sidebar.classList.toggle('collapsed');
                mainContent.classList.toggle('expanded');
                header.classList.toggle('expanded');
                
                // Change the toggle icon
                const icon = toggleSidebar.querySelector('i');
                if (sidebar.classList.contains('collapsed')) {
                    icon.classList.remove('bi-chevron-left');
                    icon.classList.add('bi-chevron-right');
                } else {
                    icon.classList.remove('bi-chevron-right');
                    icon.classList.add('bi-chevron-left');
                }
            });
            
            // Mobile Sidebar Toggle
            const mobileSidebarToggle = document.getElementById('mobileSidebarToggle');
            
            mobileSidebarToggle.addEventListener('click', function() {
                sidebar.classList.toggle('mobile-active');
            });
            
            // Hide mobile sidebar when clicking outside
            document.addEventListener('click', function(event) {
                if (sidebar.classList.contains('mobile-active') && 
                    !sidebar.contains(event.target) && 
                    event.target !== mobileSidebarToggle) {
                    sidebar.classList.remove('mobile-active');
                }
            });
            
            // Navigation between pages/sections
            const navLinks = document.querySelectorAll('.nav-link');
            const contentSections = document.querySelectorAll('.content-section');
            const currentPageBreadcrumb = document.getElementById('currentPage');
            
            navLinks.forEach(link => {
                link.addEventListener('click', function(e) {
                    e.preventDefault();
                    
                    // Update active state
                    navLinks.forEach(l => l.classList.remove('active'));
                    this.classList.add('active');
                    
                    // Show appropriate content
                    const targetPage = this.getAttribute('data-page');
                    if (targetPage) {
                        contentSections.forEach(section => {
                            section.classList.add('d-none');
                            section.classList.remove('fade-in');
                        });
                        
                        const targetSection = document.getElementById(targetPage + 'Content');
                        if (targetSection) {
                            targetSection.classList.remove('d-none');
                            setTimeout(() => {
                                targetSection.classList.add('fade-in');
                            }, 50);
                            
                            // Update breadcrumb
                            currentPageBreadcrumb.textContent = targetPage.charAt(0).toUpperCase() + targetPage.slice(1);
                        }
                        
                        // Close mobile sidebar after navigation
                        if (window.innerWidth < 992) {
                            sidebar.classList.remove('mobile-active');
                        }
                    }
                });
            });
            
            // Initialize Charts for Dashboard
            initCharts();
            
            // CRUD Operations
            
            // Add new user
            document.getElementById('saveUserBtn').addEventListener('click', function() {
                Swal.fire({
                    title: 'Creating User',
                    text: 'Please wait...',
                    allowOutsideClick: false,
                    didOpen: () => {
                        Swal.showLoading();
                    }
                });
                
                // Simulate API call
                setTimeout(() => {
                    Swal.fire({
                        icon: 'success',
                        title: 'Success!',
                        text: 'New user has been created successfully.',
                        confirmButtonColor: '#3B82F6'
                    }).then(() => {
                        // Close modal and reset form
                        const modal = bootstrap.Modal.getInstance(document.getElementById('addUserModal'));
                        modal.hide();
                        document.getElementById('addUserForm').reset();
                    });
                }, 1500);
            });
            
            // Edit user
            document.getElementById('updateUserBtn').addEventListener('click', function() {
                Swal.fire({
                    title: 'Updating User',
                    text: 'Please wait...',
                    allowOutsideClick: false,
                    didOpen: () => {
                        Swal.showLoading();
                    }
                });
                
                // Simulate API call
                setTimeout(() => {
                    Swal.fire({
                        icon: 'success',
                        title: 'Success!',
                        text: 'User information has been updated successfully.',
                        confirmButtonColor: '#3B82F6'
                    }).then(() => {
                        // Close modal
                        const modal = bootstrap.Modal.getInstance(document.getElementById('editUserModal'));
                        modal.hide();
                    });
                }, 1500);
            });
            
            // Reset password
            document.getElementById('resetPasswordBtn').addEventListener('click', function() {
                Swal.fire({
                    title: 'Resetting Password',
                    text: 'Please wait...',
                    allowOutsideClick: false,
                    didOpen: () => {
                        Swal.showLoading();
                    }
                });
                
                // Simulate API call
                setTimeout(() => {
                    Swal.fire({
                        icon: 'success',
                        title: 'Success!',
                        text: 'Password has been reset successfully.',
                        confirmButtonColor: '#3B82F6'
                    }).then(() => {
                        // Close modal and reset form
                        const modal = bootstrap.Modal.getInstance(document.getElementById('resetPasswordModal'));
                        modal.hide();
                        document.querySelector('#resetPasswordModal form').reset();
                    });
                }, 1500);
            });
            
            // Delete user
            const deleteUserBtns = document.querySelectorAll('.delete-user-btn');
            deleteUserBtns.forEach(btn => {
                btn.addEventListener('click', function() {
                    const userId = this.getAttribute('data-user-id');
                    
                    Swal.fire({
                        title: 'Are you sure?',
                        text: `Do you want to delete user ${userId}? This action cannot be undone.`,
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#EF4444',
                        cancelButtonColor: '#3B82F6',
                        confirmButtonText: 'Yes, delete it!'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            // Simulate API call
                            Swal.fire({
                                title: 'Deleting User',
                                text: 'Please wait...',
                                allowOutsideClick: false,
                                didOpen: () => {
                                    Swal.showLoading();
                                }
                            });
                            
                            setTimeout(() => {
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Deleted!',
                                    text: 'User has been deleted successfully.',
                                    confirmButtonColor: '#3B82F6'
                                });
                            }, 1500);
                        }
                    });
                });
            });
            
            // Add new agent
            document.getElementById('saveAgentBtn').addEventListener('click', function() {
                Swal.fire({
                    title: 'Creating Agent',
                    text: 'Please wait...',
                    allowOutsideClick: false,
                    didOpen: () => {
                        Swal.showLoading();
                    }
                });
                
                // Simulate API call
                setTimeout(() => {
                    Swal.fire({
                        icon: 'success',
                        title: 'Success!',
                        text: 'New agent has been created successfully.',
                        confirmButtonColor: '#3B82F6'
                    }).then(() => {
                        // Close modal and reset form
                        const modal = bootstrap.Modal.getInstance(document.getElementById('addAgentModal'));
                        modal.hide();
                        document.getElementById('addAgentForm').reset();
                    });
                }, 1500);
            });
            
            // Edit agent
            document.getElementById('updateAgentBtn').addEventListener('click', function() {
                Swal.fire({
                    title: 'Updating Agent',
                    text: 'Please wait...',
                    allowOutsideClick: false,
                    didOpen: () => {
                        Swal.showLoading();
                    }
                });
                
                // Simulate API call
                setTimeout(() => {
                    Swal.fire({
                        icon: 'success',
                        title: 'Success!',
                        text: 'Agent information has been updated successfully.',
                        confirmButtonColor: '#3B82F6'
                    }).then(() => {
                        // Close modal
                        const modal = bootstrap.Modal.getInstance(document.getElementById('editAgentModal'));
                        modal.hide();
                    });
                }, 1500);
            });
            
            // Delete agent
            const deleteAgentBtns = document.querySelectorAll('.delete-agent-btn');
            deleteAgentBtns.forEach(btn => {
                btn.addEventListener('click', function() {
                    const agentId = this.getAttribute('data-agent-id');
                    
                    Swal.fire({
                        title: 'Are you sure?',
                        text: `Do you want to delete agent ${agentId}? This action cannot be undone.`,
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#EF4444',
                        cancelButtonColor: '#3B82F6',
                        confirmButtonText: 'Yes, delete it!'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            // Simulate API call
                            Swal.fire({
                                title: 'Deleting Agent',
                                text: 'Please wait...',
                                allowOutsideClick: false,
                                didOpen: () => {
                                    Swal.showLoading();
                                }
                            });
                            
                            setTimeout(() => {
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Deleted!',
                                    text: 'Agent has been deleted successfully.',
                                    confirmButtonColor: '#3B82F6'
                                });
                            }, 1500);
                        }
                    });
                });
            });
            
            // Initialize performance chart when modal opens
            const viewPerformanceModal = document.getElementById('viewPerformanceModal');
            viewPerformanceModal.addEventListener('shown.bs.modal', function () {
                initAgentPerformanceChart();
            });
        });
        
        function initCharts() {
            // Dashboard Charts
            // User Distribution Chart
            const userDistributionCtx = document.getElementById('userDistributionChart').getContext('2d');
            const userDistributionChart = new Chart(userDistributionCtx, {
                type: 'doughnut',
                data: {
                    labels: ['Administrators', 'Regular Users', 'Guests'],
                    datasets: [{
                        data: [15, 65, 20],
                        backgroundColor: [
                            '#3B82F6',
                            '#10B981',
                            '#F59E0B'
                        ],
                        borderWidth: 0
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom',
                            labels: {
                                color: '#CBD5E1',
                                padding: 15
                            }
                        }
                    },
                    cutout: '70%'
                }
            });
            
            // User Registration Chart
            const userRegistrationCtx = document.getElementById('userRegistrationChart').getContext('2d');
            const userRegistrationChart = new Chart(userRegistrationCtx, {
                type: 'line',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                    datasets: [{
                        label: 'New Users',
                        data: [120, 150, 180, 190, 210, 250],
                        borderColor: '#3B82F6',
                        backgroundColor: 'rgba(59, 130, 246, 0.1)',
                        borderWidth: 2,
                        tension: 0.4,
                        fill: true
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                color: 'rgba(203, 213, 225, 0.1)'
                            },
                            ticks: {
                                color: '#94A3B8'
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            },
                            ticks: {
                                color: '#94A3B8'
                            }
                        }
                    }
                }
            });
        }
        
        function initAgentPerformanceChart() {
            const agentMonthlyCtx = document.getElementById('agentMonthlyChart').getContext('2d');
            const agentMonthlyChart = new Chart(agentMonthlyCtx, {
                type: 'bar',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                    datasets: [{
                        label: 'Performance Score',
                        data: [85, 88, 90, 89, 91, 92],
                        backgroundColor: '#3B82F6',
                        borderRadius: 4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            max: 100,
                            grid: {
                                color: 'rgba(203, 213, 225, 0.1)'
                            },
                            ticks: {
                                color: '#94A3B8'
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            },
                            ticks: {
                                color: '#94A3B8'
                            }
                        }
                    }
                }
            });
        }
    </script>
</body>
</html>