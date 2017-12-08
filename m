From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 1/5] perf-probe: Add warning message if there is
 unexpected event name
Date: Fri, 8 Dec 2017 11:48:48 +0900
Message-ID: <20171208114848.1a0e77e423e1ca14b9552bf7@kernel.org>
References: <151263115609.13843.6362262297053841418.stgit@devbox>
        <151263118520.13843.9962959734014217698.stgit@devbox>
        <20171207155343.GC3173@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: bhargavb <bhargavaramudu@gmail.com>, linux-kernel@vger.kernel.org,
        Paul Clarke <pc@us.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        linux-rt-users@vger.kernel.org, linux-perf-users@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171207155343.GC3173@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 7 Dec 2017 12:53:43 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Thu, Dec 07, 2017 at 04:19:45PM +0900, Masami Hiramatsu escreveu:
> > This improve the error message so that user can know
> > event-name error before writing new events to
> > kprobe-events interface.
> > 
> > E.g.
> >    ======
> >    #./perf probe -x /lib64/libc-2.25.so malloc_get_state*
> >    Internal error: "malloc_get_state@GLIBC_2" is wrong event name.
> 
> I'm changing this to:
> 
> Internal error: "malloc_get_state@GLIBC_2" is an invalid event name for the /sys/kernel/debug/tracing/kprobe_events interface.
> 
> Ok?

Hmm, it is a kernel limitation (or spec). Would you think we really need it?
(are there any chance to allow '@' for event name?)

Thank you,

> 
> - Arnaldo
> 
> >      Error: Failed to add events.
> >    ======
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  tools/perf/util/probe-event.c |    8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> > index b7aaf9b2294d..c0067950e56f 100644
> > --- a/tools/perf/util/probe-event.c
> > +++ b/tools/perf/util/probe-event.c
> > @@ -2625,6 +2625,14 @@ static int get_new_event_name(char *buf, size_t len, const char *base,
> >  
> >  out:
> >  	free(nbase);
> > +
> > +	/* Final validation */
> > +	if (ret >= 0 && !is_c_func_name(buf)) {
> > +		pr_warning("Internal error: \"%s\" is wrong event name.\n",
> > +			   buf);
> > +		ret = -EINVAL;
> > +	}
> > +
> >  	return ret;
> >  }
> >  


-- 
Masami Hiramatsu <mhiramat@kernel.org>
