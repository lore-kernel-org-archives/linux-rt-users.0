From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: PI mutex support on ARM
Date: Mon, 09 Jul 2007 07:46:06 -0700
Message-ID: <1183992366.2668.0.camel@laptopd505.fenrus.org>
References: <3efb10970707080124i7a9323c5o9257b4adcb2ac493@mail.gmail.com>
	 <20070708095841.GA4601@elte.hu>
	 <3efb10970707081317k22de079dr9a5cad6a42cf5b3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: linux@bohmer.net
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:47894 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbXGIOqf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Jul 2007 10:46:35 -0400
In-Reply-To: <3efb10970707081317k22de079dr9a5cad6a42cf5b3b@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, 2007-07-08 at 22:17 +0200, Remy Bohmer wrote:
> Hello Ingo,
> 
> > patch format problem: never diff the asm/ files, diff the asm-arm/ files.
> Yeah, of course, I know, I believe I made a real mess of this one ...
> 
> > is it safe to do a get_user() with irqs off?
> rhetorical question ;-))
> I was wondering, Is it safe to use a normal spinlock here, like this?

if get_user() isn't allowed with irq's off (and in general it's not,
maybe arm is special) then it also isn't allowed with spinlocks held..
