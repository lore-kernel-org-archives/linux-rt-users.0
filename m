From: "Remy Bohmer" <linux@bohmer.net>
Subject: Re: How to control IRQ thread priority from inside the driver
Date: Fri, 10 Aug 2007 22:20:24 +0200
Message-ID: <3efb10970708101320l79179b3eu652a82ed52731d99@mail.gmail.com>
References: <200708081514.31864.jbe@pengutronix.de>
	 <200708081409.28105.dvhltc@us.ibm.com>
	 <200708091610.58134.jbe@pengutronix.de>
	 <200708091128.44043.dvhltc@us.ibm.com>
	 <3efb10970708100421s1f058d45qa7c9c7b265c0933d@mail.gmail.com>
	 <Pine.LNX.4.58.0708101112490.20808@gandalf.stny.rr.com>
	 <3efb10970708100900q6f799f4cmd72d9f6abc27f7fe@mail.gmail.com>
	 <Pine.LNX.4.58.0708101209350.21632@gandalf.stny.rr.com>
	 <3efb10970708101247k30d375a6p274b8ae37fcedca7@mail.gmail.com>
	 <Pine.LNX.4.58.0708101555290.24727@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Darren Hart" <dvhltc@us.ibm.com>, "Ingo Molnar" <mingo@elte.hu>,
	linux-rt-users@vger.kernel.org
To: "Steven Rostedt" <rostedt@goodmis.org>,
	"Juergen Beisert" <jbe@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:37347 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765667AbXHJUU0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Aug 2007 16:20:26 -0400
Received: by py-out-1112.google.com with SMTP id d32so1526965pye
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Aug 2007 13:20:25 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.58.0708101555290.24727@gandalf.stny.rr.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Steven,

>> Arnaldo mentioned to use the irq-name for this, and to me this sounds good.
>Yeah, that wouldn't be too hard to implement.

I am going to take a look at it... I can propose a patch in a few days
to a week...

I hope Juergen also thinks this is a good idea?

> I've been developing Ingo's patches for a few years now too.  I'm one of
> the authors of the rt-mutex.c code.  Actually, I started out on RT Linux
> programing as a kernel developer at TimeSys working on their Linux 2.2

I already thought I saw your name listed somewhere ;-))))

> port.  Now I'm at Red Hat with Ingo, but I'm on other projects that keep

This is **really** a small world ;-)

Remy
