From: Stanislav Meduna <stano@meduna.org>
Subject: Re: RT_PREEMPT autodetection from user program
Date: Sun, 20 Jan 2013 10:49:28 +0100
Message-ID: <50FBBDA8.5060605@meduna.org>
References: <97041258-E312-4163-96B2-9077EED68E0B@mah.priv.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:42341 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751140Ab3ATKDL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 20 Jan 2013 05:03:11 -0500
Received: from dial-95-105-165-4-orange.orange.sk ([95.105.165.4] helo=[192.168.130.22])
	by meduna.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <stano@meduna.org>)
	id 1TwrWu-0002uQ-Ko
	for linux-rt-users@vger.kernel.org; Sun, 20 Jan 2013 10:49:34 +0100
In-Reply-To: <97041258-E312-4163-96B2-9077EED68E0B@mah.priv.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 20.01.2013 01:13, John Morris wrote:

> LCNC drives machines that weigh many tons and spins
> spindles at 24k RPM, so this is important!
...
> We haven't found /proc/config.gz in any vendor-provided
> PREEMPT_RT kernels, so that is not an option either.

On 20.01.2013 01:49, Michael Haberler wrote:

> A false positive on a vanilla kernel could be a safety hazard.

If we are speaking safety here I'd say that you have to support
specific version of kernel on specific hardware that _you_ have
quality assured. Anything else is a recipe for problems.

I've seen OSADL Linux deadlock, RT PREEMPT leaking memory,
RT PREEMPT on but without high-res timers, IDE driver
monopolizing processor so that the RT throttler was activated,
priority inversion issues between kernel and application
threads, interrupt latencies due to interrupt routing
on the specific hardware etc.

There is no way you can guarantee anything if you are using
vendor-provided kernel on a hardware you have never seen.
With your kernel, a list of supported hardware, with initscripts
that are checking if the environment matches and with the help
from this list (thank you guys, the level of support here
is excellent!) you will sleep a lot better.

Just my two cents

Regards
-- 
                                        Stano

