From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: clock_nanosleep and NTP drift correction
Date: Thu, 13 Sep 2012 17:22:27 +0200
Message-ID: <5051FA33.7050205@drcomp.erfurt.thur.de>
References: <F9467A784CC48947B1D879F07370839E0EBB712C@fe20099s.ecn.etasgroup.com> <20120913120922.GA5341@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Koehrer Mathias (ETAS/ESS2)" <mathias.koehrer@etas.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ltw.loris.tv ([188.40.101.23]:47500 "EHLO ltw.loris.tv"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754463Ab2IMPai (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 Sep 2012 11:30:38 -0400
In-Reply-To: <20120913120922.GA5341@uudg.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 09/13/2012 02:09 PM, Luis Claudio R. Goncalves wrote:

> | clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &ts, NULL);
> | within the application's main loop.
> | The value of "ts" will be incremented after every call.
> | 
> CLOCK_MONOTONIC is not affected by NTP nor any adjusts to date and time
> that the admin/user may perform.

I beg to differ. CLOCK_MONOTONIC is frequency adjusted. Though it won't
jump, it will slew. From man clock_gettime:

  CLOCK_MONOTONIC
         Clock  that  cannot  be  set and represents monotonic time since
         some unspecified starting point.  This clock is not affected  by
         discontinuous  jumps  in  the  system  time (e.g., if the system
         administrator manually changes the clock), but  is  affected  by
         the incremental adjustments performed by adjtime(3) and NTP.


Which means it's more or less what the original poster wants.


Though it's LaTeX, here's a table I've created a couple of months ago:

\begin{table}
  \begin{tabular*}{\textwidth}{l@{\extracolsep{\fill}}ccccc}
    \toprule
    {\scshape clock name}& {\scshape posix}& {\scshape set}& {\scshape
adjust}&
{\scshape jump} &
{\scshape slew}\\
    \midrule
\texttt{CLOCK_REALTIME}& yes& yes& yes& yes& yes\\
\texttt{CLOCK_MONOTONIC}& yes& no& yes& no& yes\\
\texttt{CLOCK_MONOTONIC_RAW}& no& no& no& no& no\\
\texttt{CLOCK_PROCESS_CPUTIME_ID}& yes& no& no& SMP& no\\
\texttt{CLOCK_THREAD_CPUTIME_ID}& yes& no& no& SMP& no\\
\bottomrule
  \end{tabular*}
\caption{Multiple clock sources as required by
POSIX and the Linux-specific \texttt{CLOCK_MONOTONIC_RAW}.
Only \texttt{CLOCK_REALTIME}, the clock shown to the user as system
time, can be set
explicitly.
It is not monotonic, the clock
can jump back and forth or slew when being frequency adjusted. In
contrast, \texttt{CLOCK_MONOTONIC} is strictly monotonic, but can still
be frequency adjusted and will hence slew.
\texttt{CLOCK_MONOTONIC_RAW} does not exhibit any of
these deficiencies, but has no relation to UTC at all.
It is ideal for reliably tracking foreign clocks, e.g., timestamps in
networked or FireWire audio.
The two CPUTIME clocks
accumulate the time a process or thread has spent running on the
CPU. Since these clocks rely on registers that can be local to an
individual CPU or core, care must be taken on SMP systems.}
  \label{tab:clocks}
\end{table}

(the adjust and slew columns are somewhat redundant)



Side note: if NTP is too coarse, maybe it's worth having a look at PTP.


HTH
