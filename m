From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [patch 0/6] 3.14-rt1 fixes
Date: Fri, 02 May 2014 13:12:39 +0200
Message-ID: <1399029159.5233.124.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:47170 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbaEBLMm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 May 2014 07:12:42 -0400
Received: by mail-ee0-f41.google.com with SMTP id d49so323720eek.28
        for <linux-rt-users@vger.kernel.org>; Fri, 02 May 2014 04:12:41 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The following patches are fixes that fell out of testing rt1.  Patches
1-4 are intended to be folded into existing patches, 5-6 are
replacements.

fold:
1/6 - preempt-lazy-support.patch
2/6 - x86-preempt-lazy.patch
3/6 - hotplug-light-get-online-cpus.patch
4/6 - stomp-machine-raw-lock.patch

replace:
5/6 - (prep)
6/6 - stomp-machine-deal-clever-with-stopper-lock.patch

drop: (buggy - calls migrate_disable() _after_ maybe blocking)
migrate_disable-pushd-down-in-atomic_dec_and_spin_lo.patch

-Mike

