From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.18.11-rt7
Date: Mon, 13 Apr 2015 15:43:19 +0200
Message-ID: <20150413134319.GA27894@linutronix.de>
References: <20150413131549.GA19684@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150413131549.GA19684@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Sebastian Andrzej Siewior | 2015-04-13 15:15:49 [+0200]:

>Changes since v3.18.11-rt6
>
forgot to mention:

- A patch from Brian Silverman to fix RLIMIT_RTTIME if PI-boosting.

- a ifdef fixup in blk-mq.c (triggers a warning during a non-RT compile)

Sebastian
