From: Christoph Lameter <cl@linux-foundation.org>
Subject: Re: RFC: THE OFFLINE SCHEDULER
Date: Tue, 25 Aug 2009 14:03:17 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0908251402300.17963@gentwo.org>
References: <1250983671.5688.21.camel@raz>  <1251004897.7043.70.camel@marge.simson.net> <1251018551.3810.35.camel@raz>  <1251012621.14003.71.camel@marge.simson.net> <1251025557.3810.65.camel@raz>  <1251021133.14003.172.camel@marge.simson.net>
 <alpine.DEB.1.10.0908251122020.26329@gentwo.org> <1251222993.7023.53.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: raz ben yehuda <raziebe@gmail.com>, riel@redhat.com, mingo@elte.hu,
	peterz@infradead.org, andrew motron <akpm@linux-foundation.org>,
	wiseman@macs.biu.ac.il, lkml <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp4.ultrahosting.com ([74.213.175.253]:42524 "EHLO
	smtp.ultrahosting.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755500AbZHYSEM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 25 Aug 2009 14:04:12 -0400
In-Reply-To: <1251222993.7023.53.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 25 Aug 2009, Mike Galbraith wrote:

> I asked the questions I did out of pure curiosity, and that curiosity
> has been satisfied.  It's not that I find it useless or whatnot (or that
> my opinion matters to anyone but me;).  I personally find the concept of
> injecting an RTOS into a general purpose OS with no isolation to be
> alien.  Intriguing, but very very alien.

Well lets work on the isolation piece then. We could run a regular process
on the RT cpu and switch back when OS services are needed?

