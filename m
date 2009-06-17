From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: Intel graphics and kernel RT failure
Date: Wed, 17 Jun 2009 21:47:16 +0200 (CEST)
Message-ID: <alpine.LSU.2.00.0906172146330.4179@fbirervta.pbzchgretzou.qr>
References: <695e1a650906041442q445109a2p5871a1ff9f1d3f5a@mail.gmail.com>  <alpine.LSU.2.00.0906050020110.8173@fbirervta.pbzchgretzou.qr> <1244164487.27779.31.camel@quadrophenia.thebigcorporation.com>
 <alpine.LSU.2.00.0906051706040.6401@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Hector Centeno <hcengar@gmail.com>, linux-rt-users@vger.kernel.org
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sovereign.computergmbh.de ([85.214.69.204]:38768 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710AbZFQTrP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Jun 2009 15:47:15 -0400
In-Reply-To: <alpine.LSU.2.00.0906051706040.6401@fbirervta.pbzchgretzou.qr>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Friday 2009-06-05 17:07, Jan Engelhardt wrote:
>On Friday 2009-06-05 03:14, Sven-Thorsten Dietrich wrote:
>>On Fri, 2009-06-05 at 00:21 +0200, Jan Engelhardt wrote:
>>> 
>>> Cc'ing linux-rt. Mabye someone has a flash of an idea.
>>> 
>>> On Thursday 2009-06-04 23:42, Hector Centeno wrote to Jan Engelhardt:
>>> >
>>> >I hope it is OK to contact you directly to this email. I've been
>>> >trying to use your 2.6.29 RT kernel for OpenSuse 11.1 and came across
>>> >some problems related to the Intel graphics driver (I have a laptop
>>> >with intel GMA 950). The problem seems to be related to the new intel
>>> >driver development that is going on and that seems to affect older
>>> >hardware like mine. I get a constantly growing list of errors in
>>> >/var/log/mesages like these:
>>> >
>>
>>Try this patch:
>>
>>Signed-off-by: Sven-Thorsten Dietrich <sdietrich@suse.de>
>>
>>Index: b/arch/x86/mm/iomap_32.c
>>===================================================================
>>--- a/arch/x86/mm/iomap_32.c
>>+++ b/arch/x86/mm/iomap_32.c
>>@@ -38,7 +38,7 @@ void *kmap_atomic_prot_pfn(unsigned long
>>-	idx = type + KM_TYPE_NR * smp_processor_id();
>>+	idx = type + KM_TYPE_NR * raw_smp_processor_id();
>>@@ -69,7 +69,7 @@ void
>>-	enum fixed_addresses idx = type + KM_TYPE_NR*smp_processor_id();
>>+	enum fixed_addresses idx = type + KM_TYPE_NR*raw_smp_processor_id();
>
>Yes, it does fix the problem.[...]

This change did not seem to have made it into 2.6.29.5-rt20.
Can it be added?
