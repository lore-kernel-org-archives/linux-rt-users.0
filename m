From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch-3.18.7-rt1] snd/pcm: fix snd_pcm_stream_lock*()
 irqs_disabled() splats
Date: Wed, 25 Feb 2015 15:08:39 +0100
Message-ID: <20150225140839.GB6823@linutronix.de>
References: <20150216111822.GA21649@linutronix.de>
 <1424268563.7035.5.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424268563.7035.5.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Mike Galbraith | 2015-02-18 15:09:23 [+0100]:

>Locking functions previously using read_lock_irq()/read_lock_irqsave() were
>changed to local_irq_disable/save(), leading to gripes.  Use nort variants.
applied

Sebastian
