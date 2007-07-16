From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [Question] Hooks for scheduler tracing (CFS)
Date: Mon, 16 Jul 2007 23:12:22 +0200
Message-ID: <20070716211222.GA18661@elte.hu>
References: <3efb10970707161246se06ab22i32872cfe6fa4f2f6@mail.gmail.com> <1184615557.2698.3.camel@laptopd505.fenrus.org> <3efb10970707161317h72b30aabq208150b2abde8e5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Arjan van de Ven <arjan@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	RT-Users <linux-rt-users@vger.kernel.org>,
	mathieu.desnoyers@polymtl.ca
To: linux@bohmer.net
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:53535 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706AbXGPVM3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Jul 2007 17:12:29 -0400
Content-Disposition: inline
In-Reply-To: <3efb10970707161317h72b30aabq208150b2abde8e5e@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Remy Bohmer <l.pinguin@gmail.com> wrote:

> Hello Arjan,
> 
> Thanks for this suggestion.

(please dont top-post, ever. See:
 www.zipworld.com.au/~akpm/linux/patches/stuff/top-posting.txt)

> But I looked at Systemtap before, and as I remember, it is very 
> flexible, but it only traces function calls. (or am I missing 
> something?)

systemtap it should be able to trace variables as well. (as long as 
those variables are not eliminated by gcc)

	Ingo
