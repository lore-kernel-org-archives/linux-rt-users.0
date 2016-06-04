From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: RT trees fail ltp futex_wait04  - culprit=65d8fc777f6d (futex:
 Remove requirement for lock_page() in get_futex_key())
Date: Sat, 04 Jun 2016 18:07:58 +0200
Message-ID: <1465056478.4212.3.camel@gmail.com>
References: <1465052027.4104.19.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Mel Gorman <mgorman@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38210 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbcFDQIE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 4 Jun 2016 12:08:04 -0400
Received: by mail-wm0-f52.google.com with SMTP id m124so23227914wme.1
        for <linux-rt-users@vger.kernel.org>; Sat, 04 Jun 2016 09:08:03 -0700 (PDT)
In-Reply-To: <1465052027.4104.19.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Oho, actually, it's not only RT kernels, master with an enterprise like
NOPREEMPT config fails as well, so it's a garden variety regression.

futex_wake04    1  TFAIL  :  futex_wake04.c:126: Bug: wait_thread2 did not wake after 30 secs.
futex_wait_bitset01    1  TPASS  :  futex_wait_bitset() waited 100068us, expected 100010us
futex_wait_bitset02    1  TPASS  :  futex_wait_bitset() waited 100068us, expected 100010us
INFO: ltp-pan reported some tests FAIL

	-Mike
