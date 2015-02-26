From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH -rt] lockdep: selftest: fix warnings due to missing
 PREEMPT_RT conditionals
Date: Thu, 26 Feb 2015 15:14:42 +0100
Message-ID: <20150226141442.GE12992@linutronix.de>
References: <1422472125-21979-1-git-send-email-xander.huff@ni.com>
 <54C94F73.3010006@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org, josh.cartwright@ni.com,
	gratian.crisan@ni.com, linux-kernel@vger.kernel.org,
	jaeden.amero@ni.com, ben.shelton@ni.com, brad.mouring@ni.com,
	rich.tollerton@ni.com
To: Xander Huff <xander.huff@ni.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54C94F73.3010006@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Xander Huff | 2015-01-28 15:06:59 [-0600]:

>>Fixed by wrapping the test definitions in #ifndef CONFIG_PREEMPT_RT_FULL
>>conditionals.
>>
>FYI: To be clearer, this should apply to all stable RT releases 3.4 and later.

Applied

Sebastian
