From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: RFC: Latency reducing TCP modifications for thin-stream
 interactive applications
Date: Thu, 04 Dec 2008 04:15:50 -0800
Message-ID: <1228392950.9704.4.camel@sven.thebigcorporation.com>
References: <492EA31D.8000704@simula.no>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Andreas Petlund <apetlund@simula.no>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.187]:38737 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbYLDMdH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Dec 2008 07:33:07 -0500
Received: by rn-out-0910.google.com with SMTP id k40so3409097rnd.17
        for <linux-rt-users@vger.kernel.org>; Thu, 04 Dec 2008 04:33:05 -0800 (PST)
In-Reply-To: <492EA31D.8000704@simula.no>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2008-11-27 at 14:39 +0100, Andreas Petlund wrote:

Hi -

Just a minor nit (trying your patch on a 2.6.22 Kernel):

These little white space tweaks are to be avoided, adding to the patch
size unnecessarily.

Do you have a version against 2.6.28, or Linux-tip?

Regards,

Sven

>                 }
> -
> +               
>                 /* Initial outgoing SYN's get put onto the write_queue
>                  * just like anything else we transmit.  It is not
>                  * true data, and if we misinform our callers that
> @@ -2479,14 +2585,14 @@
>                         acked |= FLAG_SYN_ACKED;
>                         tp->retrans_stamp = 0;
>                 }
> -
> +               
>                 /* MTU probing checks */
>                 if (icsk->icsk_mtup.probe_size) {
>                         if (!after(tp->mtu_probe.probe_seq_end,
> TCP_SKB_CB(skb)->end_seq)) {
>                                 tcp_mtup_probe_success(sk, skb);
>                         }
>                 }
> -
> +               
>                 if (sacked) {
>                         if (sacked & TCPCB_RETRANS) {
>                                 if (sacked & TCPCB_SACKED_RETRANS)
> @@ -2510,24 +2616,32 @@

