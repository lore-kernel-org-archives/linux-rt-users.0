From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: Problems with 3.6.11-rt30
Date: Sat, 02 Mar 2013 11:47:45 +0100
Message-ID: <87k3pq6pta.fsf@steelpick.2x.cz>
Mime-Version: 1.0
Content-Type: text/plain
To: Linux RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from max.feld.cvut.cz ([147.32.192.36]:54704 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559Ab3CBKxx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 2 Mar 2013 05:53:53 -0500
Received: from localhost (unknown [192.168.200.7])
	by max.feld.cvut.cz (Postfix) with ESMTP id 1D3A83CFF2B
	for <linux-rt-users@vger.kernel.org>; Sat,  2 Mar 2013 11:47:49 +0100 (CET)
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10044)
	with ESMTP id Q8-ddHFxRo1C for <linux-rt-users@vger.kernel.org>;
	Sat,  2 Mar 2013 11:47:46 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 4D3743CFE8F
	for <linux-rt-users@vger.kernel.org>; Sat,  2 Mar 2013 11:47:45 +0100 (CET)
Received: from wsh by steelpick.2x.cz with local (Exim 4.80)
	(envelope-from <sojkam1@fel.cvut.cz>)
	id 1UBjyj-0004nr-Is
	for linux-rt-users@vger.kernel.org; Sat, 02 Mar 2013 11:47:45 +0100
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I've just tried to boot
https://www.kernel.org/pub/linux/kernel/projects/rt/3.6/patch-3.6.11-rt30.patch.bz2
on MPC5200 (PowerPC) and I experienced some problems.

1) With moderate network traffic, cyclictest reported latencies around
   3000 us.

2) By loading the board with "ping -f -s 64000 mpc5200" after a while,
   the board become unresponsible and console printed the following
   messages.

   [217.957488] NOHZ: local_softirq_pending 02
   [217.957555] NOHZ: local_softirq_pending 02
   [217.968506] NOHZ: local_softirq_pending 02
   [220.566778] net_ratelimit: 510909 callbacks suppressed
   [220.566803] net eth0: transmit queue overrun
   [...]
   [220.667671] net eth0: transmit queue overrun
   [225.626769] net_ratelimit: 433958 callbacks suppressed
   [225.626793] net eth0: transmit queue overrun
   [225.637967] net eth0: transmit queue overrun
   [225.643195] net eth0: transmit queue overrun
   [225.648491] net eth0: transmit queue overrun
   [225.653484] net eth0: transmit queue overrun

v3.4-rt branch runs perfecly on this board. Is the above expected
behaviour for this version of -rt patch?

Best regards,
-Michal Sojka
