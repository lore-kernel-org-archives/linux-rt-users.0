From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iio: adc: xilinx-xadc: Convert to raw spinlock
Date: Sun, 07 Jun 2015 16:29:03 +0100
Message-ID: <5574633F.7090004@kernel.org>
References: <1431013090-18996-1-git-send-email-xander.huff@ni.com> <20150514171038.GG13442@linutronix.de> <55552570.5050407@ni.com> <20150518211728.GC4275@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org,
	michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org,
	linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben.shelton-acOepvfBmUk@public.gmane.org,
	joe.hershberger-acOepvfBmUk@public.gmane.org, joshc-acOepvfBmUk@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
	Xander Huff <xander.huff-acOepvfBmUk@public.gmane.org>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150518211728.GC4275-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

On 18/05/15 22:17, Sebastian Andrzej Siewior wrote:
> * Xander Huff | 2015-05-14 17:45:04 [-0500]:
> 
>> With no other processes running, I got the following results after a
>> couple of hours on one of our devices:
>>
>> admin@Xander-roboRIO:~# cyclictest -S -m -p 98
>> # /dev/cpu_dma_latency set to 0us
>> policy: fifo: loadavg: 0.01 0.07 0.12 1/176 1473
>>
>> T: 0 ( 1373) P:98 I:1000 C:6503872 Min:      9 Act:   13 Avg:   13 Max:      51
>> T: 1 ( 1374) P:98 I:1500 C:4335914 Min:      9 Act:   12 Avg:   13 Max:      49
>>
>> With a VI reading all default handles (raw, offset, scale,
>> sampling_frequency) in /sys/bus/iio/devices/iio:device0 constantly in
>> a while loop, I got the following results after a couple hours on the
>> same device:
>>
>> admin@Xander-roboRIO:~# cyclictest -S -m -p 98
>> # /dev/cpu_dma_latency set to 0us
>> policy: fifo: loadavg: 6.93 7.30 7.47 3/182 1530
>>
>> T: 0 ( 1487) P:98 I:1000 C:4497008 Min:     11 Act:   20 Avg:   21 Max:      69
>> T: 1 ( 1488) P:98 I:1500 C:2998005 Min:     11 Act:   20 Avg:   22 Max:      59
> 
> So there is an increase. And there is even a for-loop and I don't know
> how deep it is nested. Anyway, do you think it is worth it or would it
> be better to get rid of the raw-locks and simply push everything into
> threaded context?
> 
Certainly seems likely to be a better way forward to me but I don't
really mind either way.

J
