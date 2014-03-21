From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: PowerPC PPC32 CONFIG_HIGHMEM dependency question
Date: Fri, 21 Mar 2014 21:02:37 +0100
Message-ID: <20140321200237.GA28289@linutronix.de>
References: <d23eabd04d35481db8b483f9630341fd@SPIEXCHMAIL01.sierraphotonics.com>
 <20140318105438.GA10448@linutronix.de>
 <73957144b3df4c0cad00b7a65c8ca41c@SPIEXCHMAIL01.sierraphotonics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Robert Johnson <rjohnson@sierraphotonics.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52851 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbaCUUCi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Mar 2014 16:02:38 -0400
Content-Disposition: inline
In-Reply-To: <73957144b3df4c0cad00b7a65c8ca41c@SPIEXCHMAIL01.sierraphotonics.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Robert Johnson | 2014-03-21 15:12:20 [+0000]:

>>> Robert Johnson | 2014-03-17 17:41:25 [+0000]:
>>> Is there any way to get CONFIG_PREEMPT_RT_FULL to work with CONFIG_HIGHMEM?
>
>> Sebastian Andrzej Siewior | 2014-03-18 03:55:
>> Yes. The trick is to look either at the ARM code or at the x86 code and do something similar for powerpc.
>
>Which ARM and x86 source files should be referenced?
>
>Which powerpc source files would need to be modified?

In the queue there is

| # KMAP/HIGHMEM
| mm-rt-kmap-atomic-scheduling.patch
| 0002-x86-highmem-add-a-already-used-pte-check.patch
| 0003-arm-highmem-flush-tlb-on-unmap.patch
| arm-enable-highmem-for-rt.patch

which should cover x86 and arm. And now you need to do something like
that for powerpc.

Sebastian
