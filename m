From: Stanislav Meduna <stano@meduna.org>
Subject: Re: i.MX28 milliseconds latencies, interrupts disabled in arch_cpu_idle?
Date: Sat, 19 Apr 2014 00:21:07 +0200
Message-ID: <5351A553.6040104@meduna.org>
References: <53503BD8.8000506@meduna.org> <9645151.cbKImklAq0@hydra> <53516B19.6040702@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Tim Sander <tim@krieglstein.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:53249 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754510AbaDRWVP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 Apr 2014 18:21:15 -0400
In-Reply-To: <53516B19.6040702@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 18.04.2014 20:12, Stanislav Meduna wrote:

> Would it be possible to 'lie' to the tracing infrastructure and
> treat the cpu_do_idle() as interrupts enabled without
> actually enabling them?

Hm.. but this actually happens - the call to arch_cpu_idle()
is surrounded by stop_critical_timings()/start_critical_timings()
so the time should not be traced. Weird...

-- 
                                  Stano


