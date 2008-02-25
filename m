From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [(RT RFC) PATCH v2 6/9] add a loop counter based timeout
	mechanism
Date: Mon, 25 Feb 2008 23:06:01 +0100
Message-ID: <20080225220601.GH2659@elf.ucw.cz>
References: <20080225155959.11268.35541.stgit@novell1.haskins.net> <20080225160108.11268.1451.stgit@novell1.haskins.net>
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
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39645 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752772AbYBYWFg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Feb 2008 17:05:36 -0500
Content-Disposition: inline
In-Reply-To: <20080225160108.11268.1451.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon 2008-02-25 11:01:08, Gregory Haskins wrote:
> From: Sven Dietrich <sdietrich@novell.com>

Why is this good idea?

> Signed-off-by: Sven Dietrich <sdietrich@novell.com>
> ---

>  
> +config RTLOCK_DELAY
> +	int "Default delay (in loops) for adaptive rtlocks"
> +	range 0 1000000000
> +	depends on ADAPTIVE_RTLOCK
> +	default "10000"
> +        help
> +         This allows you to specify the maximum attempts a task will spin
> +	 attempting to acquire an rtlock before sleeping.  The value is
> +	 tunable at runtime via a sysctl.  A setting of 0 (zero) disables
> +	 the adaptive algorithm entirely.
> +

I believe you have _way_ too many config variables. If this can be set
at runtime, does it need a config option, too?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
