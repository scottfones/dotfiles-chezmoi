import os
import sys

c = get_config()  # noqa: F821

# Get venv bin path
python_path = sys.executable
venv_bin = os.path.dirname(python_path)
pylsp_path = os.path.join(venv_bin, "pylsp")

# Prepend venv to PATH for autodetection
os.environ["PATH"] = f"{venv_bin}:{os.environ.get('PATH', '')}"

# Disable autodetection to ensure we control which server is used
c.LanguageServerManager.autodetect = False

# Explicitly configure ONLY pylsp for Python in JupyterLab
c.LanguageServerManager.language_servers = {
    "pylsp": {
        "version": 2,
        "argv": [pylsp_path],
        "languages": ["python"],
        "mime_types": ["text/x-python", "text/python"],
        "configuration": {
            "pylsp": {
                "plugins": {
                    # Enable Ruff for linting and formatting
                    "ruff": {
                        "enabled": True,
                        "lineLength": 100,
                        "extendSelect": ["I"],  # Import sorting
                    },
                    # Enable mypy for type checking
                    "pylsp_mypy": {
                        "enabled": True,
                        "live_mode": True,  # Type check as you type
                        "strict": False,  # Use project's mypy config
                    },
                    # Disable redundant linters (Ruff replaces these)
                    "pycodestyle": {"enabled": False},
                    "pyflakes": {"enabled": False},
                    "mccabe": {"enabled": False},
                    "autopep8": {"enabled": False},
                    "yapf": {"enabled": False},
                    # Keep Jedi features for completions and navigation
                    "jedi_completion": {"enabled": True},
                    "jedi_hover": {"enabled": True},
                    "jedi_references": {"enabled": True},
                    "jedi_signature_help": {"enabled": True},
                    "jedi_symbols": {"enabled": True},
                }
            }
        },
    },
}
