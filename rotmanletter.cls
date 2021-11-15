%
% rotmanletter.cls -- a document class for writing letters with rotman letterhead 
%
%
% Notes:
%
% 1. This class can be used for creating letters with rotman logo at the
%    header and CS department address at the footer (as in standard rotman
%    letterhead stationery).
% 2. It is based on the standard Latex document class, letter.cls.
% 3. Required packages are epsfig and ifthen.
% 4. If rotman logo is to be included in the head, then the file
%    logo_rotman.png must be provided. Otherwise, the logo is omitted.
% 5. For example usage, please see rotmanletter_example.tex
% 
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{rotmanletter}
\RequirePackage{graphicx}
\RequirePackage{epstopdf}
\RequirePackage{epsfig}
\RequirePackage{ifthen}

\DeclareGraphicsExtensions{.eps}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letter}}
\ProcessOptions
\LoadClass[letterpaper]{letter} % we always use letter paper

\newboolean{logofound}
\IfFileExists{logo_rotman.png}
    {\setboolean{logofound}{true}}
    {\setboolean{logofound}{false}}

\setlength{\textwidth}{6.875in}
\setlength{\textheight}{7.0in}
\setlength{\topskip}{0.0in}
\setlength{\footskip}{1.8in}
\setlength{\oddsidemargin}{-0.25in}
\setlength{\evensidemargin}{-0.25in}
\setlength{\topmargin}{-0.875in}

\DeclareFixedFont{\xcmrbn}{OT1}{cmr}{b}{n}{10}
\DeclareFixedFont{\xcmrmn}{OT1}{cmr}{m}{n}{10}
\DeclareFixedFont{\ixcmrmn}{OT1}{cmr}{m}{n}{9}

\newsavebox{\departmenthead}
\newsavebox{\departmentfoot}

\sbox{\departmenthead}{
    \begin{tabular*}{\textwidth}
                    {@{}l@{\extracolsep{0.0in}}|@{\extracolsep{0.25in}}l@{}}
    \parbox{4.2in}{\raggedright
        \ifthenelse{\boolean{logofound}}
           {\includegraphics[scale=0.8]{logo_rotman.png}}
           {\parbox[t][0.7in][t]{2.0in}{\hfill} 
            \ClassWarning{rotmanletter}{logo_rotman.png COULD NOT BE FOUND!}}
    } &
    \parbox[t][0.7in]{5.125in}{{\xcmrbn Economic Analysis and Policy Area}\\
                               {\ixcmrmn https://rolandocampusano.com/}\\
                               {\ixcmrmn rolando.campusano@rotman.utoronto.ca}} \\
    \end{tabular*}
}

\savebox{\departmentfoot}[\textwidth][c]{\ixcmrmn
   Rotman School of Management 
    ~105 St George Street
    ~Toronto, ON, M4W3G9, Canada
}

% header and footer should be placed only on the first page
\renewcommand{\ps@firstpage}{
    \setlength{\headheight}{1.2in}
    \setlength{\headsep}{0.3in}
    \renewcommand{\@oddhead}{\usebox{\departmenthead}}
    \renewcommand{\@oddfoot}{\usebox{\departmentfoot}}
    \renewcommand{\@evenhead}{}
    \renewcommand{\@evenfoot}{}
}

\renewcommand{\ps@empty}{
    \setlength{\headheight}{1.2in}
    \setlength{\headsep}{0.3in}
    \renewcommand{\@oddhead}{}
    \renewcommand{\@oddfoot}{}
    \renewcommand{\@evenhead}{}
    \renewcommand{\@evenfoot}{}
}

\providecommand{\@evenhead}{}
\providecommand{\@oddhead}{}
\providecommand{\@evenfoot}{}
\providecommand{\@oddfoot}{}

\pagestyle{empty}


% we push closing to the right
\renewcommand{\closing}[1]{\par\nobreak\vspace{\parskip}%
    \stopbreaks
    \noindent
    \hspace*{0.6\textwidth}\parbox{0.4\textwidth}{\raggedright
    \ignorespaces #1 \\ \vspace{.25cm} %
    \ifx\@empty\fromsig
        \fromname
    \else \fromsig 
    \fi\strut}%
    \par
}