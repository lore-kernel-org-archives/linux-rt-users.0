From: Chirag Jog <chirag@linux.vnet.ibm.com>
Subject: Re: How to enable HPET on an 2.6.23.9-rt12 with Intel ICH2
Date: Tue, 22 Jan 2008 17:24:36 +0530
Message-ID: <20080122115436.GC8660@linux.vnet.ibm.com>
References: <7B9B6F61B189D94CA8CEE58A449BF3A97124FB@de01ex02.GLOBAL.JHCN.NET>
Reply-To: Chirag Jog <chirag@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linux-rt-users@vger.kernel.org
To: Lampersperger Andreas <lampersperger.andreas@heidenhain.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([59.145.155.7]:47980 "EHLO
	e28esmtp07.in.ibm.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751557AbYAVLyj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Jan 2008 06:54:39 -0500
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28esmtp07.in.ibm.com (8.13.1/8.13.1) with ESMTP id m0MBsbYp024715
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Jan 2008 17:24:37 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m0MBsZRT598192
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Jan 2008 17:24:37 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.13.1/8.13.3) with ESMTP id m0MBsYcA028311
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Jan 2008 11:54:34 GMT
Content-Disposition: inline
In-Reply-To: <7B9B6F61B189D94CA8CEE58A449BF3A97124FB@de01ex02.GLOBAL.JHCN.NET>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Lampersperger Andreas <lampersperger.andreas@heidenhain.de> [2008-01-22 12:09:42]:

> Hello,
> 
> does anyone have a hint how to enable High resolution timers on my
> system (with a Intel ICH2 (which has afaik 8254 Timers). Is this
> hardware not enough for hr-timers?
Check your BIOS settings.
If your h/w supports HPET, there should be an option in the BIOS to turn it on.

<snip>
-- 
Cheers,
Chirag Jog
