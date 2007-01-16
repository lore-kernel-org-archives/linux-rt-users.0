From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Two 2.6.20-rc5-rt2 issues
Date: Tue, 16 Jan 2007 12:56:38 +0100
Message-ID: <20070116115638.GA6809@elte.hu>
References: <5114.194.65.103.1.1168943363.squirrel@www.rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:46044 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751041AbXAPL6J (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Jan 2007 06:58:09 -0500
To: Rui Nuno Capela <rncbc@rncbc.org>
Content-Disposition: inline
In-Reply-To: <5114.194.65.103.1.1168943363.squirrel@www.rncbc.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> First one is about building for UP (CONFIG_SMP not set) on my old P4 
> laptop. As it seems, all my build attempts failed at the final link 
> stage, with undefined references to paravirt_enable. After disabling 
> CONFIG_PARAVIRT I get a similar failure, but this time for a couple 
> kvm* symbols. [...]

ok, i think i have managed to fix both bugs. I have released -rt3, 
please re-check whether it works any better. If it still doesnt then 
please send me the exact .config that fails.

> [...] I could only get a clean build when CONFIG_SMP is set, which is 
> (IMHO) overkill for a machine which is neither HyperThread/SMT enabled 
> nor multi-core. Its plain dead UP and it used to run PREEMPT_RT 
> kernels for a long time now.

btw., latest SMP kernels (2.6.18 and later) "patch themselves back" to 
UP instructions to a high degree if they run on a single CPU - that's 
why for example Fedora uses only an SMP kernel these days. Running a 
genuine UP kernel is still more efficient - but the difference shouldnt 
be /that/ large anymore. (if someone would like to measure it that would 
be interesting to see)

> Second one is already about running SMP, on a Dual Core2 T7200, for 
> which the build goes fine but run-time is haunted by a crippling BUG:

> Call Trace:
>  [<c0102dad>] __switch_to+0xcc/0x176
>  [<c01185c8>] wake_up_process+0x19/0x1b
>  [<c01fe568>] acpi_ec_gpe_handler+0x1f/0x53
>  [<c01ec6c6>] acpi_ev_gpe_dispatch+0x64/0x163
>  [<c01eca06>] acpi_ev_gpe_detect+0x94/0xd7

hm, this is a -rt specific thing that i hoped to have worked around but 
apparently not. The ACPI code uses a waitqueue in its idle routine 
(argh!) which cannot by done sanely on PREEMPT_RT. In -rt3 i've added a 
more conservative (but still ugly and incorrect) hack - could you try 
it, does -rt3 work any better?

	Ingo
