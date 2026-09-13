# Lunch Call

A lunch picker that won't let you eat the same thing twice in two days.

Open it, get one restaurant. Don't like it? Swipe left and get the next one.
That's the whole app.

**→ [Open Lunch Call](https://dhwdue.github.io/lunch-call/)**

## The rules

Two constraints keep it from suggesting the same three places forever:

- **Cooldown** — a place can't come back for 2 days after you eat there.
- **Weekly cap** — no more than 3 times in any rolling 7 days.

Both are adjustable under **Rules**.

When your list is too short to satisfy both, the app doesn't refuse to answer —
it bends one rule at a time and tells you on the card (`Bending the 3× weekly cap`,
then `Inside the 2-day cooldown`). If you see that most days, add more places.
Eight to twelve is the comfortable range; under six and it will complain constantly.

## Things that matter more than they sound

- **Passing never logs a meal.** Only "Going" writes history, so rerolling as
  much as you like can't corrupt the counts.
- **The pick is sticky.** Reopen at noon and you get the same suggestion, not a
  fresh roll — otherwise you'd just reroll until you got the answer you wanted.
- **"Not eating out today"** is a real button, so leftovers and lunch meetings
  don't skew the week.
- **Archiving keeps the history.** A place that closed stops being suggested but
  still counts in what you've already eaten.

Places you keep passing on get quietly down-weighted, and flagged after six
passes so you can retire them. Places you haven't had in a while float up.

## Your data

Everything lives in your own browser's local storage. There is no server, no
account, and no analytics — nothing you type leaves your device. That also means
your phone and laptop keep separate lists, and clearing site data wipes it.
Use **Rules → Download JSON** to keep a backup.

## Put it on your phone

1. Open the link in Safari (iOS) or Chrome (Android)
2. Share → **Add to Home Screen**

It runs fullscreen with its own icon, and works offline.

### A daily nudge, with no server

Free, entirely on-device, takes two minutes:

1. **Shortcuts** app → **Automation** → **+**
2. **Time of Day** → your lunch time → **Daily** → Next
3. Add the action **Open URLs**, paste the link above
4. Turn **Run Immediately** on

Your phone opens the app at lunchtime. If having it take over the screen is too
much, leave **Notify When Run** on instead and you'll get a tappable banner.

## Run it yourself

It is one static HTML file with no build step and no dependencies.

```bash
git clone https://github.com/Dhwdue/lunch-call.git
cd lunch-call
python3 -m http.server 8000
```

To host your own copy: fork it, then **Settings → Pages → Source: deploy from
branch `main`, folder `/ (root)`**.

The app also runs as a Claude Artifact, where it uses account-backed storage so
one person's phone and laptop stay in sync. That variant is this same file minus
the `<!doctype>`/`<head>`/`<body>` shell, which the artifact runtime supplies.

## License

MIT
