From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] slab+rt: Don't free locks twice in cpuup_canceled
Date: Fri, 4 Oct 2013 16:49:36 +0200
Message-ID: <20131004144936.GI19953@linutronix.de>
References: <1379700149-16400-1-git-send-email-minyard@acm.org>
 <52431132.9070209@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Corey Minyard <cminyard@caviumnetworks.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54366 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754120Ab3JDOti (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Oct 2013 10:49:38 -0400
Content-Disposition: inline
In-Reply-To: <52431132.9070209@caviumnetworks.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Corey Minyard | 2013-09-25 11:37:06 [-0500]:

>I forgot to mention that this was on 3.10.10-rt7.

This looks valid. But SLAB still isn't working on -RT, right?

>-corey

Sebastian
