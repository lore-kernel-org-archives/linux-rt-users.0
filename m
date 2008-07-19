From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH][RT][PPC64] Fix preempt unsafe paths accessing per_cpu
 variables
Date: Fri, 18 Jul 2008 21:26:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0807182123510.4932@gandalf.stny.rr.com>
References: <20080709160543.GG7101@linux.vnet.ibm.com>  <1216085521.7740.37.camel@pasglop>
  <20080717125645.GN20277@linux.vnet.ibm.com>  <1216325671.7740.359.camel@pasglop>
  <20080718101133.GO20277@linux.vnet.ibm.com> <1216418730.7740.451.camel@pasglop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chirag Jog <chirag@linux.vnet.ibm.com>,
	linux.kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Josh Triplett <josht@linux.vnet.ibm.com>,
	Nivedita Singhvi <niv@us.ibm.com>,
	"Timothy R. Chavez" <tim.chavez@linux.vnet.ibm.com>,
	paulmck@linux.vnet.ibm.com, Thomas Gleixner <tglx@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:64917 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbYGSB0D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 Jul 2008 21:26:03 -0400
In-Reply-To: <1216418730.7740.451.camel@pasglop>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Sat, 19 Jul 2008, Benjamin Herrenschmidt wrote:
>
> > With the original patch, the pending batch does get flushed
> > in a non-preemptable region.
> > I am resending the original with just adding the necesary comments.
>
> Your comment isn't what I meant. What I meant is that if the process
> is context switched while walking the page tables, the low level powe=
rpc
> context switch code should also perform a =EF=BB=BF__flush_tlb_pendin=
g.
>
> BTW. Is the pte_lock also not a real spinlock anymore ? That may brea=
k
> other assumptions the powerpc mm code is doing.
>
> This -rt stuff is just too scary, it changes some fundamental semanti=
cs
> of the spinlocks. yuck.

There's lots of semantics that are changed with -rt that should make
everything still work ;-)  Some spinlocks remain real spinlocks, but we
shouldn't have a problem with most being mutexes.

There's some cases that uses per CPU variables or other per cpu actions
that require a special CPU_LOCK that protects the data in a preemption
mode. The slab.c code in -rt handles this.

-- Steve


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
