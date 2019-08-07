# Unreleased

## Added
- Added summary view to the end of tests
- Added `LabelledProgressView` to display a labelled progress bar with an animatable value
- Add `QuestionSummaryView` to display the summary of a question after a test.

## Changed
- Changed scroll view in markdown views on cards to not bounce. Makes it so the view only scrolls if the content is bigger than the view.

## TODO
- [ ] Write some tests

-----
# Proposed Template
This is how we organize the CHANGELOG at work. It gives everyone a place to write out the important changes they made since the last release. It helps everyone to know what has changed. We just copy and paste these as the notes in Testflight for beta testers and then we re-word them to make them non-engineer readable for the release notes to the AppStore. When we release we add a line with `# mm.dd.yy - Semantic Version (build number)` and just keep adding the unreleased stuff above it. I figured it might be helpful for us as things change over time, but if you have ideas on a better way to organize stuff let me know.

## Added
- Added some cool new feature

## Changed
- Changed something

## Removed
- Got rid of some bad code

## Deprecated
- Removed support for old API

## TODO
- [ ] Write some tests
