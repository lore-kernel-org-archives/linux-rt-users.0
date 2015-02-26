From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.18.7-rt2: NOHZ_FULL warning at boot
Date: Thu, 26 Feb 2015 21:11:48 +0100
Message-ID: <20150226201148.GI12992@linutronix.de>
References: <20150226200547.GL4111@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:50578 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754101AbbBZULu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Feb 2015 15:11:50 -0500
Content-Disposition: inline
In-Reply-To: <20150226200547.GL4111@uudg.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Luis Claudio R. Goncalves | 2015-02-26 17:05:47 [-0300]:

>[    1.537215] WARNING: CPU: 1 PID: 20 at /home/lclaudio/SANDBOX/kernel-rt/kernel/time/tick-sched.c:167 can_stop_full_tick+0x1ee/0x2b0()

I haven't run full-dynticks for some time. I might have broken that, I
take a look at that.

Sebastian
