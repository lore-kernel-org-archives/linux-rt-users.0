From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] kernel/hrtimer: be non-freezeable in cpu_chill()
Date: Wed, 19 Feb 2014 16:42:13 +0100
Message-ID: <5304D0D5.3030802@linutronix.de>
References: <20140205115125.3cc950ce@gandalf.local.home>	<20140207113006.GD23668@linutronix.de>	<20140207090834.72774272@gandalf.local.home>	<20140207091313.097f9059@gandalf.local.home>	<20140219115353.GA28909@linutronix.de> <20140219102700.04de1195@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	John Kacur <jkacur@redhat.com>,
	Ulrich Obergfell <uobergfe@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52307 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758AbaBSPmQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Feb 2014 10:42:16 -0500
In-Reply-To: <20140219102700.04de1195@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 02/19/2014 04:27 PM, Steven Rostedt wrote:

> Hmm, I wonder if this is because msleep() sets the tasks state to
> TASK_UNINTERRUPTIBLE, and hrtimer_nanosleep sets it to
> TASK_INTERRUPTIBLE.

No, it is because freezable_schedule() is called via do_nanosleep() in
hrtimer call path and msleep() calls schedule() without it.

Sebastian
