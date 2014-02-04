From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [ANNOUNCE] 3.12.9-rt13
Date: Tue, 04 Feb 2014 16:03:38 +0100
Message-ID: <1391526218.5532.33.camel@marge.simpson.net>
References: <20140203194841.GA17108@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140203194841.GA17108@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2014-02-03 at 20:48 +0100, Sebastian Andrzej Siewior wrote:

> Known issues:

> Mike said that it caused two of his 64 CPUs to spin for five minutes
>         doing nothing. Therefore it is disabled in the queue. Everyone
>         who wants test it may do so :)

I put rt13 on an 8 socket Opetron (48 core) box, with patch enabled.  It
box did NOT reproduce the hangs the 8 socket (1 node, bleh) DL980 did.

Nor did it explode running hotplug stress, but then it deadlocks before
BOOM would have happened on the DL980.  kdump isn't working properly on
this box (not an rt issue, userspace), so..

-Mike
