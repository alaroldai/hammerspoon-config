# Hammerspoon configuration

This is a fairly minimal setup for manual tiling with Hammerspoon.
Note that this is not intended only for 'true' tiling (no overlaps at all).
Like it or not, `windowserver` is a stacking window manager, and I've found that this hybrid of tiling and stacked positions works best for me.
Your mileage may vary.

The keybindings added in this configuration are indended for use with an 87-key ANSI / US-layout keyboard. The basic assumption is that key chords consist of the left hand hitting some modifiers and the right indicating a direction.

## Positioning windows on a single monitor
All of these invocations are prefixed with a combination of Control, Alt, and Command.

- Sized to 1/2 the screen size and positioned on a screen edge (arrow keys)
- Sized to 1/4 of the screen size:
  - In the corners of the screen (bound to U, O, X and M)
  - Aligned to the midpoints of the screen edges (bound to H, J, K, and L)
  - In the centre of the screen (bound to Space)
- Sized to 1/9 of the screen size:
  - In the corners of the screen (bound to Y, [, /, and N)
  - Aligned to the midpoints of the screen edges (bound to G, I, ',', and ;)
  - In the centre of the screen (bound to "'")
- In columns, each 1/3 of the screen width (bound to Delete, End and Page Down)
- In double-wide columns, aligned to the left (Insert) or right (Page Up) of the screen
- In rows, each 1/3 of the screen width (bound to Print Screen, Scroll Lock, and Pause)

## Moving windows between monitors
Moving windows between monitors is bound to a Ctrl+Alt prefix and the vim motion keys (H, J, K, and L).

Window movement consists of:
- Computing the rect of the window as a percentage of the rect of the monitor it's on
- Computing the equivalent relative size on the destination monitor
- Assigning the new rect to the window

This is intended to prevent issues such as the window being off-screen in the new monitor's address space, or being uncomfortably small / large.

## "Pulling" a window

This is my term for selecting a window and bringing it to where I'm currently working, rather than going searching for the window.

Consider, for example: you're working with two source files and some documentation, and you want to take some notes in a scratch text document. The window for this document is in another workspace.

You could open up mission control, find the window and switch to it, but then you can't see your docs any more. So you have to open up mission control again to move the window back to the workspace you were working on.

Granted that's a small amount of work, but I see two main issues with it:
- Switching workspaces is like walking through a doorway: it's a context switch for your brain and makes it easy to forget what you were doing (especially if the content already in your scratch document is otherwise interesting)
- If you have a lot of workspaces / windows, finding the window can take time, and frustration kills flow.

My solution for this is a combination of Alfred and Hammerspoon:
- Use Alfred to select an application
- Have Alfred invoke hammerspoon to "pull" the main window of that application so that it occupies the same frame as the currently active window.

If you'd like to use the same behaviour, the `alfred-pull-window.bash` script in this repository should help.


## Installation
If all you're interested in is this configuration, cloning this repository as `~/.hammerspoon` should suffice:
```bash
$ git clone https://github.com/alaroldai/hammerspoon-config ~/.hammerspoon
```

Other options include:
- using `defaults write org.hammerspoon.Hammerspoon MJConfigFile <path-to-config-file>` to have hammerspoon load its configuration from wherever you cloned this repo
- using lua's `dofile` directive to invoke `init.lua` as part of a larger configuration
- running `up.sh` from this repository, which will create a symlink `~/.hammerspoon` that points to your checkout.


## Dependencies

This configuration is written in [Fennel](https://fennel-lang.org), and a makefile is included for compiling the Lua output. If you want to modify the source, you'll need to install Fennel.

Also, I've used [asmagill](https://github.com/asmagill/hs._asm.spaces)'s spaces addition to Hammerspoon to allow the "pull window" script to identify the active space.
