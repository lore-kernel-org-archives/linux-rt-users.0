From: Hiraku Toyooka <hiraku.toyooka.gu@hitachi.com>
Subject: Why isn't there individual CONFIG in CONFIG_PREEMPT_RT_FULL?
Date: Thu, 24 Oct 2013 21:43:14 +0900
Message-ID: <526915E2.4040809@hitachi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Cc: "Sampath, Pradyumna" <pradyumna@hitachi.co.in>
To: linux-rt-users@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
	bigeasy@linutronix.de, Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fallback.hitachi.co.jp ([133.145.228.50]:51615 "EHLO
	mailxx.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754995Ab3JXMp2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 Oct 2013 08:45:28 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I recently started to look at PREEMPT_RT patches(3.10.14-rt9) and I
have a question.

CONFIG_PREEMPT_RT_FULL consists of many patches. I think it doesn't
represent specific feature but is general term of various features.
Why don't those features have each CONFIG_* ?

Best regards,
-- 
Hiraku TOYOOKA
Linux Technology Center
Yokohama Research Laboratory
Hitachi Ltd.
