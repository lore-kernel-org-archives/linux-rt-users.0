From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 2/2] rt: Move schedule_work call to helper thread
Date: Fri, 4 Oct 2013 19:11:42 +0200
Message-ID: <20131004171142.GL19953@linutronix.de>
References: <1379365759-5743-1-git-send-email-yang.shi@windriver.com>
 <1379365759-5743-3-git-send-email-yang.shi@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, paul.gortmaker@windriver.com
To: Yang Shi <yang.shi@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55255 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab3JDRLn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Oct 2013 13:11:43 -0400
Content-Disposition: inline
In-Reply-To: <1379365759-5743-3-git-send-email-yang.shi@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Yang Shi | 2013-09-16 14:09:19 [-0700]:

>When run ltp leapsec_timer test, the following call trace is caught:
>
>BUG: sleeping function called from invalid context at kernel/rtmutex.c:659
>in_atomic(): 1, irqs_disabled(): 1, pid: 0, name: swapper/1
>Preemption disabled at:[<ffffffff810857f3>] cpu_startup_entry+0x133/0x310

This is okay and I take this, thanks.
In the long run I need something smarter here because this is the third
thread/process for a corner case.

Sebastian
