From: Steven Rostedt <srostedt@redhat.com>
Subject: Re: [PATCH 1/3] Makefile: Include arch Makefiles as late as
	possible
Date: Wed, 11 Feb 2009 09:11:42 -0500
Message-ID: <1234361502.31601.0.camel__6042.10844398967$1234361686$gmane$org@localhost.localdomain>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru>
	 <20090204150835.GA30027@oksana.dev.rtsoft.ru>
	 <20090204212612.GN22608@elte.hu> <1234324294.29851.0.camel@pasglop>
	 <20090211132338.GQ16535@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Anton Vorontsov <avorontsov@ru.mvista.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:48861 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945AbZBKOMZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 11 Feb 2009 09:12:25 -0500
In-Reply-To: <20090211132338.GQ16535@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Wed, 2009-02-11 at 14:23 +0100, Ingo Molnar wrote:
> * Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Wed, 2009-02-04 at 22:26 +0100, Ingo Molnar wrote:
> > > > +include $(srctree)/arch/$(SRCARCH)/Makefile
> > > > +
> > > >  # arch Makefile may override CC so keep this after arch Makefile is
> > > included
> > > >  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC)
> > > -print-file-name=include)
> > > >  CHECKFLAGS     += $(NOSTDINC_FLAGS)
> > > > -- 
> > > 
> > > this patch is really for Sam to judge - Cc:-ed him.
> > 
> > Sam ? I have a few more powerpc patches depending on that one... so I'd
> > like to know if it's totally doomed or not :-)
> 
> Well, toplevel Makefile changes are not to be taken lightly :-)
> 
> Looks good to me but it's handy to have Sam's Ack on it too.
> 

Someone on IRC said that Sam is on vacation. This could take a while for
an ACK.


-- Steve


