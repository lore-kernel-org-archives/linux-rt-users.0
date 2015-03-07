From: Carsten Emde <C.Emde@osadl.org>
Subject: [RESOLVED OSADL QA 3.18.7-rt2 #2] BUG: scheduling while atomic: nfsd
 and irq/30-eth0
Date: Sat, 07 Mar 2015 23:07:06 +0100
Message-ID: <54FB768A.1030305@osadl.org>
References: <54F778CF.1090201@osadl.org> <20150306181812.GE10155@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:42969 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753209AbbCGWKK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 7 Mar 2015 17:10:10 -0500
In-Reply-To: <20150306181812.GE10155@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 03/06/2015 07:18 PM, Sebastian Andrzej Siewior wrote:
> * Carsten Emde | 2015-03-04 22:27:43 [+0100]:
>
>> An NFS server occasionally runs into "BUG: scheduling while atomic".
>> The message appears about once every 2 to 4 minutes at heavy NFS
>> traffic.
>
> https://lkml.org/lkml/2015/2/18/267
> This should fix it.
Yes, this issue is resolved in 3.18.9-rt4.

Thanks,
	-Carsten.
