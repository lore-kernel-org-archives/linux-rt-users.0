From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.25.8-rt7
Date: Tue, 24 Jun 2008 13:33:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0806241332460.4608@gandalf.stny.rr.com>
References: <1214271257.8701.17.camel@localhost.localdomain>
 <200806241654.58857.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Juergen Beisert <jbe@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:50457 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074AbYFXRdB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jun 2008 13:33:01 -0400
In-Reply-To: <200806241654.58857.jbe@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Tue, 24 Jun 2008, Juergen Beisert wrote:

> On Tuesday 24 June 2008 03:34, Steven Rostedt wrote:
> >   http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.25.tar.bz2
> >   http://kernel.org/pub/linux/kernel/v2.6/patch-2.6.25.8.bz2
> >   http://rt.et.redhat.com/download/patch-2.6.25.8-rt7.bz2
>
> And for ARM I get a bunch of these warnings:
>
> [...]
> include/asm/atomic.h:241:1: warning: "cmpxchg" redefined
> [...]
> include/asm-generic/cmpxchg.h:19:1: warning: this is the location of the previous definition
> [...]
>
>
> Can I ignore them?
>

This is a Thomas question.

-- Steve

