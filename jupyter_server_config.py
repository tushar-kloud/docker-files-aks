# jupyter_server_config.py
c = get_config() 

# Security settings
c.ServerApp.allow_origin='*'
c.ServerApp.ip = '*'
c.ServerApp.port = 8888

# To disbale the token authentication
c.ServerApp.token=''
c.ServerApp.password = ""
c.ServerApp.disable_check_xsrf=True

# Performance tuning
c.ServerApp.tornado_settings = {
    'headers': {
        'Content-Security-Policy': "frame-ancestors 'self' *"
    },
    # 'websocket_max_message_size': 1024 * 1024 * 1024,
}

# Logging
c.ServerApp.log_level = 'DEBUG'
c.Application.log_level = 'DEBUG'

## Debug output in the Session
#  Default: False
c.Session.debug = True

# Enable command logging
c.HistoryManager.enabled = True
c.HistoryManager.db_cache_size = 1000  # Adjust as needed

# Set the location for the history database - Path to file to use for SQLite history database.
# c.HistoryManager.hist_file = '/home/jovyan/logs/jupyter_command_history.sqlite'
# c.HistoryManager.hist_file = '/home/jovyan/.ipython/profile_default/history.sqlite'

# Enable more verbose logging
# c.ServerApp.log_format = '%(asctime)s %(levelname)s: %(message)s'
# c.ServerApp.log_datefmt = '%Y-%m-%d %H:%M:%S'


# Kernel settings
# c.ServerApp.kernel_ws_protocol = 'v1.kernel.websocket.jupyter.org'

# Session management
# c.ServerApp.kernel_manager_class = 'jupyter_server.services.kernels.kernelmanager.AsyncMappingKernelManager'
# c.MappingKernelManager.cull_idle_timeout = 1800  # 30 minutes
# c.MappingKernelManager.cull_interval = 60  # Check every minute

# KernelManager settings
# c.KernelManager.kernel_info_timeout = 60  # Increase timeout for kernel info requests
# c.KernelManager.kernel_start_timeout = 60  # Increase timeout for starting kernels

# SessionManager settings
# c.SessionManager.session_keepalive_interval = 180  # Keepalive interval to maintain session consistency


# Enable HTTPS (configured in Azure)
# c.ServerApp.certfile = '/path/to/your/cert/file.pem'
# c.ServerApp.keyfile = '/path/to/your/key/file.key'






