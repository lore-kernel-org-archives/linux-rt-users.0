From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH PREEMPT_RT]: On AT91 ARM: GPIO Interrupt handling
	can/will stall forever
Date: Tue, 27 Nov 2007 07:25:21 -0800
Message-ID: <1196177122.23808.7.camel@imap.mvista.com>
References: <3efb10970711260531x5e9f05acgfabdfa885a220192@mail.gmail.com>
	 <3efb10970711260545i419a8352o4ca5248b10d81db5@mail.gmail.com>
	 <1196176294.13982.58.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	ARM Linux Mailing List
	<linux-arm-kernel@lists.arm.linux.org.uk>,
	RT <linux-rt-users@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Remy Bohmer <linux@bohmer.net>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:35717 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758498AbXK0PdH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 Nov 2007 10:33:07 -0500
In-Reply-To: <1196176294.13982.58.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2007-11-27 at 10:11 -0500, Steven Rostedt wrote:
> Thomas,
> 
> Can you ACK or NACK this patch.  I know you play with a bunch of
> hardware that this patch may affect.
> 

My two cents, I think it's needed (or something like it).. It looks like
handle_simple_irq normally expects a custom cascade type handler to
unmask on return. When you switch to a threaded handler the cascade
handler is gone and can't unmask..

Daniel
