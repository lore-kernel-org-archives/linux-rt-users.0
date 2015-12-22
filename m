From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] rtmutex: Use chainwalking control enum
Date: Tue, 22 Dec 2015 15:02:59 +0100
Message-ID: <20151222140259.GC27274@linutronix.de>
References: <1450220850-31632-1-git-send-email-brad.mouring@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Brad Mouring <brad.mouring@ni.com>
To: bmouring@ni.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54021 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbbLVODC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Dec 2015 09:03:02 -0500
Content-Disposition: inline
In-Reply-To: <1450220850-31632-1-git-send-email-brad.mouring@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* bmouring@ni.com | 2015-12-15 17:07:30 [-0600]:

>In 8930ed80 (rtmutex: Cleanup deadlock detector debug logic),
>chainwalking control enums were introduced to limit the deadlock
>detection logic. One of the calls to task_blocks_on_rt_mutex was
>missed when converting to use the enums.
>
>Signed-off-by: Brad Mouring <brad.mouring@ni.com>
>Cc: Thomas Gleixner <tglx@linutronix.de>

Applied

Sebastian
