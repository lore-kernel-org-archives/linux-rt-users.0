From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [ANNOUNCE] 4.4.1-rt6
Date: Mon, 15 Feb 2016 18:25:05 +0100
Message-ID: <1455557105.7777.11.camel@gmail.com>
References: <20160212234708.GB7694@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160212234708.GB7694@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 2016-02-13 at 00:47 +0100, Sebastian Andrzej Siewior wrote:

> Known issues:
>   - bcache stays disabled
> 
>   - CPU hotplug got a little better but can deadlock.

My x86_64 desktop box survived 100 iterations of Steven's script.  If
my 64 core box survives, I'll be amazed, but it definitely is better. 
 I don't cringe _as_ much when I use it ;-)

	-Mike
