From: Philipp Schrader <philipp@peloton-tech.com>
Subject: Re: RCU splat on boot from an idle CPU
Date: Fri, 11 Dec 2015 08:46:13 -0800
Message-ID: <CA+0CQ22gEUOzLqwLiLLBD=S-d_bVhEbz4UnbS=7udUttFhExxQ@mail.gmail.com>
References: <CA+0CQ216LKjL4-PVeqW3vwZhvFLhRJ2GuTOfVsEvxtoZ=xoVgQ@mail.gmail.com>
	<alpine.DEB.2.11.1509011721510.15006@nanos>
	<20150902153823.749a9f73@gandalf.local.home>
	<CA+0CQ20mdGqWn6+rsA+Q6LWiDotXW=GUj-xmWBKcCrvHC=Z_vA@mail.gmail.com>
	<20150902230729.GZ4029@linux.vnet.ibm.com>
	<20150903165411.GA25462@philipp-debian.peloton-tech.com>
	<20151211163252.GE6720@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:35149 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbbLKQqO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Dec 2015 11:46:14 -0500
Received: by lbpu9 with SMTP id u9so67087376lbp.2
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Dec 2015 08:46:13 -0800 (PST)
In-Reply-To: <20151211163252.GE6720@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Dec 11, 2015 at 8:32 AM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> Did someone in the meantime sent a patch? It does not look so.
> If this patch gets re-sent witch a changelog and gets acked by Paul/Steven I
> don't see a problem why I should not include it.
>
> Sebastian

I sent out a patch here:
http://lkml.iu.edu/hypermail/linux/kernel/1509.0/02788.html
Though I never received a response.
Shall I re-send it?
Philipp
