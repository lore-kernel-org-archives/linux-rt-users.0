From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH 4/5] [POWERPC] flags as passed to spin_*_irqsave()
	should be unsigned long.
Date: Tue, 04 Sep 2007 07:37:31 -0700
Message-ID: <1188916651.3224.2.camel@dhcp193.mvista.com>
References: <20070904070902.847F832CA0D@thor>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Tony Breeds <tony@bakeyournoodle.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:32207 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754029AbXIDOtf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Sep 2007 10:49:35 -0400
In-Reply-To: <20070904070902.847F832CA0D@thor>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2007-09-04 at 17:09 +1000, Tony Breeds wrote:
> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> 
> ---
> 
>  drivers/net/pasemi_mac.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: working/drivers/net/pasemi_mac.c
> ===================================================================
> --- working.orig/drivers/net/pasemi_mac.c	2007-09-04 16:46:40.000000000 +1000
> +++ working/drivers/net/pasemi_mac.c	2007-09-04 16:47:01.000000000 +1000
> @@ -524,7 +524,7 @@ static int pasemi_mac_clean_tx(struct pa
>  	struct pasemi_mac_buffer *info;
>  	struct pas_dma_xct_descr *dp;
>  	int start, count;
> -	int flags;
> +	unsigned long flags;

Upstream too (should always be unsigned long) ? Also you forgot to CC
LKML ..

Daniel
