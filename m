From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH RT] - trivial branch in scheduler.
Date: Fri, 24 Aug 2007 10:32:22 +0200
Message-ID: <20070824083222.GA22260@elte.hu>
References: <1187943548.16573.10.camel@sx.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: RT Users List <linux-rt-users@vger.kernel.org>,
	LKML <Linux-kernel@vger.kernel.org>,
	Peter Williams <pwil3058@bigpond.net.au>
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:56748 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764251AbXHXIcd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 24 Aug 2007 04:32:33 -0400
Content-Disposition: inline
In-Reply-To: <1187943548.16573.10.camel@sx.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Sven-Thorsten Dietrich <sven@thebigcorporation.com> wrote:

> 
> Hi Ingo,
> 
> the trivial code is in various RT patches as well as in 2.6.23-rc git's
> scheduler.
> 
> Thanks
> 
> Sven
> 
> Remove trivial conditional branch in Linux RT CFS 
> scheduler's can_migrate_task function.
> 
> signed-off-by: Sven-Thorsten Dietrich <sven@thebigcorporation.com>

thanks, applied.

	Ingo
