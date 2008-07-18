From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH][RT][PPC64] Fix preempt unsafe paths accessing per_cpu
	variables
Date: Sat, 19 Jul 2008 08:05:30 +1000
Message-ID: <1216418730.7740.451.camel@pasglop>
References: <20080709160543.GG7101@linux.vnet.ibm.com>
	 <1216085521.7740.37.camel@pasglop>
	 <20080717125645.GN20277@linux.vnet.ibm.com>
	 <1216325671.7740.359.camel@pasglop>
	 <20080718101133.GO20277@linux.vnet.ibm.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux.kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Josh Triplett <josht@linux.vnet.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nivedita Singhvi <niv@us.ibm.com>,
	"Timothy R. Chavez" <tim.chavez@linux.vnet.ibm.com>,
	paulmck@linux.vnet.ibm.com, Thomas Gleixner <tglx@linutronix.de>
To: Chirag Jog <chirag@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:41418 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754124AbYGRWGS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 Jul 2008 18:06:18 -0400
In-Reply-To: <20080718101133.GO20277@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


> With the original patch, the pending batch does get flushed=20
> in a non-preemptable region.=20
> I am resending the original with just adding the necesary comments.

Your comment isn't what I meant. What I meant is that if the process
is context switched while walking the page tables, the low level powerp=
c
context switch code should also perform a =EF=BB=BF__flush_tlb_pending.

BTW. Is the pte_lock also not a real spinlock anymore ? That may break
other assumptions the powerpc mm code is doing.

This -rt stuff is just too scary, it changes some fundamental semantics
of the spinlocks. yuck.

Ben.


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
