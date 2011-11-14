From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: rtmutex grabbed twice by same context in network code
Date: Tue, 15 Nov 2011 00:12:32 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1111150010200.4902@ionos>
References: <1321310484.10018.74.camel@tr-pentomino>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Darcy Watkins <dwatkins@tranzeo.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:49613 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775Ab1KNXMe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Nov 2011 18:12:34 -0500
In-Reply-To: <1321310484.10018.74.camel@tr-pentomino>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 14 Nov 2011, Darcy Watkins wrote:

> Hi,
> 
> Anyone have insight into the kernel crash below?

Can you please enable CONFIG_PROVE_LOCKING ? That should tell us all
the details.
 
Thanks,

	tglx
