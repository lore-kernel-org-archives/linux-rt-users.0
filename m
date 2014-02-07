From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: priority inheritance on kernel semaphore?
Date: Fri, 7 Feb 2014 18:03:22 +0100
Message-ID: <20140207170322.GE2382@linutronix.de>
References: <20140129070736.78924D6CCE2A@bmail06.one.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
To: "Kim H. Madsen" <kim@undo.dk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:47289 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbaBGRDZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Feb 2014 12:03:25 -0500
Content-Disposition: inline
In-Reply-To: <20140129070736.78924D6CCE2A@bmail06.one.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Kim H. Madsen | 2014-01-29 08:07:36 [+0100]:

>According to <https://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO> the
>preempt-rt patch is "Implementing priority inheritance for in-kernel
>spinlocks and semaphores.".
>
>Testing this on 2.6.33.7-rt29 and 3.4.37-rt51 using up()/down() seems to
>give another result? PI works fine when using rt_mutex instead in the test. Have I
>failed in the testing/configuration or is the documentation out of date?

The documentation is partly out of date. In the "early" days we had
boosting for semaphores. Later (once the semaphore users were not that
important / critical) the whole owner tracking part got removed and so
we do not have priority boosting for semaphores anymore.

There are also reader/write semaphores (rw_semaphore) and this is
almost mapped to a mutexe (there is a difference a small difference).
Here we have owner tracking and PI on -RT. The price for this is that
you can't have >1 simultaneous readers on a rw_semaphore on -RT.

So spin_lock, mutex and rw_semaphore should give you PI, plain
semaphores don't.

John, could you please update the wiki?

>- Kim--

Sebastian
