From: "Darcy Watkins" <DWatkins@tranzeo.com>
Subject: Re: Kernel 2.6.33.1-rt11 on PPC405 UIC spinlock and serial input overruns
Date: Tue, 6 Apr 2010 11:38:34 -0700
Message-ID: <D61182AC8012EA4EBC531B3AF23BE10992AE68@tranzeo-mail2.12stewart.tranzeo.com>
References: <1270145758.27946.48.camel@localhost.localdomain>  <alpine.LFD.2.00.1004060946000.32352@localhost.localdomain> <1270562527.30658.40.camel@localhost.localdomain> <alpine.LFD.2.00.1004061645090.32352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <linux-rt-users@vger.kernel.org>
To: "Thomas Gleixner" <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.tranzeo.com ([64.114.87.10]:59366 "EHLO mail2.tranzeo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755394Ab0DFSih convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Apr 2010 14:38:37 -0400
Content-class: urn:content-classes:message
In-Reply-To: <alpine.LFD.2.00.1004061645090.32352@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Thomas,

Thanks for the suggestion.

I tried boosting priority of [irq/16-serial] to 70 and then 95 with no
observable difference from before.  I still see the input overruns when
I up-arrow to backup through shell history (and the terminal sends
up-arrow escape sequences as small serial bursts at 115200).

/proc/interrupts also indicates that serial interrupts do count upwards
in good quantity.


Regards,

Darcy

-----Original Message-----
From: Thomas Gleixner [mailto:tglx@linutronix.de] 
Sent: Tuesday, April 06, 2010 7:46 AM
To: Darcy Watkins
Cc: linux-rt-users@vger.kernel.org
Subject: Re: Kernel 2.6.33.1-rt11 on PPC405 UIC spinlock and serial
input overruns

On Tue, 6 Apr 2010, Darcy L. Watkins wrote:
> ... This patch is carried forward from old RT board support code
> originally from Timesys for the AMCC Taihu circa kernel version 2.6.23
> (it implemented taihu under arch/powerpc but this never made its way
> into the kernel.org code).  I have also tried it without this patch
and
> have not noticed any difference in behavior.

Have you tried to up the priority of that serial IRQ thread ?

Thanks,

	tglx
