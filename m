From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [Announce] 2.6.29-rc6-rt3
Date: Wed, 25 Feb 2009 19:43:19 +0100
Message-ID: <1235587399.4645.3789.camel@laptop>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain>
	 <alpine.LFD.2.00.0902122353050.16972@localhost.localdomain>
	 <alpine.LFD.2.00.0902231854360.3523@localhost.localdomain>
	 <alpine.LFD.2.00.0902241849230.3523@localhost.localdomain>
	 <alpine.LFD.2.00.0902241856480.9135@localhost.localdomain>
	 <1235590444.3907.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Carsten Emde <ce@ceag.ch>, Clark Williams <williams@redhat.com>
To: Thomas Meyer <thomas@m3y3r.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:59037 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755123AbZBYSnk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Feb 2009 13:43:40 -0500
In-Reply-To: <1235590444.3907.5.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2009-02-25 at 20:34 +0100, Thomas Meyer wrote:
> Am Dienstag, den 24.02.2009, 18:57 +0100 schrieb Thomas Gleixner:

> >   http://www.kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.29-rc6.tar.bz2
> >   http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.29-rc6-rt3.bz2
> >   

> Should suspend&resume to ram work with this patchset applied?

If it works for you without (plain .29-rc6), then it ought to work with.

