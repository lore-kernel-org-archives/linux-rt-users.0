From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: uprobes enable condition (user space) - sysfs interface
Date: Tue, 5 Dec 2017 16:45:47 +0900
Message-ID: <20171205164547.144c51e493a05b61907dda01@kernel.org>
References: <CA+bpL9+McSzeKW+eXHfMJMFRm-EenC9_0pGZkGpSdFzOVozKiw@mail.gmail.com>
        <20171201164039.GC3298@kernel.org>
        <20171204213619.973d74567a7de0af15876aac@kernel.org>
        <20171204145558.GA27554@kernel.org>
        <5246be84-1fb5-c1d7-130f-b990b3bac471@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        bhargavb <bhargavaramudu@gmail.com>,
        linux-rt-users@vger.kernel.org, linux-perf-users@vger.kernel.org
To: Paul Clarke <pc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752334AbdLEHpu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 5 Dec 2017 02:45:50 -0500
In-Reply-To: <5246be84-1fb5-c1d7-130f-b990b3bac471@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 4 Dec 2017 09:23:16 -0600
Paul Clarke <pc@us.ibm.com> wrote:

> On 12/04/2017 08:55 AM, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Dec 04, 2017 at 09:36:19PM +0900, Masami Hiramatsu escreveu:
> >> On Fri, 1 Dec 2017 13:40:39 -0300
> >> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >>
> >>> Adding Masami to the CC list, to see if he can come up with a fix for
> >>> the 'perf probe' failure below, improving the message or ignoring
> >>> versioned symbols (with a warning perhaps).
> >>
> >> Thanks. Should we ignore the versioned symbols? or can we put a probe
> >> on that? If we have symbol address, we can put a probe on it, even
> >> if it is versioned.
> > 
> > Lemme try...
> > 
> > [root@jouet ~]# perf probe -x /usr/lib64/libc-2.25.so malloc_get_state_225=malloc_get_state@GLIBC_2.2.5
> > The /usr/lib64/libc-2.25.so file has no debug information.
> > Rebuild with -g, or install an appropriate debuginfo package.
> >   Error: Failed to add events.
> > [root@jouet ~]# perf probe -x /usr/lib64/libc-2.25.so malloc_get_state@GLIBC_2.2.5
> > The /usr/lib64/libc-2.25.so file has no debug information.
> > Rebuild with -g, or install an appropriate debuginfo package.
> >   Error: Failed to add events.
> 
> commit d80406453ad4a69932dc17a617d5b7bc7ae80b8f should have allowed adding probes on versioned symbols if you omit the versioning part of the symbol.  So, in the above example, this should work:
> 
> # perf probe -x /usr/lib64/libc-2.25.so malloc_get_state

No, it doesn't, the above commit improves *find_symbol_by_name(),
but perf probe uses its own lookup function, because it has to
support glob pattern matching.
Let me see, how I can improve that...

Thanks,

> 
> PC
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
