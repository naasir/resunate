%-----------------------------------------------------------
% summary   : resunate - an enchanting resume document class
% author    : naasir ramji (naasir.ramji@gmail.com)
%
% TODO      : [ ] add class options
%           : [ ] add profile picture
%-----------------------------------------------------------

%-----------------------------------------------------------
% identification
%-----------------------------------------------------------
\ProvidesClass{resunate}[2012/06/05 - An enchanting resume document class]
\LoadClass[10pt, oneside, final]{scrartcl}

%-----------------------------------------------------------
% packages
%-----------------------------------------------------------
\RequirePackage[hmargin=0.5in,vmargin=0.7in]
               {geometry}               % set page margins
\RequirePackage{soul}                   % space out
\RequirePackage{scrpage2}               % control page headers and footers
\RequirePackage{titlesec}
\RequirePackage{marvosym}               % email/phone symbols
\RequirePackage{color}                  % text color
\RequirePackage{tabularx,colortbl}      % table support w/ color
\RequirePackage{multirow}               % multirow (merged) rows
\RequirePackage{fontspec}               % specify fonts
\RequirePackage{xifthen}                % if...then...else construct
\RequirePackage{pbox}                   % auto-width paragraph boxes
\RequirePackage{tikz}                   % rounded corners
\RequirePackage{hyperref}               % hyperlinks
\RequirePackage{enumitem}               % list environments

\usetikzlibrary{shapes,decorations}

%-----------------------------------------------------------
% options
%-----------------------------------------------------------
% margins? row colors? hyperlinks? column widths?

%-----------------------------------------------------------
% style
%-----------------------------------------------------------

% remove page numbers
\thispagestyle{empty}

% enable customized headers and footers
\pagestyle{scrheadings}

% interpret dashes (-, --, ---) correctly
% NOTE: in order for this to work, this line has to be above any font definitions
\defaultfontfeatures{Mapping=tex-text}

% setup fonts
\setromanfont{Day Roman}
\setsansfont{Myriad Pro}
\newfontfamily{\icon}{FontAwesome}

% increase the size of the largest font
\renewcommand{\Huge}{\fontsize{32}{40}\selectfont}

% make sans serif the default
\renewcommand*\familydefault{\sfdefault}

% change header font
\renewcommand{\headfont}{\normalfont\rmfamily\scshape}

% TODO: what does this do?
\titleformat{\section}{\large\scshape\raggedleft}{}{0em}{}[\titlerule]

% customize hyperlinks
\hypersetup{
  colorlinks=false,
  pdfborder={0 0 0}
}

% list options
\setlist{nolistsep}
%-----------------------------------------------------------
% constants
%-----------------------------------------------------------

% primary columns
\newlength{\titleColumnWidth}
\setlength{\titleColumnWidth}{0.25\textwidth}
\newlength{\contentColumnWidth}
\setlength{\contentColumnWidth}{0.65\textwidth}
\newlength{\columnPadding}
\setlength{\columnPadding}{0.05\textwidth}

% colors
\definecolor{iconcolor}{HTML}{000000}
\definecolor{subtletextcolor}{HTML}{7A7A7A}
\definecolor{highlightcolor}{HTML}{490778}
\definecolor{accentboxcolor}{HTML}{EFEFEF}

% tikzstyle : roundedrectangle
\tikzstyle{roundedrectangle} = [
  fill=accentboxcolor,
  rectangle,
  rounded corners,
  inner sep=0.5em,
]

% table row height
\renewcommand{\arraystretch}{2.0}

