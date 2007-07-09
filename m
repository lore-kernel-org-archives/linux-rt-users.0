From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH 2.6.21.5-rt17] IPV6: estalished connections are not
	shown with "cat /proc/net/tcp6"
Date: Mon, 09 Jul 2007 09:53:45 -0700
Message-ID: <1184000025.2453.2.camel@dhcp193.mvista.com>
References: <467C40D3.206@ncos.nec.co.jp>
	 <1182601548.5493.117.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Masayuki Nakagawa <nakagawa.msy@ncos.nec.co.jp>, mingo@elte.hu,
	linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Lee Revell <rlrevell@joe-job.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:9905 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754399AbXGIRB6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Jul 2007 13:01:58 -0400
In-Reply-To: <1182601548.5493.117.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 2007-06-23 at 08:25 -0400, Steven Rostedt wrote:

> --- linux-2.6.21.orig/net/ipv4/tcp_ipv4.c       2007-06-17 17:19:02.000000000 +0200
> +++ linux-2.6.21/net/ipv4/tcp_ipv4.c    2007-06-17 17:20:27.000000000 +0200
> @@ -2033,7 +2033,12 @@ static void *established_get_first(struc
>         struct tcp_iter_state* st = seq->private;
>         void *rc = NULL;
> 
> -       for (st->bucket = 0; st->bucket < tcp_hashinfo.ehash_size; ++st->bucket) {
> 
> The above is a linear search through out a very large array, where most
> of the items are NULL.  I believe it was Lee that noticed this creating
> a large latency. This was back in 2.6.14. I'll check to see if this
> still is a source of latency with the latest kernels.

It looks fairly generic, is it a latency that could be fix the same way
up stream?

Daniel
