# AGENTS.md — Songbook Project

## Mission

Maintain and expand a Quarto-based guitar songbook. Convert the supplied song material into clean, consistent `.qmd` song files that preserve the exact lyrics and place each chord at the correct sung syllable.

The main priorities, in order, are:

1. Faithfulness to the user’s lyrics and corrections.
2. Accurate musical placement of chords.
3. Consistency with completed song files.
4. Valid Quarto/Markdown rendering.
5. Small, focused changes with no unnecessary refactoring.

## Source of Truth

When instructions conflict, use this authority order:

1. The user’s most recent correction or explicit instruction.
2. Existing completed song files that the user has approved.
3. The repository’s current `_quarto.yml`, Lua filters, CSS, templates, and scripts.
4. This document.
5. General Markdown or Quarto conventions.

Never silently “standardize” an approved lyric, chord, spelling, punctuation mark, or layout merely because another form seems more conventional.

## Repository Orientation

Before changing files:

- Inspect `_quarto.yml`.
- Identify the actual songs directory and naming pattern.
- Inspect the homepage or song index.
- Inspect any chord-rendering Lua filter, JavaScript, shortcode, or CSS.
- Read at least two recently completed song files, especially one containing mid-word chord changes.
- Check `.gitignore` before generating or modifying rendered output.

The expected general architecture is a Quarto website with one `.qmd` file per song, commonly including:

- `_quarto.yml`
- `index.qmd`
- a song directory such as `songs/`
- stylesheet files
- a chord-rendering filter or script

The existing repository always overrides these assumed names.

## One Song per File

Each song belongs in its own `.qmd` file. Do not combine several songs into one page.

Use the filename supplied by the user when one is given. Otherwise, follow the repository’s existing kebab-case convention:

- `in-the-beginning-god.qmd`
- `adam-and-god.qmd`
- `i-want-to-thank-god.qmd`
- `im-a-man-of-god.qmd`

Do not rename existing files unless explicitly asked.

## Standard Song File

Use the established song template:

```qmd
---
title: "Song Title"
description: ""
page-layout: article
---

<div class="song">

[C] First lyric line here.  
Second lyric line here.  

Next stanza begins here.  

</div>
```

Requirements:

- Preserve valid YAML front matter.
- Keep `description: ""` unless the user supplies a description.
- Use `page-layout: article`.
- Wrap the complete song in `<div class="song">` and `</div>`.
- Leave a blank line after the opening `<div>` and before the closing `</div>`.
- Preserve the repository’s established Markdown line-break convention. Completed files commonly use two trailing spaces after lyric lines.
- Separate stanzas with a blank line.
- Do not add headings, verse labels, chorus labels, credits, scripture references, or commentary unless present in the source or requested by the user.

## Lyrics

Lyrics must be transcribed conservatively and exactly.

Preserve:

- wording
- capitalization
- punctuation
- contractions
- apostrophe style
- intentional dialect
- repeated words or syllables
- hyphenation
- line breaks
- stanza breaks

Do not:

- modernize grammar
- rewrite awkward wording
- replace theological language
- expand contractions
- “fix” an approved spelling
- remove repeated material
- invent missing lyrics
- use chorus shorthand unless the source or established files use it

When text is uncertain, do not guess confidently. Preserve the best-supported reading and clearly report the uncertainty. The user’s correction immediately becomes authoritative.

## Chord Source Syntax

Chords are written inline in the `.qmd` source using square brackets:

```text
[C] [G] [G7] [Am] [Am7] [Fmaj7]
```

The source markers remain inline even though the site’s filter/CSS renders the chord visually above the lyric.

Do not replace the existing chord rendering system with a different library or syntax unless explicitly asked.

### Chord Placement

Place each chord marker immediately before the lyric syllable where the chord change occurs.

Correct pattern:

```text
[C] In the be- [G] ginning God [Am7-Fmaj7]  
Cre- [C] ated the [G] heavens and the [C-G] earth.  
```

Important rules:

- A chord at the start of a line comes before the first sung word.
- A chord change inside a word may require splitting the word at the sung syllable:
  - `be- [G] ginning`
  - `Cre- [C] ated`
- Preserve user-supplied compound chord tokens exactly:
  - `[Am7-Fmaj7]`
  - `[C-G]`
