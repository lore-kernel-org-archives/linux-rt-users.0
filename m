From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH][RT] tracing: Show padding as unsigned short
Date: Mon, 21 Nov 2011 11:11:00 -0500
Message-ID: <1321891860.20742.12.camel@frodo>
References: <1321467575.4181.36.camel@frodo>
	 <CAONaPpF_urAKGRLy2Xv4ZXfDd7gT11jhdeOHpT2rjG42KW8Pcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:42960 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755377Ab1KUQLC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Nov 2011 11:11:02 -0500
In-Reply-To: <CAONaPpF_urAKGRLy2Xv4ZXfDd7gT11jhdeOHpT2rjG42KW8Pcw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 2011-11-19 at 14:09 +0100, John Kacur wrote:

> 
> This one should also be included in 3.0.9-rt26
> Thanks

Yes it was added in -rt3, where my stable was based on -rt2. My scripts
picked it up when I ran it against -rt3.

-- Steve


