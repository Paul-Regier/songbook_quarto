# Git Workflow for the Songbook

## Recommended workflow for your songbook

Based on how you’re working:

### Normal day-to-day

- `git status`
  - Where am I at right now?
    - Which branch?
    - Changes since last commit
    - What is staged and ready to commit
- Stage only the files intended for the update, for example:

  ```powershell
  git add songs/new-song.qmd songs_to_add/source.png songs_added/source.png
  ```

  Review `git status` before committing. Avoid `git add .` when unrelated or
  generated files are present.
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
git status
git add _quarto.yml songbook.css songs/
git commit -m "Clean rebuild"
git push
quarto publish gh-pages
```

Adjust the `git add` paths to match the files intentionally changed. Include
`_site/` only when intentionally committing generated site output.

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

Use this manual workflow when raw song screenshots or text files have been placed
in `songs_to_add/`. Adding a file to the directory does not automatically create
or publish a song.

1. Inspect every file in `songs_to_add/` and group files that belong to the same song. A song may have multiple screenshots or text files.
2. Compare the sources with at least two completed files in `songs/`, including one with mid-word chord changes.
3. Create one kebab-case `.qmd` file per song in `songs/` using the established front matter and `<div class="song">` wrapper.
4. Transcribe lyrics, punctuation, line breaks, stanza breaks, and chord symbols conservatively.
5. Place every chord immediately before the sung word or syllable where it changes. Do not invent lyrics or chords that are absent from the source.
6. When a song has a chorus, include the complete chorus between each verse so the displayed song does not require scrolling back to an earlier chorus. Do not leave shorthand placeholders such as `[Chorus]` or `[Refrain]` in the finished song.
7. Run a full render:

   ```powershell
   quarto render
   ```

8. Inspect each new rendered song page for lyric accuracy, chord placement, line wrapping, chorus placement, and layout problems.
9. If every source file for a song was processed successfully, move all of that song's raw files from `songs_to_add/` to `songs_added/`. Leave incomplete or uncertain source files in the queue.
10. Confirm that the new `.qmd` file appears automatically in the homepage listing generated from `songs/`.
11. Run `git status` and review the changed files. Rendering modifies the tracked `_site/` output; stage it only when intentionally updating published artifacts. Otherwise, stage only the intended song, workflow, and archived-source files.
12. Report the new song files, render result, archived source files, and any uncertain transcription or chord placement.
