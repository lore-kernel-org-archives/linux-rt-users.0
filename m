From: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Subject: Re: 3.18.9-rt4 kernel panic - Was: 3.18.9-rt4
Date: Tue, 17 Mar 2015 06:13:12 +0100
Message-ID: <20150317061312.3713cff0@archlinux>
References: <20150313223041.0a8bf390@archlinux>
	<20150314104336.756a6f0e@archlinux>
	<20150316162348.GC28130@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail233c50.megamailservers.eu ([91.136.10.243]:41803 "EHLO
	mail37c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750777AbbCQFNU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Mar 2015 01:13:20 -0400
In-Reply-To: <20150316162348.GC28130@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 16 Mar 2015 17:23:48 +0100, Sebastian Andrzej Siewior wrote:
>What happens if you apply this:
>
>diff --git a/drivers/cpufreq/powernow-k8.c
>b/drivers/cpufreq/powernow-k8.c index f9ce7e4bf0fe..ddf3a9006339 100644

Thank you,

I'm doing an audio production at the moment. I tagged this and the
other mails as todo. Building and testing a kernel unfortunately can't
be done at the same time.

To be continued...
