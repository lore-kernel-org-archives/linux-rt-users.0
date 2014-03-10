From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] fs: jbd2: pull your plug when waiting for space
Date: Mon, 10 Mar 2014 18:41:39 +0100
Message-ID: <531DF953.7050005@linutronix.de>
References: <20140221123253.GA12822@linutronix.de> <20140310132602.6d4b0e53@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mike Galbraith <bitbucket@online.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	tglx@linutronix.de
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140310132602.6d4b0e53@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 03/10/2014 06:26 PM, Steven Rostedt wrote:
> I'm a little confused. Is this only needed for 3.12-rt? I see that you
> did not mark it for stable.

it supposed to go stable. Sorry about the missing tag.

> -- Steve

Sebastian
