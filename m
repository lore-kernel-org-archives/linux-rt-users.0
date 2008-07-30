From: "Ryan Hope" <rmh3093@gmail.com>
Subject: Re: 2.6.26-rt1
Date: Wed, 30 Jul 2008 10:41:09 -0400
Message-ID: <48f7fe350807300741t4f8dff41ide2318c8464d31c8@mail.gmail.com>
References: <alpine.LFD.1.10.0807252141420.574@apollo.tec.linutronix.de>
	 <alpine.LFD.1.10.0807271719130.574@apollo.tec.linutronix.de>
	 <alpine.LFD.1.10.0807291440240.14925@apollo.tec.linutronix.de>
	 <alpine.LFD.1.10.0807300006180.14925@apollo.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	"Steven Rostedt" <rostedt@goodmis.org>,
	"Ingo Molnar" <mingo@elte.hu>,
	"Clark Williams" <williams@redhat.com>,
	"Peter Zijlstra" <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	"Carsten Emde" <ce@ceag.ch>
To: "Thomas Gleixner" <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:16620 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757472AbYG3OlK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Jul 2008 10:41:10 -0400
Received: by wa-out-1112.google.com with SMTP id j37so25663waf.23
        for <linux-rt-users@vger.kernel.org>; Wed, 30 Jul 2008 07:41:10 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0807300006180.14925@apollo.tec.linutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I've been running this for a few days now. If I remove all debug
options from kconfig my dmesg is clean. Every thing seems pretty
stable but I have had a few random hardlocks that I can really narrow
down to anything.

-Ryan

On Tue, Jul 29, 2008 at 6:21 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> We are pleased to announce the 2.6.26-rt1 tree, which can be
> downloaded from the location:
>
>   http://rt.et.redhat.com/download/
>
> Information on the RT patch can be found at:
>
>   http://rt.wiki.kernel.org/index.php/Main_Page
>
> The merge was mostly done by Steven Rostedt, I just fixed it up, added
> the fixes from .24-rt17 and tested it on x86 32/64bit.
>
> This is the first cut of .26-rt, so don't expect it to be perfect.
>
> I run out of time, so I dropped Peter's cpu-hotplug patches
> completely. The hotplug and rcupreempt code has changed radically, so
> we need to redo that lot. Peter, Paul can you please look into that ?
>
> I tried to address the non-x86 issues as far as I could, but I had no
> chance to compile test them. So please check the wreckage.
>
> to build a 2.6.26-rt1 tree, the following patches should be applied:
>
>   http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.26.tar.bz2
>   http://rt.et.redhat.com/download/patch-2.6.26-rt1.bz2
>
> And like always, Steven's RT version of Matt Mackall's ketchup will get this
> for you nicely:
>
>  http://people.redhat.com/srostedt/rt/tools/ketchup-0.9.8-rt3
>
> As usual the broken out patches are also available.
>
> I'm going on vacation tomorrow so feel free to blame/curse/flame me,
> but please work with Steven to get it into shape.
>
> Thanks,
>
>        tglx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
