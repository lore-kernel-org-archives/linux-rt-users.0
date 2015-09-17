From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH rt-tests 3/9] cyclictest: drop unnecessary numa_on_and_available()
 check
Date: Thu, 17 Sep 2015 21:15:51 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1509172103120.10090@riemann>
References: <cover.1441038216.git.joshc@ni.com> <787515a5a59861a892ac3a44b6c6c502cfc102fd.1441038216.git.joshc@ni.com> <alpine.LFD.2.20.1509152347280.13077@riemann.fritz.box> <20150916194728.GH3126@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34362 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbbIQTQD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Sep 2015 15:16:03 -0400
Received: by wicfx3 with SMTP id fx3so36882714wic.1
        for <linux-rt-users@vger.kernel.org>; Thu, 17 Sep 2015 12:16:01 -0700 (PDT)
In-Reply-To: <20150916194728.GH3126@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Wed, 16 Sep 2015, Josh Cartwright wrote:

> On Tue, Sep 15, 2015 at 11:50:16PM +0200, John Kacur wrote:
> > On Mon, 31 Aug 2015, Josh Cartwright wrote:
> > 
> > > The condition that numa_on_and_available() checks is impossible to hit,
> > > as it's already being checked during process_options().
> > > 
> > > Removal of numa_on_and_available() also has the side effect of removing
> > > the following warning during build:
> > > 
> > > src/cyclictest/rt_numa.h:259:15: warning: implicit declaration of function ???numa_available??? [-Wimplicit-function-declaration]
> > > 
> > > Signed-off-by: Josh Cartwright <joshc@ni.com>
> 
> [..]
> 
> > We don't support building without numa libs anymore, although we of
> > course support running on machines without numa. Never-the-less I
> > created two versions of numa_on_and_available, one for if you build with
> > the unsupported NUMA=0 and one for if you build with NUMA=1, which is
> > the default.
> 
> :(.  You risk plenty of embedded folks who don't much care about NUMA.

Sorry, there is some confusion here, and it's probably partly on my side.
We do of course still support building without NUMA. All that I was really 
referring to was, that if you are building on platforms that support NUMA,
we are making the development libs a requirement for compiling, in our 
distro spec files, even you are running without NUMA
But please continue to test with NUMA=0 builds as well as the default, and 
report / or fix any builds that don't work with NUMA=0

> 
> > I would prefer not to drop this function, since I think it cleanly
> > documents the fact that numa_available must be called before any other
> > numa library functions are defined.
> > 
> > As Josh Cartwright reported though, there was no need to call it from
> > main() since it was already tested in process_options(), so I tested it
> > there.
> > 
> > Tested by building with NUMA=0, NUMA=1 and with the non-standard
> > -Wimplicit-function-declaration
> > 
> > Reported-by: Signed-off-by: Josh Cartwright <joshc@ni.com>
> 
> s/Signed-off-by: /
> 

Oops, okay, fixing that msg.

> :)
> 
> > Signed-off-by: John Kacur <jkacur@redhat.com>
> > ---
> >  src/cyclictest/cyclictest.c |  7 ++-----
> >  src/cyclictest/rt_numa.h    | 18 +++++++++++++-----
> >  2 files changed, 15 insertions(+), 10 deletions(-)
> > 
> > diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> > index 213c527fd714..b3abfcc67407 100644
> > --- a/src/cyclictest/cyclictest.c
> > +++ b/src/cyclictest/cyclictest.c
> > @@ -1451,12 +1451,11 @@ static void process_options (int argc, char *argv[], int max_cpus)
> >  			setvbuf(stdout, NULL, _IONBF, 0); break;
> >  		case 'U':
> >  		case OPT_NUMA: /* NUMA testing */
> > +			numa = 1;	/* Turn numa on */
> >  			if (smp)
> >  				fatal("numa and smp options are mutually exclusive\n");
> > +			numa_on_and_available();
> 
> ...except numa is always on here.  So why check if NUMA is enabled
> again?  Seems like a waste.
> 
> >  #ifdef NUMA
> > -			if (numa_available() == -1)
> > -				fatal("NUMA functionality not available!");
> 
> Perhaps a middle ground should be to keep this check around and define a
> static inline numa_available() in the NUMA:=0 case which unconditionally
> returns -1.
> 
> Thanks for taking a look,

You are of course correct here, but it's just one extra check at init 
time, so the impact is pretty close to zero.

Will consider more clean-ups in the future, but it's probably not worth 
obsessing about. Like I said, I like the api more as documentation for the 
process of setting numa up.

Thanks

John
