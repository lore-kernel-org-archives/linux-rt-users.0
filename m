From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: [PATCH RT] - rebalance_domains incorrect parameter
Date: Sat, 25 Aug 2007 20:32:23 -0700
Message-ID: <1188099143.4412.2.camel@sven.thebigcorporation.com>
References: <1187946562.16573.47.camel@sx.thebigcorporation.com>
	 <20070824091533.GA31142@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: RT Users List <linux-rt-users@vger.kernel.org>,
	LKML <Linux-kernel@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sccrmhc14.comcast.net ([204.127.200.84]:40942 "EHLO
	sccrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641AbXHZDgK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 25 Aug 2007 23:36:10 -0400
In-Reply-To: <20070824091533.GA31142@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2007-08-24 at 11:15 +0200, Ingo Molnar wrote:
> * Sven-Thorsten Dietrich <sven@thebigcorporation.com> wrote:
> 
> > Same issue has been fixed in mainline by: 
> > 
> > diff-tree de0cf899bbf06b6f64a5dce9c59d74c41b6b4232 (from
> > 5d2b3d3695a841231b65b55
> > Author: Oleg Nesterov <oleg@tv-sign.ru>
> > Date:   Sun Aug 12 18:08:19 2007 +0200
> 
> > signed-off-by: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
> 
> ah, you mean we should pick up an upstream fix for -rt?

Well, um yes - I had made the patch a few days ago, but then realized it
was already fixed in mainline.

>  We'll do that 
> and we'll pick up much more: all the other ~100 CFS commits that 
> happened meanwhile. (Btw., there's no need to sign off on patch 
> forwarding or backport requests - the signoff made me first believe this 
> is some new patch.)
> 

Ok. Thanks

Sven
