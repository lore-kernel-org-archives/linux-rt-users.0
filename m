From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 3/4] sparc64: convert spinlock_t to raw_spinlock_t in
 mmu_context_t
Date: Tue, 04 Mar 2014 14:59:23 -0500 (EST)
Message-ID: <20140304.145923.1615081983757728942.davem@davemloft.net>
References: <173231392194038@web29j.yandex.ru>
	<52FB5AEF.3040807@oracle.com>
	<341861392205386@web5h.yandex.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: allen.pais@oracle.com, linux-rt-users@vger.kernel.org,
	sparclinux@vger.kernel.org, bigeasy@linutronix.de
To: tkhai@yandex.ru
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:36347 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565AbaCDT7Z (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Mar 2014 14:59:25 -0500
In-Reply-To: <341861392205386@web5h.yandex.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Wed, 12 Feb 2014 15:43:06 +0400

> For example, collect only batches which does not require smp call function. Or the
> main goal of lazy tlb was to prevent smp calls?! It's good to discover this..

The goal of the lazy tlb stuff is to only have one (potential)
synchronization point with other cpus.

Then we sweep away the TSB entries, after which any TLB miss must
enter the full fault path and synchronize with the current thread
doing the flush.

Then we kill the TLB entries, both local and remote.

The tsb_grow() code path is quite the animal, as any of you who have
read the comment above it's implementation can attest :-) It took 6
months to get that code right in a non-RT context back when it was
originally written.
