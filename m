From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] cyclictest: make clock_nanosleep as default and add
 option for POSIX timers.
Date: Tue, 14 Mar 2017 16:49:39 +0100 (CET)
Message-ID: <alpine.LFD.2.20.1703141646001.10659@riemann.fritz.box>
References: <1489427937-12583-1-git-send-email-vedang.patel@intel.com> <1489428033.3793.1.camel@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8336693-978772170-1489506587=:10659"
Cc: "williams@redhat.com" <williams@redhat.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Patel, Vedang" <vedang.patel@intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35515 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752373AbdCNPtu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Mar 2017 11:49:50 -0400
Received: by mail-wm0-f65.google.com with SMTP id z63so459302wmg.2
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Mar 2017 08:49:49 -0700 (PDT)
In-Reply-To: <1489428033.3793.1.camel@intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8336693-978772170-1489506587=:10659
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Mon, 13 Mar 2017, Patel, Vedang wrote:

>  Fixing a typo in John's email
> 
> -Vedang
> On Mon, 2017-03-13 at 10:58 -0700, Vedang Patel wrote:
> > it is recommended that clock_nanosleep should be used for real-time
> > wherever available. So, make sure that cyclictest runs
> > clock_nanosleep
> > by default. Added an option to run POSIX timers. The '-n' option is
> > redundant now. I did not remove it so that it does not break existing
> > scripts.
> > 
> > Signed-off-by: Vedang Patel <vedang.patel@intel.com>
> > ---
> >  src/cyclictest/cyclictest.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/src/cyclictest/cyclictest.c
> > b/src/cyclictest/cyclictest.c
> > index 00e5f3d59a5b..a185a8a99065 100644
> > --- a/src/cyclictest/cyclictest.c
> > +++ b/src/cyclictest/cyclictest.c
> > @@ -1360,7 +1360,8 @@ static void display_help(int error)
> >  	       "                           format: n:c:v n=tasknum
> > c=count v=value in us\n"
> >  	       "-w       --wakeup          task wakeup tracing (used
> > with -b)\n"
> >  	       "-W       --wakeuprt        rt task wakeup tracing
> > (used with -b)\n"
> > -	       "	 --dbg_cyclictest  print info useful for
> > debugging cyclictest\n",
> > +	       "	 --dbg_cyclictest  print info useful for
> > debugging cyclictest\n"
> > +	       "-x	 --posix_timers    use POSIX timers\n",
> >  	       tracers
> >  		);
> >  	if (error)
> > @@ -1368,7 +1369,7 @@ static void display_help(int error)
> >  	exit(EXIT_SUCCESS);
> >  }
> >  
> > -static int use_nanosleep;
> > +static int use_nanosleep = MODE_CLOCK_NANOSLEEP; /* use
> > clock_nanosleep by default. */
> >  static int timermode = TIMER_ABSTIME;
> >  static int use_system;
> >  static int priority;
> > @@ -1489,6 +1490,7 @@ enum option_values {
> >  	OPT_TRIGGER_NODES, OPT_UNBUFFERED, OPT_NUMA, OPT_VERBOSE,
> > OPT_WAKEUP,
> >  	OPT_WAKEUPRT, OPT_DBGCYCLIC, OPT_POLICY, OPT_HELP,
> > OPT_NUMOPTS,
> >  	OPT_ALIGNED, OPT_SECALIGNED, OPT_LAPTOP, OPT_SMI,
> > OPT_TRACEMARK,
> > +	OPT_POSIX_TIMERS,
> >  };
> >  
> >  /* Process commandline options */
> > @@ -1553,9 +1555,10 @@ static void process_options (int argc, char
> > *argv[], int max_cpus)
> >  			{"dbg_cyclictest",   no_argument,       NULL
> > , OPT_DBGCYCLIC },
> >  			{"policy",           required_argument,
> > NULL, OPT_POLICY },
> >  			{"help",             no_argument,       NULL
> > , OPT_HELP },
> > +			{"posix_timers",     no_argument,	NUL
> > L, OPT_POSIX_TIMERS },
> >  			{NULL, 0, NULL, 0}
> >  		};
> > -		int c = getopt_long(argc, argv,
> > "a::A::b:Bc:Cd:D:Efh:H:i:Il:MnNo:O:p:PmqrRsSt::uUvD:wWT:",
> > +		int c = getopt_long(argc, argv,
> > "a::A::b:Bc:Cd:D:Efh:H:i:Il:MnNo:O:p:PmqrRsSt::uUvD:wWT:x",
> >  				    long_options, &option_index);
> >  		if (c == -1)
> >  			break;
> > @@ -1756,6 +1759,9 @@ static void process_options (int argc, char
> > *argv[], int max_cpus)
> >  		case 'W':
> >  		case OPT_WAKEUPRT:
> >  			tracetype = WAKEUPRT; break;
> > +		case 'x':
> > +		case OPT_POSIX_TIMERS:
> > +			use_nanosleep = MODE_CYCLIC; break;
> >  		case '?':
> >  		case OPT_HELP:
> >  			display_help(0); break;


We could apply this to the "unstable" developer version, in which case we
are not concerned with maintaining compatibility with scripts etc, so
you can go ahead and remove -n too.

Use either one of the following branches
unstable/devel/v1.1.1
unstable/devel/v1.1.1-devel

(yeah, I need to clean that up in the near future)

Thanks

John
--8336693-978772170-1489506587=:10659--
