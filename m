From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 1/3] Makefile: Include arch Makefiles as late as possible
Date: Sat, 14 Feb 2009 20:57:02 +0100
Message-ID: <20090214195702.GB1241@uranus.ravnborg.org>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru> <20090204150835.GA30027@oksana.dev.rtsoft.ru> <20090204212612.GN22608@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>,
	Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pfepa.post.tele.dk ([195.41.46.235]:54104 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbZBNTzM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 14 Feb 2009 14:55:12 -0500
Content-Disposition: inline
In-Reply-To: <20090204212612.GN22608@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Feb 04, 2009 at 10:26:12PM +0100, Ingo Molnar wrote:
> 
> * Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> 
> > This patch gives arches more freedom on overwriting CFLAGS, specifically
> > on PowerPC we want to remove -fno-omit-frame-pointer flag.
> > 
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > ---
> >  Makefile |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Makefile b/Makefile
> > index 7715b2c..d1ba93f 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -525,8 +525,6 @@ else
> >  KBUILD_CFLAGS	+= -O2
> >  endif
> >  
> > -include $(srctree)/arch/$(SRCARCH)/Makefile
> > -
> >  ifneq (CONFIG_FRAME_WARN,0)
> >  KBUILD_CFLAGS += $(call cc-option,-Wframe-larger-than=${CONFIG_FRAME_WARN})
> >  endif
> > @@ -555,6 +553,8 @@ ifdef CONFIG_DEBUG_SECTION_MISMATCH
> >  KBUILD_CFLAGS += $(call cc-option, -fno-inline-functions-called-once)
> >  endif
> >  
> > +include $(srctree)/arch/$(SRCARCH)/Makefile
> > +
> >  # arch Makefile may override CC so keep this after arch Makefile is included
> >  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
> >  CHECKFLAGS     += $(NOSTDINC_FLAGS)
> > -- 
> 
> this patch is really for Sam to judge - Cc:-ed him.

If we move the include further down then the following:

    # Force gcc to behave correct even for buggy distributions
    # Arch Makefiles may override this setting
    KBUILD_CFLAGS += $(call cc-option, -fno-stack-protector)

will most likely fail.

If popwerpc needs to get rid of "-fno-omit-frame-pointer" then
we need a way to express this at KConfig level and NOT by doing
some tricks with CFLAGS.

	Sam
