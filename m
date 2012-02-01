From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.0.14-rt31 - ksoftirq running wild - FEC ethernet
 driver to blame? Yep
Date: Wed, 01 Feb 2012 15:27:43 -0500
Message-ID: <1328128063.5882.80.camel@gandalf.stny.rr.com>
References: <1324525237.5916.114.camel@gandalf.stny.rr.com>
	 <201201181211.45011.tim.sander@hbm.com>
	 <201201241152.21472.tim.sander@hbm.com>
	 <201201251031.48983.tim.sander@hbm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Mike Galbraith <efault@gmx.de>,
	Tim Sander <tstone@iss.tu-darmstadt.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Gerlando Falauto <gerlando.falauto@keymile.com>,
	Micha Nelissen <micha@neli.hopto.org>,
	Holger Brunck <holger.brunck@keymile.com>
To: Tim Sander <tim.sander@hbm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:49417 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605Ab2BAU1q (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Feb 2012 15:27:46 -0500
In-Reply-To: <201201251031.48983.tim.sander@hbm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2012-01-25 at 10:31 +0100, Tim Sander wrote:

> Bad news, the ksoftirq(sirq-net-tx) error seems to happen not so often any 
> more but it still happens :-(.

Tim,

Is the system still usable when this happens? If so, can you configure
in ftrace, and run a trace on what ksoftirq is doing:

mkdir /debug
mount -t debugfs nodev /debug
cd /debug/tracing
echo <pid-of-ksoftirq> > set_ftrace_pid
echo function > current_tracer
cat trace

Thanks!

-- Steve


