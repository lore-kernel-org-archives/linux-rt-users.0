From: Stanislav Meduna <stano@meduna.org>
Subject: e100 driver spinning delay blocking ksoftirqd?
Date: Thu, 02 May 2013 18:57:54 +0200
Message-ID: <51829B12.6030206@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:42913 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761336Ab3EBQ6S (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 May 2013 12:58:18 -0400
Received: from dial-95-105-165-4-orange.orange.sk ([95.105.165.4] helo=[192.168.130.22])
	by meduna.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <stano@meduna.org>)
	id 1UXwpS-00015p-Ap
	for linux-rt-users@vger.kernel.org; Thu, 02 May 2013 18:58:14 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

drivers/net/ethernet/intel/e100.c:

for (i = 0; i < 100; i++) {
	udelay(20);
	if ((data_out = ioread32(&nic->csr->mdi_ctrl)) & mdi_ready)
		break;
	}

On my system this calls delay_tsc and if I understand this
correctly, this will block ksoftirqd and everything having
a lower priority for up to 2 ms. Which is what I am seeing
in my traces - this loop most probably causes the ~1 ms
latencies I am regularly seeing.

Is there something that can be done about it except trying
the split softirq feature? I need to have the timers above
some of my threads, but I don't like the networking blocking
them...

Anyone has some experiences/hints for using e100 with linux-rt?

The kernel is the current 3.4-rt one.

Thanks
-- 
                                       Stano
