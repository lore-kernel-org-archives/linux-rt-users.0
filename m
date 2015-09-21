From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 5/6] Makefile: add librttest to rt-migrate-test
Date: Mon, 21 Sep 2015 21:52:55 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1509212151560.12009@riemann>
References: <1442849248-573-1-git-send-email-haustad@cisco.com> <1442849248-573-6-git-send-email-haustad@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
	Josh Cartwright <joshc@ni.com>
To: Henrik Austad <haustad@cisco.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33095 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932073AbbIUTw6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Sep 2015 15:52:58 -0400
Received: by wiclk2 with SMTP id lk2so163099634wic.0
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Sep 2015 12:52:57 -0700 (PDT)
In-Reply-To: <1442849248-573-6-git-send-email-haustad@cisco.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 21 Sep 2015, Henrik Austad wrote:

> linker must be able to resolve reference to err_msg_n properly
> 
>    rt-migrate-test.c:(.text+0x1ff): undefined reference to `err_msg_n'
> 
> Signed-off-by: Henrik Austad <haustad@cisco.com>
> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index fcf20ce..66de743 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -87,8 +87,8 @@ hwlatdetect:  src/hwlatdetect/hwlatdetect.py
>  	chmod +x src/hwlatdetect/hwlatdetect.py
>  	ln -s src/hwlatdetect/hwlatdetect.py hwlatdetect
>  
> -rt-migrate-test: rt-migrate-test.o
> -	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS)
> +rt-migrate-test: rt-migrate-test.o librttest.a
> +	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
>  
>  ptsematest: ptsematest.o librttest.a
>  	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(EXTRA_LIBS)
> -- 

Ah, I see, this patch fixes the compile error that the previous patch 
introduces. So, you at least need to reorder them.

I'm accepting this patch for now, but I think some time is necessary to 
review the previous patch.

Signed-off-by: John Kacur <jkacur@redhat.com>
> 
