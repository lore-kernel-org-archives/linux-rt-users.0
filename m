From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Subject: How to measue the total CPU specific load (including real time
 tasks)?
Date: Tue, 7 Jul 2015 12:18:08 +0000
Message-ID: <0b987de237404a13b1753e28e3853d2f@FE-MBX1012.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from imta22.fe.bosch.de ([139.15.243.26]:19652 "EHLO
	imta22.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136AbbGGM1o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Jul 2015 08:27:44 -0400
Received: from smtp6-v.fe.bosch.de (imta24.fe.bosch.de [139.15.243.27])
	by imta22.fe.bosch.de (Postfix) with ESMTP id BA9508403B9
	for <linux-rt-users@vger.kernel.org>; Tue,  7 Jul 2015 14:18:12 +0200 (CEST)
Received: from vsmta11.fe.internet.bosch.com (unknown [10.4.98.51])
	by imta24.fe.bosch.de (Postfix) with ESMTP id B6972D80002
	for <linux-rt-users@vger.kernel.org>; Tue,  7 Jul 2015 14:18:10 +0200 (CEST)
Received: from SI-MBX1011.de.bosch.com (vsgw23.fe.internet.bosch.com [10.4.98.23])
	by vsmta11.fe.internet.bosch.com (Postfix) with ESMTP id 703DE238021E
	for <linux-rt-users@vger.kernel.org>; Tue,  7 Jul 2015 14:18:10 +0200 (CEST)
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

we use the RT_PREEMPT kernel fairly long now and it is working really fine.
However, I have one question that is related to measure the available "CPU headroom" on all available CPU cores.
We are using an Intel Core i7 PC (32 and 64bit, Debian distribution, vanilla kernel + rt_preempt patch).
The question is the same for kernel 3.2.x and 3.18.x.

On the PC a couple of real time threads are running. They are hard bound to a particular CPU core 
(via pthread_setaffinity_np or sched_setaffinity).
As we are using the boot parameter  "isolcpus=1-31", all processes run per default on CPU core 0.
Now, I want to measure the total CPU specific load.
How can this be done easily?

When I use "top" in thread-mode I see the relative CPU load for particular threads/processes.
However the "idle" value in the "top" summary does not fit. With some experiments I saw the idle value for a CPU core to 
be nearly 100% even if on the very same CPU core a real time thread was consuming about 40% CPU time.
I looked into /proc/stat to take the idle tick value but this value seems not to consider the real time threads.


The only approach I found so far is to parse all /proc/PID/stat files periodically and to extract the 
fields utime, stime, cutime, cstime, task_cpu. These values can be used to compute the CPU specific load.
However, the effort to do so is really high.

Is there any /proc file (or something similar) I can use to get the total CPU specific load (including real time threads)?
Or do I have to enable a particular kernel configuration to get this value?

Thanks for any feedback on this question.

Regards

Mathias
