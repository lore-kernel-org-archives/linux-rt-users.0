From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Ethernet transmit timeouts
Date: Sun, 10 Dec 2006 09:27:59 +0100
Message-ID: <20061210082759.GA17544@elte.hu>
References: <20061205171114.GA25926@elte.hu> <4579BFC6.6000605@gmail.com> <1165608924.24604.342.camel@localhost.localdomain> <457A6B73.2060904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tglx@linutronix.de, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:49116 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760462AbWLJI3o (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 10 Dec 2006 03:29:44 -0500
To: Dirk Behme <dirk.behme@googlemail.com>
Content-Disposition: inline
In-Reply-To: <457A6B73.2060904@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Dirk Behme <dirk.behme@googlemail.com> wrote:

> > Also please enable CONFIG_PROVE_LOCKING in the kernel hacking 
> > section.
> 
> Looks like CONFIG_PROVE_LOCKING isn't available on ARM? PROVE_LOCKING 
> depens on STACKTRACE_SUPPORT && LOCKDEP_SUPPORT. These are available 
> only on i386, x86_64 and MIPS?

iirc RMK had prototype lockdep code for ARM - maybe ask him for that?

	Ingo
