From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 3/4] sparc64: convert spinlock_t to raw_spinlock_t in
 mmu_context_t
Date: Tue, 04 Mar 2014 15:03:38 -0500 (EST)
Message-ID: <20140304.150338.542737888922892447.davem@davemloft.net>
References: <259041392800232@web13m.yandex.ru>
	<530475A8.3060602@oracle.com>
	<359241392801938@web24j.yandex.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: allen.pais@oracle.com, linux-rt-users@vger.kernel.org,
	sparclinux@vger.kernel.org, bigeasy@linutronix.de
To: tkhai@yandex.ru
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:36443 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756383AbaCDUDl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Mar 2014 15:03:41 -0500
In-Reply-To: <359241392801938@web24j.yandex.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Wed, 19 Feb 2014 13:25:38 +0400

> It seems for me it's better to decide the problem not changing protector of tsb like in patch above.
> You may get good stack without sun4v_data_access_exception error, which was in the first or second
> message.

My suspicion is that what happens when we get the data access error is
that we sample the tlb batch count as non-zero, preempt, then come
back from preemption seeing the tlb batch in a completely different state.

And that's what leads to the crash, in the one trace I saw the TSB address
passed to tsb_flush() (register %o0) was some garbage like 0x103.
