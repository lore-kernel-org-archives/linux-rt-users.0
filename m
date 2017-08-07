From: Mike Galbraith <efault@gmx.de>
Subject: Re: [ANNOUNCE] v4.11.12-rt9
Date: Mon, 07 Aug 2017 10:38:54 +0200
Message-ID: <1502095134.5568.27.camel@gmx.de>
References: <20170804173823.lzuhnejlnxczr2lj@linutronix.de>
         <1501913583.7917.42.camel@gmx.de>
         <20170807075254.pdu7immtbakn7f7g@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170807075254.pdu7immtbakn7f7g@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2017-08-07 at 09:52 +0200, Sebastian Andrzej Siewior wrote:
> 
> can you reproduce that one? I don't see where this TASK_UNINTERRUPTIBLE
> is coming from.

Yup, x3550 just reproduced nearly instantly.

	-Mike
