From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Problem with interrupt handler
Date: Mon, 25 Jan 2010 20:35:04 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1001252034290.5926@localhost.localdomain>
References: <e97c14da1001250916u9b20444k2bdb550211aca1ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Julian Fuchs <julian@fuchs.cc>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:37482 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559Ab0AYTfK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Jan 2010 14:35:10 -0500
In-Reply-To: <e97c14da1001250916u9b20444k2bdb550211aca1ea@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 25 Jan 2010, Julian Fuchs wrote:
> Hello,
> 
> being aware of the risk to bother some people here I would
> nevertheless really appreciate your help with the following issue:
> 
> Is there any difference in the request_irq() function call in
> comparison to the one in the normal kernel?
> 
> I'm trying to run
> 
> request_irq(irq, interrupt_handler, IRQF_SHARED | IRQF_DISABLED |
> IRQF_NODELAY, MODULE_IDENT, &stage)

Does the function return 0 ?
 
Thanks,

	tglx
