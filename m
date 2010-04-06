From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.33.1-rt11 BUG: sleeping function called from invalid context
 at kernel/rtmutex.c:684
Date: Tue, 6 Apr 2010 16:39:54 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1004061634320.32352@localhost.localdomain>
References: <4BB8587F.40307@xs4all.nl> <alpine.LFD.2.00.1004061005300.32352@localhost.localdomain> <4BBB3865.9070204@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: RT <linux-rt-users@vger.kernel.org>
To: Udo van den Heuvel <udovdh@xs4all.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:33393 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752951Ab0DFOkA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Apr 2010 10:40:00 -0400
In-Reply-To: <4BBB3865.9070204@xs4all.nl>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 6 Apr 2010, Udo van den Heuvel wrote:
> Only issue remaining is this message:
> 
> Apr  6 15:25:02 nawdew rtkit-daemon[3484]: Failed to make ourselves RT:
> Operation not permitted
> (repeated a number of times)
> 
> Is this also -rt related?

Don't think so. RT does not change the rules for schedsetscheduler().

Thanks,

	tglx
