From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/3] Makefile: Include arch Makefiles as late as
	possible
Date: Wed, 11 Feb 2009 14:23:38 +0100
Message-ID: <20090211132338.GQ16535@elte.hu>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru> <20090204150835.GA30027@oksana.dev.rtsoft.ru> <20090204212612.GN22608@elte.hu> <1234324294.29851.0.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:36469 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209AbZBKNYD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 11 Feb 2009 08:24:03 -0500
Content-Disposition: inline
In-Reply-To: <1234324294.29851.0.camel@pasglop>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

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

Well, toplevel Makefile changes are not to be taken lightly :-)

Looks good to me but it's handy to have Sam's Ack on it too.

	Ingo
