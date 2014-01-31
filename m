From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 2/2] timer: really raise softirq if there is irq_work
 to do
Date: Fri, 31 Jan 2014 20:06:06 +0100
Message-ID: <52EBF41E.2010608@linutronix.de>
References: <1391178845-15837-1-git-send-email-bigeasy@linutronix.de>	<1391178845-15837-2-git-send-email-bigeasy@linutronix.de> <20140131120757.594e24d6@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Clark Williams <williams@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56045 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932236AbaAaTGK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 31 Jan 2014 14:06:10 -0500
In-Reply-To: <20140131120757.594e24d6@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 01/31/2014 06:07 PM, Steven Rostedt wrote:
> The bug that I found is that if there *are* active timers, but they
> have not expired yet. Why is this a problem? Because in that case we do

Argh, right. But your patch looks also way better. After I made I was
not too happy about that amount of ifdef and wanted to redo it later.
What you just posted is a way better solution.

Sebastian