%-----------------------------------------------------------
% variables
%-----------------------------------------------------------
\newcommand*{\name}[1]{\def\@name{#1}}
\newcommand*{\phone}[1]{\def\@phone{#1}}
\newcommand*{\email}[1]{\def\@email{#1}}
\newcommand*{\website}[1]{\def\@website{#1}}
\newcommand*{\blurb}[1]{\def\@blurb{#1}}

%-----------------------------------------------------------
% overrides
%-----------------------------------------------------------

%-----------------------------------------------------------
% summary : generates the header for the page
% usage   : \maketitle
%-----------------------------------------------------------
\renewcommand*{\maketitle}{%
    \textrm{\bfseries{\Huge{\@name\\[12pt]}}}
    \ifthenelse{\isundefined{\@phone}}{}{{\textcolor{iconcolor}{{ \Telefon} \@phone\\}}}
    \ifthenelse{\isundefined{\@email}}{}{{\textcolor{iconcolor}{{\Letter} \@email\\}}}
    \ifthenelse{\isundefined{\@website}}{}{{\textcolor{iconcolor}{{\Pointinghand} \@website\\[12pt]}}}
    \ifthenelse{\isundefined{\@blurb}}{}{{\@accentbox{\@blurb}}}
}

%-----------------------------------------------------------
% usage : \begin{document} ... \end{document}
%-----------------------------------------------------------
\newenvironment{resume}%
               {\begin{@layouttable}}
               {\end{@layouttable}}

%-----------------------------------------------------------
% summary : the resume abstract (or profile)
% usage   : \begin{abstract} ... \end{abstract}
%-----------------------------------------------------------
\renewenvironment{abstract}%
                 {\begin{minipage}[t]{\titleColumnWidth}}
                 {\end{minipage}}

%-----------------------------------------------------------
% summary : the resume body
% usage   : \begin{body} ... \end{body}
%-----------------------------------------------------------
\newenvironment{body}%
               {\begin{minipage}[t]{\contentColumnWidth}}
               {\end{minipage}}

%-----------------------------------------------------------
% summary : a typical section of the resume (education, experience, etc...)
% usage   : \begin{section}{title}...\end{section}
%-----------------------------------------------------------
\renewenvironment{section}[1]%
                 {\@sectiontitle{#1}}
                 {\vspace{12pt}}

%-----------------------------------------------------------
% public methods
%-----------------------------------------------------------

%-----------------------------------------------------------
% summary : a wrench icon
% usage   : \wrench
%-----------------------------------------------------------
\newcommand{\wrench}{%
  {\icon }
}

%-----------------------------------------------------------
% summary : makes the specified text appear subtle (de-emphasizes it)
% usage   : \subtle
%-----------------------------------------------------------
\newcommand{\subtle}[1]{%
  \textcolor{subtletextcolor}{#1}
}

%-----------------------------------------------------------
% summary : a general entry
% usage   : \entry{title}{subtitle}{body}
%-----------------------------------------------------------
\newcommand{\entry}[3]{%
  \textit{#1} \hfill \subtle{#2}\\#3
  \vspace{5pt}
}

%-----------------------------------------------------------
% summary : a work related entry
% usage   : \workentry{start-date}{end-date}{position}{organization}{location}{content}
%-----------------------------------------------------------
\newcommand{\workentry}[6]{%
  {\vspace{7pt}}
  {\large\textbf{#3}}\\
  #4 -- #5 \hfill \textcolor{highlightcolor}{#1 -- #2}\\[5pt]
  {#6}
  \vspace{5pt}
  %% \ifthenelse{\isempty{#6}}{{}}{\\#6\vspace{5pt}}
}

%-----------------------------------------------------------
% private methods
%-----------------------------------------------------------

%-----------------------------------------------------------
% summary : a row in the layout table
% usage   : \@layoutrow{title}{body}
%-----------------------------------------------------------
\newcommand{\@layoutrow}[2]{%
  \begin{minipage}[t]{\titleColumnWidth}
    #2
  \end{minipage}
  &
  \begin{minipage}[t]{\contentColumnWidth}
    #1
  \end{minipage}\\
}

%-----------------------------------------------------------
% summary : a two column table layout
% usage   : \begin{@layouttable} ... \end{@layouttable}
%-----------------------------------------------------------
\newenvironment{@layouttable}%
               {\begin{tabular*}{\linewidth}%
                   {>{\raggedleft}p{\titleColumnWidth}X %
                     @{\hspace{\columnPadding}} %
                     p{\contentColumnWidth} %
                   }
               }
               {\end{tabular*}}

%-----------------------------------------------------------
% summary : a section title (listed in the title column)
% usage   : \@sectiontitle{name}
%-----------------------------------------------------------
\newcommand{\@sectiontitle}[1]{%
  {\LARGE\textrm{\textbf{#1}}}\\[-5pt]
  {\color{subtletextcolor}\line(1,0){340}}\\[-10pt]
}

%-----------------------------------------------------------
% summary : an accented box of text
% usage   : \@accentbox{text}
%-----------------------------------------------------------
\newcommand{\@accentbox}[1]{%
  \begin{tikzpicture}[baseline=0.5em]
    \node[roundedrectangle](box){%
      \begin{minipage}{0.97\linewidth}
        #1
      \end{minipage}
    };
  \end{tikzpicture}
}
