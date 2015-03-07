# sm-save-refills

Makes save points in Super Metroid refill health/ammo.

For xkas v06.  Unheadered.

# Props

* Kejardon, for his always-excellent RAMMap, PLM\_Details, and for the MessageBoxes.  Huge time savers.
* DChronos for the message box guide.
* pjboy for the bank $80 disassembly.  Epic reference.
* [metconst](http://metroidconstruction.com) for always being my inspiration.

# Notes

`bugfix-ship-save` fixes the ordering so that by the time the ship brings up the “save completed” message, saving **has** actually completed.
I didn’t think it was worth making a repo of its own.

`refill-before-save` is v2 of the save-refill patch, the smooth refill!
When the save point activates, Samus poses in it as if she’s being saved, and gets refilled.
Then it asks whether the game should be saved.

Compared to v1, the hijack point is completely different, so there is no need to handle different save routine patches specially.

As written, it refills all main/reserve energy and all ammo, but you can skip the parts you don’t want.
Check inside the ASM for details.

As noted above, the patch is for xkas v06.
Assembly is straightforward:

    xkas patch.asm rom.sfc

# Author

[Adam](https://github.com/n00btube)

# License

MIT.
