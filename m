From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2] Makefile: Add CROSS_COMPILE for Makefile
Date: Tue, 29 Sep 2015 14:15:34 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1509291415100.8405@riemann>
References: <20150929015811.GA1519@debian.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: williams@redhat.com, linux-rt-users@vger.kernel.org
To: Yuanbin Zhou <hduffddybz@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38561 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269AbbI2MPn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Sep 2015 08:15:43 -0400
Received: by wiclk2 with SMTP id lk2so12821847wic.1
        for <linux-rt-users@vger.kernel.org>; Tue, 29 Sep 2015 05:15:42 -0700 (PDT)
In-Reply-To: <20150929015811.GA1519@debian.debian>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 28 Sep 2015, Yuanbin Zhou wrote:

> Signed-off-by: Yuanbin Zhou <hduffddybz@gmail.com>
> ---
>  Makefile | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 87946fb..35a7d5a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,6 +1,15 @@
>  VERSION = 0.94
> -CC=$(CROSS_COMPILE)gcc
> -AR=$(CROSS_COMPILE)ar
> +
> +CROSS_COMPILE ?= $(CONFIG_CROSS_COMPILE:"%"=%)
> +AS = $(CROSS_COMPILE)as
> +LD = $(CROSS_COMPILE)ld
> +CC = $(CROSS_COMPILE)gcc
> +CPP = $(CC) -E
> +AR = $(CROSS_COMPILE)ar
> +NM = $(CROSS_COMPILE)nm
> +STRIP = $(CROSS_COMPILE)strip
> +OBJCOPY = $(CROSS_COMPILE)objcopy
> +OBJDUMP = $(CROSS_COMPILE)objdump
>  
>  OBJDIR = bld
>  
> -- 
> 2.1.4
> 
> 
> --

Signed-off-by: John Kacur <jkacur@redhat.com>

Thanks!
