From: Giuliano Colla <giuliano.colla@fastwebnet.it>
Subject: CLOCK_MONOTONIC issue
Date: Mon, 22 Jun 2015 13:06:28 +0200
Message-ID: <5587EC34.2070808@fastwebnet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mr004msr.fastwebnet.it ([85.18.95.67]:53441 "EHLO
	mr004msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753921AbbFVLMQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Jun 2015 07:12:16 -0400
Received: from microserver.localdomain (151.41.156.223) by mr004msr.fastwebnet.it (8.5.140.03) (authenticated as giuliano.colla)
        id 54FF13C4065674D8 for linux-rt-users@vger.kernel.org; Mon, 22 Jun 2015 13:06:30 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

in order both to profile the performance of my rt threads, and to 
perform timed operations (such as sem_timedwait), I'm using the 
clock_gettime() function.

Using as a parameter CLOCK_REALTIME everything appears to work as 
expected, but if I attempt to use CLOCK_MONOTONIC (which should be a 
more reliable timing source, from what I read), I get bogus times.

This occurs on different platforms, and with different kernel 
versions/rt patch. (3.10.10-rt7 - 3.10.67-rt71 - 3.12.31-rt45).

Am I missing something obvious, such as a kernel misconfiguration, or 
this is something to be expected?

Any hint will be appreciated.

Thanks in advance,

Giuliano

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
