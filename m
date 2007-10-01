From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: periodic bursts
Date: Mon, 01 Oct 2007 19:40:46 +0200
Message-ID: <4701311E.3000204@siemens.com>
References: <725A29F6B5035C45A40BDE230A5B92190F8DB322@TRISTK010MSX.tr001.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-9; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "Kaya, Sinan" <sinan.kaya@siemens.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lizzard.sbs.de ([194.138.37.39]:16491 "EHLO lizzard.sbs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752159AbXJASMJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Oct 2007 14:12:09 -0400
Received: from mail1.sbs.de (localhost [127.0.0.1])
	by lizzard.sbs.de (8.12.6/8.12.6) with ESMTP id l91HehmY024605
	for <linux-rt-users@vger.kernel.org>; Mon, 1 Oct 2007 19:40:43 +0200
In-Reply-To: <725A29F6B5035C45A40BDE230A5B92190F8DB322@TRISTK010MSX.tr001.siemens.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Kaya, Sinan wrote:
> Hello all,
> My realtime system experiences periodic bursts every 4 hours. How can
> i find the reason for this  ? I know the traceit tool but it dumps
> so much data and it is useless under this case. I need to find what 
> happened at the exact time of burst.

The trace-it tool is a demo, you need to adopt it to your scenario, 
specifically make it trigger the stop once you detected some burst. 
Means, you need to put its code into your application. Did you do this?

> 
> I use rtai_smi module to disable SMI interrupts

Then you will probably like this tool even more:
http://www.rts.uni-hannover.de/rtaddon/#smictrl

> and set my network interface driver priorities to 99. So it should be
> something non maskable but what ?

Out-of-the-box NIC drivers are generally not suited for more than
soft-RT. They allocate memory (skbs) from global pools which takes
varying time (or may even fail if your are short on memory), sometimes
they try to pile up packets first before they raise an IRQ, and they
often contain hardware/link state watchdogs that can inject latencies 
right at the wrong time. If you need low latency by design, more work is 
required.

In any case, understanding this particular problem comes first, and
collecting the right traces will help.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux
