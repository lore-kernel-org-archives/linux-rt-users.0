From: Alessio Igor Bogani <abogani@texware.it>
Subject: Re: High resolution timers on ACPI-less kernel
Date: Tue, 09 Oct 2007 11:48:14 +0200
Message-ID: <1191923294.14549.6.camel@godzilla.tecnorama.it>
References: <470B44A1.7080007@free.fr>
	 <alpine.LFD.0.9999.0710091117020.25146@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: John Sigler <linux.kernel@free.fr>, linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hermes.xcon.it ([62.48.35.101]:54774 "EHLO hermes.xcon.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589AbXJIJsS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Oct 2007 05:48:18 -0400
In-Reply-To: <alpine.LFD.0.9999.0710091117020.25146@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2007-10-09 at 11:22 +0200, Thomas Gleixner wrote:
[...]
> We do not trust TSC at all. Never ever.

I found in the code at arch/i386/kernel/tsc.c that there is a exception
for Geode LX (the famous OLPC). ;-)

Ciao,
Alessio
