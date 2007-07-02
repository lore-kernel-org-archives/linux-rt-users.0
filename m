From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Question about latency tracer output
Date: Mon, 2 Jul 2007 18:07:01 -0300
Message-ID: <20070702210701.GE4827@unix.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ivoti.hst.terra.com.br ([200.176.10.212]:50275 "EHLO
	ivoti.terra.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755398AbXGBVKV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Jul 2007 17:10:21 -0400
Received: from sr03-07.mta.terra.com.br (sr03-07.mta.terra.com.br [200.154.152.46])
	by ivoti.terra.com.br (Postfix) with ESMTP id B6FE04A536C
	for <linux-rt-users@vger.kernel.org>; Mon,  2 Jul 2007 18:10:18 -0300 (BRT)
Received: from disraeli.terra.com.br (disraeli.terra.com.br [200.176.10.19])
	by bungunia.hst.terra.com.br (Postfix) with ESMTP id 1823B1944239
	for <linux-rt-users@vger.kernel.org>; Mon,  2 Jul 2007 18:08:16 -0300 (BRT)
Received: from lclaudio.dyndns.org (unknown [189.4.11.102])
	(authenticated user lc_poa)
	by disraeli.terra.com.br (Postfix) with ESMTP id 0454A3840BF
	for <linux-rt-users@vger.kernel.org>; Mon,  2 Jul 2007 18:08:15 -0300 (BRT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello!

What's the meaning of VP and KP, as in the log exerpt bellow? I saw that
they are hardcoded to 0... are they just placeholders?

    [root@dexterlab ~]# cat /proc/latency_trace
    preemption latency trace v1.1.5 on 2.6.21-rc3-rt0
    --------------------------------------------------------------------
    latency: 65 us, #20/20, CPU#3 | (M:rt VP:0, KP:0, SP:1 HP:1 #P:4)

Thanks,
Luis
-- 
[ Luis Claudio R. Goncalves                   lclaudio at uudg dot org ]
[ Fingerprint:   4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8    ]
[ Linux-HA Developer - LateNite Programmer - Gospel User - Bass Player ]
[ Fault Tolerance - Real-Time - Distributed Systems - IECLB - Is 40:31 ]
