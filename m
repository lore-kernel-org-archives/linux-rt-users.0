From: "Andrew Victor" <avictor.za@gmail.com>
Subject: Re: [PATCH]: Atmel Serial Console interrupt handler splitup
Date: Thu, 13 Dec 2007 19:33:46 +0200
Message-ID: <cd73a99e0712130933s6f601ef7sed90f48c08d9adaa@mail.gmail.com>
References: <3efb10970712070724i6fa66666t2b8422329759ce24@mail.gmail.com>
	 <Pine.LNX.4.58.0712121606241.23712@gandalf.stny.rr.com>
	 <3efb10970712121429l7b41d57md4f826f6aaf4b71@mail.gmail.com>
	 <3efb10970712130840r7a2c5f72jca641d1cac545464@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
	"Andrew Victor" <linux@maxim.org.za>,
	RT <linux-rt-users@vger.kernel.org>,
	"Ingo Molnar" <mingo@elte.hu>,
	"Thomas Gleixner" <tglx@linutronix.de>
To: "Remy Bohmer" <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.227]:42630 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760409AbXLMRdy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 Dec 2007 12:33:54 -0500
Received: by nz-out-0506.google.com with SMTP id s18so424301nze.1
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Dec 2007 09:33:47 -0800 (PST)
In-Reply-To: <3efb10970712130840r7a2c5f72jca641d1cac545464@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

hi Remy,

> These patches should go to mainline:
> * atmel_serial_cleanup_no_at91.patch

I don't know what coding rules you're following...   :)

The code you've moved out of the interrupt handler should probably now
be marked as inline.

Regards,
  Andrew Victor
