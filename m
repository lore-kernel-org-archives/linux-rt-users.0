From: "Remy Bohmer" <linux@bohmer.net>
Subject: Re: [PATCH]: Atmel Serial Console interrupt handler splitup
Date: Fri, 7 Dec 2007 21:38:17 +0100
Message-ID: <3efb10970712071238v4c3f1e03q60114a37b6d11b2e@mail.gmail.com>
References: <3efb10970712070724i6fa66666t2b8422329759ce24@mail.gmail.com>
	 <cd73a99e0712071157t6b5fe850l52e21dd31a6b8411@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Andrew Victor" <linux@maxim.org.za>,
	RT <linux-rt-users@vger.kernel.org>,
	"ARM Linux Mailing List" <linux-arm-kernel@lists.arm.linux.org.uk>,
	"Steven Rostedt" <rostedt@goodmis.org>,
	"David Brownell" <david-b@pacbell.net>, hskinnemoen@atmel.com
To: "Andrew Victor" <avictor.za@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:38230 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbXLGUiS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Dec 2007 15:38:18 -0500
Received: by wr-out-0506.google.com with SMTP id c49so681948wra
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Dec 2007 12:38:17 -0800 (PST)
In-Reply-To: <cd73a99e0712071157t6b5fe850l52e21dd31a6b8411@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Andrew,

> The serial driver is also used for Atmel's AVR32 architecture.
> There was some bug in the DMA patch that causes it to fail there -
> Haavard was going to look into in when he had time.
> Once that is resolved, the DMA patch will be submitted to mainline.

In that case, shall I create a new patchset for this compared to mainline?
Then we can merge the DMA patch in the interrupt handler later on. (it
is really difficult to do)

Kind Regards,

Remy
