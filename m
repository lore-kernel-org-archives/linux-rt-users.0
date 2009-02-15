From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/3] Makefile: Include arch Makefiles as late as
	possible
Date: Sun, 15 Feb 2009 09:09:46 +0100
Message-ID: <20090215080946.GB24508@elte.hu>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru> <20090204150835.GA30027@oksana.dev.rtsoft.ru> <20090204212612.GN22608@elte.hu> <20090214195702.GB1241@uranus.ravnborg.org> <20090214220326.GA5200@elte.hu> <1234657196.26036.86.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Ravnborg <sam@ravnborg.org>,
	Anton Vorontsov <avorontsov@ru.mvista.com>,
	Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:54256 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365AbZBOIKU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 15 Feb 2009 03:10:20 -0500
Content-Disposition: inline
In-Reply-To: <1234657196.26036.86.camel@pasglop>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Sat, 2009-02-14 at 23:03 +0100, Ingo Molnar wrote:
> > 
> > So the question is: even with FRAME_POINTERS disabled on PPC, is 
> > __builtin_return_address(1)/(2) reliable, and is save_stack_trace() fast? (i.e.
> > can it walk down the stack frame efficiently, or does it have to scan the full
> > kernel stack) I.e. does PPC have all the material advantages of frame pointers?
> 
> Yes, we do. We effectively have frame pointers in fact, they may only be
> omitted in leaf functions but then gcc __builtin_return_address() knows
> how to handle that afaik.

So basically we want to define FRAME_POINTERS on PPC, but do not want
the -fno-omit-frame-pointers flag.

Originally (many moons ago) FRAME_POINTER _was_ just the toplevel Makefile
detail, but these days we've got a handful of secondary uses as well,
expressing the reliability of backtraces in essence.

We could split the whole option (affecting lots of files), or we could zap
that compiler flag in the PPC case - it is only PPC that worries about this
anyway.

	Ingo
