From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Freezing issue on loading/usage of kernel modules
Date: Fri, 9 May 2014 14:14:53 +0200
Message-ID: <20140509121453.GC29014@linutronix.de>
References: <534DAE0F.4070009@hmi.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Rob Connolly <Rob.Connolly@hmi.co.nz>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35150 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbaEIMOz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 9 May 2014 08:14:55 -0400
Content-Disposition: inline
In-Reply-To: <534DAE0F.4070009@hmi.co.nz>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Rob Connolly | 2014-04-16 10:09:19 [+1200]:

>Hi,
Hi,

>Any help or advice appreciated,

Disable -RT and enable the complete lockdep program, sleeping while
atomic and "debugging preemptile kernel". This might give you a hint if
the locking is broken or not.
Then you could try to boot with threaded_interrupts and see how it goes.

>Thanks in advance,
>
>Rob Connolly

Sebastian
