From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] rcutorture: comment out rcu_bh ops on PREEMPT_RT_FULL
Date: Fri, 26 Feb 2016 21:55:44 +0100
Message-ID: <20160226205544.GA9708@linutronix.de>
References: <20160226131920.66d9cf52@sluggy.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:34153 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754972AbcBZUzq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Feb 2016 15:55:46 -0500
Content-Disposition: inline
In-Reply-To: <20160226131920.66d9cf52@sluggy.hsv.redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Clark Williams | 2016-02-26 13:19:20 [-0600]:

>
>RT has dropped support of rcu_bh, comment out in rcutorture.
>
>Signed-off-by: Clark Williams <williams@redhat.com>
applied.

Sebastian
