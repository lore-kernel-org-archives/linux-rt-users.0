From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH v2] sched/completion: convert completions to use simple
 wait queues
Date: Mon, 16 May 2016 16:38:09 -0400
Message-ID: <20160516163809.7bac1d54@redhat.com>
References: <1461848244-16469-1-git-send-email-wagi@monom.org>
	<fa94c34f-31ea-84fd-ac9f-52ed59c31d12@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: Daniel Wagner <wagi@monom.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49665 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753856AbcEPUiM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 May 2016 16:38:12 -0400
In-Reply-To: <fa94c34f-31ea-84fd-ac9f-52ed59c31d12@monom.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 12 May 2016 16:08:34 +0200
Daniel Wagner <wagi@monom.org> wrote:

> In short, I haven't figured out yet why the kernel builds get slightly slower. 

You're doing make -j 200, right? How many cores do you have? Couldn't it
be that you're saturating your CPUs?

You could try make -j<NR CPUs>, or some process creation benchmark. Although
I don't know what's the best way to measure this.
