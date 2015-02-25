# sm-save-refills

Makes save points in Super Metroid refill health/ammo.

For xkas v06.  Unheadered.

# Props

* Kejardon, for his always-excellent RAMMap.
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
