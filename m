From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 3/6] Add a rebuild-switch to Makefile
Date: Mon, 21 Sep 2015 21:43:44 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1509212143210.12009@riemann>
References: <1442849248-573-1-git-send-email-haustad@cisco.com> <1442849248-573-4-git-send-email-haustad@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
	Josh Cartwright <joshc@ni.com>
To: Henrik Austad <haustad@cisco.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38651 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932150AbbIUTnr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Sep 2015 15:43:47 -0400
Received: by wiclk2 with SMTP id lk2so127342901wic.1
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Sep 2015 12:43:46 -0700 (PDT)
In-Reply-To: <1442849248-573-4-git-send-email-haustad@cisco.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 21 Sep 2015, Henrik Austad wrote:

> Update from joshc for job-level safety
> 
> Co-authored.by: Josh Cartwright <joshc@ni.com>
> Signed-off-by: Henrik Austad <haustad@cisco.com>
> ---
>  Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index f630076..fcf20ce 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -129,6 +129,11 @@ RPMDIRS = BUILD BUILDROOT RPMS SRPMS SPECS
>  distclean: clean
>  	rm -rf $(RPMDIRS) releases *.tar.gz rt-tests.spec tmp
>  
> +.PHONY: rebuild
> +rebuild:
> +	$(MAKE) clean
> +	$(MAKE) all
> +
>  .PHONY: changelog
>  changelog:
>  	git log >ChangeLog
> -- 
Signed-off-by: John Kacur <jkacur@redhat.com>
