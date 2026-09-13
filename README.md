# Lunch Call

A lunch picker that won't let you eat the same thing twice in two days.

Open it, get one restaurant. Don't like it? Swipe left and get the next one.
That's the whole app.

**→ [Open Lunch Call](https://dhwdue.github.io/lunch-call/)**

## The rules

Three constraints keep it from marching you to the same three places forever:

- **Repeat cooldown** — a place can't come back until another lunch has passed.
- **Frequency cap** — no more than 3 times in your last 5 lunches.
- **Long walks** — never three long walks in a row.

Each place is tagged with a walking time: under 5 min, 5–10, or over 10. Tap the
pill in **Places** to change it. All three numbers are adjustable under **Rules**.

### Days you skip do not exist

Every rule counts **logged lunches, not calendar days**. If you don't use the app
on Tuesday, Tuesday isn't a gap — Monday's lunch is still "your last lunch" when
you open it on Wednesday. Nothing decays while you're away, so taking a week off
doesn't quietly reset your cooldowns.

Marking a day **Not eating out** is the same: it's invisible to every rule.

### When everything is blocked

With a short list all your options can get blocked at once. Rather than refuse to
answer, the app bends one rule at a time and tells you which on the card —
the frequency cap first, then the long-walk streak, and the repeat cooldown last,
because walking far again is a smaller insult than eating the same thing twice
running.

If you see that most days, add more places. Eight to twelve is comfortable; under
six and it will complain constantly.

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

## A desktop launcher (macOS)

`tools/make-launcher.sh` builds a double-clickable **Lunch Call.app** with the app
icon. It opens Chrome in app mode — no tabs, no address bar, just the app — and
falls back to your default browser if Chrome isn't installed.

```bash
bash tools/make-launcher.sh                      # onto your Desktop
bash tools/make-launcher.sh "$URL" /Applications # or anywhere
```

Drag it to your Dock and it behaves like any other app.

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
one person's phone and laptop stay in sync. `tools/build-artifact.py` generates
that variant — the same file with our document shell and service worker stripped,
since the artifact runtime supplies its own.

## License

MIT
