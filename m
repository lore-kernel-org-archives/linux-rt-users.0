From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] iio: adc: xilinx-xadc: Convert to raw spinlock
Date: Sat, 23 May 2015 12:36:17 +0100
Message-ID: <55606631.6080201@kernel.org>
References: <1431013090-18996-1-git-send-email-xander.huff@ni.com> <20150514171038.GG13442@linutronix.de> <55552570.5050407@ni.com> <20150518211728.GC4275@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	michal.simek@xilinx.com, soren.brinkmann@xilinx.com,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rt-users@vger.kernel.org, ben.shelton@ni.com,
	joe.hershberger@ni.com, joshc@ni.com
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Xander Huff <xander.huff@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50411 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757652AbbEWLgT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 May 2015 07:36:19 -0400
In-Reply-To: <20150518211728.GC4275@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

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
Certainly looks like that wants to be tried out...

Jonathan
> 
> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

