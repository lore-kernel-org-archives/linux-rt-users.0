From: "Jiang, Yunhong" <yunhong.jiang@intel.com>
Subject: Should I still use pm_timer as clock source for hrt mode
Date: Tue, 21 Apr 2015 17:08:58 +0000
Message-ID: <DDCAE26804250545B9934A2056554AA0208A7A44@ORSMSX112.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:25428 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753058AbbDURJD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 21 Apr 2015 13:09:03 -0400
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi, all
	I noticed followed statement about TSC timer on https://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO , " Since the TSC timer on PC platforms, as used in the previous versions, are now marked as unsuitable for hrt mode due to many lacks of functionalities and reliabilities, you will need i.E. pm_timer as provided by ACPI to use as clock source".

	I'm testing on Intel Xeon CPU E5-2640 and has "Switched to clocksource tsc" on kernel log, I think it mean the TSC on my system is stable and reliable enough to use as clock source, right? With the invariant and synchronized TSC support in latest hardware, can I assume generally TSC would be better than pm_timer? 

Thanks
--jyh
