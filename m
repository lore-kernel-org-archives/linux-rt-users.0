From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Null pointer 4.14.1-rt3
Date: Thu, 30 Nov 2017 11:35:33 -0500
Message-ID: <20171130113533.4485d894@gandalf.local.home>
References: <80ce7c3e-2d01-f082-9c21-fc1084a836c8@monom.org>
        <8c913cc2-b2e3-8c2e-e503-aff1428f8ff5@monom.org>
        <20171130112232.4c0cb600@gandalf.local.home>
        <20171130162433.GG11362@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Daniel Wagner <wagi@monom.org>, linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752926AbdK3Qff (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Nov 2017 11:35:35 -0500
In-Reply-To: <20171130162433.GG11362@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 30 Nov 2017 17:24:34 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2017-11-30 11:22:32 [-0500], Steven Rostedt wrote:
> > On Thu, 30 Nov 2017 16:11:22 +0100
> > Daniel Wagner <wagi@monom.org> wrote:
> > 
> > Is it compiled for non SMP? That push pull logic shouldn't be called.  
> 
> SMP compiled.

Hmm, I'm not sure I tested this on a UP machine. Perhaps I should boot
with CPUs=1

-- Steve
