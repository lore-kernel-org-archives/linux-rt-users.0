From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] MIPS: Octeon: Mark SMP-IPI interrupt as IRQF_NO_THREAD
Date: Mon, 3 Oct 2011 23:44:43 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1110032344240.1489@ionos>
References: <1317673870-10671-1-git-send-email-venkat.subbiah@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-rt-users@vger.kernel.org, david.daney@cavium.com
To: Venkat Subbiah <venkat.subbiah@caviumnetworks.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:53581 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab1JCVpE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 3 Oct 2011 17:45:04 -0400
In-Reply-To: <1317673870-10671-1-git-send-email-venkat.subbiah@caviumnetworks.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 3 Oct 2011, Venkat Subbiah wrote:

> From: Venkat Subbiah <venkat.subbiah@cavium.com>
> 
> This is to exclude it from force threading to allow RT patch set to work.
> And while on this line
> * Remove IRQF_DISABLED as as this flag is NOOP
> * Add IRQF_PERCPU as this is a per cpu interrupt.
> 
> 
> Signed-off-by: Venkat Subbiah <venkat.subbiah@cavium.com>
> Acked-by: David Daney <david.daney@cavium.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>

