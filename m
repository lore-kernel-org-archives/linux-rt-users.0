From: "John Ulvr" <julvr@broadcom.com>
Subject: Small fix for MIPs
Date: Wed, 25 Mar 2009 12:58:24 -0700
Message-ID: <400C43189542CE41BC0A5B252FC9013649F00BEF97@SJEXCHCCR02.corp.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mms2.broadcom.com ([216.31.210.18]:1849 "EHLO mms2.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752368AbZCYT6d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Mar 2009 15:58:33 -0400
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

 
In /arch/mips/mm/init.c, line 64 should be changed from:
 
DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);

to
 
DEFINE_PER_CPU_LOCKED(struct mmu_gather, mmu_gathers);
 

Thanks

John

