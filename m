From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [rt-tests][PATCH] align thread wakeup times
Date: Fri, 4 Oct 2013 15:33:25 +0200
Message-ID: <20131004133325.GB26223@opentech.at>
References: <20130909072948.GA1967@opentech.at> <20131004132207.GF19953@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: williams@redhat.com, linux-rt-users@vger.kernel.org,
	C.Emde@osadl.org, tglx@linutronix.de, andi@opentech.at
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:37855 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753531Ab3JDNd2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Oct 2013 09:33:28 -0400
Content-Disposition: inline
In-Reply-To: <20131004132207.GF19953@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 04 Oct 2013, Sebastian Andrzej Siewior wrote:

> * Nicholas Mc Guire | 2013-09-09 09:29:48 [+0200]:
> 
> >Hi !
> Hi Nicholas,
> 
> >  This patch provides and additional -A/--align flag to cyclictest to align
> > thread wakeup times of all threads as closly defined as possible.
> >
> >  When running multiple threads in cyclictest (-S or -t # option) the threads
> > are launched in an unsynchronized manner. Basically the creation order and
> > time for thread creation determines the start time. For provoking a maximum
> > congestion situation (e.g. cache evictions) and to improve reproducibility
> > or run conditions the start time should be defined distances appart. The 
> > well defined distance is implemented as a offset parameter to -A/--align
> > and will offset each threads start time by the parameter * the sequentially
> > assigned thread number (par->tnum), together with the -d0 (distance in the
> > intervals of the individual threads) this alignment option allows to get 
> > the thread wakeup times as closely synchronized as possible.
> >
> >  The method to sync is simply that the thread with par->tnum == 0 is chosen
> > to set a globally shared timestamp, and all other threads use this timestamp
> > as their starting time rather than each calling clock_gettime() at startup.
> > To ensure synchronization of the thread startup the setting of the global
> > time is guarded by pthread_barriers.
> 
> I would rather fix current behaviour instead introducing yet another
> option. By using -d0 I assume that all threads wakeup at the same time.

Nop they do not -d0 just says that they all use
the same period rather than some offset with multiple threads (e.g. -S)

> According to your patch this does not happen due to the thread creating
> / starting overhead.
> Is there is a reason to keep this "faulty" behavior? If not I would vote
> to make this what you suggest the default.
> 

its not faulty behavior - its a different case
in fact we need both.

same period + "random" start time
same period + synced start time

it makes a difference on some boxes that is significant.

thx!
hofrat
