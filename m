From: Scott Wood <swood@redhat.com>
Subject: Re: [PATCH RT] rtmutex: Flush block plug on __down_read()
Date: Tue, 08 Jan 2019 13:19:47 -0600
Message-ID: <1546975187.3632.10.camel@redhat.com>
References: <1546634001-4450-1-git-send-email-swood@redhat.com>
         <20190107165056.2lhd53umgt4vod5o@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190107165056.2lhd53umgt4vod5o@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2019-01-07 at 17:50 +0100, Sebastian Andrzej Siewior wrote:
> On 2019-01-04 15:33:21 [-0500], Scott Wood wrote:
> > __down_read() bypasses the rtmutex frontend to call
> > rt_mutex_slowlock_locked() directly, and thus it needs to call
> > blk_schedule_flush_flug() itself.
> 
> we don't do this in the spin_lock() case because !RT doesn't do it.

And because spin_lock() is called inside the flush path.

>  We
> do it for rtmutex because !RT does it for mutex.
> Now I can't remember why this was skipped for a rw_sem since it is
> performed for !RT as part of the schedule() invocation.

Without this we were seeing XFS hangs on our internal kernel.  I wasn't able
to reproduce it on a newer kernel, but it's very timing-dependant so I
wouldn't read too much into that.

> If I don't come up with a plausible explanation then I will apply this
> plus a hunk for the __down_write_common() case which should also be
> required (right?).

I don't think it's needed, as it doesn't call into the rtmutex code via a
backdoor.  When blocking on sem->rtmutex, rt_mutex_fastlock() will call the
flush.  When blocking with a direct call to schedule(), tsk_is_pi_blocked()
will not be true, and thus schedule() will do the flush via
sched_submit_work().

-Scott
