From: "John Kacur" <jkacur@gmail.com>
Subject: Re: 2.6.26-rt1
Date: Wed, 30 Jul 2008 16:31:47 +0200
Message-ID: <520f0cf10807300731y7d243ac0s62eb8549325b43ee@mail.gmail.com>
References: <alpine.LFD.1.10.0807252141420.574@apollo.tec.linutronix.de>
	 <alpine.LFD.1.10.0807271719130.574@apollo.tec.linutronix.de>
	 <alpine.LFD.1.10.0807291440240.14925@apollo.tec.linutronix.de>
	 <alpine.LFD.1.10.0807300006180.14925@apollo.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
Received: from nf-out-0910.google.com ([64.233.182.186]:1304 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbYG3Obv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Jul 2008 10:31:51 -0400
Received: by nf-out-0910.google.com with SMTP id d3so22374nfc.21
        for <linux-rt-users@vger.kernel.org>; Wed, 30 Jul 2008 07:31:47 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0807300006180.14925@apollo.tec.linutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Jul 30, 2008 at 12:21 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>
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

Hmnn, I'm getting a build error with this.

drivers/infiniband/hw/ipath/ipath_verbs.c: In function 'sdma_complete':
drivers/infiniband/hw/ipath/ipath_verbs.c:1028: error: size of array
'type name' is negative
drivers/infiniband/hw/ipath/ipath_verbs.c:1028: warning: comparison of
distinct pointer types lacks a cast
drivers/infiniband/hw/ipath/ipath_verbs.c:1035: error: size of array
'type name' is negative
drivers/infiniband/hw/ipath/ipath_verbs.c:1035: warning: comparison of
distinct pointer types lacks a cast
drivers/infiniband/hw/ipath/ipath_verbs.c:1038: error: size of array
'type name' is negative
drivers/infiniband/hw/ipath/ipath_verbs.c:1038: warning: comparison of
distinct pointer types lacks a cast
drivers/infiniband/hw/ipath/ipath_verbs.c:1040: error: size of array
'type name' is negative
drivers/infiniband/hw/ipath/ipath_verbs.c:1040: warning: comparison of
distinct pointer types lacks a cast
drivers/infiniband/hw/ipath/ipath_verbs.c: In function 'decrement_dma_busy':
drivers/infiniband/hw/ipath/ipath_verbs.c:1056: error: size of array
'type name' is negative
drivers/infiniband/hw/ipath/ipath_verbs.c:1056: warning: comparison of
distinct pointer types lacks a cast
drivers/infiniband/hw/ipath/ipath_verbs.c:1061: error: size of array
'type name' is negative
drivers/infiniband/hw/ipath/ipath_verbs.c:1061: warning: comparison of
distinct pointer types lacks a cast
drivers/infiniband/hw/ipath/ipath_verbs.c: In function 'ipath_verbs_send_pio':
drivers/infiniband/hw/ipath/ipath_verbs.c:1295: error: size of array
'type name' is negative
drivers/infiniband/hw/ipath/ipath_verbs.c:1295: warning: comparison of
distinct pointer types lacks a cast
drivers/infiniband/hw/ipath/ipath_verbs.c:1297: error: size of array
'type name' is negative
drivers/infiniband/hw/ipath/ipath_verbs.c:1297: warning: comparison of
distinct pointer types lacks a cast
make[3]: *** [drivers/infiniband/hw/ipath/ipath_verbs.o] Error 1
make[2]: *** [drivers/infiniband/hw/ipath] Error 2
make[1]: *** [drivers/infiniband] Error 2
make: *** [drivers] Error 2
