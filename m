From: Jens Koehler <jenskxxx@googlemail.com>
Subject: Re: hrtimer: interrupt took 10252 ns - meaning?
Date: Mon, 13 Jun 2016 11:16:11 +0200
Message-ID: <CAL7_A_VUiLH9JBkL8HBrUaAn6_yF+3jefXHMwGFS8Sr4g29q0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:36352 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933446AbcFMJQN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Jun 2016 05:16:13 -0400
Received: by mail-vk0-f42.google.com with SMTP id u64so59444375vkf.3
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Jun 2016 02:16:13 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I found now out that the problem with RT throttling could happen when
my application sends UDP broadcasts (and receive its own broadcast).

Is this an already known problem?

[137482.258011] hrtimer: interrupt took 9434 ns
[178458.961966] NOHZ: local_softirq_pending 102
[178458.967583] NOHZ: local_softirq_pending 102
[178458.973295] NOHZ: local_softirq_pending 102
[178458.980249] NOHZ: local_softirq_pending 102
[178458.984994] NOHZ: local_softirq_pending 102
[178458.990582] NOHZ: local_softirq_pending 102
[178458.996292] NOHZ: local_softirq_pending 102
[178459.000348] [sched_delayed] sched: RT throttling activated

Jens
