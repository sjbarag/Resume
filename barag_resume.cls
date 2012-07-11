% ----- use the article class as a base -----
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{barag_resume}[4/6/2012 - Sean Barag's resume/cv class]

\RequirePackage{geometry}
\RequirePackage{fancyhdr}                % It's a fancy... wait for it... header!
\RequirePackage{libertine}               % Linux Libertine fonts
\RequirePackage{marvosym}                % Provides symbols next to contact info
\RequirePackage{ifsym}                   % Provides the house symbol next to contact info
\RequirePackage{mdwlist}                 % itemize* and friends are more compact
\RequirePackage{parskip}                 % Use whitespace to delimit paragraphs & prevent indentations
\RequirePackage{multicol}                % Multiple columns for computer skills section
\RequirePackage{hyperref}                % Hyperlinks and metadata
\RequirePackage[T1]{fontenc}             % Use Type1 fonts
\RequirePackage{calc}                    % Calculate box lengths
\RequirePackage{tikz}                    % Draw a neat li'l timeline
\RequirePackage{etoolbox}                % Checks for definition of things

\usetikzlibrary{calc}                    % allows more precise layout in TikZ
\usepgflibrary{arrows}                   % loads nicer arrows in PGF for the timeline

% ----- set up document geometry -----
\geometry{top=.25in,
          bottom=.1in,
          hmargin=.4in,
          marginparwidth=.22\textwidth,
          marginparsep=.05\textwidth,
          includemp, reversemp,     % Enable mergin par and move it to the left side
          letterpaper,
          includehead, includefoot}

\renewcommand*\familydefault{\sfdefault} % apply linux biolinum (sans-serif)
\urlstyle{same}                          % sans-serif URLs

% ----- hyperlink & metadata setup -----
\hypersetup{
    colorlinks=false,             % don't color any links
    pdfborder={0 0 0},            % and prevent ugly boxes around them
    pdfdisplaydoctitle=true,      % show title instead of filename
}

% ----- email helper command -----
\newcommand{\mailto}[1]{\href{mailto:#1}{#1}}

% ----- commands to set info for the header
% use the LaTeX standard "\author" for your name
\newcommand{\homeaddress}[1]{\def\@homeaddress{#1}}
\newcommand{\phonenumber}[1]{\def\@phonenumber{#1}}
\newcommand{\emailaddress}[1]{\def\@emailaddress{#1}}
\newcommand{\portfolio}[1]{\def\@portfolio{#1}}

% ----- tikz drawing of a house -----
\newcommand{\tikzhome}{%
\begin{tikzpicture}[scale=.175]
    \draw[thin] (0,.75) -- ++(0,-.75) -- ++(1,0) -- ++(0,.75)
        -- (1.25, .75) -- (.5, 1.25) -- (-.25, .75) -- (0,.75) -- ++(0, -.25)
        (.35, 0) -- (.35, .5) -- (.65, .5) -- (.65, 0);
\end{tikzpicture}%
}

% ----- fancyhdr setup -----
\fancyheadoffset[LO,LE]{\marginparsep+\marginparwidth}        % header goes across marginpar
\pagestyle{fancy}
\lhead{%
    \Huge \@author
}
\rhead{%
    \flushright
    \begin{tabular}{r c}
        \@ifundefined{@homeaddress} {}{\@homeaddress          & \tikzhome \\  } % house
        \@ifundefined{@phonenumber} {}{\@phonenumber          & \Mobilefone\\ } % telephone
        \@ifundefined{@emailaddress}{}{\mailto{\@emailaddress} & \Letter \\    } % envelope
        \@ifundefined{@portfolio}   {}{\url{\@portfolio}      & \texttt{\textless \textgreater}} % <>
    \end{tabular}\hspace{-1em}
}
\cfoot{}

\addtolength{\headheight}{\baselineskip*2}  % add extra space after header rule
\renewcommand{\headrulewidth}{.6pt}         % thicken the header rule
\addtolength{\parskip}{4pt}                 % expand space between paragraphs just a touch
\setlength{\footskip}{0pt}

% ----- resume section titles -----
\renewcommand*{\section}[1]{%
    \hspace{0pt}\marginpar{\textbf{#1}}\relax
}

% ----- job entries -----
\newenvironment{job}[4]
{\begin{tikzpicture}[overlay]
    \node[minimum width=\textwidth + 8pt, minimum height=1em]
        at (current bounding box.center) [anchor = north west, xshift=-6pt] (jobbox) {};
    \draw[color=gray] (jobbox.north west) node[anchor=base east, font=\scriptsize] (datebox) {#4};
    \draw[color=gray] (datebox.east) -- ++(-2bp, 0);
  \end{tikzpicture}%
%
{\large\emph{#1}\ }{\small in #2} \\
             #3
  \begin{itemize*}\vspace{-1em}}
{\end{itemize*}}

% ----- computer skills itemize -----
\newenvironment{csitemize}
{\begin{list}{\labelitemi}{\leftmargin=.5cm \itemindent=0em}}
{\end{list}}
