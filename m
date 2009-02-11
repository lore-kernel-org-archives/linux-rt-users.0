From: Steven Rostedt <srostedt@redhat.com>
Subject: Re: [PATCH RT 0/4] sh arch support for 2.6.28-rt
Date: Wed, 11 Feb 2009 10:16:21 -0500
Message-ID: <1234365381.31601.2.camel@localhost.localdomain>
References: <1234364503-857-1-git-send-email-matsu@igel.co.jp>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Mundt <lethal@linux-sh.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Katsuya Matsubara <matsu@igel.co.jp>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:36654 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755230AbZBKPQr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 11 Feb 2009 10:16:47 -0500
In-Reply-To: <1234364503-857-1-git-send-email-matsu@igel.co.jp>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Thu, 2009-02-12 at 00:01 +0900, Katsuya Matsubara wrote:
> These patches apply preempt-rt treatments into sh specific code.
> 64 bit support is not included because I have no sh64 board.
> These are based on the 2.6.28-rt git.
> 
> I made sure that these work on renesas rts7751r2dplus.
> 
> -- Katsuya Matsubara / matsu@igel.co.jp
> 
> ---
> 
> Katsuya Matsubara (4):
>   sh: use __preempt_enable_no_resched in cpu_idle()
>   sh: enable interrupts in signal handling
>   sh: decouple the pagefault-disabled logic
>   convert-locks-list: add sh specific spin locks

Applied. Thanks!

-- Steve


