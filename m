From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] rtmutex: Flush block plug on __down_read()
Date: Wed, 9 Jan 2019 09:31:08 +0100
Message-ID: <20190109083107.xqjreevkq3lkkfzq@linutronix.de>
References: <1546634001-4450-1-git-send-email-swood@redhat.com>
 <20190107165056.2lhd53umgt4vod5o@linutronix.de>
 <1546975187.3632.10.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Scott Wood <swood@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1546975187.3632.10.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2019-01-08 13:19:47 [-0600], Scott Wood wrote:
> >  We
> > do it for rtmutex because !RT does it for mutex.
> > Now I can't remember why this was skipped for a rw_sem since it is
> > performed for !RT as part of the schedule() invocation.
> 
> Without this we were seeing XFS hangs on our internal kernel.  I wasn't able
> to reproduce it on a newer kernel, but it's very timing-dependant so I
> wouldn't read too much into that.

In this case I don't care much if you can reproduce this or not. The
point is that !RT does this so RT should do it, too. And back then (when
this piece was added) we wanted to copy the !RT behaviour and somehow
missed that piece.

> > If I don't come up with a plausible explanation then I will apply this
> > plus a hunk for the __down_write_common() case which should also be
> > required (right?).
> 
> I don't think it's needed, as it doesn't call into the rtmutex code via a
> backdoor.  When blocking on sem->rtmutex, rt_mutex_fastlock() will call the
> flush.  When blocking with a direct call to schedule(), tsk_is_pi_blocked()
> will not be true, and thus schedule() will do the flush via
> sched_submit_work().

a backdoor :) But yes, in each case we invoke schedule() so it is good.
Okay then. Let me apply it.
Thank you.

> -Scott

Sebastian
