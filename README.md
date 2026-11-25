# Rahul Passi — Portfolio

A responsive, static portfolio website with a print-ready PDF portfolio. Built with plain HTML, CSS and JavaScript; no build step or package installation is needed to run the site.

## Run locally

Open `index.html` in a browser, or serve the folder locally:

```sh
python3 -m http.server 8000
```

Then visit <http://localhost:8000>.

## Portfolio PDF

The website's download button points to `assets/Rahul_Passi_Portfolio.pdf`. The PDF is designed for A4 printing and includes clickable project and contact links. Regenerate it after content changes with:

```sh
swift scripts/build_pdf.swift
```

## Deploy on GitHub Pages

This is a static site: GitHub Pages can serve it directly from the repository root. No build command, package installation, or custom domain is required. Relative asset paths keep the stylesheet, JavaScript, favicon and PDF working both at the domain root and under a repository subpath.

### 1. Add the files to your GitHub repository

The project folder currently has no Git metadata or remote configured. To update an existing repository without replacing its history:

1. Find the repository name in your GitHub account and clone it (replace `<repository-name>`):

   ```sh
   git clone https://github.com/Rahulpassi67/<repository-name>.git
   ```

2. Copy the contents of this portfolio folder into the cloned repository folder. For example, replace both paths below with the actual local paths. Keep the repository's `.git` directory intact. Review any file replacements before continuing.

   ```sh
   cp -R /path/to/rahul-portfolio/. /path/to/<repository-name>/
   cd /path/to/<repository-name>
   ```

3. From inside the cloned repository, review and commit the files:

   ```sh
   git status
   git add .
   git commit -m "Prepare portfolio for GitHub Pages"
   git push
   ```

If your GitHub repository is empty and you prefer to initialize this folder directly, run these commands from this folder, replacing `<repository-name>`:

```sh
git init
git branch -M main
git remote add origin https://github.com/Rahulpassi67/<repository-name>.git
git add .
git commit -m "Prepare portfolio for GitHub Pages"
git push -u origin main
```

Do not run `git init` in a folder that already contains a `.git` directory.

### 2. Enable GitHub Pages

1. Open the repository on GitHub and select **Settings → Pages**.
2. Under **Build and deployment**, set **Source** to **Deploy from a branch**.
3. Select the branch you pushed (usually `main`) and the **/(root)** folder, then select **Save**.
4. Wait for the Pages deployment to finish. GitHub displays the published address in the Pages settings.

For a repository named `Rahulpassi67.github.io`, the URL is `https://Rahulpassi67.github.io/`. For another repository name, the URL is `https://Rahulpassi67.github.io/<repository-name>/`.

### 3. Check the published site

Open the Pages URL and check the main navigation, project links, contact links, favicon and **Download portfolio** button. The PDF is stored at `assets/Rahul_Passi_Portfolio.pdf` and is served with the site. After later changes, commit and push again; GitHub Pages republishes the selected branch.

No repository settings have been changed and no files have been pushed by this project setup.

## Deploy on Render

1. Create a new **Static Site** in Render and connect the GitHub repository.
2. Set the build command to blank and the publish directory to `.`.
3. Deploy. No server-side runtime is required.

## Project files

- `index.html` — page content and metadata
- `styles.css` — responsive visual system, layout and reduced-motion handling
- `script.js` — mobile navigation and subtle reveal effects
- `favicon.svg` — vector favicon
- `.nojekyll` — tells GitHub Pages to serve the static site without Jekyll processing
- `assets/Rahul_Passi_Portfolio.pdf` — matching downloadable portfolio
- `scripts/build_pdf.swift` — macOS PDF generation script

The profile, education, skills, project details and internship responsibilities are based on the supplied resume and portfolio brief.
