From: Stanislav Meduna <stano@meduna.org>
Subject: Re: loading pages to memory causes high latency
Date: Sat, 27 Oct 2012 11:06:26 +0200
Message-ID: <508BA412.5020708@meduna.org>
References: <508ACFCF.8040001@meduna.org> <alpine.LFD.2.02.1210262254560.2756@ionos> <alpine.LFD.2.02.1210271029370.2756@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:44272 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750730Ab2J0JGn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Oct 2012 05:06:43 -0400
Received: from dial-95-105-165-4-orange.orange.sk ([95.105.165.4] helo=[192.168.130.22])
	by meduna.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <stano@meduna.org>)
	id 1TS2Lh-0000uH-6J
	for linux-rt-users@vger.kernel.org; Sat, 27 Oct 2012 11:06:39 +0200
In-Reply-To: <alpine.LFD.2.02.1210271029370.2756@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 27.10.2012 10:38, Thomas Gleixner wrote:

> There is not much we can do about that unless we want to do a major
> surgery on that pata driver code.
> 
> So either you disable the throttler or you reconfigure the pata irq
> thread to SCHED_OTHER, which will slow it down a bit, but avoids the
> hogging of the machine with a RT task going wild.

Thank you for the analysis. Yep I'll reconfigure it to SCHED_OTHER -
file access is a totally low-prio thing in my application and I was more
afraid of a possibility where someone fetching logfiles or something
like that will bring the application to the knees.

BTW what granularity does the throttler have? I cannot live with
50 ms lag once in a second, but in my case I can well live with
5 ms lag once in 100 ms (even if that means that the throttler
would be activated more often).

Right now I have

CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y

and lacking better choices my clock source is TSC. I admit that
I do not know what precisely each setting does - the NO_HZ combined
with HZ=1000 looks a bit weird ;)

Best regards
-- 
                                      Stano

