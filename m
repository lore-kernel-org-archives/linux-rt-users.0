From: "Remy Bohmer" <linux@bohmer.net>
Subject: Re: [BUG on PREEMPT_RT, 2.6.23.1-rt5] in rt-mutex code and signals
Date: Sat, 17 Nov 2007 23:49:23 +0100
Message-ID: <3efb10970711171449q3907b9a8r91d94832fb5ba701@mail.gmail.com>
References: <3efb10970711160751l279fe99dl9f3a130a4373a449@mail.gmail.com>
	 <3efb10970711161502m6216bf5rc19a34184b4f3a2b@mail.gmail.com>
	 <Pine.LNX.4.58.0711161830570.28002@gandalf.stny.rr.com>
	 <3efb10970711170344n670d8b69w6679d494922c5bb@mail.gmail.com>
	 <1195316550.25393.21.camel@imap.mvista.com>
	 <3efb10970711170909n3acca605j70525e36faf8da7f@mail.gmail.com>
	 <1195320569.25393.38.camel@imap.mvista.com>
	 <20071117174608.GA30641@elte.hu>
	 <1195322141.25393.41.camel@imap.mvista.com>
	 <20071117180430.GA10768@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
To: "Ingo Molnar" <mingo@elte.hu>, "Daniel Walker" <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:54720 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbXKQWtY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 17 Nov 2007 17:49:24 -0500
Received: by py-out-1112.google.com with SMTP id u77so4972753pyb
        for <linux-rt-users@vger.kernel.org>; Sat, 17 Nov 2007 14:49:23 -0800 (PST)
In-Reply-To: <20071117180430.GA10768@elte.hu>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> > Sure, you want to split the list?
>
> split the list with you? Feel free to take any of those :-) dev->sem is
> nontrivial and probably not possible right now - and some of the others
> might be problematic too. But there might be fixable ones in the list.
> This shouldnt become like the BKL conversion - never truly finished.

Hey Ingo and Daniel, Leave some of the fun open for me :-)

I just looked at the list and I found a few that seem doable.


Remy
