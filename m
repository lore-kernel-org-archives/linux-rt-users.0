From: Simon Falsig <simon@newtec.dk>
Subject: RE: Real-time kernel thread performance and optimization
Date: Wed, 12 Dec 2012 16:39:01 +0100
Message-ID: <ce2a2c5c91e1f62aee4e59c3458ee697@mail.gmail.com>
References: <6b5093025753dbc76e1d23af7c999826@mail.gmail.com>
 <50B933A5.3020400@am.sony.com> d27143389b68c615c242b56c7cd4dd22@mail.gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from eu1sys200aog109.obsmtp.com ([207.126.144.127]:57462 "HELO
	eu1sys200aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752766Ab2LLPjF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 12 Dec 2012 10:39:05 -0500
Received: by mail-wg0-f70.google.com with SMTP id ds1so676700wgb.1
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Dec 2012 07:39:03 -0800 (PST)
In-Reply-To: d27143389b68c615c242b56c7cd4dd22@mail.gmail.com
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

And another tweak. Having looked at the actual code for usleep_range(),
I'm now basically doing the same (calling schedule_hrtimeout_range()),
although in absolute mode. This makes everything simpler, as I can then
just keep forwarding my original timeout with 10ms, instead of having to
keep track of how long my work took - and it minimizes drift also.

In addition to the below changes, I've also changed to a tickless kernel,
btw.

static int bus_rt_timer_thread(void *arg)
{
	struct custombus_device_driver *cbdrv, *next_cbdrv;
	
	printk(KERN_INFO "RT Thread entering loop\n");
	
	ktime_t timeout = ktime_get();
	while(!kthread_should_stop()) {
				
		rt_mutex_lock(&list_10ms_mutex);
	
list_for_each_entry_safe(cbdrv,next_cbdrv,&polling_10ms_list,poll_list) {
			driver_for_each_device(&cbdrv->driver, NULL, NULL,
cbdrv->poll_function);
		}
		rt_mutex_unlock(&list_10ms_mutex);
				
		timeout = ktime_add_us(timeout, 10000);
		__set_current_state(TASK_UNINTERRUPTIBLE);
		schedule_hrtimeout_range(&timeout, 100, HRTIMER_MODE_ABS);
	}
	printk(KERN_INFO "RT Thread exited\n");

	return 0;	
}

int __init bus_timer_interrupt_init(void)
{
	struct sched_param param = { .sched_priority = MAX_RT_PRIO - 1 };
	
	thread_10ms = kthread_create(bus_rt_timer_thread, NULL,
"bus_10ms");
	if (IS_ERR(thread_10ms)) {
		printk(KERN_ERR "RT Failed to create RT thread\n");
		return -ESRCH;
	}

	sched_setscheduler(thread_10ms, SCHED_FIFO, &param);

	wake_up_process(thread_10ms);
	
	printk(KERN_INFO "RT Timer thread installed with standard priority
%d.\n", param.sched_priority);
	return 0;
}


This implementation is again even simpler, and also performs better.
30-minute stress test results:

Old implementation (original hr_timer):
	Cycles over 10.3 ms:	3144
	Cycles under 9.7 ms:	3852
	Max. cycletime:	~56.5 ms

New implementation (usleep_range):
	Cycles over 10.3 ms:	26
	Cycles under 9.7 ms:	0
	Max. cycletime:	~10.4 m

New new implementation (schedule_hrtimeout_range):
	Cycles over 10.3 ms:	0
	Cycles under 9.7 ms:	0
	Max. cycletime:	~10.2 m


Again, comments, questions, anything else is welcome,
Best regards,
Simon Falsig
