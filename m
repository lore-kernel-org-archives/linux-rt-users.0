From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Hung task for proc_cgroup_show
Date: Tue, 22 Dec 2015 14:51:53 +0100
Message-ID: <20151222135153.GB27274@linutronix.de>
References: <CALqGcGoMqJuvzQpGb84LzyxQCJADB73YEreND0HgOFK5DOQ6ig@mail.gmail.com>
 <20150714150016.GC21820@linutronix.de>
 <CALqGcGqzWsNacBHRUgFOrtJB6MSoqR+kDJteA8mgi9E4_o8vxw@mail.gmail.com>
 <20151211161450.GA6720@linutronix.de>
 <CALqGcGob5_qWeK1ndErqN9Z3DkGTPciTojjkEOkvauZyNd59Bg@mail.gmail.com>
 <20151221181153.GB6714@linutronix.de>
 <CALqGcGrzpA_95LiL+4dHKX6xf7iwz-uL0_y8BtnQJgKLkZD-4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: Christoph Mathys <eraserix@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:53987 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbbLVNvz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Dec 2015 08:51:55 -0500
Content-Disposition: inline
In-Reply-To: <CALqGcGrzpA_95LiL+4dHKX6xf7iwz-uL0_y8BtnQJgKLkZD-4w@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Christoph Mathys | 2015-12-22 13:36:19 [+0100]:

>I tried to reproduce this bug in kvm, hoping to get copy/pastable
>dumps. The test didn't run at all, instead I got a stunning number of
>the following slowpath warning (seem like it was repeated over 100
>times during 9ms). I see them occasionally (less than once every few
>minutes) on real hardware as well. I don't know what to make of them
>and if they can help in any way. Here is the repeated message:
>
>[   63.141432] WARNING: CPU: 0 PID: 54 at kernel/res_counter.c:28
>res_counter_uncharge_until+0x98/0xa0()

It seems the ressource counter code is somehow unbalanced. It has its
own lock but you see what you see.
You could try without CONFIG_RESOURCE_COUNTERS or switch to v4.1 instead
since it has the file in question removed as per 5b1efc027c0b ("kernel:
res_counter: remove the unused API").

Sebastian
