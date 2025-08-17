% modern-roboto.cls — modern LaTeX class with Roboto & brand colors
% ---------------------------------------------------------------
% Usage (in your .tex file):
% \documentclass{modern-roboto}
% \title{Název}
% \author{Autor}
% \begin{document}\maketitle\section{Ukázka} ... \end{document}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{modern-roboto}[2025/08/17 Modern Roboto class with branded colors]

% ---- Options -------------------------------------------------
% Pass-through unknown options to base class (article)
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[a4paper,11pt]{article}

% ---- Engine & fonts -----------------------------------------
\RequirePackage{iftex}
\ifPDFTeX
% pdfLaTeX fallback: use Helvetica-like sans
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage[scaled=0.92]{helvet}
\renewcommand{\familydefault}{\sfdefault}
\else
% XeLaTeX/LuaLaTeX: use Roboto
\RequirePackage{fontspec}
% Prefer Roboto if available; otherwise fall back to TeX Gyre Heros
\IfFontExistsTF{Roboto}{%
	\setmainfont{Roboto}[Ligatures=TeX]
	\setsansfont{Roboto}[Ligatures=TeX]
}{%
	\setmainfont{TeX Gyre Heros}[Ligatures=TeX]
	\setsansfont{TeX Gyre Heros}[Ligatures=TeX]
}
\renewcommand{\familydefault}{\sfdefault}
\fi

% ---- Layout & typography ------------------------------------
\RequirePackage[a4paper,margin=2.5cm]{geometry}
\RequirePackage{microtype}
\RequirePackage{parskip} % modern paragraphs: no indent + vertical space

% ---- Colors --------------------------------------------------
\RequirePackage{xcolor}
% Brand palette (from attached logo)
\definecolor{main}{HTML}{004AAD}% deep brand blue
\definecolor{secondary}{HTML}{8C52FF}% violet accent
% Background blue derived from main (tint)
\colorlet{bg-blue}{main!10}


%---- TITLE ----%
\renewcommand{\maketitle}{
	\begin{titlepage}
		\thispagestyle{empty} % bez čísla stránky
		\centering
		\vspace*{3cm}
		{\Huge\bfseries\color{main}\@title\par}
		\vspace{2cm}
		{\Large Rok realizace: \@date\par}
		\vfill
		\includegraphics[width=0.4\textwidth]{logo.png}
	\end{titlepage}
}

% ---- Headings (titlesec) ------------------------------------
\RequirePackage{titlesec}

% Rules under section headings
\newcommand*{\MainRule}{\par\noindent\color{main}\rule{\linewidth}{1.2pt}}
\newcommand*{\SecondaryRule}{\par\noindent\color{secondary}\rule{\linewidth}{0.8pt}}

\titleformat{\section}
{\Large\bfseries\sffamily\color{main}}{\thesection}{0.8em}{}[\vspace{0.25em}\MainRule]
\titleformat{\subsection}
{\large\bfseries\sffamily\color{secondary}}{\thesubsection}{0.6em}{}[\vspace{0.2em}\SecondaryRule]
\titleformat{\subsubsection}
{\normalsize\bfseries\sffamily\color{main}}{\thesubsubsection}{0.6em}{}

\titlespacing*{\section}{0pt}{2.0ex plus .2ex}{1.0ex}
\titlespacing*{\subsection}{0pt}{1.6ex plus .2ex}{0.8ex}
\titlespacing*{\subsubsection}{0pt}{1.2ex plus .2ex}{0.6ex}

% ---- Hyperlinks ---------------------------------------------
\RequirePackage{hyperref}
\hypersetup{
	colorlinks=true,
	linkcolor=main,
	urlcolor=secondary,
	citecolor=secondary,
	pdfauthor={},
	pdftitle={}
}

% ---- Headers/footers ----------------------------------------
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\fancyfoot[C]{\thepage}

% ---- Lists & tables tweaks ----------------------------------
\RequirePackage{enumitem}
\setlist[itemize]{topsep=3pt,itemsep=2pt}
\setlist[enumerate]{topsep=3pt,itemsep=2pt}
\RequirePackage{booktabs}

% ---- Background helpers -------------------------------------
\RequirePackage{framed}
% A soft blue background box for callouts/examples
\newenvironment{bgbluebox}{%
	\def\FrameCommand{\fboxrule=0pt\fcolorbox{bg-blue}{bg-blue}}%
	\MakeFramed{\advance\hsize-\width\FrameRestore}
}{\endMakeFramed}

% ---- Title styling ------------------------------------------
\renewcommand{\maketitle}{%
	\begingroup
	\setlength{\parindent}{0pt}%
	\vspace*{1em}%
	{\huge\bfseries\color{main}\@title\par}
	\vspace{0.25em}
	{\large\color{secondary}\@author\par}
	\vspace{0.5em}
	\MainRule
	\vspace{1.5em}
	\endgroup
}

% ---- Section number depth & TOC ------------------------------
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{2}

% ---- End -----------------------------------------------------
