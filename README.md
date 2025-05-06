# FSJQS-6v6

FSJQS was based on the [6v6 Adjustments](https://github.com/6v6-Adjustments/6v6-adjustments), but all new additions were done in the workshop itself.
This is an attempt to convert it back to a maintainable project using opy. 
Due to challenges of updating their code to work with the changes already made in the workshop itself I've decided to restart with a fresh decompile from Overwatch's Workshop code. This is very much still a work in progress as I am moving parts over to their own files from a massive main.opy. Referencing both the original source code and the changes made in the workshop itself.

Most of the additional work on top of the changes in the 6v6 Adjustments code was done by xDidact in collaboration with [Realth](https://www.twitch.tv/realth) and his community. The balance changes are being used in the weekly PUGS every Sunday.

## Scripts

### `npm run compile`
Compiles the project using `build.js`. Optionally, you can pass a version number as an argument:

```bash
npm run compile 1.15.92
```

This will update the version number to 1.15.92. If no version is provided it will be kept as is.