From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] v4.13.10-rt3 (possible recursive locking warning)
Date: Thu, 16 Nov 2017 16:39:35 +0100
Message-ID: <20171116153935.vkspby3iw4v7wnmx@linutronix.de>
References: <20171027222709.sna64giwxak4dxxc@linutronix.de>
 <916b113b-f743-8b3f-6f47-70ed572f76b6@ccrma.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <916b113b-f743-8b3f-6f47-70ed572f76b6@ccrma.stanford.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-11-03 10:11:47 [-0700], Fernando Lopez-Lezcano wrote:
> I'm seeing this (old Lenovo T510 running Fedora 26):
> 
> --------
…
> [   54.942023] WARNING: possible recursive locking detected
> [   54.942026] 4.13.10-200.rt3.1.fc26.ccrma.x86_64+rt #1 Not tainted
> [   54.942026] --------------------------------------------
> [   54.942028] csd-sound/1392 is trying to acquire lock:
> [   54.942029]  (&lock->wait_lock){....-.}, at: [<ffffffffb19b2a5d>]  rt_spin_lock_slowunlock+0x4d/0xa0
> [   54.942038]
>                but task is already holding lock:
> [   54.942039]  (&lock->wait_lock){....-.}, at: [<ffffffffb1165c79>] futex_lock_pi+0x269/0x4b0
…

I've been looking at the wrong spot most of the time… So that is
harmless. After consolidation of ->wait_lock's init function it
complains about unlocking the hash_bucket lock while holding
pi_mutex->wait_lock which is okay because those are used in different
"context" and we don't end up in an attempt of holding the same lock
twice. So in order to avoid moving raw_spin_lock_init() into each caller
of __rt_mutex_init() (like it was) I think we can go with something like
this:

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -2261,6 +2261,7 @@ void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
 				struct task_struct *proxy_owner)
 {
 	__rt_mutex_init(lock, NULL, NULL);
+	raw_spin_lock_init(&lock->wait_lock);
 	debug_rt_mutex_proxy_lock(lock, proxy_owner);
 	rt_mutex_set_owner(lock, proxy_owner);
 }

an alternative would be to use _nested version but I think this is
simpler.

> Best,
> -- Fernando

Sebastian
