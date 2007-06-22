From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -rt] CONFIG_PARAVIRT and CONFIG_MCOUNT don't play well
	together
Date: Fri, 22 Jun 2007 08:43:42 -0400
Message-ID: <1182516222.5493.33.camel@localhost.localdomain>
References: <20070622080634.GP3723@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Chris Wright <chrisw@sous-sol.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-05.nyroc.rr.com ([24.24.2.59]:41611 "EHLO
	ms-smtp-05.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753571AbXFVMnx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jun 2007 08:43:53 -0400
In-Reply-To: <20070622080634.GP3723@sequoia.sous-sol.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2007-06-22 at 01:06 -0700, Chris Wright wrote:
> Current -rt is broken when compiling with CONFIG_PARAVIRT and
> CONFIG_MCOUNT both enabled.  Because CONFIG_MCOUNT disables
> CONFIG_REGPARM, the calling convention must once again be explicit
> with fastcall.  However, this was only half-way addressed in the -rt
> patch (adding fastcall back to paravirt_ops function ptr declaration but
> not the actual function definitions) so the compiled kernel has caller
> putting stuff in registers and callee pulling things from the stack.
> Impressive how far into boot it can get despite that ;-)  Thanks to
> Steven Rostedt for prodding me and starting the initial debugging.

Chris, thanks a hell of a lot for looking into this!!!

-rt doesn't do much with paravirt, but since both -rt and lguest are two
things I love to play with, it was really bothering me that they were
not getting along.

Much appreciated!

-- Steve
