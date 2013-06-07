From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.8.11-rt8 NFS triggered seizures
Date: Fri, 7 Jun 2013 11:03:00 +0200
Message-ID: <20130607090300.GC10280@linutronix.de>
References: <1368437465.11686.60.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: RT <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45096 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753887Ab3FGJDB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Jun 2013 05:03:01 -0400
Content-Disposition: inline
In-Reply-To: <1368437465.11686.60.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Mike Galbraith | 2013-05-13 11:31:05 [+0200]:

>Letting my little Toshiba Satellite download an opensuse install DVD (at
>20 KiB/s so I can use the other half of my wonderful bandwidth for

Didn't they say, that the won't shape their custimers for the next two
years?

>When make modules_install install hung first thing this morning, box was
>responsive enough to fire up top, which displayed nada.  Desktop then
>froze, so I crashed it.  Seems completion ain't gonna happen.

The "panic" says "Oops" so your karnel most likely hit a NULL pointer.
The completion you say is missing might run into the NULL pointer
problem. Any way to get the backtrace from the oops?

Sebastian
