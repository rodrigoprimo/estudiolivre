#!/usr/bin/perl -pi

s/\r//;

s/^\d\.\d\.\d\.\d\.\s*(.+)$/\subsubsubsection{$1}/;

s/^\d\.\d\.\d\.\s*(.+)$/\subsubsection{$1}/;

s/^\d\.\d\.\s*(.+)$/\subsection{$1}/;

s/^\d\.\s*(.+)$/\section{$1}/;

s/^\s*\*\s*(.+)$/{item $1}/;

s/^\s*\d[. -](.+)$/{item $1}/;

s/->/\rightarrow\n\n/g;

s/>/\textgreater /g;
s/</\textless /g;


