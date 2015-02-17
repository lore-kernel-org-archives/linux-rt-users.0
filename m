From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCHv2 -rt 3.10.x] mce: don't try to wake thread before it
 exists.
Date: Tue, 17 Feb 2015 11:00:53 +0100
Message-ID: <20150217100053.GF26177@linutronix.de>
References: <20140826190703.57a93cf7@gandalf.local.home>
 <1409844567-21413-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:42997 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786AbbBQKA6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 05:00:58 -0500
Content-Disposition: inline
In-Reply-To: <1409844567-21413-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Paul Gortmaker | 2014-09-04 11:29:27 [-0400]:

>If a broken machine with issues raises an MCE irq event real
>early in the boot, it can try and wake the -rt specific handler
>thread (mce_notify_helper) before it exists.  (It is created
>through a device_initcall that happens later in the boot.)  When
>this happens, we see the irq, which calls the wake with a null
>pointer, which then panics the machine at boot.

applied.

Sebastian
