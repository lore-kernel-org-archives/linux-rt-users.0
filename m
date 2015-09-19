From: Henrik Austad <haustad@cisco.com>
Subject: Re: [PATCH 3/7] Add a rebuild-switch to Makefile
Date: Sat, 19 Sep 2015 07:41:27 +0200
Message-ID: <20150919054127.GA8043@laethe.rd.cisco.com>
References: <1442595170-6229-1-git-send-email-haustad@cisco.com>
 <1442595170-6229-4-git-send-email-haustad@cisco.com>
 <20150918211031.GF31303@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from alln-iport-6.cisco.com ([173.37.142.93]:43788 "EHLO
	alln-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbbISFwu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 19 Sep 2015 01:52:50 -0400
Content-Disposition: inline
In-Reply-To: <20150918211031.GF31303@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Sep 18, 2015 at 04:10:31PM -0500, Josh Cartwright wrote:
> On Fri, Sep 18, 2015 at 06:52:46PM +0200, Henrik Austad wrote:
> > Signed-off-by: Henrik Austad <haustad@cisco.com>
> > ---
> >  Makefile | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Makefile b/Makefile
> > index d4988c5..160547c 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -129,6 +129,9 @@ RPMDIRS = BUILD BUILDROOT RPMS SRPMS SPECS
> >  distclean: clean
> >  	rm -rf $(RPMDIRS) releases *.tar.gz rt-tests.spec tmp
> >  
> > +.PHONY: rebuild
> > +rebuild: clean all
> 
> Does this actually work?  Make is free to execute 'clean' and 'all' at
> the same time, with ... interesting side effects.

You're right. It works as long as you have -j1. Never had an issue as the 
whole make-job is small enough to be run with just 'make rebuild' and not a 
ton of jobs.

> If you really want this (and I'm not sure you do):

Well, it became pretty apparent when I tested to see that I didn't break 
tile or x86 when compiling for 64-bit arm android

> .PHONY: rebuild
> rebuild:
> 	$(MAKE) clean
> 	$(MAKE)

Yep, that works much better, thanks

-- 
Henrik Austad
TIPBU Eng
Cisco Systems Norway
