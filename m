From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 00/18] [ANNOUNCE] Dynamically created function based
 events
Date: Mon, 5 Feb 2018 10:02:59 -0500
Message-ID: <20180205100259.311603b2@gandalf.local.home>
References: <20180202230458.840252014@goodmis.org>
        <261141691.15507.1517677454208.JavaMail.zimbra@efficios.com>
        <20180203140217.2382df69@gandalf.local.home>
        <20180203205207.mpob4w6eyehhg2ky@ast-mbp>
        <20180203161732.4a65c66b@gandalf.local.home>
        <CAM9d7cgmWmo6S30fLg6Zdk5ic8a3UJOjYSo3C55CcG=NBz6mhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-trace-users <linux-trace-users@vger.kernel.org>,
        acme <acme@kernel.org>, Clark Williams <williams@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, bristot <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
To: Namhyung Kim <namhyung@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752914AbeBEPDC (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 5 Feb 2018 10:03:02 -0500
In-Reply-To: <CAM9d7cgmWmo6S30fLg6Zdk5ic8a3UJOjYSo3C55CcG=NBz6mhQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 4 Feb 2018 11:25:20 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> I'm interested in this.  From my understanding, it's basically
> function tracing + filter + custom argument info, right?
> 
> Supporting arguments with complex type could be error-prone.
> We need to prevent malfunctions by invalid inputs.

All reads are done with probe_kernel_read(). If it faults (at any
stage), it simply returns "0".

-- Steve

