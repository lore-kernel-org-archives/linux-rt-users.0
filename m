From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.23-rc9-rt2
Date: Mon, 8 Oct 2007 09:52:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710080951270.4846@gandalf.stny.rr.com>
References: <1191536413.5210.19.camel@localhost.localdomain>
 <1985e0f60710070635l7016bad1t9c4d4cb1a966534f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Jaswinder Singh <jaswinderlinuxrt@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:61300 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbXJHNwm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Oct 2007 09:52:42 -0400
In-Reply-To: <1985e0f60710070635l7016bad1t9c4d4cb1a966534f@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
On Sun, 7 Oct 2007, Jaswinder Singh wrote:

> Do you have any plans to support nested or reentrant Interrupt Handling schemes.
>

Hi Jaswinder,

Not sure what you mean by this, since interrupt handlers are run as
threads and are fully preemptible.

-- Steve
