From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.0-rt2
Date: Sun, 24 Jul 2011 12:05:59 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1107241204300.2702@ionos>
References: <alpine.LFD.2.02.1107231706380.2702@ionos> <20110724010932.GA2133@zhy>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Yong Zhang <yong.zhang0@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59953 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223Ab1GXKGC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 24 Jul 2011 06:06:02 -0400
In-Reply-To: <20110724010932.GA2133@zhy>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 24 Jul 2011, Yong Zhang wrote:
> [ 1244.912621]  [<c15d151c>] rt_spin_lock+0x1c/0x40
> [ 1244.912626]  [<c111f763>] mem_cgroup_split_huge_fixup+0x43/0xd0

Can you please disable CONFIG_TRANSPARENT_HUGEPAGE for now? That's not
easy to fix, but I put it on the todo list.

Thanks,

	tglx


