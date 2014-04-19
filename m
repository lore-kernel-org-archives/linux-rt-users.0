From: Tim Sander <tim@krieglstein.org>
Subject: Re: i.MX28 milliseconds latencies, interrupts disabled in arch_cpu_idle?
Date: Sat, 19 Apr 2014 23:24:47 +0200
Message-ID: <12490005.Mvd4Usk8IT@virgo>
References: <53503BD8.8000506@meduna.org> <9645151.cbKImklAq0@hydra> <53516B19.6040702@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lvps176-28-13-145.dedicated.hosteurope.de ([176.28.13.145]:60886
	"EHLO lvps176-28-13-145.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751351AbaDSVYw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 19 Apr 2014 17:24:52 -0400
In-Reply-To: <53516B19.6040702@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Stanislav
Am Freitag, 18. April 2014, 20:12:41 schrieb Stanislav Meduna:
> On 18.04.2014 18:09, Tim Sander wrote:
> > Are you sure that this is not the cpu idle latency?
> 
> Don't think so. However it is close to what I'd expect as an average
> idle time (capped up by periodic ticks @ 250 Hz = 4 ms).
Have you tried patching out the wfi in the idle loop? At least the i.mx35 does 
some strange l2cache dance due to an hw bug. Patching out this whole stuff 
helped a lot with latencys on an unloaded system.

Best regards
Tim

