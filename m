From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Odd bug in SATA link power management
Date: Mon, 2 Nov 2009 15:51:35 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0911021550120.12138@localhost.localdomain>
References: <74fd948d0910301225k207ec1f9sf2744ba0c5de6d33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Pedro Ribeiro <pedrib@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:54989 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751507AbZKBOve (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Nov 2009 09:51:34 -0500
In-Reply-To: <74fd948d0910301225k207ec1f9sf2744ba0c5de6d33@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 30 Oct 2009, Pedro Ribeiro wrote:
> This bug is always reproducible and does not happen with Debian kernel
> 2.6.30.2. I didn't test any other kernel, not even the 2.6.31.4
> vanilla.
> 
> Below I'm sending the script which does the pm-utils action and my
> lspci -vv. Is there any advice you can give me?

Yes, please test 2.6.31.4 vanilla so we know whether the problem is
related to the -rt patch or not.

Thanks,

	tglx
