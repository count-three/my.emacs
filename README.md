# Magit basic workflow

## 1. Start Magit

```text
C-x g
```

Open `magit-status`.

Equivalent command:

```bash
git status
```

---

## 2. Stage file

Place cursor on target file and press:

```text
s
```

If section is folded, press:

```text
TAB
```

Equivalent command:

```bash
git add init.el
```

---

## 3. Commit

Press:

```text
c c
```

Write commit message.

Example:

```text
Add sanitized init.el
```

Finalize commit with:

```text
C-c C-c
```

Equivalent command:

```bash
git commit -m "Add sanitized init.el"
```

---

## 4. Rename branch to main

Press:

```text
b r
```

Rename branch:

```text
main
```

Equivalent command:

```bash
git branch -M main
```

Alternative:

```text
M-x magit-branch-rename
```

---

## 5. Add remote repository

Press:

```text
M a
```

Remote name:

```text
origin
```

Repository URL:

```text
https://github.com/count-three/my.emacs.git
```

Equivalent command:

```bash
git remote add origin https://github.com/count-three/my.emacs.git
```

---

## 6. Push to GitHub

Press:

```text
P p
```

Equivalent command:

```bash
git push
```
