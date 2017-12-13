From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4] perf-probe: Support escaped character in parser
Date: Wed, 13 Dec 2017 22:40:24 +0900
Message-ID: <20171213224024.f4d4e5dde81582f80b132be3@kernel.org>
References: <151309111236.18107.5634753157435343410.stgit@devbox>
        <20171212152724.GO3958@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: bhargavb <bhargavaramudu@gmail.com>, linux-kernel@vger.kernel.org,
        Paul Clarke <pc@us.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        linux-rt-users@vger.kernel.org, linux-perf-users@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171212152724.GO3958@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 12 Dec 2017 12:27:24 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Wed, Dec 13, 2017 at 12:05:12AM +0900, Masami Hiramatsu escreveu:
> > Support the special characters escaped by '\' in parser.
> > This allows user to specify versions directly like below.
> > 
> >   =====
> >   # ./perf probe -x /lib64/libc-2.25.so malloc_get_state\\@GLIBC_2.2.5
> >   Added new event:
> >     probe_libc:malloc_get_state (on malloc_get_state@GLIBC_2.2.5 in /usr/lib64/libc-2.25.so)
> > 
> >   You can now use it in all perf tools, such as:
> > 
> > 	  perf record -e probe_libc:malloc_get_state -aR sleep 1
> > 
> >   =====
> > 
> > Or, you can use separators in source filename, e.g.
> > 
> >   =====
> >   # ./perf probe -x /opt/test/a.out foo+bar.c:3
> >   Semantic error :There is non-digit character in offset.
> >     Error: Command Parse Error.
> >   =====
> > 
> > Usually "+" in source file cause parser error, but
> > 
> >   =====
> >   # ./perf probe -x /opt/test/a.out foo\\+bar.c:4
> >   Added new event:
> >     probe_a:main         (on @foo+bar.c:4 in /opt/test/a.out)
> > 
> >   You can now use it in all perf tools, such as:
> > 
> > 	  perf record -e probe_a:main -aR sleep 1
> >   =====
> > 
> > escaped "\+" allows you to specify that.
> 
> <SNIP>
>  
> >  Changes in v4:
> >   - Fix a build error (Thanks for Arnaldo!)
> >     This time, I ensured that I ran "make build-test" and it passed.
> 
> Thanks, testing it I still have that artifact:
> 
>  ---------------------------------------
> 
> [root@jouet perf]# perf probe -x /lib64/libc-2.25.so malloc_get_state\\@GLIBC_2.2.5
> Added new event:
>   probe_libc:malloc_get_state (on malloc_get_state@GLIBC_2.2.5 in /usr/lib64/libc-2.25.so)
> 
> You can now use it in all perf tools, such as:
> 
> 	perf record -e probe_libc:malloc_get_state -aR sleep 1
> 
> [root@jouet perf]# perf probe -l
> Failed to find debug information for address dd38eca7
>   probe_libc:malloc_get_state (on 0xdd38eca7 in /usr/lib64/libc-2.25.so)
> [root@jouet perf]#
> 
>  ---------------------------------------
> 
> I mean the "on 0xdd38eca7" part:
> 
> 
> That failed to find debug information part:
> 
> [root@jouet perf]# perf probe -vv -l
> Add filter: *
> Opening /sys/kernel/debug/tracing//kprobe_events write=0
> Opening /sys/kernel/debug/tracing//uprobe_events write=0
> Parsing probe_events: p:probe_libc/malloc_get_state /usr/lib64/libc-2.25.so:0x00000000dd38eca7
> Group:probe_libc Event:malloc_get_state probe:p
> try to find information at dd38eca7 in /usr/lib64/libc-2.25.so
> Open Debuginfo file: /usr/lib/debug/usr/lib64/libc-2.25.so.debug
> Failed to find debug information for address dd38eca7
> Failed to find corresponding probes from debuginfo.
> symsrc__init: build id mismatch for /usr/lib/debug/usr/lib64/libc-2.25.so.debug.
> Failed to find probe point from both of dwarf and map.
>   probe_libc:malloc_get_state (on 0xdd38eca7 in /usr/lib64/libc-2.25.so)
> [root@jouet perf]#

Ah, I got it. So symsrc__init checks debugfile to get symbols,
but failed.

> 
> Ok, so build-id mismatch, lets see:
> 
> [root@jouet perf]# rpm -q glibc glibc-debuginfo
> glibc-2.25-10.fc26.x86_64
> glibc-2.25-10.fc26.i686
> glibc-debuginfo-2.25-12.fc26.x86_64
> [root@jouet perf]#
> 
> Ok, the debuginfo file is newer than the glibc installed, updating glibc
> now...
> 
> We could have a more informative message in this case, right? I.e.
> something like:
> 
> [root@jouet perf]# perf probe -l
> There was a build-id mismatch while trying to resolve 0xdd38eca7, please
> check your system's debuginfo files for mismatches, e.g. check the
> versions for glibc and glibc-debuginfo.
>   probe_libc:malloc_get_state (on 0xdd38eca7 in /usr/lib64/libc-2.25.so)

OK, I'll try to check how debuginfo is searched in such environment.

Thank you,

> [root@jouet perf]#
> 
> - Arnaldo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
