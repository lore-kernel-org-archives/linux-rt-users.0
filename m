From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [patch 10/15] fixup maintainerclean
Date: Wed, 25 Jul 2007 01:11:58 +0200
Message-ID: <20070724231158.GO1678@pengutronix.de>
References: <20070724092517.390730736@metis.extern.pengutronix.de> <20070724092607.856146831@metis.extern.pengutronix.de> <200707241427.04043.dvhltc@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:56476 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756410AbXGXXMA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jul 2007 19:12:00 -0400
Received: from rsc by metis.extern.pengutronix.de with local (Exim 3.36 #1 (Debian))
	id 1IDTXq-0003KM-00
	for <linux-rt-users@vger.kernel.org>; Wed, 25 Jul 2007 01:11:58 +0200
Content-Disposition: inline
In-Reply-To: <200707241427.04043.dvhltc@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Jul 24, 2007 at 02:27:03PM -0700, Darren Hart wrote:
> On Tuesday 24 July 2007 02:25:27 Robert Schwebel wrote:
> > Add some more things which have to be cleaned on maintainer-clean; this
> > does also remove directories in the case that something went wrong
> > during development, leaving the tree in a non-clean state.
> >
> 
> Couple questions on this one - we do have to understand it to maintain it :-)
> 
> > Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>
> >
> > ---
> >  GNUmakefile.am |    7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > Index: GNUmakefile.am
> > ===================================================================
> > --- GNUmakefile.am.orig
> > +++ GNUmakefile.am
> > @@ -9,5 +9,10 @@ EXTRA_DIST = \
> >  	autogen.sh
> >
> >  MAINTAINERCLEANFILES = \
> > -        GNUmakefile.in
> > +	GNUmakefile.in \
> > +	$(DIST_ARCHIVES)
> 
> What are these?

"make dist" creates rt-tests-x.y.tar.{bz2,gz}. This entry removes them
if you do a "make maintainer-clean" (which you wanna do before checking
stuff into some rcs.

> > +
> > +maintainer-clean-local:
> > +	-chmod -R a+rw $(distdir)
> > +	-rm -fr $(distdir)
> 
> And this?

On "make distcheck" the autotools build the tarballs, extract them
again, into a temporary directory called like the package, make the
sources read only, create an out-of-tree directory, run configure there,
build and cleanup afterwards. If everything goes right, the temporary
directory is removed again. If something goes wrong, it remains there.
This entry instructs "make maintainer-clean" to make the directory
read/write again, then remove it.

This is a handy shortcut which makes sure that, after make
maintainer-clean, everything is back to the state where it can be
checked in.

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
