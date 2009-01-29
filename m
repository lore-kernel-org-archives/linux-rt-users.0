From: Aymeric <ejisneos@gmail.com>
Subject: 2.6.26 freezes since rt13
Date: Thu, 29 Jan 2009 14:12:37 +0100
Message-ID: <4981AB45.8000202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:55825 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863AbZA2NMm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Jan 2009 08:12:42 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1433772nfc.21
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Jan 2009 05:12:41 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,


I started to have problems with the kernel 2.6.26 since the rt13 patch:
when I start the JACK server, I can't launch a synthesizer application
such as minicomputer without experiencing a freeze about 10 second after
having launched it. I have to shut down my computer, then reboot. I
tried with a higher buffer size (4), and the only difference was the
time it took to freeze again.

I also wanted to ask why the patch you gave at the beginning of january,
to make alsa_seq work, hasn't been applied to the official RT kernel,
even to the GIT one, because I systematically have to use it each time I
compile a new version of the RT patch.


Thanks.
