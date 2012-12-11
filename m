From: Simon Falsig <simon@newtec.dk>
Subject: RE: Real-time kernel thread performance and optimization
Date: Tue, 11 Dec 2012 15:30:07 +0100
Message-ID: <d27143389b68c615c242b56c7cd4dd22@mail.gmail.com>
References: <6b5093025753dbc76e1d23af7c999826@mail.gmail.com> <50B933A5.3020400@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org
To: frank.rowand@am.sony.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:45892 "HELO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753663Ab2LKOaK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Dec 2012 09:30:10 -0500
Received: by mail-lb0-f198.google.com with SMTP id n1so3440409lba.1
        for <linux-rt-users@vger.kernel.org>; Tue, 11 Dec 2012 06:30:08 -0800 (PST)
In-Reply-To: <50B933A5.3020400@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I've finally had time to giving this a further look. After reading up on
some kernel internals, I decided to try and reimplement the timer system
using the usleep_range() call instead of the hrtimer/callback functions.

I've arrived at the following:


static int bus_rt_timer_thread(void *arg)
{
	struct custombus_device_driver *cbdrv, *next_cbdrv;
	cancelCallback = 0;
	printk(KERN_INFO "Entering RT loop\n");
	ktime_t startTime = ktime_get();
	while(cancelCallback == 0) {
		rt_mutex_lock(&list_10ms_mutex);
	
list_for_each_entry_safe(cbdrv,next_cbdrv,&polling_10ms_list,poll_list) {
			driver_for_each_device(&cbdrv->driver, NULL, NULL,
cbdrv->poll_function);
		}
		rt_mutex_unlock(&list_10ms_mutex);
		
		s64 timeTaken_us = ktime_us_delta(ktime_get(), startTime);
		if(timeTaken_us < 9900) {
			usleep_range(9900 - timeTaken_us, 10100 -
timeTaken_us);
		}
		
		startTime = ktime_get();
	}
	printk(KERN_INFO "RT Exited\n");
	return 0;	
}


