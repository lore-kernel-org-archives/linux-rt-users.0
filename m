From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH RT] - rebalance_domains incorrect parameter
Date: Fri, 24 Aug 2007 11:15:33 +0200
Message-ID: <20070824091533.GA31142@elte.hu>
References: <1187946562.16573.47.camel@sx.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: RT Users List <linux-rt-users@vger.kernel.org>,
	LKML <Linux-kernel@vger.kernel.org>
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:48048 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755415AbXHXJPf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 24 Aug 2007 05:15:35 -0400
Content-Disposition: inline
In-Reply-To: <1187946562.16573.47.camel@sx.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Sven-Thorsten Dietrich <sven@thebigcorporation.com> wrote:

> Same issue has been fixed in mainline by: 
> 
> diff-tree de0cf899bbf06b6f64a5dce9c59d74c41b6b4232 (from
> 5d2b3d3695a841231b65b55
> Author: Oleg Nesterov <oleg@tv-sign.ru>
> Date:   Sun Aug 12 18:08:19 2007 +0200

> signed-off-by: Sven-Thorsten Dietrich <sven@thebigcorporation.com>

ah, you mean we should pick up an upstream fix for -rt? We'll do that 
and we'll pick up much more: all the other ~100 CFS commits that 
happened meanwhile. (Btw., there's no need to sign off on patch 
forwarding or backport requests - the signoff made me first believe this 
is some new patch.)

	Ingo
