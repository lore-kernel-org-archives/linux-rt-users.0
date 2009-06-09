From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: network hanging on heavy load
Date: Tue, 9 Jun 2009 23:12:31 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0906092309430.3351@localhost.localdomain>
References: <loom.20090528T141638-240@post.gmane.org> <alpine.LFD.2.00.0906022342260.3419@localhost.localdomain> <loom.20090608T140411-767@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: John Connor <jconnor@gdrs.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:51577 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752299AbZFIVMh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Jun 2009 17:12:37 -0400
In-Reply-To: <loom.20090608T140411-767@post.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 8 Jun 2009, John Connor wrote:
> 2.6.28-rt

I assume this is the infamous ubuntu 2.6.28-rt kernel ? If yes, then
please ask the ubuntu folks. We never released a 2.6.28-rt patch and
we have really no clue at all what the ubuntu folks hacked together
there.

Please try to build the latest mainstream -rt kernel and report back
when the problem still persists.

Thanks,

	tglx
