From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: cyclictest hangs with posix interval timers !?
Date: Thu, 04 Jan 2007 14:30:13 +0100
Message-ID: <1167917413.23138.20.camel@localhost.localdomain>
References: <459CE84F.8000009@imc-berlin.de>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:48269 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964856AbXADNYu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Jan 2007 08:24:50 -0500
To: Steven Scholz <steven.scholz@imc-berlin.de>
In-Reply-To: <459CE84F.8000009@imc-berlin.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-01-04 at 12:43 +0100, Steven Scholz wrote:
> So I recon it has something to do with the rootfs I am using (created with
> PTXdist).

Can you try to use a standard root filesystem (fedora, debian or
whatever you have handy) ?

	tglx
