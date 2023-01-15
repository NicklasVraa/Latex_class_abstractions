% DESC: LaTeX document-class abstraction for academic papers.
% AUTH: Nicklas Vraa.

% CLASS CONFIGURATION: ----------------------------------------------------

    \NeedsTeXFormat{LaTeX2e}
    \ProvidesClass{paper}[2022/12/12 Nicklas Vraa's custom LaTeX class]

    % Intercept base-class options.
    \newcommand{\onecol}{true}
    \DeclareOption{twocolumn}{
        \renewcommand{\onecol}{false}
        \PassOptionsToClass{\CurrentOption}{article}
    }

    \DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
    \ProcessOptions\relax
    \LoadClass{article}

% PACKAGES: ---------------------------------------------------------------

    \RequirePackage[utf8]{inputenc}
    \RequirePackage[T1]{fontenc}
    \RequirePackage[nottoc]{tocbibind}
    \RequirePackage{amsfonts, amsmath, amssymb, caption, cite, enumitem, esint, fancyhdr, float, geometry, graphicx, hyperref, inconsolata, lastpage, listings, microtype, parskip, setspace, silence, siunitx, svg, tabularray, titlesec, titletoc, titling, ulem, xcolor}

    \WarningsOff* % Ignore all warnings.

% COLUMN-COUNT-SPECIFIC: --------------------------------------------------

    % Adjust margins, title placement and 1st level heading formatting.
    \ifnum\pdfstrcmp{\onecol}{true}=0
        \geometry{a4paper, top=28mm, left=34mm, right=34mm, bottom=36mm}
        \setlength{\droptitle}{-3.8em}
    \else
        \geometry{a4paper, top=22mm, left=26mm, right=26mm, bottom=32mm}
        \setlength{\columnsep}{5mm}
        \setlength{\droptitle}{-2.8em}
    \fi

% HEADER & FOOTER: --------------------------------------------------------

    \fancypagestyle{firstpage}{%
        \fancyhf{}
        \fancyfoot[C]{\thepage\ of \pageref{LastPage}}
        \renewcommand{\headrulewidth}{0pt}
    }
    \fancypagestyle{withoutheader}{%
        \fancyhf{}
        \fancyfoot[C]{\thepage\ of \pageref{LastPage}}
        \renewcommand{\headrulewidth}{0.0pt}
    }
    \fancypagestyle{withheader}{%
        \fancyhf{}
        \fancyfoot[C]{\thepage\ of \pageref{LastPage}}
        \renewcommand{\headrulewidth}{0.1pt}
    }
    \pagestyle{withoutheader}

    % If header is included, adjust margins and title placement.
    \newcommand{\header}[3]{%
        \ifnum\pdfstrcmp{\onecol}{true}=0 % If one-column.
            \geometry{a4paper, top=32mm, left=34mm, right=34mm, bottom=36mm}
        \else % Else if two-column.
            \geometry{a4paper, top=30mm, left=26mm, right=26mm, bottom=32mm}
        \fi
        \setlength{\droptitle}{-5em}
        \pagestyle{withheader}
        \lhead{#1}\chead{#2}\rhead{#3}
    }

% FRONTMATTER: ------------------------------------------------------------

    % Reduce vertical space before date.
    \NewCommandCopy{\olddate}{\date}
    \renewcommand{\date}[1]{\olddate{\vspace{0.2em}\normalsize{#1}}}

    % Title, subtitle, authors and byline commands.
    \newcommand{\titles}[2]{%
        \title{\textbf{\textsc{#1}}\\[0.8ex] \large\scshape #2}%
    }

    \newcommand{\authors}[1]{%
        \author{\normalsize{#1}}%
    }

    % Either this alone, or both \authors and \date.
    \newcommand{\byline}[1]{\author{\normalsize{#1}} \date{}}

    % Shortcut.
    \newcommand{\front}{\maketitle\thispagestyle{firstpage}}%\thispagestyle{firstpage}

% ABSTRACT: ---------------------------------------------------------------

    \renewcommand{\abstract}[1]{\textbf{\textsc{Abstract}}: #1}

% TABLE OF CONTENTS: ------------------------------------------------------

    % Adjust indentation and formatting of entries.
    \titlecontents{section}[0em]{}{\thecontentslabel.\hspace*{0.5em}}{}{\titlerule*[0.5pc]{.}\contentspage}
    \titlecontents{subsection}[0em]{\hspace*{1.4em}}{\thecontentslabel.\hspace*{0.5em}}{}{\titlerule*[0.5pc]{.}\contentspage}
    \titlecontents{subsubsection}[0em]{\hspace*{2.8em}}{\thecontentslabel.\hspace*{0.5em}}{}{\titlerule*[0.5pc]{.}\contentspage}

    \newcommand{\toc}{\tableofcontents} % Shortcut.

% FORMATTING: ------------------------------------------------------------

    \renewcommand{\b}[1]{\textbf{#1}} % Bold.
    \renewcommand{\i}[1]{\textit{#1}} % Italic.
    \renewcommand{\u}[1]{\uline{#1}} % Underline.
    \newcommand{\m}[1]{$#1$} % Inline math.
    \newcommand{\s}[1]{\sout{#1}} % Strikethrough.

% HEADINGS: ---------------------------------------------------------------

    % Adjust spacing between heading and text.
    \titlespacing\numberless{0pt}{14pt}{4pt}
    \titlespacing\section{0pt}{14pt}{4pt}
    \titlespacing\subsection{0pt}{14pt}{4pt}
    \titlespacing\subsubsection{0pt}{14pt}{4pt}

    % Set formatting of headings.
    \titleformat*{\section}{\bfseries\scshape}
    \titleformat*{\subsection}{\bfseries\scshape}
    \titleformat*{\subsubsection}{\bfseries\scshape}
    \titleformat*{\paragraph}{\bfseries\scshape}
    \titleformat*{\subparagraph}{\bfseries\scshape}

    % Add '.' after number to numbered headings.
    \renewcommand*{\@seccntformat}[1]{\csname the#1\endcsname.\hspace{0.5em}}

    % Set lowest level of heading that will be numbered.
    \setcounter{secnumdepth}{3}

    % Shortcuts for headings.
    \newcommand{\h}[2][\DefaultOpt]{%
        \def\DefaultOpt{#2}\section[#1]{#2}\label{#2}%
    }
    \newcommand{\hh}[2][\DefaultOpt]{%
        \def\DefaultOpt{#2}\subsection[#1]{#2}\label{#2}%
    }
    \newcommand{\hhh}[2][\DefaultOpt]{%
        \def\DefaultOpt{#2}\subsubsection[#1]{#2}\label{#2}%
    }
    \newcommand{\hhhh}[2][\DefaultOpt]{%
        \def\DefaultOpt{#2}\paragraph[#1]{#2}\label{#2}%
    }
    \newcommand{\hhhhh}[2][\DefaultOpt]{%
        \def\DefaultOpt{#2}\subparagraph[#1]{#2}\label{#2}%
    }

    % Non-numbered heading shortcut.
    \renewcommand{\H}[1]{%
        \section*{#1}\label{#1}\addcontentsline{toc}{section}{#1}%
    }

% CODE: -------------------------------------------------------------------

    \lstdefinestyle{inline}{ % Inline styling.
        basicstyle=\ttfamily\footnotesize, breaklines=true
    }
    \lstdefinestyle{block}{ % Block styling.
        basicstyle=\ttfamily\footnotesize,
        commentstyle=\color[rgb]{0.5,0.5,0.5},
        postbreak=\mbox{\hspace{-2.5em}\textcolor{gray}{$\hookrightarrow$}\space\space},
        breaklines=true,
        numbers=left,
        numberstyle=\tiny,
        numbersep=7pt,
        showspaces=false,
        tabsize=4,
        xleftmargin=14pt
    }
    \RenewDocumentCommand{\c}{v}{%
        \lstinline[style=inline]{#1}%
    } % Shortcut.

    % Custom code environment.
    \lstnewenvironment{code}[3]{
        \newcommand{\append}{\captionof{lstlisting}{#3}\label{#1}}
        \begin{center}\noindent\rule{\columnwidth}{0.1pt}\end{center}\vspace{-1mm}
        \lstset{language=#2,style=block}
    }{
        \vspace{-5mm}
        \begin{center}\noindent\rule{\columnwidth}{0.1pt}\end{center}
        \append\vspace{0.8em}
    }

% MATHEMATICS: -----------------------------------------------------------

    % Shortcuts.
    \newcommand{\mean}[1]{\overline{#1}}
    \newcommand{\pfrac}[2]{\left( \frac{#1}{#2} \right)}
    \renewcommand{\Re}{\mathbb{R}} % Real set.
    \renewcommand{\Im}{\mathbb{I}} % Imaginary set.
    \newcommand{\N}{\mathbb{N}} % Natural set.
    \newcommand{\Z}{\mathbb{Z}} % Integer set.
    \newcommand{\Q}{\mathbb{Q}} % Rational set.
    \newcommand{\C}{\mathbb{C}} % Complex set.
    \renewcommand{\epsilon}{\varepsilon}

    % Custom math environment.
    \renewenvironment{math}[1]{
        \begin{equation}\label{#1}
    }{
        \end{equation}
    }

% LISTS: ------------------------------------------------------------------

    % Create new list-type based on 'itemize'.
    \newlist{bullets}{itemize}{10}
    \setlist[bullets,1]{leftmargin=6mm}
    \setlist[bullets]{leftmargin=*,label=$\vcenter{\hbox{\tiny$\bullet$}}$,labelindent=\parindent}

    % Create new list-type based on 'enumerate'.
    \newlist{numbers}{enumerate}{10}
    \setlist[numbers,1]{leftmargin=6mm}
    \setlist[numbers]{leftmargin=*,label*=\arabic*.,labelindent=\parindent}

% FIGURES: ---------------------------------------------------------------

    \def\maxwidth#1{\ifdim\Gin@nat@width>#1 #1\else\Gin@nat@width\fi}
    \newcommand{\fig}[4][1]{ % One command for vectors and images.
        \begin{figure}[h!]
            \centering
            \filename@parse{#3}
            \ifnum\pdfstrcmp{\filename@ext}{svg}=0%
                \sbox0{\includesvg[width=#1\columnwidth]{#3}}%
            \else%
                \sbox0{\includegraphics[width=\maxwidth{#1\columnwidth}]{#3}}%
            \fi%
            \begin{minipage}{\wd0}\usebox0\caption{#4}\label{#2}\end{minipage}
        \end{figure}
    }

% TABLES: ----------------------------------------------------------------

    \newcommand{\cols}[3]{ % Column-based table.
        \begin{table}[h!]
            \centering
            \sbox0{%
                \begin{tblr}{
                    hline{1,2,Z} = {0.1pt,solid},
                    rowsep = {1pt},
                    hspan = even}%
                    #3
                \end{tblr}}
            \begin{minipage}{\wd0}
                \usebox0\caption{#2}\label{#1}
            \end{minipage}
        \end{table}
    }
    \newcommand{\rows}[3]{ % Row-based table.
        \begin{table}[h!]
            \centering
            \sbox0{%
                \begin{tblr}{
                    hline{1,Z} = {0.1pt,solid},
                    vline{2} = {0.1pt,solid},
                    rowsep = {1pt},
                    hspan = even}%
                    #3
                \end{tblr}}
            \begin{minipage}{\wd0}
                \usebox0\caption{#2}\label{#1}
            \end{minipage}
        \end{table}
    }
    \newcommand{\grid}[3]{ % Grid-based table.
        \begin{table}[h!]
            \centering
            \sbox0{%
                \begin{tblr}{
                    hline{1,2,Z} = {0.1pt,solid},
                    vline{2} = {0.1pt,solid},
                    rowsep = {1pt},
                    hspan = even}%
                    #3
                \end{tblr}}
            \begin{minipage}{\wd0}
                \usebox0\caption{#2}\label{#1}
            \end{minipage}
        \end{table}
    }

% CAPTIONS: ---------------------------------------------------------------

    % Set formatting of caption text.
    \DeclareCaptionFormat{myformat}{\fontsize{8}{9}\selectfont#1#2#3}
    \captionsetup{
        format=plain,
        labelfont=bf,
        font=scriptsize,
        justification=raggedright,
        singlelinecheck=false
    }

% REFERENCES: -------------------------------------------------------------

    \hypersetup{hidelinks} % Remove box around links.
    \normalem % Allow italized and underlined text.

    % Add reference category for code blocks.
    \renewcommand{\lstlistingname}{Snippet}
    \providecommand*{\lstlistingautorefname}{snippet}

    \renewcommand{\url}[2]{\href{#2}{#1}} % Shortcut.

    % Add underline to urls.
    \NewCommandCopy{\oldhref}{\href}
    \renewcommand{\href}[2]{\uline{\oldhref{#1}{#2}}}

    % Lowercase reference names.
    \renewcommand{\r}[1]{\renewcommand\lstlistingautorefname{snippet}\renewcommand\figureautorefname{figure}\renewcommand\equationautorefname{equation}\renewcommand\tableautorefname{table}\renewcommand\sectionautorefname{section}\renewcommand\subsectionautorefname{section}\renewcommand\subsubsectionautorefname{section}\renewcommand\paragraphautorefname{section}\renewcommand\subparagraphautorefname{section}\autoref{#1}}

    % Uppercase reference names.
    \newcommand{\R}[1]{\renewcommand\lstlistingautorefname{Snippet}\renewcommand\figureautorefname{Figure}\renewcommand\equationautorefname{Equation}\renewcommand\tableautorefname{Table}\renewcommand\sectionautorefname{Section}\renewcommand\subsectionautorefname{Section}\renewcommand\subsubsectionautorefname{Section}\renewcommand\paragraphautorefname{Section}\renewcommand\subparagraphautorefname{Section}\autoref{#1}}

% BIBLIOGRAPHY: -----------------------------------------------------------

    \bibliographystyle{unsrt} % Sort by order of appearance.
    \newcommand{\bib}[1]{\bibliography{#1}} % Shortcut.