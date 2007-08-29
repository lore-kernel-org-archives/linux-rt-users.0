Return-Path: <linux-rt-users-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:43499
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752361AbXH2E4i (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 29 Aug 2007 00:56:38 -0400
Date: Tue, 28 Aug 2007 21:56:36 -0700 (PDT)
Message-Id: <20070828.215636.99202736.davem@davemloft.net>
Subject: Re: [PATCH 2.6.21.5-rt17] IPV6: estalished connections are not
 shown with "cat /proc/net/tcp6"
From: David Miller <davem@davemloft.net>
In-Reply-To: <46D4CED2.4060302@ncos.nec.co.jp>
References: <46D4CED2.4060302@ncos.nec.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
To: nakagawa.msy@ncos.nec.co.jp
Cc: rostedt@goodmis.org, dwalker@mvista.com, mingo@elte.hu, linux-rt-users@vger.kernel.org, tglx@linutronix.de, rlrevell@joe-job.com
List-ID: <linux-rt-users.vger.kernel.org>

From: Masayuki Nakagawa <nakagawa.msy@ncos.nec.co.jp>
Date: Tue, 28 Aug 2007 18:41:38 -0700

> +static inline void __inet_hash_setbit(unsigned long *bitmask,
> +	unsigned int index)
> +{
> +	if (bitmask)
> +		set_bit(index, bitmask);
> +}
> +
> +static inline void __inet_hash_clearbit(unsigned long *bitmask,
> +	unsigned int index)
> +{
> +	if (bitmask)
> +		clear_bit(index, bitmask);
> +}
> +

A new atomic operation every single socket hashing insert or delete
operation is way too much amount of overhead for what should be a
trivial problem.

Please fix this in another way that does not add new locks or atomics
to the socket creation and destruction fast paths, thank you.
