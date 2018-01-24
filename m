From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: problems with 4.14.6-rt7
Date: Wed, 24 Jan 2018 15:18:50 +0100
Message-ID: <20180124141849.hsikgyqgymbd2qe5@linutronix.de>
References: <2644174.vLadu3AOG5@dabox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Tim Sander <tim@krieglstein.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:60717 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933648AbeAXOSv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 24 Jan 2018 09:18:51 -0500
Content-Disposition: inline
In-Reply-To: <2644174.vLadu3AOG5@dabox>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2018-01-08 15:56:17 [+0100], Tim Sander wrote:
> Hi
Hi,

> I am currently using 4.14.6-rt7 on an De0-Nano-Soc (intel/altera arm v7 dual core)
> board. I have added a small driver which adds some functionality like iio. As soon
> as i have some realtime load on one core i see messages like:
…
> I know that i am really using up all realtime budget on this system for one core 
> but i would expect that rt-throttling kicks in and gets some time for these
> starving processes?

You should see something like
	sched: RT throttling activated

once the RT tasks are throttled. Do you?

> Best regards
> Tim

Sebastian
