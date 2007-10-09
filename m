From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: High resolution timers on ACPI-less kernel
Date: Tue, 9 Oct 2007 19:13:19 +0200 (CEST)
Message-ID: <alpine.LFD.0.9999.0710091911550.7766@localhost.localdomain>
References: <470B44A1.7080007@free.fr> <1191921343.13628.0.camel@godzilla.tecnorama.it> <470B49BD.4070506@free.fr> <alpine.LFD.0.9999.0710091131400.25146@localhost.localdomain> <470B5971.40601@free.fr> <470BA56F.9090509@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Dragan Noveski <perodog@gmx.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:46311 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752485AbXJIRN2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Oct 2007 13:13:28 -0400
In-Reply-To: <470BA56F.9090509@gmx.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 9 Oct 2007, Dragan Noveski wrote:
> hallo, i am using the 2.6.22.1-rt9 kernel too, and it runs pretty good for me,
> but following this thread i got very unsure, if the hrtimer is being used
> here.
>  .resolution: 1 nsecs

Yes, it switched to high resolution (1 nsec). Otherwise it would show 10, 4 or 1 ms

     tglx
