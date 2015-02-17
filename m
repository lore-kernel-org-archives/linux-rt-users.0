From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] rtmutex.c: Fix incorrect waiter check
Date: Tue, 17 Feb 2015 17:10:31 +0100
Message-ID: <20150217161031.GT26177@linutronix.de>
References: <548F7E4C.90805@hp.com>
 <1421269898-30591-1-git-send-email-brad.mouring@ni.com>
 <1421269898-30591-2-git-send-email-brad.mouring@ni.com>
 <20150121151352.7e4ef150@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brad Mouring <bmouring@ni.com>,
	Paul McKenney <paulmck@linux.vnet.ibm.com>,
	linux-rt-users@vger.kernel.org, T Makphaibulchoke <tmac@hp.com>,
	Brad Mouring <brad.mouring@ni.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44258 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbbBQQKg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 11:10:36 -0500
Content-Disposition: inline
In-Reply-To: <20150121151352.7e4ef150@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Steven Rostedt | 2015-01-21 15:13:52 [-0500]:

>On Wed, 14 Jan 2015 15:11:38 -0600
>"Brad Mouring" <bmouring@ni.com> wrote:
>
>> In task_blocks_on_lock, there's a null check on pi_blocked_on
>> of the task_struct. This pointer can encode the fact that the
>> task that contains the pointer is waking (preventing requeuing)
>> and therefore is non-null. Use the inline function to avoid
>> dereferencing an invalid "pointer"
>
>Yep, this looks legit. I can apply it to the series I maintain.

I added it to v3.18 with a stable tag. I don't know why this did not
pop-up earlier or if this is part of the rtmutex re-write.

>-- Steve

Sebastian
