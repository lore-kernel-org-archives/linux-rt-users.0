From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 1/3] Makefile: Include arch Makefiles as late as possible
Date: Sat, 14 Feb 2009 20:58:10 +0100
Message-ID: <20090214195810.GC1241@uranus.ravnborg.org>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru> <20090204150835.GA30027@oksana.dev.rtsoft.ru> <20090204212612.GN22608@elte.hu> <1234324294.29851.0.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>,
	Anton Vorontsov <avorontsov@ru.mvista.com>,
	Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pfepb.post.tele.dk ([195.41.46.236]:33396 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbZBNT4V (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 14 Feb 2009 14:56:21 -0500
Content-Disposition: inline
In-Reply-To: <1234324294.29851.0.camel@pasglop>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Feb 11, 2009 at 02:51:34PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2009-02-04 at 22:26 +0100, Ingo Molnar wrote:
> > > +include $(srctree)/arch/$(SRCARCH)/Makefile
> > > +
> > >  # arch Makefile may override CC so keep this after arch Makefile is
> > included
> > >  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC)
> > -print-file-name=include)
> > >  CHECKFLAGS     += $(NOSTDINC_FLAGS)
> > > -- 
> > 
> > this patch is really for Sam to judge - Cc:-ed him.
> 
> Sam ? I have a few more powerpc patches depending on that one... so I'd
> like to know if it's totally doomed or not :-)

See my answer to the mail from Ingo.

We really need to do this on Kconfig level it at all possible.

	Sam
