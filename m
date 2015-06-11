From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 4.0.4-rt1
Date: Thu, 11 Jun 2015 14:09:49 +0200
Message-ID: <20150611120949.GE16115@linutronix.de>
References: <20150519213923.GA26363@linutronix.de>
 <555C5C9E.2030607@pavlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Pavel Vasilyev <pavel@pavlinux.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <555C5C9E.2030607@pavlinux.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Pavel Vasilyev | 2015-05-20 13:06:22 [+0300]:

>Nvidia GeForce GT740 (blob driver)

If you worry but the >1ms spikes I suggest to remove that blob first.

># cyclictest -S -c 1 -m -p 99 --latency=0 --policy=fifo
>
># /dev/cpu_dma_latency set to 0us
>WARN: Running on unknown kernel version...YMMV
>policy: fifo: loadavg: 1.57 1.70 1.55 1/557 19347
>
>T: 0 (18369) P:99 I:1000 C:  26617 Min:      6 Act:   13 Avg:   12 Max:    1614

Sebastian
