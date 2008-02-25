From: Sven-Thorsten Dietrich <sdietrich@novell.com>
Subject: Re: [(RT RFC) PATCH v2 6/9] add a loop counter based timeout
	mechanism
Date: Mon, 25 Feb 2008 14:39:29 -0800
Message-ID: <1203979169.16711.101.camel@sven.thebigcorporation.com>
References: <20080225155959.11268.35541.stgit@novell1.haskins.net>
	 <20080225160108.11268.1451.stgit@novell1.haskins.net>
	 <20080225220601.GH2659@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Gregory Haskins <ghaskins@novell.com>, mingo@elte.hu,
	a.p.zijlstra@chello.nl, tglx@linutronix.de, rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bill.huey@gmail.com, kevin@hilman.org, cminyard@mvista.com,
	dsingleton@mvista.com, dwalker@mvista.com, npiggin@suse.de,
	dsaxena@plexity.net, ak@suse.de, acme@redhat.com, gregkh@suse.de,
	pmorreale@novell.com, mkohari@novell.com
To: Pavel Machek <pavel@ucw.cz>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:55724 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754452AbYBYWnY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Feb 2008 17:43:24 -0500
In-Reply-To: <20080225220601.GH2659@elf.ucw.cz>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Mon, 2008-02-25 at 23:06 +0100, Pavel Machek wrote:
> On Mon 2008-02-25 11:01:08, Gregory Haskins wrote:
> > From: Sven Dietrich <sdietrich@novell.com>
> 
> Why is this good idea?
> 

The timeout is useful to eliminate excessive CPU utilization when
waiting for long-held critical sections. 

The patch header should state this :) Will fix.

> > Signed-off-by: Sven Dietrich <sdietrich@novell.com>
> > ---
> 
> >  
> > +config RTLOCK_DELAY
> > +	int "Default delay (in loops) for adaptive rtlocks"
> > +	range 0 1000000000
> > +	depends on ADAPTIVE_RTLOCK
> > +	default "10000"
> > +        help
> > +         This allows you to specify the maximum attempts a task will spin
> > +	 attempting to acquire an rtlock before sleeping.  The value is
> > +	 tunable at runtime via a sysctl.  A setting of 0 (zero) disables
> > +	 the adaptive algorithm entirely.
> > +
> 
> I believe you have _way_ too many config variables. If this can be set
> at runtime, does it need a config option, too?
> 

Absolutely. The sysctl was added after-the-fact, so this is a relic, we
will remove the config option, and define the default timeout in the
appropriate header.

Sven

> 									Pavel
