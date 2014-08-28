From: Asier Tamayo <asier.tamayo@onaedm.com>
Subject: RV: Migrating from Xenomai
Date: Thu, 28 Aug 2014 10:24:13 +0000
Message-ID: <4F6C25B906613147991AA0B688C61D1F41FB2CAC@SRVEXCHANGE.ona-electroerosion.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from srv20311.emailfirewall.spamina.com ([92.54.22.44]:60918 "EHLO
	srv20311.emailfirewall.spamina.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S936558AbaH1KqS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Aug 2014 06:46:18 -0400
Received: from [212.81.200.66] (helo=mail.ona-electroerosion.com)
	by srv20311.emailfirewall.spamina.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <asier.tamayo@onaedm.com>)
	id 1XMwrd-0005eL-JB
	for linux-rt-users@vger.kernel.org; Thu, 28 Aug 2014 12:23:34 +0200
Content-Language: es-ES
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hello all,

I have been using Xenomai for some time, in an Atom N270 based board, running a kernel 2.6.34 compiled with Sysgo's ELinOS 5.2 tool. I have mainly used the native skin, as well as some RTDM drivers.

Now, I have to start using a new AMD G-Series T52R based board, and kernel 2.6.34 shows some problems with it. Therefore, I have to update the kernel to a newer one, but ELinOS has dropped the Xenomai support. 

One of the options I see is migrating my application to the PREEMPT_RT patch, which is already supported by ELinOS. Has anyone got any experience with it? Which difficulties should I expect to find in the migration process? Any special problems with RTDM, shared memory...?

Has anyone got information about latencies and performance comparison between Xenomai and PREEMPT_RT patch? I have found some in https://www.osadl.org/fileadmin/dam/rtlws/12/Brown.pdf, but it is a bit outdated.
 
Best regards,

Asier Tamayo

