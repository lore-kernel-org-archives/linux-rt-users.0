From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Subject: [PATCH 2/2] priority System V Semaphores
Date: Thu, 22 Dec 2011 09:59:12 +0100
Message-ID: <1324544352.24803.9.camel@twins>
References: <1324419795.20886.3.camel@raz>
	 <4EF2261F.4050002@colorfullife.com> <1324500515.5467.18.camel@raz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Manfred Spraul <manfred@colorfullife.com>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lior Brafman <LBrafman@manz.com>,
	Torsten Scherer <TScherer@manz.com>,
	Rasty Slutsker <RSlutsker@manz.com>
To: raz ben yehuda <raziebe@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:58157 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536Ab1LVI7Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Dec 2011 03:59:25 -0500
In-Reply-To: <1324500515.5467.18.camel@raz>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2011-12-21 at 22:48 +0200, raz ben yehuda wrote:
> Vxworks is the use case. And there are plenty of companies with
> vxWorks software and in i believe they will migrate sooner or later to
> PreemptRT.  My current company uses old wrapper software that implements
> vxWorks semaphores as system V semaphores. vxWorks semaphores have a priority
> feature which is widely used.
> I will probably change it some time in the future to posix semaphores , but posix 
> semaphores are implemented in glibc with futexes and atomic ops and i rather 
> mess with kernel and not glibc. funny , but true. glibc is harder. 

Semaphores are a fscking trainwreck for real-time programming. Don't use
them, full stop. If you do, you're doing it wrong, it's really that
simple.

Use PI mutexes, which are already fully supported in glibc, no extra
patching needed.

Full NAK for any and all priority fudging for any semaphore
implementation.
