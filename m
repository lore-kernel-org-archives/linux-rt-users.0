From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] Kind of revert "powerpc: 52xx: provide a default in mpc52xx_irqhost_map()"
Date: Fri, 04 Oct 2013 17:38:27 +0200
Message-ID: <524EE0F3.6020507@linutronix.de>
References: <1380901029-3548-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev@ozlabs.org, linux-rt-users@vger.kernel.org,
	Anatolij Gustschin <agust@denx.de>
To: Wolfram Sang <wsa@the-dreams.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54700 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027Ab3JDPia (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Oct 2013 11:38:30 -0400
In-Reply-To: <1380901029-3548-1-git-send-email-wsa@the-dreams.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/04/2013 05:37 PM, Wolfram Sang wrote:
> This more or less reverts commit 6391f697d4892a6f233501beea553e13f7745a23.
> Instead of adding an unneeded 'default', mark the variable to prevent
> the false positive 'uninitialized var'. The other change (fixing the
> printout) needs revert, too. We want to know WHICH critical irq failed,
> not which level it had.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Anatolij Gustschin <agust@denx.de>

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
