From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: 2.6.27.5 RT patch status (26rt11)
Date: Fri, 21 Nov 2008 15:56:52 -0200
Message-ID: <20081121175652.GD20958@ghostprotocols.net>
References: <20081110234740.GB18819@windriver.com> <20081120132544.GG30491@ghostprotocols.net> <20081120132910.GH30491@ghostprotocols.net> <63a49ef40811200543m75bb49deu4dc1c861b226c481@mail.gmail.com> <20081120141926.GK30491@ghostprotocols.net> <20081120144450.GL30491@ghostprotocols.net> <63a49ef40811210925o3e5a74a1maf90d2c1fb7ccf5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	linux-rt-users@vger.kernel.org
To: Alessio Igor Bogani <abogani@texware.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:57211 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752887AbYKUR5E (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Nov 2008 12:57:04 -0500
Content-Disposition: inline
In-Reply-To: <63a49ef40811210925o3e5a74a1maf90d2c1fb7ccf5d@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Em Fri, Nov 21, 2008 at 06:25:59PM +0100, Alessio Igor Bogani escreveu:
> Dear Sir Carvalho de Melo,
> 
> 2008/11/20 Arnaldo Carvalho de Melo <acme@redhat.com>:
> [...]
> > RIP  [<ffffffff8105d5d9>] wakeup_next_waiter+0x35/0x173
> 
> Do you incur in this bug systematically every time boot your machine?

Nope, it was just once, after fixing that NR_CPUS problem I had that
trucated output bug, then rebooting got to this one. But then I was
sidetracked with other stuff, will try to get back to this soon.

- Arnaldo
