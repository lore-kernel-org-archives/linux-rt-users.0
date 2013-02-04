From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.6.11-rt26
Date: Mon, 4 Feb 2013 16:02:04 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1302041600010.11905@ionos>
References: <alpine.LFD.2.02.1302041537230.11905@ionos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44326 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188Ab3BDPCF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 4 Feb 2013 10:02:05 -0500
In-Reply-To: <alpine.LFD.2.02.1302041537230.11905@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 4 Feb 2013, Thomas Gleixner wrote:
> Dear RT Folks,
> 
> I'm pleased to announce the 3.6.11-rt26 release.
> 
> Changes since 3.6.11-rt25:

Forgot to mention the change from EXPORT_SYMBOL_GPL to EXPORT_SYMBOL
for pagefault_dis/enable. I really hate it, but it breaks the
compilation of ^!@%^$@ drivers which work fine against mainline. Sigh!

@Steven: Wants to go into stable-rt as well

Thanks,

	tglx

 
