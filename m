From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 3.10-rt1] rt: Fix NO_HZ config use
Date: Mon, 12 Aug 2013 12:28:47 +0200
Message-ID: <20130812102847.GC23040@linutronix.de>
References: <1375475074-30704-1-git-send-email-minyard@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixnet <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, Corey Minyard <cminyard@mvista.com>
To: minyard@acm.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43593 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030Ab3HLK2s (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 12 Aug 2013 06:28:48 -0400
Content-Disposition: inline
In-Reply-To: <1375475074-30704-1-git-send-email-minyard@acm.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* minyard@acm.org | 2013-08-02 15:24:34 [-0500]:

>From: Corey Minyard <cminyard@mvista.com>
>
>NO_HZ is old, it has become NO_HZ_COMMON. NO_HZ generally still works
>because a leftover NO_HZ in a config file will still work, but it needs
>to be fixed.

Thank you. Patch applied and folded back.

Sebastian
