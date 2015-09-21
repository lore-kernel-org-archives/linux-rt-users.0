From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 1/6] Add CROSS_COMPILE-switch to CC and AR
Date: Mon, 21 Sep 2015 21:41:53 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1509212141330.12009@riemann>
References: <1442849248-573-1-git-send-email-haustad@cisco.com> <1442849248-573-2-git-send-email-haustad@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
	Josh Cartwright <joshc@ni.com>
To: Henrik Austad <haustad@cisco.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37701 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162AbbIUTmE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Sep 2015 15:42:04 -0400
Received: by wicfx3 with SMTP id fx3so126887721wic.0
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Sep 2015 12:42:02 -0700 (PDT)
In-Reply-To: <1442849248-573-2-git-send-email-haustad@cisco.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 21 Sep 2015, Henrik Austad wrote:

> Signed-off-by: Henrik Austad <haustad@cisco.com>
> ---
>  Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index 3094e1b..f630076 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,4 +1,6 @@
>  VERSION = 0.93
> +CC=$(CROSS_COMPILE)gcc
> +AR=$(CROSS_COMPILE)ar
>  
>  HAVE_NPTL ?= yes
>  
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>
