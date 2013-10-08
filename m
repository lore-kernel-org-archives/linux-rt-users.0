From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] Kind of revert "powerpc: 52xx: provide a default in
 mpc52xx_irqhost_map()"
Date: Tue, 8 Oct 2013 23:44:06 +0200
Message-ID: <20131008234406.38cbebe2@crub>
References: <1380901029-3548-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev@ozlabs.org, linux-rt-users@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Wolfram Sang <wsa@the-dreams.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:51201 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755498Ab3JHVoJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 Oct 2013 17:44:09 -0400
In-Reply-To: <1380901029-3548-1-git-send-email-wsa@the-dreams.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri,  4 Oct 2013 17:37:09 +0200
Wolfram Sang <wsa@the-dreams.de> wrote:

> This more or less reverts commit 6391f697d4892a6f233501beea553e13f7745a23.
> Instead of adding an unneeded 'default', mark the variable to prevent
> the false positive 'uninitialized var'. The other change (fixing the
> printout) needs revert, too. We want to know WHICH critical irq failed,
> not which level it had.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Anatolij Gustschin <agust@denx.de>

applied, thanks!
