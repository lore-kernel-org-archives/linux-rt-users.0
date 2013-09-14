From: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [patch 1/3] ipc/sem: fix -rt livelock
Date: Sat, 14 Sep 2013 23:46:53 +0200
Message-ID: <5234D94D.8010608@colorfullife.com>
References: <1379051751.5455.112.camel@marge.simpson.net> <1379052760.5455.127.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:52115 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756789Ab3INVrD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 14 Sep 2013 17:47:03 -0400
Received: by mail-bk0-f47.google.com with SMTP id mx12so956657bkb.34
        for <linux-rt-users@vger.kernel.org>; Sat, 14 Sep 2013 14:47:01 -0700 (PDT)
In-Reply-To: <1379052760.5455.127.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Mike,

On 09/13/2013 08:12 AM, Mike Galbraith wrote:
> goto again loop can and does induce livelock in -rt.  Remove it.
>
> spin_unlock_wait(lock) in -rt kernels takes/releases the lock in question, so
> all it takes to create a self perpetuating loop is for one task to start the
> ball rolling by taking the array lock, other tasks see this, and react by
> take/release/retry endlessly.
I think your code inherits the race I just sent to you:
The test of complex_count must be after spin_is_locked().

http://marc.info/?l=linux-kernel&m=137919453307294

Could you check that?
Or alternatively: Is my proposed sem_lock() function -rt friendly?


>   		locknum = -1;
> +
> +		if (nsops == 1 && !sma->complex_count) {
> +			sem = sma->sem_base + sops->sem_num;
> +			spin_lock(&sem->lock);
> +			spin_unlock(&sma->sem_perm.lock);
> +			locknum = sops->sem_num;
> +		}
A clever idea:
If the decision that the slow path must be used proves to be a false 
alarm, switch back to the fast path.
You can even move that block further up and skip the loop over all 
per-semaphore arrays.

--
     Manfred
