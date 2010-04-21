From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] lockdep: Make MAX_STACK_TRACE_ENTRIES configurable.
Date: Wed, 21 Apr 2010 13:37:03 +0200
Message-ID: <1271849823.1776.87.camel@laptop>
References: <alpine.LFD.2.00.1004161329030.11320@localhost.localdomain>
	 <alpine.LFD.2.00.1004161727000.11320@localhost.localdomain>
	 <alpine.LFD.2.00.1004191841230.6259@localhost>
	 <20100420140941.d085007d.akpm@linux-foundation.org>
	 <alpine.LFD.2.00.1004211309560.6646@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:35644 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643Ab0DULhI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Apr 2010 07:37:08 -0400
Received: from f199130.upc-f.chello.nl ([80.56.199.130] helo=dyad.programming.kicks-ass.net)
	by bombadil.infradead.org with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1O4YEr-00050s-SK
	for linux-rt-users@vger.kernel.org; Wed, 21 Apr 2010 11:37:06 +0000
In-Reply-To: <alpine.LFD.2.00.1004211309560.6646@localhost>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2010-04-21 at 13:12 +0200, John Kacur wrote:
> 
> Certain configurations that have LOCKDEP turned on, run into the limit
> where the MAX_STACK_TRACE_ENTRIES are too small. Rather than simply
> turning of the locking correctness validator let the user configure this
> value to something reasonable for their system.

I'm not sure its worth having a CONFIG_ value for this, that'll just be
yet another random value nobody knows what to do with.

Do you actually have a machine that reproduces this? Can you see how
many classes, avg stacktraces per class and the avg entries per
stacktrace there are?

Also, is there's lots of classes, are there many with a similar name?

That is, is it a valid depletion or is there something wonkey with those
setups?

