# My dotfiles

## Tools

- stow
- zellij
- ripgrep
- nnn
- lazygit
- atuin
- zsh
- delta
- wezterm

## Neovim
Plugin based on [Astronvim](https://docs.astronvim.com)

# VScode Keybinding

```

[
    // Navigation
    {
      "key": "ctrl-h",
      "command": "workbench.action.navigateLeft"
    },
    {
      "key": "ctrl-l",
      "command": "workbench.action.navigateRight"
    },
    {
      "key": "ctrl-k",
      "command": "workbench.action.navigateUp"
    },
    {
      "key": "ctrl-j",
      "command": "workbench.action.navigateDown"
    },
    {
      "key": "space ,",
      "command": "workbench.action.showAllEditors",
      "when": "vim.mode == 'Normal' && (editorTextFocus || !inputFocus)"
    },
    {
      "key": "space e",
      "command": "runCommands",
      "args": {
        "commands": [
          "workbench.action.toggleSidebarVisibility",
          "workbench.files.action.focusFilesExplorer"
        ]
      },
      "when": "vim.mode == 'Normal' && (editorTextFocus || !inputFocus) && !sideBarFocus"
    },
    {
      "key": "space e",
      "command": "runCommands",
      "args": {
        "commands": [
          "workbench.action.toggleSidebarVisibility",
          "workbench.action.focusActiveEditorGroup"
        ]
      },
      "when": "sideBarFocus && !inputFocus"
    },
    {
      "key": "space e",
      "when": "vim.mode == 'Normal' && editorTextFocus && foldersViewVisible",
      "command": "workbench.action.toggleSidebarVisibility"
    },

    {
      "key": "tab",
      "command": "workbench.action.nextEditorInGroup",
      "when": "(vim.mode == 'Normal' || vim.mode == 'Visual') && (editorTextFocus || !inputFocus)"
    },
    {
      "key": "shift-tab",
      "command": "workbench.action.previousEditorInGroup",
      "when": "(vim.mode == 'Normal' || vim.mode == 'Visual') && (editorTextFocus || !inputFocus)"
    },
    {
      "key": "\\ .", // Replace with your desired keybinding
      "command": "list.collapseAll",
      "when": "(vim.mode == 'Normal' || vim.mode == 'Visual') &&  explorerViewletVisible && (filesExplorerFocus || editorTextFocus)" // Allows toggling in both the Explorer and Editor
  },

    // Coding
    // {
    //    "key": "cmd+.",
    //    "when": "vim.mode == 'Normal' && editorTextFocus && !activeEditorIsReadonly && editorHasCodeActionsProvider"
    // },
    {
      "key": "shift-j",
      "command": "editor.action.moveLinesDownAction",
      "when": "vim.mode == 'VisualLine' && editorTextFocus"
    },
    {
      "key": "shift-k",
      "command": "editor.action.moveLinesUpAction",
      "when": "vim.mode == 'VisualLine' && editorTextFocus"
    },
    {
      "key": "shift-k",
      "command": "editor.action.showHover",
      "when": "vim.mode == 'Normal' && editorTextFocus"
    },
    {
      "key": "space c a",
      "command": "editor.action.codeAction",
      "when": "vim.mode == 'Normal' && editorTextFocus"
    },
    {
      "key": "\\ t",
      "command": "workbench.actions.view.problems",
      "when": "workbench.panel.markers.view.active"
    },
    {
      "key": "\\ r",
      "command": "editor.action.rename",
      "when": "vim.mode == 'Normal' && editorTextFocus"
    },
    {
      "key": "\\ q",
      "command": "workbench.action.gotoSymbol",
      "when": "vim.mode == 'Normal' && editorTextFocus"
    },
    {
      "key": "space b d",
      "command": "workbench.action.closeActiveEditor",
      "when": "vim.mode == 'Normal' && editorTextFocus"
    },
    {
      "key": "space space",
      "command": "workbench.action.quickOpen",
      "when": "vim.mode == 'Normal' && (editorTextFocus || !inputFocus)"
    },
    {
      "key": "space g d",
      "command": "editor.action.revealDefinition",
      "when": "vim.mode == 'Normal' && editorTextFocus"
    },
    {
      "key": "space g r",
      "command": "editor.action.goToReferences",
      "when": "vim.mode == 'Normal' && editorTextFocus"
    },
    {
      "key": "\\ s",
      "command": "workbench.action.findInFiles",
      "when": "vim.mode == 'Normal' && (editorTextFocus || !inputFocus)"
    },
    {
      "key": "space g g",
      "command": "runCommands",
      "when": "vim.mode == 'Normal' && (editorTextFocus || !inputFocus)",
      "args": {
        "commands": ["workbench.view.scm", "workbench.scm.focus"]
      }
    },
    {
      "key": "ctrl-n",
      "command": "editor.action.addSelectionToNextFindMatch",
      "when": "(vim.mode == 'Normal' || vim.mode == 'Visual') && (editorTextFocus || !inputFocus)"
    },

    // File Explorer
    {
      "key": "r",
      "command": "renameFile",
      "when": "filesExplorerFocus && foldersViewVisible && !explorerResourceIsRoot && !explorerResourceReadonly && !inputFocus"
    },
    {
      "key": "c",
      "command": "filesExplorer.copy",
      "when": "filesExplorerFocus && foldersViewVisible && !explorerResourceIsRoot && !explorerResourceReadonly && !inputFocus"
    },
    {
      "key": "p",
      "command": "filesExplorer.paste",
      "when": "filesExplorerFocus && foldersViewVisible && !explorerResourceIsRoot && !explorerResourceReadonly && !inputFocus"
    },
    {
      "key": "x",
      "command": "filesExplorer.cut",
      "when": "filesExplorerFocus && foldersViewVisible && !explorerResourceIsRoot && !explorerResourceReadonly && !inputFocus"
    },
    {
      "key": "d",
      "command": "deleteFile",
      "when": "filesExplorerFocus && foldersViewVisible && !explorerResourceIsRoot && !explorerResourceReadonly && !inputFocus"
    },
    {
      "key": "a",
      "command": "explorer.newFile",
      "when": "filesExplorerFocus && foldersViewVisible && !explorerResourceIsRoot && !explorerResourceReadonly && !inputFocus"
    },
    {
      "key": "shift-a",
      "command": "explorer.newFolder",
      "when": "filesExplorerFocus && foldersViewVisible && !explorerResourceIsRoot && !explorerResourceReadonly && !inputFocus"
    },
    {
      "key": "s",
      "command": "explorer.openToSide",
      "when": "filesExplorerFocus && foldersViewVisible && !explorerResourceIsRoot && !explorerResourceReadonly && !inputFocus"
    },
    {
      "key": "shift-s",
      "command": "runCommands",
      "when": "filesExplorerFocus && foldersViewVisible && !explorerResourceIsRoot && !explorerResourceReadonly && !inputFocus",
      "args": {
        "commands": [
          "workbench.action.splitEditorDown",
          "explorer.openAndPassFocus",
          "workbench.action.closeOtherEditors"
        ]
      }
    },
    {
      "key": "enter",
      "command": "explorer.openAndPassFocus",
      "when": "filesExplorerFocus && foldersViewVisible && !explorerResourceIsRoot && !explorerResourceIsFolder && !inputFocus"
    },
    {
      "key": "enter",
      "command": "list.toggleExpand",
      "when": "filesExplorerFocus && foldersViewVisible && !explorerResourceIsRoot && explorerResourceIsFolder && !inputFocus"
    },
    {
        "key": "space m",
        "command": "bookmarks.toggle",
        "when": "(vim.mode == 'Normal' && editorTextFocus)"
      }
  ]

```
