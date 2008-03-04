From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: High resolution timers on AT91SAM926x
Date: Tue, 04 Mar 2008 21:55:19 +0100
Message-ID: <47CDB737.8090300@grandegger.com>
References: <200803011457.40857.david-b@pacbell.net>	 <200803031039.57909.david-b@pacbell.net>	 <d6c8ef150803031342r567aab86x776dc2a8b73714b6@mail.gmail.com>	 <200803031729.19264.david-b@pacbell.net> <3efb10970803041222j61fd8d28k5cef0994b9bd6f12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b@pacbell.net>,
	Bosko Radivojevic <bosko.radivojevic@gmail.com>,
	lkml <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org, tglx@linutronix.de
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:56251 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757220AbYCDUzZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Mar 2008 15:55:25 -0500
In-Reply-To: <3efb10970803041222j61fd8d28k5cef0994b9bd6f12@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Remy Bohmer wrote:
> Hello Bosko/Dave,
> 
>> On Monday 03 March 2008, Bosko Radivojevic wrote:
>>
>>> I had CONFIG_ATMEL_TCLIB enabled, but not TCB_CLKSRC and
>>  > TCB_CLKSRC_BLOCK=0. With all those options, I finally have HRT
>>  > functionality. But, strange thing is that jitter of my little example
>>  > (get time, sleep 1ms, get time, show the difference) is around 250us.
>>  > Maybe this is normal for this architecture?
>> I have no idea why that would be.  Maybe you can find out.  :)
> 
> These are normal figures for this core, on preempt-rt.
> You are talking about jitter on timers. While on preempt-rt the worst
> case latency of scheduling a RT-thread is about 300us, 250us is thus
> quite normal, and actually quite good... (the kernel-mainline average
> latency is better, but worst-case is unbound)
> (Note: The 300 us seem to be caused by something in the networking
> layer, without network I noticed worst case latencies about 150us, but
> NO guarantee here)

This confirms our observation with PowerPC MPC5200 boards (running at
400 MHz). Without networking, the worst case latency measured with
cyclictest does not exceed 100 us. With networking, and especially with
the NFS file-system, latencies go up to 170 us. I also measured external
interrupt latencies with an external log system using GPIO pins but was
unable to achieve latencies below 1ms. This needs more debugging.

Wolfgang.
