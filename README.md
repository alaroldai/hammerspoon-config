# Hammerspoon configuration

This is a fairly minimal setup for manual tiling with Hammerspoon.
Note that this is not intended only for 'true' tiling (no overlaps at all). Like it or not, `windowserver` is a stacking
window manager, and I've found that this hybrid of tiling and stacked positions works best for me. Your mileage may
vary.

All bindings are prefixed by `<Ctrl+Option+Command>`, and based around Vim's motions.

Supported window positions:

  - Corners (u,[,n,/)

    ```
    x-- --x --- ---
    --- --- --- ---
    --- --- x-- --x
    ```

  - Centered edges (hjkl)

    ```
    --- -x- --- ---
    x-- --- --x ---
    --- --- --- -x-
    ```

  - Centered (m)

    ```
    ---
    -x-
    ---
    ```

  - Edges (arrow keys)
  
    ```
    xxx --x --- x--
    --- --x --- x--
    --- --x xxx x--
    ```

  - Fullscreen (spacebar)

    ```
    xxx
    xxx
    xxx
    ```


Also included is the `hs.tiling` module, which is currently bound to `<Ctrl+Option> space`
