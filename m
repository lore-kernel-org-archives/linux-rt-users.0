From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/2] list_bl.h: make list head locking RT safe
Date: Fri, 21 Jun 2013 17:36:31 +0200
Message-ID: <51C472FF.1050409@linutronix.de>
References: <1370900209-40769-1-git-send-email-paul.gortmaker@windriver.com> <1370900209-40769-2-git-send-email-paul.gortmaker@windriver.com> <20130621122305.GC21228@linutronix.de> <20130621152528.GB19624@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de,
	paulmck@linux.vnet.ibm.com, linux-rt-users@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:40052 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161506Ab3FUPgm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Jun 2013 11:36:42 -0400
In-Reply-To: <20130621152528.GB19624@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/21/2013 05:25 PM, Paul Gortmaker wrote:
> I guess the easiest way to make use of the existing checks is to
> simply set/clear the bit inside the lock.  That will allow the
> existing code to check if the list got smashed by something.
> 
> If the incremental patch below is what you had in mind, then I'll
> resend a v2 with this change incorporated.

Yes, that is probably the easiest thing.

> Thanks,
> Paul.
> --

Sebastian
