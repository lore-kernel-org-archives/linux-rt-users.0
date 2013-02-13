From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 3.6.11-rt28 build failure on 32bit Intel
Date: Wed, 13 Feb 2013 13:14:21 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1302131314060.11905@ionos>
References: <20130208192328.0fd0db59@tor.valhalla.alchemy.lu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Joakim Hernberg <jbh@alchemy.lu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:58441 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754310Ab3BMMOX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Feb 2013 07:14:23 -0500
In-Reply-To: <20130208192328.0fd0db59@tor.valhalla.alchemy.lu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 8 Feb 2013, Joakim Hernberg wrote:

> Hi,
> 
> I get the following when trying to build 3.6.11-rt28 build failure on
> 32bit Intel:
> 
> CC arch/x86/mm/iomap_32.o 
> arch/x86/mm/iomap_32.c:57:7: error: expected identifier or '(' before
> '{' token
> make[2]: *** [arch/x86/mm/iomap_32.o] Error 1
> make[1]: *** [arch/x86/mm] Error 2
> make: *** [arch/x86] Error 2

Yes, I know. Fixes are on the way.
