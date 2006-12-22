From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.20-rc1-rt1 Panic on reboot after fresh kernel compile
Date: Fri, 22 Dec 2006 20:06:52 +0100
Message-ID: <20061222190652.GA13216@elte.hu>
References: <458AA2F4.4080601@atl.lmco.com> <20061221153142.GA19242@elte.hu> <458BFC46.1020301@atl.lmco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org,
	"Gautam H. Thaker" <gautam.h.thaker@lmco.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:41181 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752028AbWLVTJG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Dec 2006 14:09:06 -0500
To: Jonathan Walsh <jwalsh@atl.lmco.com>
Content-Disposition: inline
In-Reply-To: <458BFC46.1020301@atl.lmco.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Jonathan Walsh <jwalsh@atl.lmco.com> wrote:

> kernel with CONFIG_SMP enabled and it rebooted and is running 
> successfully.  I also attached my .config file if it might be of any 
> use.

could you send the config that fails? The one you sent has CONFIG_SMP 
enabled. (and it's not totally clear which UP config variant you used) I 
tried your SMP one with CONFIG_SMP turned off an defaults picked, but 
that didnt crash here.

	Ingo
