From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] sched: fix RLIMIT_RTTIME when PI-boosting to RT
Date: Mon, 9 Mar 2015 18:34:41 +0100
Message-ID: <20150309173441.GG13768@linutronix.de>
References: <1424305436-6716-1-git-send-email-brian@peloton-tech.com>
 <CANGgnMaiiBDO=pYs2n7HbOMf58m0FOreSC8y8RmDvu-zdO+ibA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Silverman <brian@peloton-tech.com>, mingo@redhat.com,
	peterz@infradead.org, LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:36947 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672AbbCIRes (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Mar 2015 13:34:48 -0400
Content-Disposition: inline
In-Reply-To: <CANGgnMaiiBDO=pYs2n7HbOMf58m0FOreSC8y8RmDvu-zdO+ibA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Austin Schuh | 2015-03-05 09:10:47 [-0800]:

>ping?

Why is this a ping? I haven't seen this in my rt nor in my lkml inbox.
Please repost it properly including lkml.
>From what I can tell not beeing a sched guy is that the patch looks
reasonable since the timeout gets only set to zero on enqueue_task_rt().
Is there something special you do to trigger this?

Sebastian
