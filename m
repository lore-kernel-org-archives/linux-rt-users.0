From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 1/2] Makefile: pi_stress need librttest.a so it should
 depend on it
Date: Tue, 24 Feb 2015 15:26:45 +0100 (CET)
Message-ID: <alpine.LFD.2.10.1502241525100.5726@riemann>
References: <CAONaPpEuAPbdZDx+jNwff=BoVpG-y9yBG=cJu-LuWuLKuQUXFg@mail.gmail.com> <1424716730-22583-1-git-send-email-m.olbrich@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Clark Williams <clark.williams@gmail.com>,
	John Kacur <jkacur@gmail.com>, r.schwebel@pengutronix.de,
	linux-rt-users@vger.kernel.org
To: Michael Olbrich <m.olbrich@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:39642 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576AbbBXO05 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Feb 2015 09:26:57 -0500
Received: by wesx3 with SMTP id x3so25503530wes.6
        for <linux-rt-users@vger.kernel.org>; Tue, 24 Feb 2015 06:26:56 -0800 (PST)
In-Reply-To: <1424716730-22583-1-git-send-email-m.olbrich@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 23 Feb 2015, Michael Olbrich wrote:

> Signed-off-by: Michael Olbrich <m.olbrich@pengutronix.de>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 9e479d3c0dca..da7b419c4bcd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -73,7 +73,7 @@ cyclictest: cyclictest.o librttest.a
>  signaltest: signaltest.o librttest.a
>  	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
>  
> -pi_stress: pi_stress.o
> +pi_stress: pi_stress.o librttest.a
>  	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
>  
>  hwlatdetect:  src/hwlatdetect/hwlatdetect.py
> -- 
> 2.1.4

Okay,
Signed-off-by: John Kacur <jkacur@redhat.com>

will be in the next build 
