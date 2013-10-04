From: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [patch 1/3] ipc/sem: fix -rt livelock
Date: Fri, 04 Oct 2013 16:02:07 +0200
Message-ID: <524ECA5F.1090803@colorfullife.com>
References: <1379051751.5455.112.camel@marge.simpson.net> <1379052760.5455.127.camel@marge.simpson.net> <5234D94D.8010608@colorfullife.com> <1379220340.5545.93.camel@marge.simpson.net> <20131004104450.GB19953@linutronix.de> <1380885410.5432.5.camel@marge.simpson.net> <524EA673.5050400@linutronix.de> <1380894919.5432.12.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:49457 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754782Ab3JDOCN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Oct 2013 10:02:13 -0400
Received: by mail-bk0-f52.google.com with SMTP id e11so1513502bkh.25
        for <linux-rt-users@vger.kernel.org>; Fri, 04 Oct 2013 07:02:11 -0700 (PDT)
In-Reply-To: <1380894919.5432.12.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/04/2013 03:55 PM, Mike Galbraith wrote:
> On Fri, 2013-10-04 at 13:28 +0200, Sebastian Andrzej Siewior wrote:
>> On 10/04/2013 01:16 PM, Mike Galbraith wrote:
>>> Manfred's race fix also kills loop, and thereby the -rt livelock, so the
>>> only question is does -rt want to use his completion wakeup scheme, and
>>> does it want to do something about spin_unlock_wait() unconditionally
>>> grabbing/releasing every lock in the array.
>> So his patches went into v3.11 or so right? So all -RT released post
>> this point will have it fixed right?
> Most fixes have gone into master.  There's still at least one in the
> pipe, ipc/sem.c: synchronize semop and semctl with IPC_RMID, and I
> _think_ there's still one open issue.
>
> <quoting Manfred>
> And now new:
> 1) ipc/namespace.c:
>       free_ipcs() still assumes the "old style" free calls:
>       rcu_lock and ipc_lock dropped within the callback.
>
>       freeary() was converted - but free_ipcs was not updated.
>
>       Thus:
>       Closing a namespace with sem arrays and threads that are waiting
> on
> the array with semtimedop() and bad timing can deadlock the semtimedop
> thread.
>       (i.e.: spin_lock() waiting forever).
> </quoting Manfred>
That one was a false alarm, i.e. everything is fixed in -mm.

--
	Manfred



