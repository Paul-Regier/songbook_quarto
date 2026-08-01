# Git Workflow for the Songbook

## Recommended workflow for your songbook

Based on how you’re working:

### Normal day-to-day

- `git status`
  - Where am I at right now?
    - Which branch?
    - Changes since last commit
    - What is staged and ready to commit
- `git add .`
  - `.` = everything
- `git commit -m "Update songs"`
  - Saves changes locally – creates a snapshot of the project on the machine.
  - `-m` = commit message
- `git push`
  - Sends local commits to the remote repository.
  - Makes work public/backed up.
- `quarto publish gh-pages`

### Big changes, CSS, listings, or cleanup

```powershell
quarto render --clean
git add .
git commit -m "Clean rebuild"
git push
quarto publish gh-pages
```

## Adding a new song

1. Add a new file, for example: `songs/new-song.qmd`.
2. Preview the site:

   ```powershell
   quarto render
   ```

3. Render and publish again:

   ```powershell
   quarto publish gh-pages
   ```

4. The homepage automatically updates with the new entry.

## Mental model

- Render = build
- Publish = build + deploy

## Add queued new songs

Use this workflow when raw song screenshots or text files have been placed in `songs-to-add/`.

1. Inspect every file in `songs-to-add/` and group files that belong to the same song.
2. Compare the sources with at least two completed files in `songs/`, including one with mid-word chord changes.
3. Create one kebab-case `.qmd` file per song in `songs/` using the established front matter and `<div class="song">` wrapper.
4. Transcribe lyrics, punctuation, line breaks, stanza breaks, and chord symbols conservatively.
5. Place every chord immediately before the sung word or syllable where it changes. Do not invent lyrics or chords that are absent from the source.
6. Run a full render:

   ```powershell
   quarto render
   ```

7. Inspect each new rendered song page for lyric accuracy, chord placement, line wrapping, and layout problems.
8. If every source file for a song was processed successfully, move those raw files from `songs-to-add/` to `songs-added/`. Leave incomplete or uncertain source files in the queue.
9. Run `git status` and review the changed files. Stage only the intended song, workflow, and archived-source files.
10. Report the new song files, render result, archived source files, and any uncertain transcription or chord placement.
