From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2 2/5] perf-probe: Cut off the version suffix from event
 name
Date: Mon, 11 Dec 2017 15:25:47 -0300
Message-ID: <20171211182547.GH3958@kernel.org>
References: <151263115609.13843.6362262297053841418.stgit@devbox>
 <151263122864.13843.10998234736675352577.stgit@devbox>
 <dd7ab590-f5bc-e7bb-6807-210c099072fe@us.ibm.com>
 <20171208120148.63dcf5fb271cb8654e70b5cf@kernel.org>
 <3cfc7d95-0956-3e7b-9d36-db5bda9dc753@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        bhargavb <bhargavaramudu@gmail.com>,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        linux-rt-users@vger.kernel.org, linux-perf-users@vger.kernel.org
To: Paul Clarke <pc@us.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3cfc7d95-0956-3e7b-9d36-db5bda9dc753@us.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Em Fri, Dec 08, 2017 at 08:49:46AM -0600, Paul Clarke escreveu:
> 
> 
> On 12/07/2017 09:01 PM, Masami Hiramatsu wrote:
> > On Thu, 7 Dec 2017 10:34:51 -0600
> > Paul Clarke <pc@us.ibm.com> wrote:
> >> On 12/07/2017 01:20 AM, Masami Hiramatsu wrote:
> >>> Cut off the version suffix (e.g. @GLIBC_2.2.5 etc.) from
> >>> automatic generated event name. This fixes wildcard event
> >>> adding like below case;
> >>>
> >>>   =====
> >>>   # perf probe -x /lib64/libc-2.25.so malloc*
> >>>   Internal error: "malloc_get_state@GLIBC_2" is wrong event name.
> >>>     Error: Failed to add events.
> >>>   =====
> >>>
> >>> This failure was caused by a versioned suffix symbol.
> >>> With this fix, perf probe automatically cuts the
> >>> suffix after @ as below.
> >>>
> >>>   =====
> >>>   # ./perf probe -x /lib64/libc-2.25.so malloc*
> >>>   Added new events:
> >>>     probe_libc:malloc_printerr (on malloc* in /usr/lib64/libc-2.25.so)
> >>>     probe_libc:malloc_consolidate (on malloc* in /usr/lib64/libc-2.25.so)
> >>>     probe_libc:malloc_check (on malloc* in /usr/lib64/libc-2.25.so)
> >>>     probe_libc:malloc_hook_ini (on malloc* in /usr/lib64/libc-2.25.so)
> >>>     probe_libc:malloc    (on malloc* in /usr/lib64/libc-2.25.so)
> >>>     probe_libc:malloc_trim (on malloc* in /usr/lib64/libc-2.25.so)
> >>>     probe_libc:malloc_usable_size (on malloc* in /usr/lib64/libc-2.25.so)
> >>>     probe_libc:malloc_stats (on malloc* in /usr/lib64/libc-2.25.so)
> >>>     probe_libc:malloc_info (on malloc* in /usr/lib64/libc-2.25.so)
> >>>     probe_libc:mallochook (on malloc* in /usr/lib64/libc-2.25.so)
> >>>     probe_libc:malloc_get_state (on malloc* in /usr/lib64/libc-2.25.so)
> >>>     probe_libc:malloc_set_state (on malloc* in /usr/lib64/libc-2.25.so)
> >>>
> >>>   You can now use it in all perf tools, such as:
> >>>
> >>> 	  perf record -e probe_libc:malloc_set_state -aR sleep 1
> >>>
> >>>   =====
> >>
> >> I think this will still fall over for a case where there are multiple versions of the same base symbol, like:
> >>
> >> $ nm /lib64/libc.so.6 | egrep ' sched_getaffinity'
> >> 0000000000134430 T sched_getaffinity@GLIBC_2.3.3
> >> 00000000000dcf00 T sched_getaffinity@@GLIBC_2.3.4
> > 
> > No, in that case perf probe adds number suffix (_1, _2...) for new events :)
> > 
> > This feature (number suffix) is anyway required for the case that inlined
> > function is spreaded in multiple places. I think this is natural for perf probe.
> 
> I can live with that.
> 
> Is the versioning tag retained for display with "perf probe -l" display, so the probe points can be distinguished?
> 
> In other words, will one see:
> # perf probe -l
>   probe_libc:sched_getaffinity (on sched_getaffinity@GLIBC_2.3.3 in /usr/lib64/libc-2.17.so)
>   probe_libc:sched_getaffinity_1 (on sched_getaffinity@@GLIBC_2.3.4 in /usr/lib64/libc-2.17.so)
> or
> # perf probe -l
>   probe_libc:sched_getaffinity (on sched_getaffinity in /usr/lib64/libc-2.17.so)
>   probe_libc:sched_getaffinity_1 (on sched_getaffinity in /usr/lib64/libc-2.17.so)

