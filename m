From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] Makefile: Include arch Makefiles as late as
 possible
Date: Wed, 11 Feb 2009 14:51:34 +1100
Message-ID: <1234324294.29851.0.camel__45955.8381968693$1234325161$gmane$org@pasglop>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru>
	 <20090204150835.GA30027@oksana.dev.rtsoft.ru>
	 <20090204212612.GN22608@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755549AbZBKED5@vger.kernel.org>
In-Reply-To: <20090204212612.GN22608@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2009-02-04 at 22:26 +0100, Ingo Molnar wrote:
> > +include $(srctree)/arch/$(SRCARCH)/Makefile
> > +
> >  # arch Makefile may override CC so keep this after arch Makefile is
> included
> >  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC)
> -print-file-name=include)
> >  CHECKFLAGS     += $(NOSTDINC_FLAGS)
> > -- 
> 
> this patch is really for Sam to judge - Cc:-ed him.

Sam ? I have a few more powerpc patches depending on that one... so I'd
like to know if it's totally doomed or not :-)

Cheers,
Ben.
