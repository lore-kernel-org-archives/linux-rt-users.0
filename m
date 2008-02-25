From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [(RT RFC) PATCH v2 8/9] adjust pi_lock usage in wakeup
Date: Mon, 25 Feb 2008 23:10:33 +0100
Message-ID: <20080225221033.GJ2659@elf.ucw.cz>
References: <20080225155959.11268.35541.stgit@novell1.haskins.net> <20080225160118.11268.47575.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mingo@elte.hu, a.p.zijlstra@chello.nl, tglx@linutronix.de,
	rostedt@goodmis.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bill.huey@gmail.com,
	kevin@hilman.org, cminyard@mvista.com, dsingleton@mvista.com,
	dwalker@mvista.com, npiggin@suse.de, dsaxena@plexity.net,
	ak@suse.de, acme@redhat.com, gregkh@suse.de, sdietrich@novell.com,
	pmorreale@novell.com, mkohari@novell.com
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41971 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754357AbYBYWKJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Feb 2008 17:10:09 -0500
Content-Disposition: inline
In-Reply-To: <20080225160118.11268.47575.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon 2008-02-25 11:01:18, Gregory Haskins wrote:
> From: Peter W.Morreale <pmorreale@novell.com>
> 
> In wakeup_next_waiter(), we take the pi_lock, and then find out whether
> we have another waiter to add to the pending owner.  We can reduce
> contention on the pi_lock for the pending owner if we first obtain the
> pointer to the next waiter outside of the pi_lock.
> 
> This patch adds a measureable increase in throughput.
> 
> Signed-off-by: Peter W. Morreale <pmorreale@novell.com>

Missing sign-off.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
