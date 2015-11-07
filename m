From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: kernel BUG at kernel/rtmutex_common.h:75
Date: Sat, 7 Nov 2015 19:09:43 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1511071908340.4032@nanos>
References: <CAAh1qt=DCL9aUXNxanP5BKtiPp3m+qj4yB+gDohhXPVFCxWwzg@mail.gmail.com> <alpine.DEB.2.11.1511061215400.4032@nanos>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-190995543-1446919783=:4032"
Cc: linux-rt-users@vger.kernel.org
To: Yimin Deng <yimin11.deng@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35700 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938AbbKGSK0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 7 Nov 2015 13:10:26 -0500
In-Reply-To: <alpine.DEB.2.11.1511061215400.4032@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-190995543-1446919783=:4032
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 6 Nov 2015, Thomas Gleixner wrote:
> On Wed, 4 Nov 2015, Yimin Deng wrote:
> > It seems that the purpose to call the remove_waiter() is to remove the
> > waiter added by “plist_add(&waiter->list_entry, &lock->wait_list);” in
> > the task_blocks_on_rt_mutex(). But in the scenario above there's no
> > waiter on the lock yet and
> > the waiter has not been added into the wait list of the lock in the
> > task_blocks_on_rt_mutex() due to the failure “-EAGAIN”. So it reported
> > kernel BUG in the rt_mutex_top_waiter().
> > 
> > I modified it as below and the issue seems disappear.
> > - if (unlikely(ret))
> > + if (unlikely(ret && (-EAGAIN != ret)))
> >        remove_waiter(lock, waiter);
> > 
> > Could the scenario above be possible? If so, how to resolve this issue?
> > Thanks!
> 
> Yes it is possible. Nice detective work!
> 
> Your solution is correct, but actually it's not sufficient, because we
> have another possibility to return early without being queued
> (-EDEADLOCK). Find the full solution below.
> 
> Thanks for tracking that down!

Btw, please update to 3.12.48-rt66. It contains quite some bugfixes in
the area of futex/rtmutex.

Thanks,

	tglx
--8323329-190995543-1446919783=:4032--
