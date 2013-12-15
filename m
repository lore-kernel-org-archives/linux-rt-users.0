From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/1] rcutree/rcu_bh_qs: disable irq while calling
 rcu_preempt_qs()
Date: Sun, 15 Dec 2013 13:01:34 +0100
Message-ID: <20131215120134.GA31090@linutronix.de>
References: <1386237162-10141-1-git-send-email-tiejun.chen@windriver.com>
 <52A09B10.1010004@windriver.com>
 <52A12F04.8040402@windriver.com>
 <52A205A0.2030707@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?4oCcdGllanVuLmNoZW7igJ0=?= <tiejun.chen@windriver.com>,
	tglx@linutronix.de, linux-rt-users@vger.kernel.org,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55383 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297Ab3LOMBl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 15 Dec 2013 07:01:41 -0500
Content-Disposition: inline
In-Reply-To: <52A205A0.2030707@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Paul Gortmaker | 2013-12-06 12:13:04 [-0500]:

>OK, that is a good start, but it largely only covers #2 in my list.
>We still don't know what the symptoms are (#1), or whether the added
>irqsave will be problematic for other rcu_bh_qs callers (i.e. #3).
>
>It would be really nice to have that additional information.

Tiejun please send a new patch once you have #1 and #3.

>Thanks,
>Paul.

Sebastian
