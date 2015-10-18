\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{homework}[2015/09/15 Homework Class]

\LoadClass{report}

\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{commath}
\RequirePackage{enumitem}
\RequirePackage{parskip}
%\RequirePackage{fullpage}
\RequirePackage[T1]{fontenc}
\RequirePackage{fancyhdr}
\RequirePackage{titling}
\RequirePackage{xspace}
\RequirePackage{changepage}

\RequirePackage{xparse}

\newif\if@oneperpage\@oneperpagefalse
\DeclareOption{oneperpage}{
  \@oneperpagetrue
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

% NEVER split at binary and relational operators
% essentially, don't split math
\relpenalty=10000
\binoppenalty=10000

\newcommand{\cdotfill}{%
    \leavevmode
    \xleaders\hbox to1em{\hfill$\cdot$\hfill}\hfill\kern0pt
}

\newcommand{\mrulefill}{%
    \leavevmode%
    \leaders\hrule height 0.7ex depth \dimexpr0.4pt-0.7ex\hfill\kern0pt
}

\newcommand{\CurrentQuestion}{1}

\newcommand{\question}[1]{%
  \renewcommand{\CurrentQuestion}{#1}
  \bigskip
  \bigskip
  \if@oneperpage
      \pagebreak[4]
  \fi
  \noindent\textsc{\large \bfseries Question #1}% \mrulefill
  \nopagebreak
  \par
  \medskip
  \@afterindentfalse\@afterheading
}

\NewDocumentCommand\subquestion{sO{\CurrentQuestion}m}{%
  \par
  \medskip
  \noindent{\bfseries \IfBooleanTF#1{}{#2}#3}
  \enspace
  \@ifnextchar\par{\@gobble}{}
}

\newcommand{\solution}{%
  \smallskip
  \noindent{\bfseries Solution}
  \nopagebreak
  \par
  \smallskip
  \@afterindentfalse\@afterheading
}

\newcommand{\done}{%
}

\def\HomeworkHTitle{\@title}
\def\HomeworkHAuthor{\@author}
\def\HomeworkHDate{\@date}

\newcommand{\htitle}[1]{%
    \def\HomeworkHTitle{#1}
}
\newcommand{\hauthor}[1]{%
    \def\HomeworkHAuthor{#1}
}
\newcommand{\hdate}[1]{%
    \def\HomeworkHDate{#1}
}

\pagestyle{fancy}
\fancyhf{}
\lhead{\HomeworkHTitle}
\chead{\HomeworkHAuthor}
\rhead{\HomeworkHDate}
\cfoot{\thepage}

% helpful commands
\newcommand{\ZnZ}[1][n]{\ensuremath{\mathbb{Z}/#1\mathbb{Z}}}
\newcommand{\Z}{\ensuremath{\mathbb{Z}}}
\newcommand{\Q}{\ensuremath{\mathbb{Q}}}