- Do not convert a compound token into separate chords unless the user requests it or the repository already requires that transformation.
- A chord marker at the end of a line is valid when the musical change occurs after the last sung syllable.
- Do not move all chords to the start of a line.
- Do not change chord quality, inversion, enharmonic spelling, or progression based on musical preference.
- Do not infer additional chords merely to make a progression more conventional.
- Follow the spacing style of the approved neighboring files. Do not create broad spacing-only diffs.

Chord accuracy is more important than visual source-code neatness.

## Canonical Approved Style

This is an approved example of the desired overall file style:

```qmd
---
title: "Wonderf’lly"
description: ""
page-layout: article
---

<div class="song">

[G] Wonderf’lly, wonderf’ [G7] lly,  
God made [C] me wonderf’ [Am7] lly.  
When I [D7] look,  I can see I’m just [G] fine.  
I’m designed perfectly,  
[G7] Don’t need [C] changed, no [Am] siree.  

</div>
```

Treat the actual completed repository version as authoritative if it contains more verses or later corrections.

## Editing Workflow

Unless the user explicitly requests batch processing, handle one song at a time.

1. Locate the target song and any supplied source material.
2. Read nearby completed songs for formatting context.
3. Establish the exact lyrics and stanza structure.
4. Add or tighten chord placement at the sung syllables.
5. Make only the changes required for that song.
6. Render or preview the result.
7. Review the rendered page visually when chord alignment is involved.
8. Report the file changed and any genuine uncertainty.
9. Stop. Do not begin another song until the user says to continue.

When the user says “next,” process the next uncompleted song in the already established project order. Do not repeat questions whose answers are clear from the repository or prior work.

A useful two-pass method is:

- Pass 1: lyrics, punctuation, line breaks, and stanzas.
- Pass 2: chord timing and syllable-level alignment.

Do not mark a song complete until both passes are satisfactory.

## Scope Control

Make minimal, focused diffs.

Do not, unless explicitly requested:

- redesign the website
- replace the chord-rendering filter
- rewrite CSS globally
- reorganize directories
- rename completed songs
- reformat every song
- update unrelated dependencies
- alter publishing configuration
- edit generated site files
- commit, push, or publish changes

If a global defect prevents the target song from rendering, fix only the smallest underlying issue necessary and explain it.

## Validation

Use the repository’s documented commands when present. Otherwise, the normal validation sequence is:

```bash
quarto render
```

For interactive inspection:

```bash
quarto preview
```

Validation should confirm:

- YAML parses.
- The `.qmd` page renders without errors.
- The song wrapper is closed.
- Chord tokens are transformed by the established renderer.
- Chords appear above the intended syllables.
- Line and stanza breaks match the source.
- The song appears in the site navigation or generated listing when expected.
- No unrelated files changed.
- Generated output is not added unless the repository intentionally tracks it.

If Quarto is unavailable, still perform structural checks and clearly state that the full render was not run.

## Completion Checklist

A song is complete only when all applicable items pass:

- [ ] One song is contained in one `.qmd` file.
- [ ] Filename follows the established convention.
- [ ] Front matter is valid and the title is exact.
- [ ] `description: ""` is retained unless supplied otherwise.
- [ ] `page-layout: article` is present.
- [ ] The song is wrapped in `<div class="song">`.
- [ ] Lyrics match the supplied or approved text.
- [ ] Punctuation, apostrophes, capitalization, and dialect are preserved.
- [ ] Line breaks and stanza breaks are correct.
- [ ] Every chord is preserved exactly.
- [ ] Every chord is placed before the correct sung syllable.
- [ ] Mid-word changes use intentional syllable splitting.
- [ ] Compound chord tokens remain intact.
- [ ] The page renders successfully, or the inability to render is reported.
- [ ] The rendered chord alignment has been visually checked when possible.
- [ ] No unrelated refactoring or formatting changes were introduced.

## Handoff Response Format

After editing a song, respond briefly with:

- the file changed
- whether rendering passed
- any uncertain lyric or chord placement requiring user review

Do not paste a long explanation when the work is straightforward. When useful, paste the finished `.qmd` content so the user can review the exact lyrics and chords.
