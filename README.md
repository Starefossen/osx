# macOS Setup

My macOS setup and configurations.

## Non Automated Tasks

### Terminal

* Source Code Pro Font: https://github.com/adobe-fonts/source-code-pro/releases
* Install the `config/Starefossen.terminal` profile and set it to default.

### Sudo prompt

Add the following line to the top of /etc/pam.d/sudo there is no need to replace sudo:

```
auth       sufficient     pam_tid.so
```

Source: https://github.com/mattrajca/sudo-touchid/issues/30

### Non breaking spaces

Make your ~/Library/KeyBindings/DefaultKeyBinding.dict file look like this (if it doesn’t exist create it, if there are already bindings in it just add the one from below):

```
{
"~ " = ("insertText:", " ");
}
```

Source: https://superuser.com/questions/78245/how-to-disable-the-option-space-key-combination-for-non-breaking-spaces
