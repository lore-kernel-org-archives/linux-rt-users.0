From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] lockdep: Make MAX_STACK_TRACE_ENTRIES configurable.
Date: Wed, 21 Apr 2010 14:03:00 +0200
Message-ID: <1271851380.1776.96.camel@laptop>
References: <alpine.LFD.2.00.1004161329030.11320@localhost.localdomain>
	 <alpine.LFD.2.00.1004161727000.11320@localhost.localdomain>
	 <alpine.LFD.2.00.1004191841230.6259@localhost>
	 <20100420140941.d085007d.akpm@linux-foundation.org>
	 <alpine.LFD.2.00.1004211309560.6646@localhost>
	 <1271849823.1776.87.camel@laptop>
	 <4BCEAD7B0200005A0006513E@soto.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: John Kacur <jkacur@redhat.com>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:39388 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940Ab0DUMDF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Apr 2010 08:03:05 -0400
Received: from f199130.upc-f.chello.nl ([80.56.199.130] helo=dyad.programming.kicks-ass.net)
	by bombadil.infradead.org with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1O4Ydz-0004Uh-76
	for linux-rt-users@vger.kernel.org; Wed, 21 Apr 2010 12:03:03 +0000
In-Reply-To: <4BCEAD7B0200005A0006513E@soto.provo.novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2010-04-21 at 05:47 -0600, Gregory Haskins wrote:
> 
> I am not sure if Johns solution is the right/best one per se, but I can attest
> that I used to hit this problem _all_ the time and it was somewhat annoying
> to need to patch the kernel on all of my machines to fix it.  I realize that I
> perhaps do not represent the average user, but it was a pain-point for me.
> FWIW, John's patch would indeed make my life easier since I tend to share the
> .config between builds. 

Right, so all I'm wanting to know if its a symptom of some funny or an
actual depletion, in the latter case I think the best solution is to
simply increase the number. In the former case we should of course fix
the real issue instead of making it disappear.

So one case I remember is where some code managed to create 1k classes
where 1 would have sufficed, this resulted in at least 1k extra stack
traces to be stored, consuming vast amounts of stack_entries.

So please, if you can reproduce, look at where these entries are going,
lots of classes with the same name are a good hint that something is
fishy. Classes with more than 13 (4*nr_states + 1) stacks should also
never happen, etc..

Is this specific to -RT, or do we see it without as well? If so, what in
-RT grows this? Are we creating a class per rt_mutex spinlock or
something silly like that?

