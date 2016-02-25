From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: WARNING: amd_iommu. linux-4.4.1-rt6
Date: Thu, 25 Feb 2016 09:44:20 +0100
Message-ID: <20160225084420.GA16161@linutronix.de>
References: <56CBA91D.6080909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: DIXLOR <dixlor@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52283 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759823AbcBYIoW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Feb 2016 03:44:22 -0500
Content-Disposition: inline
In-Reply-To: <56CBA91D.6080909@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* DIXLOR | 2016-02-23 03:34:37 [+0300]:

>
>[    1.828887] iommu: Adding device 0000:00:14.5 to group 10
>[    1.831805] ------------[ cut here ]------------
>[    1.831814] WARNING: CPU: 0 PID: 1 at
>drivers/iommu/amd_iommu.c:1958 0xffffffff812d6449()

please don't cut it in the middle

>[    1.831817] Modules linked in:
>[    1.831827] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G W       4.4.1-rt6+ #5
>[    1.831831] Hardware name: empty empty/S8225, BIOS 'V3.03   ' 11/01/2012
>[    1.831835]  ffffffff815fd5cc ffffffff81224d47 0000000000000000 ffffffff81034e17
>[    1.831847]  ffff8804231a5a00 ffff880422bb8420 ffff88042310e898 ffff880423934000
>[    1.831858]  ffff880422bb8400 ffffffff812d6449 ffff880422b5e7f8 ffff880422b5e8e8
>[    1.831868] Call Trace:
>[    1.831873]  [<ffffffff81224d47>] ? 0xffffffff81224d47
>[    1.831878]  [<ffffffff81034e17>] ? 0xffffffff81034e17

and provide a resolved stack strace.

Sebastian
