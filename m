From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.25.4-rt2 compile errors on ARM due to cmpxchg() problems.
Date: Tue, 20 May 2008 10:34:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0805201034130.1838@gandalf.stny.rr.com>
References: <3efb10970805200721u6a837a2ap94ead54f7eb7bf89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, lvcargnini@gmail.com,
	Thomas Gleixner <tglx@linutronix.de>
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:59303 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756149AbYETOez (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 May 2008 10:34:55 -0400
In-Reply-To: <3efb10970805200721u6a837a2ap94ead54f7eb7bf89@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Tue, 20 May 2008, Remy Bohmer wrote:

> Hello Steven,
>
> I want to test 2.6.25.4-rt2 on ARM, but unfortunately I run into
> several compile errors.
> All errors seem to be related to cmpxchg routines -> duplicate
> definitions or missing BUILD_BUG_ON() or typecheck() macros.
> I already figured out the missing BUILD_BUG_ON() + typecheck() problem
> which is caused by including a header
> 'include/asm-generic/cmpxchg-local.h' in linux/kernel.h before these
> macros are defined in linux/kernel.h. See below for a piece/snippet of
> the compiler output.
>
> Looking deeper into this, things look quite messy around cmpxchg() on ARM...
>
> Any ideas what has been changed here, and why these things can go
> wrong so badly?
>

No idea right off the bat. But I may be needing to set up a ARM
crosscompiler. Unless Thomas would like to take a look into this.

Thomas?

-- Steve