[root@jouet ~]# perf probe -x /lib64/libc-2.25.so malloc*
Added new events:
  probe_libc:malloc_printerr (on malloc* in /usr/lib64/libc-2.25.so)
  probe_libc:malloc_consolidate (on malloc* in /usr/lib64/libc-2.25.so)
  probe_libc:malloc_check (on malloc* in /usr/lib64/libc-2.25.so)
  probe_libc:malloc_hook_ini (on malloc* in /usr/lib64/libc-2.25.so)
  probe_libc:malloc    (on malloc* in /usr/lib64/libc-2.25.so)
  probe_libc:malloc_trim (on malloc* in /usr/lib64/libc-2.25.so)
  probe_libc:malloc_usable_size (on malloc* in /usr/lib64/libc-2.25.so)
  probe_libc:malloc_stats (on malloc* in /usr/lib64/libc-2.25.so)
  probe_libc:malloc_info (on malloc* in /usr/lib64/libc-2.25.so)
  probe_libc:mallochook (on malloc* in /usr/lib64/libc-2.25.so)
  probe_libc:malloc_get_state (on malloc* in /usr/lib64/libc-2.25.so)
  probe_libc:malloc_set_state (on malloc* in /usr/lib64/libc-2.25.so)

You can now use it in all perf tools, such as:

	perf record -e probe_libc:malloc_set_state -aR sleep 1

[root@jouet ~]# perf probe -l
  probe_libc:malloc    (on 0xd22a6973 in /usr/lib64/libc-2.25.so)
  probe_libc:malloc_check (on 0x25db6f5a in /usr/lib64/libc-2.25.so)
  probe_libc:malloc_consolidate (on 0x88f7c44a in /usr/lib64/libc-2.25.so)
  probe_libc:malloc_get_state (on 0xdd38eca7 in /usr/lib64/libc-2.25.so)
  probe_libc:malloc_hook_ini (on 0x8de2b533 in /usr/lib64/libc-2.25.so)
  probe_libc:malloc_info (on 0x8b327bde in /usr/lib64/libc-2.25.so)
  probe_libc:malloc_printerr (on 0x8fff087c in /usr/lib64/libc-2.25.so)
  probe_libc:malloc_set_state (on 0x861940e6 in /usr/lib64/libc-2.25.so)
  probe_libc:malloc_stats (on 0x51fa3cdc in /usr/lib64/libc-2.25.so)
  probe_libc:malloc_trim (on 0xa9fa4e43 in /usr/lib64/libc-2.25.so)
  probe_libc:malloc_usable_size (on 0xceb5e090 in /usr/lib64/libc-2.25.so)
  probe_libc:mallochook (on 0x6ebc00f5 in /usr/lib64/libc-2.25.so)
[root@jouet ~]#

[acme@jouet perf]$ nm /lib64/libc-2.25.so | grep malloc_get_state
0000000000151ba0 T malloc_get_state@GLIBC_2.2.5
[acme@jouet perf]$

For your example it finds two symbols, adds two but I couldn't find a
simple way of mapping one to the other, would be nice if 'perf probe -l'
showed them like 'nm' does.

[root@jouet ~]# nm /lib64/libc-2.25.so | grep ' sched_getaffinity'
0000000000151cd0 T sched_getaffinity@GLIBC_2.3.3
00000000000f3c10 T sched_getaffinity@@GLIBC_2.3.4
[root@jouet ~]#

[root@jouet ~]# perf probe -x /lib64/libc-2.25.so sched_getaffinity*
Added new events:
  probe_libc:sched_getaffinity (on sched_getaffinity* in /usr/lib64/libc-2.25.so)
  probe_libc:sched_getaffinity_1 (on sched_getaffinity* in /usr/lib64/libc-2.25.so)

You can now use it in all perf tools, such as:

	perf record -e probe_libc:sched_getaffinity_1 -aR sleep 1

[root@jouet ~]# perf probe -l
  probe_libc:sched_getaffinity (on 0x5fd95e7c in /usr/lib64/libc-2.25.so)
  probe_libc:sched_getaffinity_1 (on 0xd8d51601 in /usr/lib64/libc-2.25.so)
[root@jouet ~]#
