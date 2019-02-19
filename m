From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 1/2] softirq: Avoid "local_softirq_pending" messages
 if ksoftirqd is blocked
Date: Tue, 19 Feb 2019 17:28:41 +0100
Message-ID: <20190219162841.rypvpb6p3fd75zwv@linutronix.de>
References: <20190218163107.iwdpngwmbs6xyk7x@linutronix.de>
 <20190219145826.GH21785@localhost.localdomain>
 <20190219160606.jwjrgf6nxarnd2wt@linutronix.de>
 <20190219162741.GI21785@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
To: Juri Lelli <juri.lelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190219162741.GI21785@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2019-02-19 17:27:41 [+0100], Juri Lelli wrote:
> It is better. Warning message doesn't appear anymore.

Okay, thanks.

Sebastian
