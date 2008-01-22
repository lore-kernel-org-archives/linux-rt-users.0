From: "Lampersperger Andreas" <lampersperger.andreas@heidenhain.de>
Subject: AW: AW: How to enable HPET on an 2.6.23.9-rt12 with Intel ICH2
Date: Tue, 22 Jan 2008 16:10:21 +0100
Message-ID: <7B9B6F61B189D94CA8CEE58A449BF3A9712996@de01ex02.GLOBAL.JHCN.NET>
References: <7B9B6F61B189D94CA8CEE58A449BF3A97124FB@de01ex02.GLOBAL.JHCN.NET> <20080122115436.GC8660@linux.vnet.ibm.com> <7B9B6F61B189D94CA8CEE58A449BF3A9712600@de01ex02.GLOBAL.JHCN.NET> <4795A1DE.BA47.005A.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <linux-rt-users@vger.kernel.org>
To: "Gregory Haskins" <ghaskins@novell.com>,
	"Chirag Jog" <chirag@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.heidenhain.lt ([194.25.102.130]:59765 "EHLO mx02.jhcn.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752086AbYAVPKa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Jan 2008 10:10:30 -0500
In-Reply-To: <4795A1DE.BA47.005A.0@novell.com>
Content-class: urn:content-classes:message
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Greg,

no I haven't a similar setup or an nmi_watchdog parameter.

The basic question for me is:

What preferences in hardware must be met, to have HR-Timers enabled?

My board has an Intel Chipset FW82801E (C-ICH) with Intel Celeron
400Mhz.
Can I get hr-timers working with that chipset?

And tue to the boot-message 
ACPI: Unable to load the System Description Tables
I guess, that there is a very bad ACPI implementation in that BIOS,
which
is maybe the only reason for not working hr-timers.

Thank your for any further comments.
Andreas

> I had a similar problem once.  It turned out that "nmi_watchdog=1" 
> in the kernel-args disables HPET such that you will see that 
> warning from cyclictest.  Not sure if you have a similar 
> setup, but perhaps this info will help.

-Greg  


-------------------------------------------------------------------------------------------------------
Registergericht: Traunstein / Code of Register HRB 275 Sitz / Head Office: Traunreut
Aufsichtsratsvorsitzender / Chairman of Supervisory Board: Rainer Burkhard
Geschaeftsfuehrung / Managing Director: Thomas Sesselmann
