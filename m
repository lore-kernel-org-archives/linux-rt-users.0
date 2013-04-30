From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.8.10-rt6
Date: Tue, 30 Apr 2013 12:35:00 +0200
Message-ID: <20130430103500.GA4688@linutronix.de>
References: <20130429201202.GB7979@linutronix.de>
 <20130429161925.2a6ea78a@riff.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60305 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759915Ab3D3KfD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Apr 2013 06:35:03 -0400
Content-Disposition: inline
In-Reply-To: <20130429161925.2a6ea78a@riff.lan>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Clark Williams | 2013-04-29 16:19:25 [-0500]:

>On Mon, 29 Apr 2013 22:12:02 +0200
>Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>>     - suspend / resume seems to program program the timer wrong and wait
>>       ages until it continues.
>> 
>
>It has to be something we're doing when we apply RT to v3.8.x, since
>v3.8.x suspends/resumes with no issues and I was able to suspend and
>resume fine with the 3.6-rt series. 

Are your problems gone with:

diff --git a/kernel/printk.c b/kernel/printk.c
index 6d52c34..8783ea5 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -1583,6 +1583,8 @@ asmlinkage int vprintk_emit(int facility, int level,
 	 */
 	if (unlikely(forced_early_printk(fmt, args)))
 		return 1;
+	if (in_nmi())
+		return 1;
 
 	boot_delay_msec(level);
 	printk_delay();

>Clark

Sebastian
