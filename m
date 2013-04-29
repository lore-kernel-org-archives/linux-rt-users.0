From: Stanislav Meduna <stano@meduna.org>
Subject: Re: timerfd read does not return - was probably fixed in 3.4.38
Date: Mon, 29 Apr 2013 10:43:27 +0200
Message-ID: <517E32AF.8080907@meduna.org>
References: <516BDE52.90200@meduna.org> <alpine.LFD.2.02.1304151416580.21884@ionos> <516BF8FD.2000700@meduna.org> <516EC3F3.1080406@meduna.org> <516FB8B9.9090506@meduna.org> <517B8D91.4010700@meduna.org> <517D0DD0.6040307@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:35800 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311Ab3D2Inh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Apr 2013 04:43:37 -0400
In-Reply-To: <517D0DD0.6040307@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 28.04.2013 13:53, Carsten Emde wrote:

Hi Carsten,

> We, therefore, configure and enable continuous latency
> monitoring histograms (CONFIG_WAKEUP_LATENCY_HIST and
> CONFIG_MISSED_TIMER_OFFSETS_HIST) by default in all our farm systems
> since more than two years (https://www.osadl.org/?id=864), and we are
> not aware of any problem that might be related to them.

The problem is our systems that started to exhibit this problem
did have just these enabled :( Many more were compiled in.

Your continuous test farm is impressive! A suggestion: would it
be possible to also add a dmesg and more of the /proc/timer_list
output to the profile pages? This would make comparing with
the own system even easier.

For example the Geode system at https://www.osadl.org/?id=948 :
how did you convince it to use highres timers? In my environment
the Geode LX / CS5536 needs tsc=reliable, but your kernel command
line does not contain it.

Thanks
-- 
                                        Stano

