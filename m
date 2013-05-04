From: Stanislav Meduna <stano@meduna.org>
Subject: e100: usleep in timer context legal?
Date: Sat, 04 May 2013 07:57:06 +0200
Message-ID: <5184A332.4020401@meduna.org>
References: <51829B12.6030206@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:50684 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751542Ab3EDF5R (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 4 May 2013 01:57:17 -0400
Received: from dial-95-105-165-4-orange.orange.sk ([95.105.165.4] helo=[192.168.130.22])
	by meduna.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <stano@meduna.org>)
	id 1UYVT4-0002Hp-FK
	for linux-rt-users@vger.kernel.org; Sat, 04 May 2013 07:57:13 +0200
In-Reply-To: <51829B12.6030206@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

drivers/net/ethernet/intel/e100.c has a following construct:

static u16 mdio_ctrl_hw(struct nic *nic, ...
  ...
  spin_lock_irqsave(&nic->mdio_lock, flags);
  ...
  udelay(20);
  ...
  spin_unlock_irqrestore(&nic->mdio_lock, flags);

This function is indirectly called from
static void e100_watchdog(unsigned long data)

which is a timer. So if I understand it correctly, this
will be called as a softirq. There is also another path -
e.g. via ioctl() - where this will be called in the thread
context.

Is this legal? From googling I am a bit confused, I think
it is (usleep is not really "blocking" and under RT
it is always (?) processed in a thread context), but I'd
like to check. I am mostly a userspace developer and I admit
I do not yet know all the fine differences in hard-irq,
soft-irq, when are soft-irqs processed etc).

I am still hunting livelock issues where the RT throttler
activates and after 1-3 seconds all is OK again; so far
I have been unable to capture a trace of it, as it is
strongly timing-dependent and nearly never happens in
a lab :( Due to an oversight in our code we are calling
the mdio_ctrl_hw really often (but not more often the
udelays can handle), so I suspect it can be related.

Thanks
-- 
                                       Stano

