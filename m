From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: cyclic test results on 8 way (2.6.23.1-rt7 through 2.6.23.1-rt11)
Date: Tue, 13 Nov 2007 09:15:03 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0711130914500.369@gandalf.stny.rr.com>
References: <200711072334.40216.dvhltc@us.ibm.com>
 <1985e0f60711130540j43eac275p4f77bb373bb4c958@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Darren Hart <dvhltc@us.ibm.com>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Gregory Haskins <ghaskins@novell.com>
To: Jaswinder Singh <jaswinderlinuxrt@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-05.nyroc.rr.com ([24.24.2.59]:61734 "EHLO
	ms-smtp-05.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089AbXKMOPw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 Nov 2007 09:15:52 -0500
In-Reply-To: <1985e0f60711130540j43eac275p4f77bb373bb4c958@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On Tue, 13 Nov 2007, Jaswinder Singh wrote:

> On Nov 8, 2007 1:04 PM, Darren Hart <dvhltc@us.ibm.com> wrote:
> > # ./cyclictest -n -i 10000 -l 10000 -p 95
>
> 10000 (10 milliseconds) interval seems to be quite big for current
> machine. 10 milliseconds is good for 10 to 15 years old machine but
> not for latest machines.
>
> I think we should try -i 1000 or -i 4000 .
>

heh, I test with -i 250.

-- Steve
