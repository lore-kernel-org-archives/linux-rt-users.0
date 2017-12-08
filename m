From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 2/5] perf-probe: Cut off the version suffix from
 event name
Date: Fri, 8 Dec 2017 12:15:38 +0900
Message-ID: <20171208121538.4b50a1555cd15e19e72c1af0@kernel.org>
References: <151263115609.13843.6362262297053841418.stgit@devbox>
        <151263122864.13843.10998234736675352577.stgit@devbox>
        <20171207165659.GD3173@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: bhargavb <bhargavaramudu@gmail.com>, linux-kernel@vger.kernel.org,
        Paul Clarke <pc@us.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        linux-rt-users@vger.kernel.org, linux-perf-users@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
In-Reply-To: <20171207165659.GD3173@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 7 Dec 2017 13:56:59 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Thu, Dec 07, 2017 at 04:20:28PM +0900, Masami Hiramatsu escreveu:
> > Cut off the version suffix (e.g. @GLIBC_2.2.5 etc.) from
> > automatic generated event name. This fixes wildcard event
> > adding like below case;
> > 
> >   =====
> >   # perf probe -x /lib64/libc-2.25.so malloc*
> >   Internal error: "malloc_get_state@GLIBC_2" is wrong event name.
> >     Error: Failed to add events.
> >   =====
> > 
> > This failure was caused by a versioned suffix symbol.
> > With this fix, perf probe automatically cuts the
> > suffix after @ as below.
> > 
> >   =====
> >   # ./perf probe -x /lib64/libc-2.25.so malloc*
> >   Added new events:
> >     probe_libc:malloc_printerr (on malloc* in /usr/lib64/libc-2.25.so)
> >     probe_libc:malloc_consolidate (on malloc* in /usr/lib64/libc-2.25.so)
> >     probe_libc:malloc_check (on malloc* in /usr/lib64/libc-2.25.so)
> >     probe_libc:malloc_hook_ini (on malloc* in /usr/lib64/libc-2.25.so)
> >     probe_libc:malloc    (on malloc* in /usr/lib64/libc-2.25.so)
> >     probe_libc:malloc_trim (on malloc* in /usr/lib64/libc-2.25.so)
> >     probe_libc:malloc_usable_size (on malloc* in /usr/lib64/libc-2.25.so)
> >     probe_libc:malloc_stats (on malloc* in /usr/lib64/libc-2.25.so)
> >     probe_libc:malloc_info (on malloc* in /usr/lib64/libc-2.25.so)
> >     probe_libc:mallochook (on malloc* in /usr/lib64/libc-2.25.so)
> >     probe_libc:malloc_get_state (on malloc* in /usr/lib64/libc-2.25.so)
> >     probe_libc:malloc_set_state (on malloc* in /usr/lib64/libc-2.25.so)
> 
> Thanks for working on this! I'm now going over it, and one thing I
> noticed was that the (on malloc*) on all the entries matched by that
> wildcard, can I suggest that you expand it there as well? I.e.
> 
>      probe_libc:malloc_set_state (on malloc_set_state in /usr/lib64/libc-2.25.so)
> 

Hmm, the reason why I chose it was perf probe accepted multiple
probe points at once. e.g.

./perf probe -x /lib64/libc-2.25.so -a malloc* -a free* 

So, if we specify several probe points, I guess user will like to
see which events come from which one. 


> This way we'll now when aliases are used, and also for the versioning
> case, i.e. to which version is a probe pointing?

Currently we can know that by perf probe -l. I would recommend this way,
since -l can show you more precise information (and if it take a time
to read/analyze debuginfo, user can understand the reason why).

Thank you,

> 
> See also Paul Clarke's question and suggestion, which I agree, i.e.
> instead of chopping off the version, just replace the chars with valid
> ones or better, do what Paul suggests, be more flexible in interpreting
> @, i.e. if it is a number and/or fails to point to any file, interpret
> it as versioning.
> 
> - Arnaldo
> 
> >   You can now use it in all perf tools, such as:
> > 
> > 	  perf record -e probe_libc:malloc_set_state -aR sleep 1
> > 
> >   =====
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Reported-by: bhargavb <bhargavaramudu@gmail.com>
> > ---
> >  tools/perf/util/probe-event.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> > index c0067950e56f..74435fb7ab7f 100644
> > --- a/tools/perf/util/probe-event.c
> > +++ b/tools/perf/util/probe-event.c
> > @@ -2584,8 +2584,8 @@ static int get_new_event_name(char *buf, size_t len, const char *base,
> >  	if (!nbase)
> >  		return -ENOMEM;
> >  
> > -	/* Cut off the dot suffixes (e.g. .const, .isra)*/
> > -	p = strchr(nbase, '.');
> > +	/* Cut off the dot suffixes (e.g. .const, .isra) and version suffixes */
> > +	p = strpbrk(nbase, ".@");
> >  	if (p && p != nbase)
> >  		*p = '\0';
> >  


-- 
Masami Hiramatsu <mhiramat@kernel.org>
