From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] rt-tests: Makefile: fixed dropped quote in help target
Date: Thu, 22 Oct 2015 22:50:00 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1510222249340.5508@riemann>
References: <20151022144155.719760c4@sluggy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: RT <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34120 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932530AbbJVUuE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Oct 2015 16:50:04 -0400
Received: by wikq8 with SMTP id q8so49640968wik.1
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Oct 2015 13:50:03 -0700 (PDT)
In-Reply-To: <20151022144155.719760c4@sluggy>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Thu, 22 Oct 2015, Clark Williams wrote:

> From 2b16becaef4e70cd7630785850d5fefe4949533b Mon Sep 17 00:00:00 2001
> From: Clark Williams <williams@redhat.com>
> Date: Thu, 22 Oct 2015 14:38:49 -0500
> Subject: [PATCH] Makefile: fixed dropped quote in help target text
> 
> Signed-off-by: Clark Williams <williams@redhat.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 908187202ba3..2e6ad8a1107f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -201,7 +201,7 @@ install_hwlatdetect: hwlatdetect
>  	@echo "    install   :  install tests to local filesystem"
>  	@echo "    clean     :  remove object files"
>  	@echo "    distclean :  remove all generated files"
> -	@echo "	   tarball   :  make a rt-tests tarball suitable for release
> +	@echo "    tarball   :  make a rt-tests tarball suitable for release"
>  	@echo "    help      :  print this message"
>  
>  .PHONY: tags
> -- 
> 2.4.3
> 
> --

Oops, thanks

Signed-off-by: John Kacur <jkacur@redhat.com>
