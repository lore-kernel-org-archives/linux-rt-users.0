From: Henrik Austad <haustad@cisco.com>
Subject: Re: [PATCH 6/7] rt_test.h: add numa_available() for !NUMA
Date: Sat, 19 Sep 2015 07:49:01 +0200
Message-ID: <20150919054901.GB8043@laethe.rd.cisco.com>
References: <1442595170-6229-1-git-send-email-haustad@cisco.com>
 <1442595170-6229-7-git-send-email-haustad@cisco.com>
 <20150918212707.GG31303@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from alln-iport-6.cisco.com ([173.37.142.93]:41040 "EHLO
	alln-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbbISFux (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 19 Sep 2015 01:50:53 -0400
Content-Disposition: inline
In-Reply-To: <20150918212707.GG31303@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Sep 18, 2015 at 04:27:07PM -0500, Josh Cartwright wrote:
> On Fri, Sep 18, 2015 at 06:52:49PM +0200, Henrik Austad wrote:
> > Code will snould not call numa_available(), but compiler will complain
> 
> snould -> should.
> 
> Why should it not call it?

Because if numa is 0, it will stop evaluating the conditional and never get 
to numa_available()

        if (numa && (numa_available() == -1))
                fatal("--numa specified and numa functions not available.\n");

Even so, the compiler will try to find the symbol, which it couldn't. So 
the warning was legit, but the problem would never arise in practice (as 
you state below).

> > with:
> > 
> >   src/cyclictest/rt_numa.h:263: warning: implicit declaration of function ???numa_available???
> > 
> > Signed-off-by: Henrik Austad <haustad@cisco.com>
> > ---
> >  src/cyclictest/rt_numa.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
> > index 06c9420..172d9b2 100644
> > --- a/src/cyclictest/rt_numa.h
> > +++ b/src/cyclictest/rt_numa.h
> > @@ -200,6 +200,7 @@ struct bitmask {
> >  };
> >  #define BITS_PER_LONG    (8*sizeof(long))
> >  
> > +static inline int numa_available(void) { return 0; }
> 
> I would have expected this to return -1, as libnuma isn't available...

Ah, you're right, should have been -1.

> John and I were talking about this earlier this week:
> 
> http://lkml.kernel.org/r/787515a5a59861a892ac3a44b6c6c502cfc102fd.1441038216.git.joshc@ni.com

I agree, that is a much better way of dealing with it! 

Thanks!

-- 
Henrik Austad
TIPBU Eng
Cisco Systems Norway
