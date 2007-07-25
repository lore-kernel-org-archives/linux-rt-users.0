From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [patch 10/15] fixup maintainerclean
Date: Wed, 25 Jul 2007 08:47:57 -0700
Message-ID: <200707250847.58118.dvhltc@us.ibm.com>
References: <20070724092517.390730736@metis.extern.pengutronix.de> <200707241427.04043.dvhltc@us.ibm.com> <20070724231158.GO1678@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:60875 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963AbXGYPr7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jul 2007 11:47:59 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6PFlxvF028357
	for <linux-rt-users@vger.kernel.org>; Wed, 25 Jul 2007 11:47:59 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6PFlxNs546230
	for <linux-rt-users@vger.kernel.org>; Wed, 25 Jul 2007 11:47:59 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6PFlw1x021329
	for <linux-rt-users@vger.kernel.org>; Wed, 25 Jul 2007 11:47:58 -0400
In-Reply-To: <20070724231158.GO1678@pengutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tuesday 24 July 2007 16:11:58 Robert Schwebel wrote:
> On Tue, Jul 24, 2007 at 02:27:03PM -0700, Darren Hart wrote:
> > On Tuesday 24 July 2007 02:25:27 Robert Schwebel wrote:
> > > Add some more things which have to be cleaned on maintainer-clean; this
> > > does also remove directories in the case that something went wrong
> > > during development, leaving the tree in a non-clean state.
> >
> > Couple questions on this one - we do have to understand it to maintain it
> > :-)
> >
> > > Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>


Acked-by: Darren Hart <dvhltc@us.ibm.com>


> > >
> > > ---
> > >  GNUmakefile.am |    7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > Index: GNUmakefile.am
> > > ===================================================================
> > > --- GNUmakefile.am.orig
> > > +++ GNUmakefile.am
> > > @@ -9,5 +9,10 @@ EXTRA_DIST = \
> > >  	autogen.sh
> > >
> > >  MAINTAINERCLEANFILES = \
> > > -        GNUmakefile.in
> > > +	GNUmakefile.in \
> > > +	$(DIST_ARCHIVES)
> >
> > What are these?
>
> "make dist" creates rt-tests-x.y.tar.{bz2,gz}. This entry removes them
> if you do a "make maintainer-clean" (which you wanna do before checking
> stuff into some rcs.
>
> > > +
> > > +maintainer-clean-local:
> > > +	-chmod -R a+rw $(distdir)
> > > +	-rm -fr $(distdir)
> >
> > And this?
>
> On "make distcheck" the autotools build the tarballs, extract them
> again, into a temporary directory called like the package, make the
> sources read only, create an out-of-tree directory, run configure there,
> build and cleanup afterwards. If everything goes right, the temporary
> directory is removed again. If something goes wrong, it remains there.
> This entry instructs "make maintainer-clean" to make the directory
> read/write again, then remove it.
>
> This is a handy shortcut which makes sure that, after make
> maintainer-clean, everything is back to the state where it can be
> checked in.
>
> Robert



-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
