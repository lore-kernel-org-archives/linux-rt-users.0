From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Changing Kernel thread priorities
Date: Tue, 07 Jun 2011 00:36:01 +0200
Message-ID: <1307399761.2497.989.camel@laptop>
References: <4829399.10721.1307362225402.JavaMail.root@WARSBL213.highway.telekom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Monica Puig-Pey <puigpeym@unican.es>,
	Rolando Martins <rolando.martins@gmail.com>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	tglx <tglx@linutronix.de>
To: hannes_bauer@aon.at
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:43048 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754956Ab1FFWc0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Jun 2011 18:32:26 -0400
Received: from j77219.upc-j.chello.nl ([24.132.77.219] helo=dyad.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.76 #1 (Red Hat Linux))
	id 1QTiFu-0007Ja-0t
	for linux-rt-users@vger.kernel.org; Mon, 06 Jun 2011 22:26:42 +0000
In-Reply-To: <4829399.10721.1307362225402.JavaMail.root@WARSBL213.highway.telekom.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

"Monica Puig-Pey" <puigpeym@unican.es> wrote:
> 
> I need to change the priority from inside the driver, when creating the 
> kernel thread.

No you don't. How does you driver know about what priority is correct
wrt all the other running RT tasks on the system?

Determining the right priority in a fixed priority scheduling system is
a system wide problem, nobody but the administrator can possibly even
begin to solve it.

There's a reason all RT irq threads are started at 50, its plain
impossible to do better.

