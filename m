From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/2] rt: Don't call schedule_work_on in preemption disabled
 context
Date: Fri, 04 Oct 2013 19:56:35 +0200
Message-ID: <524F0153.5040808@linutronix.de>
References: <1379365759-5743-1-git-send-email-yang.shi@windriver.com> <1379365759-5743-2-git-send-email-yang.shi@windriver.com> <20131004154616.GJ19953@linutronix.de> <524EEE99.1060907@windriver.com> <20131004171010.GK19953@linutronix.de> <524EFF90.3090402@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, paul.gortmaker@windriver.com
To: Yang Shi <yang.shi@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55512 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab3JDR4i (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Oct 2013 13:56:38 -0400
In-Reply-To: <524EFF90.3090402@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/04/2013 07:49 PM, Yang Shi wrote:
> And, I checked the git commit history about the drain_local_stock call,
> it sounds it is just an optimization for preventing from deferring local
> stock drain to work queue.
> 
> So, It sounds safe to remove the get_cpu and the shortcut to make
> schedule_work_on called safely as you suggested.
> 
> If this sounds fine to you, I'm going to come up with V2.

This sounds fine to me, thanks.

> 
> Thanks,
> Yang

Sebastian
