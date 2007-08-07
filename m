From: Daniel Walker <dwalker@mvista.com>
Subject: Re: Old -rt patches
Date: Mon, 06 Aug 2007 23:01:48 -0700
Message-ID: <1186466508.22044.8.camel@imap.mvista.com>
References: <46B0B7A4.8060805@free.fr>  <46B6E210.9090502@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	mingo@elte.hu, tglx@linutronix.de
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.158]:4845 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbXHGGGZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Aug 2007 02:06:25 -0400
In-Reply-To: <46B6E210.9090502@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2007-08-06 at 10:55 +0200, John Sigler wrote:
> John Sigler wrote:
> 

> Would anyone care to comment?

I'm not sure if this is the answer that you looking for, but yes you
certainly will find fixed bug is older version of the tree.

> Perhaps I could also test a different strategy, such as xenomai?
> http://www.xenomai.org/

If it's a kernel bug it's not going to matter if you use a xenomai skin
or not.. If you use some other real time layer that might fix it ..

you really need to test your app on a current version of the kernel ..
We as developers generally don't support out dated trees..

Daniel
