From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH 4/4] cyclictest: add --tracemark option
Date: Tue, 22 Mar 2016 11:01:00 -0400
Message-ID: <20160322110100.7b04acdb@redhat.com>
References: <1458239417-31089-1-git-send-email-lcapitulino@redhat.com>
	<1458239417-31089-5-git-send-email-lcapitulino@redhat.com>
	<alpine.LFD.2.20.1603221556580.10687@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38579 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077AbcCVPBD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Mar 2016 11:01:03 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 9495978239
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Mar 2016 15:01:03 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.20.1603221556580.10687@riemann>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 22 Mar 2016 15:57:45 +0100 (CET)
John Kacur <jkacur@redhat.com> wrote:

> 
> 
> On Thu, 17 Mar 2016, Luiz Capitulino wrote:
> 
> > cyclictest will only write to /sys/kernel/debug/tracing/trace_maker
> > if it's also setup to do tracing. This conflicts with
> > running cyclictest under trace-cmd.
> > 
> > The --tracemark option tells cyclictest to write to the
> > trace_marker file even when it's not doing tracing.
> > 
> > It can be used like this:
> > 
> >  # trace-cmd record [...] cyclictest [...] -bX --tracemark --notrace
> > 
> > Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
> > ---
> >  src/cyclictest/cyclictest.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> > 
> > diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> > index 65f2aec..75af721 100644
> > --- a/src/cyclictest/cyclictest.c
> > +++ b/src/cyclictest/cyclictest.c
> > @@ -192,6 +192,7 @@ static void trigger_update(struct thread_param *par, int diff, int64_t ts);
> >  static int shutdown;
> >  static int tracelimit = 0;
> >  static int notrace = 0;
> > +static int trace_marker = 0;
> >  static int ftrace = 0;
> >  static int kernelversion;
> >  static int verbose = 0;
> > @@ -545,6 +546,18 @@ static void open_tracemark_fd(void)
> >  		warn("unable to open trace_marker file: %s\n", path);
> >  }
> >  
> > +static void enable_trace_mark(void)
> > +{
> > +	if (!trace_marker)
> > +		return;
> > +
> > +	if (!tracelimit)
> > +		fatal("--tracemark requires -b\n");
> > +
> > +	debugfs_prepare();
> > +	open_tracemark_fd();
> > +}
> > +
> >  static void setup_tracer(void)
> >  {
> >  	if (!tracelimit || notrace)
> > @@ -1286,7 +1299,7 @@ enum option_values {
> >  	OPT_SYSTEM, OPT_SMP, OPT_THREADS, OPT_TRACER, OPT_TRIGGER,
> >  	OPT_TRIGGER_NODES, OPT_UNBUFFERED, OPT_NUMA, OPT_VERBOSE, OPT_WAKEUP,
> >  	OPT_WAKEUPRT, OPT_DBGCYCLIC, OPT_POLICY, OPT_HELP, OPT_NUMOPTS,
> > -	OPT_ALIGNED, OPT_SECALIGNED, OPT_LAPTOP,
> > +	OPT_ALIGNED, OPT_SECALIGNED, OPT_LAPTOP, OPT_TRACEMARK,
> >  };
> >  
> >  /* Process commandline options */
> > @@ -1340,6 +1353,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
> >  			{"spike",	     required_argument, NULL, OPT_TRIGGER },
> >  			{"spike-nodes",	     required_argument, NULL, OPT_TRIGGER_NODES },
> >  			{"threads",          optional_argument, NULL, OPT_THREADS },
> > +			{"tracemark",        no_argument,       NULL, OPT_TRACEMARK },
> >  			{"tracer",           required_argument, NULL, OPT_TRACER },
> >  			{"unbuffered",       no_argument,       NULL, OPT_UNBUFFERED },
> >  			{"numa",             no_argument,       NULL, OPT_NUMA },
> > @@ -1574,6 +1588,8 @@ static void process_options (int argc, char *argv[], int max_cpus)
> >  			ct_debug = 1; break;
> >  		case OPT_LAPTOP:
> >  			laptop = 1; break;
> > +		case OPT_TRACEMARK:
> > +			trace_marker = 1; break;
> >  		}
> >  	}
> >  
> > @@ -1983,6 +1999,8 @@ int main(int argc, char **argv)
> >  
> >  	setup_tracer();
> >  
> > +	enable_trace_mark();
> > +
> >  	if (check_timer())
> >  		warn("High resolution timers not available\n");
> >  
> > -- 
> > 2.1.0
> > 
> 
> I've pushed all the fixed up to before this point to kernel.org
> can you respin this patch against the latest code?

Sure, which branch?

> 
> Once it applies cleanly then I'll take it
> 
> Thanks
> 
> John
> 

