From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] seqlock: serialize against writers
Date: Fri, 29 Aug 2008 18:09:16 +0200
Message-ID: <87abevpzv7.fsf@basil.nowhere.org>
References: <20080829154237.1196.66825.stgit@dev.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mingo@elte.hu, rostedt@goodmis.org, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	gregory.haskins@gmail.com
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:34397 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753317AbYH2QJT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Aug 2008 12:09:19 -0400
In-Reply-To: <20080829154237.1196.66825.stgit@dev.haskins.net> (Gregory Haskins's message of "Fri, 29 Aug 2008 11:44:58 -0400")
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Gregory Haskins <ghaskins@novell.com> writes:

> *Patch submitted for inclusion in PREEMPT_RT 26-rt4.  Applies to 2.6.26.3-rt3*
>
> Hi Ingo, Steven, Thomas,
>   Please consider for -rt4.  This fixes a nasty deadlock on my systems under
>   heavy load.

Does this even work under x86-64? x86-64 uses seqlocks in user space
in its vsyscalls. And read_lock() definitely doesn't work there because 
it writes.

You would need at least to disable vsyscall gettimeofday(), making
it much much slower.

Perhaps you tested on one of the systems where the vsyscalls need
to fallback for other reasons? (e.g. one using pmtimer for timing).

-Andi
