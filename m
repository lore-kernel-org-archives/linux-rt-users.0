From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: PI mutex support on ARM
Date: Mon, 20 Aug 2007 13:59:20 +0100
Message-ID: <20070820125919.GD10774@flint.arm.linux.org.uk>
References: <200708201453.14641.m.gruber@tirol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, l.pinguin@gmail.com,
	tglx@linutronix.de, mingo@elte.hu
To: Manfred Gruber <m.gruber@tirol.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39061 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbXHTM7l (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 20 Aug 2007 08:59:41 -0400
Content-Disposition: inline
In-Reply-To: <200708201453.14641.m.gruber@tirol.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Aug 20, 2007 at 02:12:17PM +0200, Manfred Gruber wrote:
> Is about the PI Mutex issue on ARM some work going on?

work best sentences when formed properly they're.

> Or does someone have an information for me how to implement this for a armv4 
> correct ?

The futexes are something I've no interest in at the moment since I'm
not running EABI or even TLS based environments.  People who are get
the privilege of solving the problems found there in.
