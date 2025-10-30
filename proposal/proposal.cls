% imperial_proposal.cls — Compact A4 class tailored for Imperial-style research statements
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{proposal}[2025/10/29 v1.0 compact class for research statements]

% -------- Options / Base --------
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[11pt]{article}

\makeatletter

% -------- Engine-aware fonts --------
\RequirePackage{iftex}
\ifPDFTeX
  \RequirePackage[T1]{fontenc}
  \RequirePackage[utf8]{inputenc}
  \RequirePackage{microtype}
  \RequirePackage{helvet}
  \renewcommand{\familydefault}{\sfdefault} % Sans default (Helvetica/Arial look)
\else
  \RequirePackage{fontspec}
  \defaultfontfeatures{Ligatures=TeX, Scale=MatchLowercase}
  \setmainfont{Helvetica Neue}
  \RequirePackage{microtype}
\fi

% -------- Geometry (A4, header/footer inside margins, max body height) --------
\RequirePackage[
  paper=letterpaper,
  left=0.8in, right=0.8in,
  top=0.7in, bottom=1in,
  includehead, includefoot,
  headheight=10pt,    % header box height
  headsep=6pt,        % gap between header and text
  footskip=2pt       % baseline of footer to bottom
]{geometry}

% -------- Header / Footer --------
% ===== Header/footer logic (no overlap, sized correctly) =====
\RequirePackage{fancyhdr}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}

% Make sure header lives inside the top margin (you likely already have includehead)
% and size the header box + gap for two lines on page 1:
\setlength{\headheight}{25pt}  % ~2 × 12–13pt lines
\setlength{\headsep}{6pt}      % small but visible gap before body

\makeatletter
% Optional short forms for later pages
\newcommand{\runningtitle}[1]{\gdef\@runningtitle{#1}}
\newcommand{\runningauthor}[1]{\gdef\@runningauthor{#1}}
\let\@runningtitle\@empty
\let\@runningauthor\@empty

% --- Subsequent pages: small, inline, bullet; centered page number ---
\fancyhead[C]{%
  {\small\nouppercase{%
    \ifx\@runningtitle\@empty \@title \else \@runningtitle \fi
    \enspace\textbullet\enspace
    \ifx\@runningauthor\@empty \@author \else \@runningauthor \fi
  }}%
}
\fancyfoot[C]{\thepage}
\pagestyle{fancy}

% --- First page: two lines in normalsize (no page number) ---
\fancypagestyle{firstpage}{%
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \fancyhead[C]{%
    % Set a controlled leading so two lines fit in \headheight neatly
    {\fontsize{10.95}{12.5}\selectfont % normalsize with ~12.5pt leading
      \nouppercase{%
        \parbox[t]{0.8\textwidth}{%
          \centering \bf \@title\\ \@author
        }%
      }%
    }%
  }%
}
\AtBeginDocument{%
  \thispagestyle{firstpage}%
  \pagestyle{fancy}%
}
\makeatother
% ===== End header/footer logic =====
% ==== End minimal header/footer logic ====

% -------- Sections (compact) --------
\RequirePackage{titlesec}
\titleformat{\section}{\normalsize\bfseries}{\thesection}{0.6em}{}
\titleformat{\subsection}{\normalsize\bfseries}{\thesubsection}{0.5em}{}
\titlespacing*{\section}{0pt}{1.0ex}{0.5ex}
\titlespacing*{\subsection}{0pt}{0.8ex}{0.4ex}

% -------- Paragraphs & Lists (compact) --------
\setlength{\parindent}{2mm}
\setlength{\parskip}{0pt}
\RequirePackage{enumitem}
\setlist{nosep}

% -------- Math & Captions --------
\setlength{\abovedisplayskip}{6pt}
\setlength{\belowdisplayskip}{6pt}
\RequirePackage[font=small,labelfont=bf]{caption}

% -------- Minimal inline title (optional) --------
% Keep for calls that require a visible title; otherwise, omit \maketitle in the doc.

\renewcommand{\maketitle}{%
  \noindent{\bfseries\@title}\par
  \vspace{0.25\baselineskip}
}

% -------- PDF metadata convenience --------
\RequirePackage[hidelinks]{hyperref}
\AtBeginDocument{%
  \hypersetup{%
    pdftitle={\@title},
    pdfauthor={\ifx\@runningauthor\@empty \@author \else \@runningauthor \fi}
  }%
}

\makeatother

% ---------------- Usage ----------------
% \documentclass{imperial_proposal}
% \title{Your Proposal Title}
% \author{Your Name}
% \doctype{Research Vision}        % optional (default: Research Statement)
% \runningauthor{V. Palacio}       % optional
% \runningtitle{Short Title}       % optional; header defaults to Author • Doctype
% % \runningheader{Custom Header}  % optional; overrides header content entirely
% \begin{document}
% % \maketitle  % only if the call requires a visible on-page title; otherwise omit
% \section{Overview} ...
% \end{document}
