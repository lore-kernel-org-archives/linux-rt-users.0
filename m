From: Patrice Kadionik <kadionik@enseirb-matmeca.fr>
Subject: RT-Preempt port for NIOS II and hrtimer
Date: Wed, 10 Feb 2010 22:13:25 +0100
Message-ID: <4B732175.40603@enseirb-matmeca.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:52950 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756429Ab0BJVNf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Feb 2010 16:13:35 -0500
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 653124C80BD
	for <linux-rt-users@vger.kernel.org>; Wed, 10 Feb 2010 22:13:29 +0100 (CET)
Received: from [127.0.0.1] (lns-bzn-55-82-255-171-179.adsl.proxad.net [82.255.171.179])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 49C8F4C8054
	for <linux-rt-users@vger.kernel.org>; Wed, 10 Feb 2010 22:13:27 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear all;

I'm trying to port the  RT-Preempt patch on the NIOS II processor. NIOS 
II is a softcore processor (with or without MMU) that runs into an 
Altera FPGA circuit. It is designed by Altera and is used to build SoPC 
(System on Programmable Chip).

Until now, I've integrated the  RT-Preempt patch 
(patch-2.6.31.12-rt20.gz) into the 2.6.31 Linux source code 
(http://sopc.et.ntust.edu.tw/) for nios2mmu (NIOS II with MMU). I have 
now to modify files under the arch/nios2 directory according to these 
guidelines:
- Katsuya Matsubara. Porting and Evaluating the Linux Realtime 
Preemption on Embedded Platform: 
http://www.celinuxforum.org/CelfPubWiki/JapanTechnicalJamboree14?action=AttachFile&do=get&target=preempt070427celfjambo14.pdf
- Wu Zhangjin, Nicholas Mc Guire. Porting RT-preempt to Loongson2F: 
http://lwn.net/images/conf/rtlws11/papers/proc/p14.pdf
- Port PREEMPT_RT on AR71xx on mailing list: 
http://marc.info/?l=linux-rt-users&m=126441381626221&w=2

In the same time, I study the hrtimer subsystem.
In my SoPC design, I have added an specific HW timer (named hrtimer) 
that have a 20 ns resolution. I intend to integrate it in the NIOS II 
port as a hrtimer.

I've found some useful documents on hrtimer subsytem:
- Thomas Gleixner, Douglas Niehaus. hrtimers and beyond: 
http://www.kernel.org/pub/linux/kernel/people/tglx//hrtimers/ols2006-hrtimers.pdf
- RT Wiki page: http://rt.wiki.kernel.org/index.php/High_resolution_timers
- RT Wiki page: 
http://rt.wiki.kernel.org/index.php/High_resolution_timer_design_notes

Are there guidelines explaining how to integrate a specific HW timer in 
the hrtimer subsystem?
Are there some source code and examples  that can help me to integrate 
my specific timer as hrtimer?

Thank you for your help.

Patrice.

-- 
Patrice Kadionik. F6KQH / F4CUQ
-----------

+----------------------------------------------------------------------+
+"Tout doit etre aussi simple que possible, pas seulement plus simple" +
+----------------------------------------------------------------------+
+ Patrice Kadionik             http://www.enseirb.fr/~kadionik         +
+ IMS Laboratory               http://www.ims-bordeaux.fr/             +
+ ENSEIRB                      http://www.enseirb.fr                   +
+ PO BOX 99                    fax   : +33 5.56.37.20.23               +
+ 33402 TALENCE Cedex          voice : +33 5.56.84.23.47               +
+ FRANCE                       mailto:patrice.kadionik@ims-bordeaux.fr +
+----------------------------------------------------------------------+


