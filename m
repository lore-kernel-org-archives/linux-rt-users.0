From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Signaltest hanging in 2.6.23-rc4-rt1
Date: Wed, 19 Sep 2007 11:32:17 -0300
Message-ID: <20070919143217.GH3229@unix.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: mingo@elte.hu, tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from marova.hst.terra.com.br ([200.176.10.215]:43859 "EHLO
	marova.hst.terra.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553AbXISOiR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Sep 2007 10:38:17 -0400
Received: from sr01-08.mta.terra.com.br (sr01-08.mta.terra.com.br [200.154.152.27])
	by marova.hst.terra.com.br (Postfix) with ESMTP id 94D0811B02AF
	for <linux-rt-users@vger.kernel.org>; Wed, 19 Sep 2007 11:38:15 -0300 (BRT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello,

I have been running some tests using signaltest and when I tried to run the
simplest one of the tests in 2.6.23-rc4-rt1, the test halted right after the
first iteration.

The test I was running is:

	-------
	REP=20
	ARQ=sinaltest_rep_test.log

	for i in `seq $REP`
	do
	        (time signaltest -l 10000) 2>&1 | tee /tmp/lalala
	        echo -e "\n--[ step $i\n" >> $ARQ
	        cat /tmp/lalala >> $ARQ
	done
	-------

The kernel was 2.6.23-rc4-rt1, x86_64, system 100% idle, after the first
iteration signaltest hangs (wchan shows "-").

   [lclaudio@lab ~]$ ps -Ao pid,psr,rtprio,stat,vsz,rss,cmd,wchan | grep sig
    2775   0      - Rl+   24392   532 signaltest -l 10000         -

This is just a 'heads-up'. I will investigate it further but that would be
nice if others could also run the test.

Regards,
Luis
-- 
[ Luis Claudio R. Goncalves                                       ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]
