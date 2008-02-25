From: Sven-Thorsten Dietrich <sdietrich@novell.com>
Subject: Re: [(RT RFC) PATCH v2 2/9] sysctl for runtime-control of lateral
	mutex stealing
Date: Mon, 25 Feb 2008 14:57:11 -0800
Message-ID: <1203980231.16711.115.camel@sven.thebigcorporation.com>
References: <20080225155959.11268.35541.stgit@novell1.haskins.net>
	 <20080225160048.11268.55059.stgit@novell1.haskins.net>
	 <20080225215335.GE2659@elf.ucw.cz>
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
Received: from charybdis-ext.suse.de ([195.135.221.2]:58502 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761003AbYBYW5V (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Feb 2008 17:57:21 -0500
In-Reply-To: <20080225215335.GE2659@elf.ucw.cz>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Mon, 2008-02-25 at 22:53 +0100, Pavel Machek wrote:
> Hi!
> 
> > From: Sven-Thorsten Dietrich <sdietrich@suse.de>
> > 
> > Add /proc/sys/kernel/lateral_steal, to allow switching on and off
> > equal-priority mutex stealing between threads.
> > 
> > Signed-off-by: Sven-Thorsten Dietrich <sdietrich@suse.de>
> > ---
> > 
> >  
> >  #include "rtmutex_common.h"
> >

I'll move it to the header file.

>   
> > +#ifdef CONFIG_RTLOCK_LATERAL_STEAL
> > +int rtmutex_lateral_steal __read_mostly = 1;
> > +#endif
> > +
> 
> Ugly..
> 

> 
> >  /*
> >   * lock->owner state tracking:
> >   *
> > @@ -321,7 +325,8 @@ static inline int lock_is_stealable(struct task_struct *pendowner, int unfair)
> >  	if (current->prio > pendowner->prio)
> >  		return 0;
> >  
> > -	if (!unfair && (current->prio == pendowner->prio))
> > +	if (unlikely(current->prio == pendowner->prio) &&
> > +	   !(unfair && rtmutex_lateral_steal))
> >  #endif
> 
> But this is even worse, you are creating #ifdef maze here. Can you
> simply #define rtmutex_lateral_steal 0 in !CONFIG_RTLOCK_LATERAL_STEAL
> and let the optimizer fix this?
> 

Ok - much of this will also disappear into the header then.

> 
> > index c913d48..c24c53d 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -175,6 +175,10 @@ extern struct ctl_table inotify_table[];
> >  int sysctl_legacy_va_layout;
> >  #endif
> >  
> > +#ifdef CONFIG_RTLOCK_LATERAL_STEAL
> > +extern int rtmutex_lateral_steal;
> > +#endif
> > +
> 
> Try checkpatch.
> 									Pavel

I have that as part of quilt refresh, and it returns:

Your patch has no obvious style problems and is ready for submission.

But Greg may need to enforce it on his git tree that he mails these from
- are you referring to anything specific in this patch?

Sven
