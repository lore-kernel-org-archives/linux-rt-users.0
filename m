From: Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: softirq-rx and rt_mutex_lock
Date: Wed, 12 May 2010 20:15:00 -0700
Message-ID: <4BEB6EB4.50501@us.ibm.com>
References: <AANLkTimTMTD9XJ_yH_tSy7LwMnxkw1gG9udkdEWLmaNv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-net@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: ratheesh k <ratheesh.ksz@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:55317 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754170Ab0EMDPD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 12 May 2010 23:15:03 -0400
In-Reply-To: <AANLkTimTMTD9XJ_yH_tSy7LwMnxkw1gG9udkdEWLmaNv@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

ratheesh k wrote:
> What i learned that - softirq cannot be put into sleep mode .( Am i right )  ?

Hello, Ratheesh,

I'm adding linux-rt (the real-time linux mailing list, which
is the more appropriate place to put this question first) to
the cc list. Also note that linux-net is mostly a dead list,
as you'll observe if you take a look at the archives, and
netdev@vger.kernel.org is the more appropriate mailing list
for network development questions (i.e., search here first).

> I am facing a problem in my RT linux . I used rt_mutex_lock to protect
> one critical section in softirq-rx code . There is some kernel crash
> happens in the critical section .
> 
> PC- > my function in critical section
> LR -> rt_mutex_unlock .
> 
> Why LR is rt_mutex unlock ?
> If rt_mutex_lock can sleep , softirq-rx may sleep ?

If you are running with the RT patchset (CONFIG_PREEMPT_RT),
yes, irqs are now kernel threads. There is more information
here:

https://rt.wiki.kernel.org/index.php/Main_Page

thanks,
Nivedita
