From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/3] Makefile: Include arch Makefiles as late as
	possible
Date: Sat, 14 Feb 2009 23:03:26 +0100
Message-ID: <20090214220326.GA5200@elte.hu>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru> <20090204150835.GA30027@oksana.dev.rtsoft.ru> <20090204212612.GN22608@elte.hu> <20090214195702.GB1241@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>,
	Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754718AbZBNWEe@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090214195702.GB1241@uranus.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Sam Ravnborg <sam@ravnborg.org> wrote:

> On Wed, Feb 04, 2009 at 10:26:12PM +0100, Ingo Molnar wrote:
> > 
> > * Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> > 
> > > This patch gives arches more freedom on overwriting CFLAGS, specifically
> > > on PowerPC we want to remove -fno-omit-frame-pointer flag.
> > > 
> > > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > > ---
> > >  Makefile |    4 ++--
> > >  1 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Makefile b/Makefile
> > > index 7715b2c..d1ba93f 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -525,8 +525,6 @@ else
> > >  KBUILD_CFLAGS	+= -O2
> > >  endif
> > >  
> > > -include $(srctree)/arch/$(SRCARCH)/Makefile
> > > -
> > >  ifneq (CONFIG_FRAME_WARN,0)
> > >  KBUILD_CFLAGS += $(call cc-option,-Wframe-larger-than=${CONFIG_FRAME_WARN})
> > >  endif
> > > @@ -555,6 +553,8 @@ ifdef CONFIG_DEBUG_SECTION_MISMATCH
> > >  KBUILD_CFLAGS += $(call cc-option, -fno-inline-functions-called-once)
> > >  endif
> > >  
> > > +include $(srctree)/arch/$(SRCARCH)/Makefile
> > > +
> > >  # arch Makefile may override CC so keep this after arch Makefile is included
> > >  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
> > >  CHECKFLAGS     += $(NOSTDINC_FLAGS)
> > > -- 
> > 
> > this patch is really for Sam to judge - Cc:-ed him.
> 
> If we move the include further down then the following:
> 
>     # Force gcc to behave correct even for buggy distributions
>     # Arch Makefiles may override this setting
>     KBUILD_CFLAGS += $(call cc-option, -fno-stack-protector)
> 
> will most likely fail.

ah, ok. (I long ago made the mental note of "dont change the toplevel Makefile
if you can avoid it" - this reinforces that.)

> If popwerpc needs to get rid of "-fno-omit-frame-pointer" then
> we need a way to express this at KConfig level and NOT by doing
> some tricks with CFLAGS.

Here is what we have in the toplevel Makefile at the moment:

 ifdef CONFIG_FRAME_POINTER
 KBUILD_CFLAGS   += -fno-omit-frame-pointer -fno-optimize-sibling-calls
 else
 KBUILD_CFLAGS   += -fomit-frame-pointer
 endif

My original suggestion (more than a week ago) was to make PPC always
select FRAME_POINTERS.

It was pointed out that -fno-omit-frame-pointers (i.e.: generate frame
pointers) not only makes the code less optimal on PPC, but it can also be 
miscompiled.

But instrumentation really needs to know whether __builtin_return_address(1)
[etc] is reliable, whether stack tracing is fast - and other details -  and PPC
is the odd one out.

So the question is: even with FRAME_POINTERS disabled on PPC, is 
__builtin_return_address(1)/(2) reliable, and is save_stack_trace() fast? (i.e.
can it walk down the stack frame efficiently, or does it have to scan the full
kernel stack) I.e. does PPC have all the material advantages of frame pointers?

	Ingo
