# gnustep-devel-apps

A collection of GNUstep Developer Applications to be used with AGNoStep Apps Manager.

## Goal

This module is useful with [agnostep-apps-manager](../../../agnostep-apps-manager).
It allows to retrieve the source of most of the known GNUstep Developer Applications like Gorm, Project Center, Gem editor... and then to build and install them into a GNUstep Desktop.

> [!NOTE] This is a work in progress, as we are replacing previous `AgnostepManager.app` with this new module method.

## List of available applications

- EasyDiff
- Gem
- Gorm
- ProjectCenter
- Thematic
- Ycode (new IDE from libs-xcode)

## Purgatory

### Emacs

- `git clone` was erratic (savannah issue) and when it was successfull, I  failed to build due to `AppKit` not found. Fix needed.