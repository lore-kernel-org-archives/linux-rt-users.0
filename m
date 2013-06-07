From: Mike Galbraith <bitbucket@online.de>
Subject: Re: 3.8.11-rt8 NFS triggered seizures
Date: Fri, 07 Jun 2013 13:17:28 +0200
Message-ID: <1370603848.5854.42.camel@marge.simpson.net>
References: <1368437465.11686.60.camel@marge.simpson.net>
	 <20130607090300.GC10280@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:53191 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255Ab3FGLRb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Jun 2013 07:17:31 -0400
In-Reply-To: <20130607090300.GC10280@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2013-06-07 at 11:03 +0200, Sebastian Andrzej Siewior wrote:

> The "panic" says "Oops" so your karnel most likely hit a NULL pointer.
> The completion you say is missing might run into the NULL pointer
> problem. Any way to get the backtrace from the oops?

The oops is just me poking sysrq-c to crash the box.

-Mike

