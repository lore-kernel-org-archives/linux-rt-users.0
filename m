From: "John Ulvr" <julvr@broadcom.com>
Subject: RE: Small fix for MIPs
Date: Wed, 25 Mar 2009 13:09:10 -0700
Message-ID: <400C43189542CE41BC0A5B252FC9013649F00BEF9A@SJEXCHCCR02.corp.ad.broadcom.com>
References: <400C43189542CE41BC0A5B252FC9013649F00BEF97@SJEXCHCCR02.corp.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mms3.broadcom.com ([216.31.210.19]:4492 "EHLO MMS3.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753592AbZCYUJY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Mar 2009 16:09:24 -0400
In-Reply-To: <400C43189542CE41BC0A5B252FC9013649F00BEF97@SJEXCHCCR02.corp.ad.broadcom.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Just to clarify, the bellow applies to the RT_PREEMPT patch on the 2.6.29-rc8 kernel, and fixes a compile error.


John


-----Original Message-----
From: linux-rt-users-owner@vger.kernel.org [mailto:linux-rt-users-owner@vger.kernel.org] On Behalf Of John Ulvr
Sent: Wednesday, March 25, 2009 3:58 PM
To: linux-rt-users@vger.kernel.org
Subject: Small fix for MIPs

 
In /arch/mips/mm/init.c, line 64 should be changed from:
 
DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);

to
 
DEFINE_PER_CPU_LOCKED(struct mmu_gather, mmu_gathers);
 

Thanks

John

