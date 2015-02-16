From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.14.3-rt5
Date: Mon, 16 Feb 2015 12:29:54 +0100
Message-ID: <20150216112954.GB21649@linutronix.de>
References: <20140509181214.GK29014@linutronix.de>
 <20140513153020.35c0e9d08db60c7b3919e593@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Juri Lelli <juri.lelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140513153020.35c0e9d08db60c7b3919e593@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Juri Lelli | 2014-05-13 15:30:20 [+0200]:

>Hi,
Hi Juri,

>Also SCHED_DEADLINE dies without the following.
>
>Thanks,
>
>- Juri
>
>---From 3ca5943538c728399037823e5632431bc2da707c Mon Sep 17 00:00:00 2001
>From: Juri Lelli <juri.lelli@gmail.com>
>Date: Tue, 13 May 2014 15:21:16 +0200
>Subject: [PATCH] sched/deadline: dl_task_timer has to be irqsafe

applied.

Sebastian
