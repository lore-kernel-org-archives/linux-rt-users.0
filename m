From: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Subject: Re: [PATCH 00/32] tracing: Inter-event (e.g. latency) support
Date: Sat, 1 Jul 2017 00:01:39 -0700
Message-ID: <CAEi0qN=FNd056iBufikmRuuVLUPZbsYH=bAZNVnaOmRVjoQHuw@mail.gmail.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, vedang.patel@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37697 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbdGAHBl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 1 Jul 2017 03:01:41 -0400
In-Reply-To: <cover.1498510759.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Tom,
Nice series and nice ELC talk as well. Thanks.

On Mon, Jun 26, 2017 at 3:49 PM, Tom Zanussi
<tom.zanussi@linux.intel.com> wrote:
> This patchset adds support for 'inter-event' quantities to the trace
> event subsystem.  The most important example of inter-event quantities
> are latencies, or the time differences between two events.

I tried your patches out and they are working fine for me. I will test
them out more.

I think for the wakeup latency in your examples, its better / more
accurate to use sched_waking instead of sched_wakeup tracepoint? [1]

Also, one other comment I had is, it would be nice to suppress the
output of individual trace events that are part of the synthetic event
into the trace buffer. Otherwise I feel the value of it is slightly
diminished - because one can simply post-process the individual
non-synthetic trace events themselves to get wake up latencies which
the synthetic events is trying to calculate in the first place.
Inorder to conserve space, if a user doesn't care about individual
events, and just the synthetic events then the individual ones
shouldn't be written to the trace buffer IMO.

-Joel

[1] commit fbd705a0c6184580d0e2fbcbd47a37b6e5822511 (sched: Introduce
the 'trace_sched_waking' tracepoint)
