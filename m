From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Query - state of memory hotplug with RT kernel
Date: Fri, 3 Jun 2016 18:04:33 +0200
Message-ID: <20160603160433.GC4496@linutronix.de>
References: <1997236940.56779393.1464861408686.JavaMail.zimbra@redhat.com>
 <420969271.56780563.1464862241604.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Pankaj Gupta <pagupta@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52690 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693AbcFCQEf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 Jun 2016 12:04:35 -0400
Content-Disposition: inline
In-Reply-To: <420969271.56780563.1464862241604.JavaMail.zimbra@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Pankaj Gupta | 2016-06-02 06:10:41 [-0400]:

>Hello,
Hi,

>Recently, I have been debugging some of the issues with memory 
>hotplug with RT kernel. I want to know state of memory hotplug 
>with RT kernel and if there are any known issues or work going
>on upstream?

I never tried memory hotplug. You are the first one that complains or
mentions it.

>I came to know that there is rework of 'cpu hotplug' going on.
>Not sure about 'memory hotplug'.
>
>Any inputs or pointers on this?

I have been looking into CPU hotplug but got interrupted by v4.6 and a
few other things. Regarding memory hotplug, as I said I don't know what
is broken. Is this something that can be tested in kvm?

>Best regards,
>Pankaj

Sebastian
