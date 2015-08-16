From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RT] oops in 4.1.3-rt3
Date: Sun, 16 Aug 2015 13:33:42 +0200
Message-ID: <20150816113342.GB7004@linutronix.de>
References: <20150803142700.1de720e4@sluggy>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150803142700.1de720e4@sluggy>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Clark Williams | 2015-08-03 14:27:00 [-0500]:

>Sebastian,
Hi Clark,

>Below is a traceback I hit while running 4.1.3-rt3 on my Lenovo T530.
>
>I was doing my normal, play music, copy files over the lan, do compiles,
>do email, etc., so I I can't really point you at a reproducer. The graphics
>system stayed up somewhat but the actual trace I hit scrolled off. This was
>extracted from the syslog with 'journalctl'. 
>
>If I encounter it again, I'll see if I can force a kdump. 

So it did not happen again? Is it possible to get addr2line from this
kernel (from $eip)? sock_prot_inuse_add() does "just" __this_cpu_add().

>Clark

Sebastian
