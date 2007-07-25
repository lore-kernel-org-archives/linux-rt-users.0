From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: Re: Pin-pointing the root of unusual application latencies
Date: Wed, 25 Jul 2007 18:31:34 +0200
Message-ID: <200707251831.34969.fzu@wemgehoertderstaat.de>
References: <469600F7.3060603@free.fr> <200707251728.00207.fzu@wemgehoertderstaat.de> <46A77054.8040203@free.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout1.freenet.de ([195.4.92.91]:40076 "EHLO mout1.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752559AbXGYQai (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jul 2007 12:30:38 -0400
In-Reply-To: <46A77054.8040203@free.fr>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Am Mittwoch, 25. Juli 2007 schrieb John Sigler:
> Karsten Wiese wrote:
> 
> > John Sigler wrote:
> > 
> >> Is there some form of priority inheritance? Does the IRQ handler get a 
> >> priority boost if a high priority task is waiting for it?
> > 
> > No. But that would be "nice to have".
> 
> No to the first question? to the second question? or to both? :-)
> 
To the second.
I checked some soundcard drivers some time ago in -rt kernels, looking for
that "priority boosted by consuming process threaded interrupt handler".
Then there was no such.

> In kernel/futex.c does "PI" stand for Priority Inheritance?
> 
I guess so, yes.

> e.g.
> 
> /*
>   * Priority Inheritance state:
>   */
> struct futex_pi_state {
> 	/*
> 	 * list of 'owned' pi_state instances - these have to be
> 	 * cleaned up in do_exit() if the task exits prematurely:
> 	 */
> 	struct list_head list;
> 
> 	/*
> 	 * The PI object:
> 	 */
> 	struct rt_mutex pi_mutex;
> 
> 	struct task_struct *owner;
> 	atomic_t refcount;
> 
> 	union futex_key key;
> };
> 
> 
