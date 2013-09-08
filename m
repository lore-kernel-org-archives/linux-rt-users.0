From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: synchronize RT thread to external IRQ - suggestions?
Date: Sat, 7 Sep 2013 20:53:49 -0400
Message-ID: <20130907205349.2feeef7f@gandalf.local.home>
References: <C5F241C8-47AB-4EA5-83D2-C067EA7F3E7B@mah.priv.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Jon Elson <elson@pico-systems.com>
To: Michael Haberler <ml1234@mah.priv.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:2048 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980Ab3IHAxv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 7 Sep 2013 20:53:51 -0400
In-Reply-To: <C5F241C8-47AB-4EA5-83D2-C067EA7F3E7B@mah.priv.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 1 Sep 2013 19:40:14 +0200
Michael Haberler <ml1234@mah.priv.at> wrote:

> I've hardware at hand which would best be serviced by an RT-hardened thread after the hardware interrupts the host - in the simplest form it could be say a parport IRQ

request_threaded_irq() in the driver.

Then just set the priority of that thread to whatever you like it to be.

Or is this a user task thread?

-- Steve
