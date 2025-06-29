# Holiday CMatrix

**Holiday CMatrix** is a date-aware wrapper for the [cmatrix](https://github.com/abishekvashok/cmatrix) terminal screensaver that automatically applies themed color schemes and effects based on US holidays and the current date. Transform your terminal into a festive Matrix experience that changes throughout the year!

- 🎄 **Christmas**: Red/green/white
- 🎆 **4th of July**: Patriotic red/white/blue
- 🎃 **Halloween**: Spooky purple/green with old-style scrolling
- 🌈 **Pride Month**: Full rainbow color spectrum
- ✨ **New Year**: Yellow/white/blue
- ❤️ **Valentine's Day**: Romantic red/magenta/white palette

... and more!

Built-in themes cover major US holidays, with support for custom external theme files that can override defaults or add new celebrations.

> ⚠️ **WARNING:** 
> These themes rely on a contribution to the cmatrix project that has not been merged yet: [-C multicolor palette](https://github.com/abishekvashok/cmatrix/pull/200)
> 
> You can either
> 1. build `cmatrix` from source at that commit, or
> 2. wait for it to be merged and released
>
> You can't really make interesting themes without it.

## QuickStart

1. **Install:**

	```bash
	sudo make install
	```

2. **Run with current date theme:**

	```bash
	holiday-cmatrix
	```

3. **See all available themes:**

	```bash
	holiday-cmatrix --list
	```

4. **Run with a specific holiday theme:**

	```bash
	holiday-cmatrix -d 12-25    # Preview Christmas theme
	holiday-cmatrix -d 07-04    # Preview 4th of July theme
	```

That's it! The script automatically detects today's date and launches cmatrix with the appropriate holiday theme.

## User Guide

### Basic Commands

| Command                              | Description                                    |
|--------------------------------------|------------------------------------------------|
| `holiday-cmatrix`                    | Run with today's date theme                    |
| `holiday-cmatrix -t`                 | Show today's theme without running             |
| `holiday-cmatrix -l`                 | List all configured themes                     | 
| `holiday-cmatrix -h`                 | Show help and usage                            |
| `holiday-cmatrix --default 'args'`   | Set custom default theme for non-holiday dates |

### Testing Specific Dates

Use the `-d` flag to test themes for specific dates:

```bash
# Test Christmas theme
holiday-cmatrix -d 12-25 -t

# Test Halloween theme  
holiday-cmatrix -d 10-31 -t

# Test Pride Month theme
holiday-cmatrix -d 06-15 -t

# Actually run New Year theme
holiday-cmatrix -d 01-01
```

Date format is `MM-DD` (month-day with leading zeros).

### Built-in Holiday Themes

The script includes these pre-configured holiday themes:

| Holiday             | Date Range        | Colors              | Special Effects                   |
|---------------------|-------------------|---------------------|-----------------------------------|
| **New Year**        | Dec 31 - Jan 2    | Yellow/White/Blue   | Rainbow + Character changes       |
| **Valentine's Day** | Feb 12-16         | Red/Magenta/White   | Character changes                 |
| **Pride Month**     | June 1-30         | Rainbow colors      | Character changes                 |
| **4th of July**     | July 1-8          | Red/White/Blue      | Rainbow + Bold text               |
| **Halloween**       | Oct 25-31         | Yellow/Red/Black    | Old-style + Character changes     |
| **Thanksgiving**    | Nov 20-30         | Yellow/Red/Green    | Standard effects                  |
| **Christmas**       | Dec 15-30         | Red/Green/White     | Bold text                         |


### Advanced Usage

- [Custom Default Theme](#custom-default-theme)
- [Custom External Themes](#custom-external-themes)
  - [External Theme File Format](#external-theme-file-format)
  - [Theme Precedence Rules](#theme-precedence-rules)
- [CMatrix Parameters](#cmatrix-parameters)
- [Examples](#examples)

#### Custom Default Theme

Use the `--default` option to set a custom theme for dates that don't match any holiday:

```bash
# Set a blue/white default theme
holiday-cmatrix --default '-a -C blue,white -u 1'

# Test a non-holiday date with custom default
holiday-cmatrix -d 03-15 -t --default '-a -C cyan,magenta -r -u 2'

# Use bold green theme as default
holiday-cmatrix --default '-a -C green -B -u 0'
```

#### Custom External Themes

Create your own holiday themes using external theme files that override built-in themes.

**Default External File Location:**
```
~/.holiday-cmatrix
```

**Custom File Location:**
```bash
holiday-cmatrix -f my-custom-themes
```

##### External Theme File Format

Create a text file with one theme per line and tab-separated fields:

```bash
# Comments start with #
# Format: Name<TAB>Start: MM-DD[<TAB>End: MM-DD]<TAB>cmatrix_arguments

# Override Christmas with custom magenta theme
Christmas	12-20	12-25	-a -C magenta,cyan,white -u 1 -B

# Add St. Patrick's Day
St. Patrick's Day	03-17	-a -C green,white -u 2

# Custom summer theme for entire July
Summer	07-01	07-31	-a -C yellow,blue,white -r -u 1

# Earth Day theme
Earth Day	04-22	-a -C green,blue -u 3 -k
```

##### Theme Precedence Rules

1. **External themes override built-in themes** for overlapping date ranges
2. **Multiple themes per date range** are supported
3. **Built-in themes remain active** for non-overlapping dates
4. **External themes are checked first** during date matching

#### CMatrix Parameters

The script supports all cmatrix parameters, but relies heavily on the as-yet-unmerged [-C multicolor palette](https://github.com/abishekvashok/cmatrix/pull/200) to really make interesting themes.

#### Examples

**View themes with external file:**
```bash
holiday-cmatrix -f my-themes --list
```

**Test external theme override:**
```bash
# Create custom Christmas theme
printf "Christmas\t12-24\t12-26\t-a -C blue,white,white -r -u 0\n" > custom-xmas
holiday-cmatrix -f custom-xmas -d 12-25 -t
```

**Multiple holiday celebrations:**
```bash
# my-themes file:
Valentine's Day	02-14	02-14	-a -C red,magenta -u 1 -B
St. Patrick's Day	03-17	03-17	-a -C green,white -u 2
April Fools	04-01	04-01	-a -C yellow,magenta -u 0 -k
```

**Creating seasonal themes:**
```bash
# Seasonal theme file:
Spring	03-20	06-19	-a -C green,yellow -u 2
Summer	06-20	09-21	-a -C yellow,blue -r -u 1
Fall	09-22	12-20	-a -C red,yellow,green -u 3
Winter	12-21	03-19	-a -C blue,white,cyan -u 4
```
