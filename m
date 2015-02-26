From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.18.7-rt2
Date: Thu, 26 Feb 2015 11:53:04 +0100
Message-ID: <20150226105304.GB12992@linutronix.de>
References: <20150223090617.GA26453@linutronix.de>
 <1424785301.8767.11.camel@gmail.com>
 <CAA8Xd+9QEn0XE2pV-7fW0cBXKBSK9=oZyTaFH2urGvJLGb=gFw@mail.gmail.com>
 <1424937725.3622.31.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Gustavo Bittencourt <gbitten@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424937725.3622.31.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Mike Galbraith | 2015-02-26 09:02:05 [+0100]:

>I found what was breaking my core2 lappy in 4.0-rt as well, namely the
4.0-rt? So you are a time traveler?

>locking, ww_mutex: fix ww_mutex vs self-deadlock
>
>If the caller already holds the mutex, task_blocks_on_rt_mutex()
>returns -EDEADLK, we proceed directly to rt_mutex_handle_deadlock()
>where it's instant game over.

The EDDEADLK / ELREADY seem to got broken duering the rtmutex rework.
Now I see:
| Wound/wait tests |
---------------------
                ww api failures:  ok  |  ok  |  ok  |
             ww contexts mixing:  ok  |  ok  |
           finishing ww context:  ok  |  ok  |  ok  |  ok  |
             locking mismatches:  ok  |  ok  |  ok  |
               EDEADLK handling:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         spinlock nest unlocked:  ok  |

with no backtrace from the ww code which I haven't seen before that
patch. Applied.

Sebastian
