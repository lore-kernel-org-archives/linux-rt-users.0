From: "Joachim Deguara" <joachim.deguara@amd.com>
Subject: Re: LAPIC broken on ferrari 1000
Date: Thu, 12 Jul 2007 20:40:37 +0200
Message-ID: <200707122040.37708.joachim.deguara@amd.com>
References: <200707121624.02169.joachim.deguara@amd.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from outbound-dub.frontbridge.com ([213.199.154.16]:28660 "EHLO
	outbound4-dub-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756558AbXGLSk5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Jul 2007 14:40:57 -0400
Received: from outbound4-dub.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound4-dub-R.bigfish.com (Postfix) with ESMTP id 40F61E604DB
	for <linux-rt-users@vger.kernel.org>; Thu, 12 Jul 2007 18:40:56 +0000 (UTC)
Received: from mail52-dub-R.bigfish.com (unknown [10.5.252.3])
	by outbound4-dub.bigfish.com (Postfix) with ESMTP id 3530618000BA
	for <linux-rt-users@vger.kernel.org>; Thu, 12 Jul 2007 18:40:56 +0000 (UTC)
Received: from mail52-dub (localhost.localdomain [127.0.0.1])
	by mail52-dub-R.bigfish.com (Postfix) with ESMTP id 13ADB1BA8325
	for <linux-rt-users@vger.kernel.org>; Thu, 12 Jul 2007 18:40:56 +0000 (UTC)
Received: from svlb1extmailp02.amd.com (unknown [139.95.251.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail52-dub.bigfish.com (Postfix) with ESMTP id A90A765004F
	for <linux-rt-users@vger.kernel.org>; Thu, 12 Jul 2007 18:40:55 +0000 (UTC)
Received: from SSVLGW01.amd.com (ssvlgw01.amd.com [139.95.250.169])
	by svlb1extmailp02.amd.com (Switch-3.2.7/Switch-3.2.7) with ESMTP id l6CIenNR001852
	for <linux-rt-users@vger.kernel.org>; Thu, 12 Jul 2007 11:40:52 -0700
In-Reply-To: <200707121624.02169.joachim.deguara@amd.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thursday 12 July 2007 16:24:01 Joachim Deguara wrote:
> Hi,
>   I have a ferrari 1000 laptop with AMD Turion x2 (RevF) and it seams the
> LAPIC is broke only with the RT patch.  What happens is it boots and does
> not get any timer interrupts so I have to either move the mouse or hit
> shift to get it continure booting and getting interrupts.  This is tested
> with 2.6.22.1-rt1.  The dmesg along with sysrq-Q, kernel config and also
> the output of:
> cat /proc/interrupts
> sleep 10 (me hitting shift a few time)
> cat /proc/interrupts
>
> -Joachim

Just wanted to follow up that I tried to make the boot experience as safe as 
possible and rule out other problems.  This was done with a UP kernel (though 
its a dual-core) and HRT and dynticks turned off along with limit C-states to 
just C0.  Now that we can do some bisecting I have found that:

x86_64-apic-whitex86_64-apic-whitespace-comment-and-remove-unused-code.patch
x86_64-timec-fix-whitespace-wreckage.patch
#GOOD
x86_64-consolidate-tsc-calibration.patch
#Not Bisectable
x86_64-preparatory-apic-set-lvtt.patch
#Not Bisectable
x86_64-convert-to-cleckevents.patch
#BAD

I will be pouring over the code and looking how the LAPIC works but I thought 
this might help those that wrote the patches.

-Joachim
