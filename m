From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: hrtimer: interrupt took 6742 ns, then RT throttling and hung
 machine for nearly 2 seconds
Date: Mon, 15 Apr 2013 14:22:07 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1304151416580.21884@ionos>
References: <516BDE52.90200@meduna.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56238 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab3DOMWJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Apr 2013 08:22:09 -0400
In-Reply-To: <516BDE52.90200@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 15 Apr 2013, Stanislav Meduna wrote:
> Unfortunately it is not easily reproducible - it happens once
> per several days and there is no obvious trigger.
> 
> Any hints?

Yes, we decoded that problem a week ago. Patch is available here:

http://www.spinics.net/lists/linux-tip-commits/msg19100.html

It's on the way to Linus tree, so it will come via the stable updates
to RT soon.

Thanks,

	tglx
