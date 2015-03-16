From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] irq_work: Hide access to hirq_work_list in
 PREEMPT_RT_FULL
Date: Mon, 16 Mar 2015 18:48:29 +0100
Message-ID: <20150316174829.GD28130@linutronix.de>
References: <20150312180857.31a0f7d1@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:36744 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757045AbbCPRsb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Mar 2015 13:48:31 -0400
Content-Disposition: inline
In-Reply-To: <20150312180857.31a0f7d1@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Steven Rostedt | 2015-03-12 18:08:57 [-0400]:

>The hirq_work_list is only defined when PREEMPT_RT_FULL is configured.
>Most access to it is within an #ifdef CONFIG_PREEMPT_RT_FULL, except
>for one. Encapsulate that location too.
>
>Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Applied

Sebastian
