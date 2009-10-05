From: Azraiyl <azraiyl@gmail.com>
Subject: Re: RT Latency on Atmel Processors
Date: Mon, 5 Oct 2009 18:01:14 +0200
Message-ID: <a9067d050910050901k7b3347acpace7580085e9440a@mail.gmail.com>
References: <a9067d050909240502n3377f3c5gb70fcf16c58b3942@mail.gmail.com>
	 <3efb10970909241340v75375381m8f833e41ba96b733@mail.gmail.com>
	 <a9067d050909290727wc4659e8m55b55503d43979b5@mail.gmail.com>
	 <3efb10970909291126w4d64fcf6s2b48277fe079a09c@mail.gmail.com>
	 <a9067d050909291346g43e777a1ya02cb12e7625de0d@mail.gmail.com>
	 <3efb10970909291419x28b48dd5hf60442390295afe9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:60724 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329AbZJEQBv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Oct 2009 12:01:51 -0400
Received: by bwz6 with SMTP id 6so2598829bwz.37
        for <linux-rt-users@vger.kernel.org>; Mon, 05 Oct 2009 09:01:14 -0700 (PDT)
In-Reply-To: <3efb10970909291419x28b48dd5hf60442390295afe9@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> I would expect the load is much higher... Do you have a proper
> sched_clock() implementation or the default fallback-to-jiffies based
> sched_clock()? Load statistics might be misleading...
> See attached for a preliminary patch... (using it on a sam9261 core)

No, I always was using vanilla (or sometimes tried with the atmel
patches from linux4sam). With 2.6.31 the ftrace behaviour does not
change (but then I've to add your serial fix) It seems with your patch
at least the the timing informations in the trace look better e.g.
(but maybe they're still wrong, don't know yet):

--- >8 ---

 <idle>-0       0d.h.2 34147us+: irq_exit <-_text
 <idle>-0       0d...3 34160us+: __do_softirq <-irq_exit
 <idle>-0       0d...3 34173us+: trigger_softirqs <-__do_softirq
 <idle>-0       0d...1 34192us!: default_idle <-cpu_idle
 <idle>-0       0d...2 41277us+: _text <-__irq_svc
 <idle>-0       0d...2 41290us+: irq_enter <-_text
 <idle>-0       0d...2 41302us+: idle_cpu <-irq_enter
 <idle>-0       0d.h.2 41315us+: tick_check_idle <-irq_enter
 <idle>-0       0d.h.2 41326us+: irq_to_desc <-_text

--- >8 ---

Hmm my idea was to quickly try out different boards and choose the
best one, but it seems that I have to go deeper.

Thanks once more for you patch

Azraiyl
