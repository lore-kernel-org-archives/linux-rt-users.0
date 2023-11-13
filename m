Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7F5224C0
	for <linux-rt-users@vger.kernel.org>; Mon, 13 Nov 2023 19:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF54610E5
	for <linux-rt-users@vger.kernel.org>; Mon, 13 Nov 2023 11:08:00 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 6B2C51F8F7;
	Mon, 13 Nov 2023 20:07:55 +0100 (CET)
Date: Mon, 13 Nov 2023 20:07:51 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, francesco.dolcini@toradex.com
Subject: Re: [ANNOUNCE] v6.6-rt13
Message-ID: <ZVJ0B9HYLTsLxxXw@francesco-nb.int.toradex.com>
References: <20231108152329.NDcgOQAF@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108152329.NDcgOQAF@linutronix.de>

Hello Sebastian, hello John

On Wed, Nov 08, 2023 at 04:23:29PM +0100, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
> 
> I'm pleased to announce the v6.6-rt13 patch set. 
> 
> Changes since v6.6-rt12:
> 
>   - Update to the printk series provided by John Ogness. Some of the
>     patches were merged during the merge window other are under review.
>     Here is a small changelog:
>     - warn and panic console output will interrupt the threaded printing
>       mid-line rather than waiting for the line to finish printing
>     
>     - in panic, printing is now synchronous rather than first storing all
>       panic messages and then dumping to consoles
>     
>     - printing kthreads will sleep, rather than busy-wait, while consoles
>       are in emergency or panic states
>     
>     - atomic console printing will only print to the end of the emergency
>       messages, rather than flushing all remaining records
>     
>     - apply various printk mainline fixes currently in review
>         https://lore.kernel.org/lkml/20231106210730.115192-1-john.ogness@linutronix.de

During our weekly CI tests of rt-devel branch we noticed that commit
78f4b59c6faa ("printk: Update the printk series.") breaks booting on
multiple NXP i.MX platforms (arm and arm64), likely related to
drivers/tty/serial/imx.c.

We are not planning any additional investigation at the moment and
we have no debug outputs to share, just wanted to give you a head-up.

Francesco

