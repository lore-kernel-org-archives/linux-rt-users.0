From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [V3 PATCH] mm/memcontrol: Don't call schedule_work_on in preemption
 disabled context
Date: Fri, 08 Nov 2013 12:55:08 +0100
Message-ID: <527CD11C.3070204@linutronix.de>
References: <1383158913-16325-1-git-send-email-yang.shi@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, linux-rt-users@vger.kernel.org,
	paul.gortmaker@windriver.com
To: Yang Shi <yang.shi@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57817 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166Ab3KHLzR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Nov 2013 06:55:17 -0500
In-Reply-To: <1383158913-16325-1-git-send-email-yang.shi@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/30/2013 07:48 PM, Yang Shi wrote:
> Adapt tglx's suggestion to rework this patch.
> The old mm-memcontrol-Don-t-call-schedule_work_on-in-preempt.patch can be
> replaced by this one.

Thanks, will replace.

Sebastian
