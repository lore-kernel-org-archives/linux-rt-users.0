From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 3.14.25-rt22 1/2] rtmutex Real-Time Linux: Fixing kernel
 BUG at kernel/locking/rtmutex.c:997!
Date: Fri, 6 Mar 2015 13:19:21 +0100
Message-ID: <20150306121921.GA10155@linutronix.de>
References: <1424395866-81589-1-git-send-email-tmac@hp.com>
 <1424395866-81589-2-git-send-email-tmac@hp.com>
 <20150223133719.2b7c604e@gandalf.local.home>
 <54EBC2DB.3050904@hp.com>
 <20150223195743.546b2ef0@grimm.local.home>
 <20150226135630.GD12992@linutronix.de>
 <20150226090610.7eb0ac61@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>,
	Thavatchai Makphaibulchoke <tmac@hp.com>,
	linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
	linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150226090610.7eb0ac61@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Steven Rostedt | 2015-02-26 09:06:10 [-0500]:

>If we can pull that off and remove all rtmutex trylocks from hardirq
>context, I would much rather do that.
>
>This hocus pocus coding is just going to lead us down the path of the
>black arts. I already have a black cat, so I'm good to go.

Okay. So what is the fix for v3.14 and other trees where the rtmutex
reworked has been integrated? Revert the optimization like I did in
v3.18?

Sebastian
