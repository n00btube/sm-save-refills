# sm-save-refills

Makes save points in Super Metroid refill health/ammo.

For xkas v06.  Unheadered.

Also, because I discovered it was broken, there’s now a special bugfix patch for saving at the ship.
The vanilla behavior is to do the write to SRAM **after** the “Save Completed” message is dismissed!
That is, to “not actually save” until just before Samus exits her ship.

`bugfix-ship-save` fixes the ordering.
Saving happens much sooner, making the “completed” message honest.
I’m including it here because it’s not worth having a separate git repo for it.

# Props

* Kejardon, for his always-excellent RAMMap, and for the MessageBoxes.  Huge time savers.
* DChronos for the message box guide.
* [metconst](http://metroidconstruction.com) for always being my inspiration.

# Notes

This is an instant refill, without fancy routines like the ship uses.

The patch comes in two flavors:

1. `vanilla` for the unmodified ROM.  Tested.
2. `scyzer` for use with Scyzer’s save/load patches.  Not tested.

If there is interest, I may check compatibility with JAM’s patches that affect saves as well.

As noted above, the patch is for xkas v06.
Assembly is straightforward:

    xkas patch.asm rom.sfc

# Author

Adam, not that this one was hard.

# License

MIT.
