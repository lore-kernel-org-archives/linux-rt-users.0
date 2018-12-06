From: Daniel Bristot de Oliveira <daniel@bristot.me>
Subject: Re: [PATCH RT] hrtimer: move state change before hrtimer_cancel in
 do_nanosleep()
Date: Thu, 6 Dec 2018 14:54:20 +0100
Message-ID: <42567e6b-87b4-9b9e-6442-97e4b7428d71@bristot.me>
References: <20181206101555.xqrz2fl6k36bvezm@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206101555.xqrz2fl6k36bvezm@linutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On 12/6/18 11:15 AM, Sebastian Andrzej Siewior wrote:
> There is a small window between setting t->task to NULL and waking the
> task up (which would set TASK_RUNNING). So the timer would fire, run and
> set ->task to NULL while the other side/do_nanosleep() wouldn't enter
> freezable_schedule(). After all we are peemptible here (in
> do_nanosleep() and on the timer wake up path) and on KVM/virt the
> virt-CPU might get preempted.
> So do_nanosleep() wouldn't enter freezable_schedule() but cancel the
> timer which is still running and wait for it via
> hrtimer_wait_for_timer(). Then wait_event()/might_sleep() would complain
> that it is invoked with state != TASK_RUNNING.
> This isn't a problem since it would be reset to TASK_RUNNING later
> anyway and we don't rely on the previous state.
> 
> Move the state update to TASK_RUNNING before hrtimer_cancel() so there
> are no complains from might_sleep() about wrong state.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Thanks!

-- Daniel
