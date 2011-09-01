From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V2 1/1] lib/atomic64 using raw_spin_lock_irq[save|resotre]
 for atomicity
Date: Thu, 1 Sep 2011 11:59:18 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1109011158500.2723@ionos>
References: <1314847923-26428-1-git-send-email-haishan.bai@gmail.com> <1314847923-26428-2-git-send-email-haishan.bai@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: akpm@linux-foundation.org, eric.dumazet@gmail.com,
	vapier@gentoo.org, asharma@fb.com, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Shan Hai <haishan.bai@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43721 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756087Ab1IAJ7a (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 1 Sep 2011 05:59:30 -0400
In-Reply-To: <1314847923-26428-2-git-send-email-haishan.bai@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 1 Sep 2011, Shan Hai wrote:

> The spin_lock_irq[save|restore] could break the atomicity of the
> atomic64_* operations in the PREEMPT-RT configuration, because
> the spin_lock_irq[save|restore] themselves are preemptable in the
> PREEMPT-RT, using raw variant of the spin lock could provide the
> atomicity that atomic64_* need.

Good catch. Queued for the next release.
 
Thanks,

	tglx
