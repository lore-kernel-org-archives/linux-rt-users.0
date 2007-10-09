From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: High resolution timers on ACPI-less kernel
Date: Tue, 9 Oct 2007 11:53:17 +0200 (CEST)
Message-ID: <alpine.LFD.0.9999.0710091152460.25146@localhost.localdomain>
References: <470B44A1.7080007@free.fr>  <alpine.LFD.0.9999.0710091117020.25146@localhost.localdomain> <1191923294.14549.6.camel@godzilla.tecnorama.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: John Sigler <linux.kernel@free.fr>, linux-rt-users@vger.kernel.org
To: Alessio Igor Bogani <abogani@texware.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:35310 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751556AbXJIJxg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Oct 2007 05:53:36 -0400
In-Reply-To: <1191923294.14549.6.camel@godzilla.tecnorama.it>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 9 Oct 2007, Alessio Igor Bogani wrote:

> On Tue, 2007-10-09 at 11:22 +0200, Thomas Gleixner wrote:
> [...]
> > We do not trust TSC at all. Never ever.
> 
> I found in the code at arch/i386/kernel/tsc.c that there is a exception
> for Geode LX (the famous OLPC). ;-)

True. Forgot about that one :9

	tglx