int __init bus_timer_interrupt_init(void)
{
	struct sched_param param = { .sched_priority = MAX_RT_PRIO - 1 };
	
	thread_10ms = kthread_create(bus_rt_timer_thread, NULL,
"bus_10ms");
	if (IS_ERR(thread_10ms)) {
		printk(KERN_ERR "Failed to create RT thread\n");
		return -ESRCH;
	}

	sched_setscheduler(thread_10ms, SCHED_FIFO, &param);

	wake_up_process(thread_10ms);
	
	printk(KERN_INFO "RT timer thread installed with standard priority
%d.\n", param.sched_priority);
	return 0;
}


This is not only simpler than the previous implementation, it also
performs better. Results of a 30-minute stress-test:

Old implementation:
	Cycles over 10.3 ms:	3144
	Cycles under 9.7 ms:	3852
	Max. cycletime:	~56.5 ms

New implementation:
	Cycles over 10.3 ms:	26
	Cycles under 9.7 ms:	0
	Max. cycletime:	~10.4 ms

So all in all, much much better.
As far as I have found out, usleep_range() uses hrtimers also though (like
my previous implementation), so I'd be interested in knowing where the
main difference between the two implementations lies? I'd guess that it's
related to priorities somehow?

Additional answers/comments below:

> -----Original Message-----
> From: Frank Rowand [mailto:frank.rowand@am.sony.com]
> Sent: 30. november 2012 23:31
> To: Simon Falsig
> Cc: linux-rt-users@vger.kernel.org
> Subject: Re: Real-time kernel thread performance and optimization
>
> On 11/30/12 07:46, Simon Falsig wrote:
> > Hi,
> >
> > Inspired by Thomas Gleixners LinuxCon '12 appeal for more
> > communication/feedback/interaction from people using the preempt-RT
> > patch, here comes a rather long (and hopefully at least slightly
> > interesting) set of questions.
> >
> > First of all, a bit of background.  We have been using Linux and
> > preempt-RT on a custom ARM board for some years, and are currently in
> > the process of transitioning to a new AMD Fusion-based platform (also
> > custom-made, x86, 1.67 GHz dual-core). As we want to keep both systems
> > in production simultaneous for at least some time, we want to keep the
> > systems as similar as possible. For the new board, we have currently
> > settled on a 3.2.9 kernel with the rt16 patch (I can see that an rt17
> > patch has been released since we started though).
> >
> > Our own system consists of a user-space application, communicating
> > with/over:
> >  - Ethernet (for our GUI, which runs on a separate machine)
> >  - Serial ports (various hardware)
> >  - A set of custom kernel modules (implementing device drivers for
> > some custom I/O hardware)
> >
> > For the kernel modules we have a utility timer module, that allows
> > other modules to register a "poll" function, which is then run at a 10
> > ms cycle rate. We want this to happen in real-time, so the timer
> > module is made as an rt-thread using hrtimers (the implementation is
> > new, as the existing code from our old board used the ARM
> > hardware-timer). The following code is used:
> >
> > // Timer callback for 10ms polling of rackbus devices static enum
> > hrtimer_restart bus_10ms_callback(struct hrtimer *val) {
> > 	struct custombus_device_driver *cbdrv, *next_cbdrv;
> > 	ktime_t now = ktime_get();
> >
> > 	rt_mutex_lock(&list_10ms_mutex);
> >
> >
list_for_each_entry_safe(cbdrv,next_cbdrv,&polling_10ms_list,poll_list) {
> > 		driver_for_each_device(&cbdrv->driver, NULL,
> NULL,
> > cbdrv->poll_function);
> > 	}
> > 	rt_mutex_unlock(&list_10ms_mutex);
> >
> > 	hrtimer_forward(&timer, now, kt);
> > 	if(cancelCallback == 0) {
> > 		return HRTIMER_RESTART;
> > 	}
> > 	else {
> > 		return HRTIMER_NORESTART;
> > 	}
> > }
> >
> > // Thread to start 10ms timer
> > static int bus_rt_timer_init(void *arg) {
> > 	kt = ktime_set(0, 10 * 1000 * 1000);		//10
> ms = 10 *
> > 1000 * 1000 ns
> > 	cancelCallback = 0;
> > 	hrtimer_init(&timer, CLOCK_MONOTONIC,
> HRTIMER_MODE_REL);
> > 	timer.function = bus_10ms_callback;
> > 	hrtimer_start(&timer, kt, HRTIMER_MODE_REL);
> >
> > 	return 0;
> > }
> >
> > // Module initialization
> > int __init bus_timer_interrupt_init(void) {
> > 	struct sched_param param = { .sched_priority = MAX_RT_PRIO
> - 1 };
> >
> > 	thread_10ms = kthread_create(bus_rt_timer_init, NULL,
> "bus_10ms");
> > 	if (IS_ERR(thread_10ms)) {
> > 		printk(KERN_ERR "Failed to create RT
> thread\n");
> > 		return -ESRCH;
> > 	}
> >
> > 	sched_setscheduler(thread_10ms, SCHED_FIFO, &param);
> >
> > 	wake_up_process(thread_10ms);
> >
> > 	printk(KERN_INFO "RT timer thread installed with priority
> %d.\n",
> > param.sched_priority);
> > 	return 0;
> > }
>
> I don't understand why you create a kernel thread to execute
> bus_rt_timer_init().  That thread sets up your timer and then
immediately
> exits.  Is there a reason you can't just move the contents of
> bus_rt_timer_init() into
> bus_timer_interrupt_init() and avoid creating the thread?

My original idea with that was that starting the timer from a
high-priority thread would also cause the timer to run at a higher
priority (which I'm pretty sure that I read somewhere at the time I wrote
the code) - although that may of course have been a misunderstanding on my
side, or a feature that has been changed since.
Commenting out the sched_setschedule() call in bus_timer_interrupt_init(),
did also seem to give me worse performance, although not drastically.

>
> >
> >
> > I currently have a single module registered for polling. The poll
> > function
> > is:
> >
> > static inline void read_input(struct Io1000 *b) {
> > 	u16  *input = &b->ibuf[b->in];
> >
> > 	*input = le16_to_cpu((inb(REG_INPUT_1) << 8));
> >
> > 	process();
> > }
> >
> >
> > The "inb" function reads a register on an FPGA, attached over the LPC
bus.
> > The pseudocode "process" function is a placeholder for some filtering
> > of the read inputs, performing mostly memory access (some of this
> > protected by a spin lock, although the lock should never be locked
> > during the tests, as there isn't anything else accessing it), and
> > calling the kernel "wake_up" function on the wait_queue containing our
> data.
> > To measure performance of the system, I've implemented a simple
> > ChipScope core in the FPGA, allowing me to count the number of cycles
> > where the period deviates above or below the desired 10 ms, and to
> > store the maximum period seen.
> >
> > All this works just fine on an unloaded system. I'm consistently
> > getting cycle times very close to the 10 ms, with a range of 9.7 ms -
10.3 ms.
> >
> > Once I start loading the system with various stress tests, I am
> > getting ranges of about 9.0 ms - 18.0 ms. I have however also seen
> > rare 50-70 ms spikes, typically  when starting the stress loads, but
> > they don't seem to be repeatable.
> > My stress loads are (inspired from Ingo Molnars dohell script
> > (https://lkml.org/lkml/2005/6/22/347)):
> >
> > while true; do killall hackbench; sleep 5; done & while true; do
> > ./hackbench 20; done & du / & ./dortc & ./serialspammer &
> >
> > In addition to this, I'm also doing an external ping flood. The
> > serialspammer application basically just spams both our serial ports
> > with data (I've hardwired a physical loop-back to them), not because
> > it's a lot of data (at 115000kbps), but mostly as the serial chip is
> > on the same LPC bus as the FPGA. As our userspace application runs
> > just fine on a 180 MHz ARM, it only presents a very light load to our
> > new platform. The used stress loads should thus represent a very heavy
> > load compared to what we expect to see during normal operation.
> >
> >
> > Question 1:
> > - I'm rather content with the current performance, but I'd still like
> > to know if there is anything obvious (or anything obvious missing) in
> > the posted code that could be improved for better performance? I can
> > see that it is recommended to prefault and lock the used memory, but I
> > haven't been able to find anything about how to do this in a kernel
thread?
>
> Kernel memory does not get swapped, so access to it does not result in a
> "major fault".  Access to kernel memory can result in a "minor fault"
> (tlb miss), but that is not prevented by locking memory.  So you do not
need
> to worry about prefaulting and locking memory in a kernel thread.
>
> The memory issue that a kernel thread may need to worry about is
allocating
> kernel memory.  The short answer is to not allocate kernel memory from
> your kernel thread while it is in the real time domain.  Also, do not
call other
> parts of the kernel that allocate kernel memory.

Sounds good, it seems I'm in the clear with regard to that then. Thanks
for the info!

>
> > Question 2:
> >  - Are latency spikes to be expected when starting the above stress
loads?
>
> Yes, latency spikes are possible when starting processes (if I remember
> correctly, this is related to locking).
>

Sounds reasonable - we aren't starting any processes under normal runtime
circumstances, so this shouldn't be much of a problem. And it doesn't seem
to be an issue under the new implementation in any case.

> > Question 3:
> >  - As far as I can see spinlocks use priority inheritance - so I
> > presume that our spinlock calls from within our RT-thread should not
> > pose a potential major problem? According to
> > https://rt.wiki.kernel.org/index.php/HOWTO:_Build_an_RT-application
> > though, it seems that both spinlocks and "wake_up" are no-go's when
> > called in interrupt contexts - does the same apply to our timer
> > context? (I've had the "process" call commented out, without any
> > seemingly noticeable change in performance.)
>
> Your hrtimer function bus_10ms_callback() is called from the hrtimer
softirq,
> so it needs to follow softirq rules. (At least in 3.6.7-rt18, which is
not the
> version you are using...)
>

Again, thanks for the info.

> > Bonus-question:
> >  - Additionally, I've tried running cyclictest alongside with all the
> > above, and it actually performs rather well, without any substantial
> > spikes. A strange thing is though, that the results are actually
> > better with load than without? (running with -t1 -p 80 -n -i 10000 -l
> > 10000)
> >  - Loaded: Min: 16, Avg: 41, Max: 177
> >  - No load: Min: 16, Avg: 97, Max: 263
>
> If the system is less loaded, then the idle thread might be able to
enter
> deeper levels of sleep.  Deeper levels of sleep have larger latencies to
exit.
> You would have to look at your processor specific values for exiting
sleep
> states to see if this is sufficient to explain the difference.
>

This was my initial suspicion also. Our current board is apparently a bit
dodgy with regard to the processor P states though (apparently they aren't
yet fully implemented in the BIOS we're using), so I'm not really that
inclined to spend too much effort investigating it before I'm certain that
everything is as it should be.

> > Once I get this finished up, I'll be happy to do a complete write-up
> > of the timer-thread code, if anyone is interested. I remember looking
> > for something similar (but without success), when I wrote the code
> > earlier this year.
>
> It would be very useful to add your results to the wiki.
>
> -Frank

Cool - is there any particular place it should go? A how-to, FAQ entry,
etc? Just so I know how to do the write-up...


All in all, thanks for a very useful reply! Any further comments or
similar are of course welcome.

Best regards,
Simon
