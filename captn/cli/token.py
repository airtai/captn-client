# AUTOGENERATED! DO NOT EDIT! File to edit: ../../notebooks/CLI_Token.ipynb.

# %% auto 0
__all__ = ['token', 'app']

# %% ../../notebooks/CLI_Token.ipynb 3
import airt
import typer

from ..client import _fix_cli_doc_string, _replace_env_var

# %% ../../notebooks/CLI_Token.ipynb 4
from airt._cli.token import token as _token

token = _token

token.__doc__ = _replace_env_var(token.__doc__)

# %% ../../notebooks/CLI_Token.ipynb 5
app = typer.Typer()
app.command()(token)
