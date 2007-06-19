From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: v2.6.21.4-rt11
Date: Tue, 19 Jun 2007 06:04:03 +0200
Message-ID: <1182225843.8176.494.camel@chaos>
References: <1182098605.8176.422.camel@chaos>
	 <2accc2ff0706170949j26c391aek7ed32e0e55d9a3d1@mail.gmail.com>
	 <1182099558.8176.436.camel@chaos>
	 <20070619.011440.260207451.matsu@igel.co.jp>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: nelsoneci@gmail.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Katsuya MATSUBARA <matsu@igel.co.jp>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:48273 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750925AbXFSEEI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 Jun 2007 00:04:08 -0400
In-Reply-To: <20070619.011440.260207451.matsu@igel.co.jp>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Katsuya-San,

On Tue, 2007-06-19 at 01:14 +0900, Katsuya MATSUBARA wrote:
> > It lacks support for the generic timeofday and clock event layers, which
> > causes the compile breakage.
> 
>  I am working on Renesas SuperH platforms.
>  I faced the similar compile errors
>  because 2.6.21.X in SH does not support GENERIC_TIME yet.
>  I made a workaround patch. Is this correct?

Looks good.

Can you in future please use "diff -ur" to generate patches. That's the
usual format.

Thanks,

	tglx
