Return-Path: <SRS0=3uJl=UC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A30C04AB5
	for <linux-rt-users@archiver.kernel.org>; Mon,  3 Jun 2019 16:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC22272FF
	for <linux-rt-users@archiver.kernel.org>; Mon,  3 Jun 2019 16:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbfFCQi4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 3 Jun 2019 12:38:56 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37374 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfFCQi4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 3 Jun 2019 12:38:56 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hXpz3-000471-Cc; Mon, 03 Jun 2019 18:38:53 +0200
Date:   Mon, 3 Jun 2019 18:38:53 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     He Zhe <zhe.he@windriver.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: glibc nptl tst-robustpi8.c crashes since v5.0.3-rt1
Message-ID: <20190603163853.psno24qkyrjwspg2@linutronix.de>
References: <edd7c4be-738e-5b4f-73f4-0ff4b233a281@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <edd7c4be-738e-5b4f-73f4-0ff4b233a281@windriver.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-05-29 18:20:56 [+0800], He Zhe wrote:
> Hi,
Hi,

> Since v5.0.3-rt1, glibc/nptl/tst-robustpi8.c causes the following crash.
> https://github.com/lattera/glibc/blob/master/nptl/tst-robustpi8.c

thank you for the report.

> root@intel-x86-64:~# ./tst-robustpi8
> 007: ------------[ cut here ]------------
> 007: kernel BUG at /buildarea2/zhe/repo/linux-rt-devel/kernel/locking/rtmutex.c:1336!
…
> 007: Call Trace:
> 007:  rt_spin_lock_slowlock_locked+0x87/0x230
> 007:  rt_spin_lock_slowlock+0x67/0xa0
> 007:  rt_spin_lock+0x38/0x40
> 007:  ? futex_lock_pi+0x2cd/0x490
> 007:  futex_lock_pi+0x2cd/0x490
> 007:  do_futex+0x330/0xc40
> 007:  __se_sys_futex+0x7f/0x170
…

this is due to commit
	1a1fb985f2e2b ("futex: Handle early deadlock return correctly")

let me see what I can do…

> Zhe

Sebastian
