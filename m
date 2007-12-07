From: "Andrew Victor" <avictor.za@gmail.com>
Subject: Re: [PATCH]: Atmel Serial Console interrupt handler splitup
Date: Fri, 7 Dec 2007 21:57:04 +0200
Message-ID: <cd73a99e0712071157t6b5fe850l52e21dd31a6b8411@mail.gmail.com>
References: <3efb10970712070724i6fa66666t2b8422329759ce24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Andrew Victor" <linux@maxim.org.za>,
	RT <linux-rt-users@vger.kernel.org>,
	"ARM Linux Mailing List" <linux-arm-kernel@lists.arm.linux.org.uk>,
	"Steven Rostedt" <rostedt@goodmis.org>,
	"David Brownell" <david-b@pacbell.net>, hskinnemoen@atmel.com
To: "Remy Bohmer" <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:12369 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbXLGT5G (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Dec 2007 14:57:06 -0500
Received: by rv-out-0910.google.com with SMTP id k20so800740rvb
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Dec 2007 11:57:04 -0800 (PST)
In-Reply-To: <3efb10970712070724i6fa66666t2b8422329759ce24@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

hi Remy,

> What is wise here? should I create a new patchset for mainline? Or can
> you push the DMA patch also to mainline together with this set? I have
> it working here for months, so I see no reason not to, maybe you have
> a reason?

The serial driver is also used for Atmel's AVR32 architecture.
There was some bug in the DMA patch that causes it to fail there -
Haavard was going to look into in when he had time.

Once that is resolved, the DMA patch will be submitted to mainline.


Regards,
  Andrew Victor
