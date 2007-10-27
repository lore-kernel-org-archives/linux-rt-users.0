From: "Jaswinder Singh" <jaswinderlinux@gmail.com>
Subject: Re: [2.6.23-rt3] NMI watchdog trace of deadlock
Date: Sat, 27 Oct 2007 15:42:32 +0530
Message-ID: <3f9a31f40710270312o5a4eb79exa67ed63b4f084f9e@mail.gmail.com>
References: <1193245634.20679.8.camel@localhost.localdomain>
	 <1193462494.25330.7.camel@Homer.simpson.net>
	 <200710271915.42363.nickpiggin@yahoo.com.au>
	 <20071027094407.GA12047@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>,
	"Mike Galbraith" <efault@gmx.de>,
	"Steven Rostedt" <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>
To: "Ingo Molnar" <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:34816 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbXJ0KMp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Oct 2007 06:12:45 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1332740wah
        for <linux-rt-users@vger.kernel.org>; Sat, 27 Oct 2007 03:12:44 -0700 (PDT)
In-Reply-To: <20071027094407.GA12047@elte.hu>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Ingo,

On 10/27/07, Ingo Molnar <mingo@elte.hu> wrote:
>
> it's not atomic interrupt context but irq thread context - and -rt
> remaps kmap_atomic() to kmap() internally.
>
> the problem seems to be what Mike's patch works around: fiddling with
> irq flags in the ntfs code. That fiddling seems quite unnecessary at
> first sight.
>

Is this a nice idea to go inside device drivers and filesystem and
make changes in kernel source code to enable RT.

RT related change should be in header files, so that we don't need to
make changes for drivers or filesystem source files.

And when user will disable RT then these patches will again make problems.

We need to find some better alternative.

Thank you,

Jaswinder Singh.
