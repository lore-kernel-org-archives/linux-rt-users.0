From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH]: Atmel Serial Console interrupt handler splitup
Date: Fri, 07 Dec 2007 10:31:37 -0800
Message-ID: <20071207183137.D9E4DF6DFD@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <3efb10970712070724i6fa66666t2b8422329759ce24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.arm.linux.org.uk
To: linux@maxim.org.za, linux@bohmer.net
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:22580 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756077AbXLGScl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Dec 2007 13:32:41 -0500
In-Reply-To: <3efb10970712070724i6fa66666t2b8422329759ce24@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> 		 On AT91 David Brownell noticed several months
> ago that the DBGU can miss some characters on NO_HZ. I would expect
> that this would be better now due to the shorter interrupt handler,
> although it was not my goal to solve it with these patches.

The current (kernel.org git) AT91 timer handler incorporates a bugfix
in that area, which seemed to resolve most of those problems.

- Dave
