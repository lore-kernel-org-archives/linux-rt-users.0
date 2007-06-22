From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH -rt] CONFIG_PARAVIRT and CONFIG_MCOUNT don't play well
	together
Date: Fri, 22 Jun 2007 10:33:30 +0200
Message-ID: <20070622083330.GB19382@elte.hu>
References: <20070622080634.GP3723@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Chris Wright <chrisw@sous-sol.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:60740 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751882AbXFVIdf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jun 2007 04:33:35 -0400
Content-Disposition: inline
In-Reply-To: <20070622080634.GP3723@sequoia.sous-sol.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Chris Wright <chrisw@sous-sol.org> wrote:

> Current -rt is broken when compiling with CONFIG_PARAVIRT and 
> CONFIG_MCOUNT both enabled.  Because CONFIG_MCOUNT disables 
> CONFIG_REGPARM, the calling convention must once again be explicit 
> with fastcall.  However, this was only half-way addressed in the -rt 
> patch (adding fastcall back to paravirt_ops function ptr declaration 
> but not the actual function definitions) so the compiled kernel has 
> caller putting stuff in registers and callee pulling things from the 
> stack. Impressive how far into boot it can get despite that ;-) Thanks 
> to Steven Rostedt for prodding me and starting the initial debugging.

thanks! I ran into this before and asked for the fastcalls to not be 
removed from upstream paravirt.c but to no avail it seems. It does no 
harm to anyone to keep the 'fastcall' declarations and definitions for 
places where _actual assembly code_ depends on the calling convention. 
Could someone please send this upstream-wards too?

	Ingo
