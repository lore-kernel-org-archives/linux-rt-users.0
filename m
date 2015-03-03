From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] Makefile: cleanup linking to librttest.a
Date: Tue, 3 Mar 2015 19:58:21 +0100 (CET)
Message-ID: <alpine.LFD.2.10.1503031955410.5674@riemann>
References: <CAONaPpHd1Wbc3AcXH2+4DO=3=yKdFXRnM8LFbE-ebiZV8WOuMA@mail.gmail.com> <1425408168-27325-1-git-send-email-m.olbrich@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Clark Williams <clark.williams@gmail.com>,
	John Kacur <jkacur@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Michael Olbrich <m.olbrich@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36537 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756422AbbCCS6Y (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Mar 2015 13:58:24 -0500
Received: by widem10 with SMTP id em10so25257643wid.1
        for <linux-rt-users@vger.kernel.org>; Tue, 03 Mar 2015 10:58:23 -0800 (PST)
In-Reply-To: <1425408168-27325-1-git-send-email-m.olbrich@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Tue, 3 Mar 2015, Michael Olbrich wrote:

> Only add '-lrttest -L.' where it's actually needed.
> Use '$<' instead of '$^'. Otherwise librttest is added twice:
> As 'librttest.a' and as '-lrttest'.
> 
> Signed-off-by: Michael Olbrich <m.olbrich@pengutronix.de>
> ---
> 
> Better like this?
> 
> Michael
> 
>  Makefile | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index da7b419c4bcd..5d7f449cc026 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -11,7 +11,8 @@ sources += signaltest.c ptsematest.c sigwaittest.c svsematest.c sendme.c \
>  
>  TARGETS = $(sources:.c=)
>  
> -LIBS 	= -lrt -lpthread -lrttest -L.
> +LIBS	= -lrt -lpthread
> +RTTESTLIB = -lrttest -L.
>  EXTRA_LIBS ?= -ldl	# for get_cpu
>  DESTDIR	?=
>  prefix  ?= /usr/local
> @@ -68,41 +69,41 @@ all: $(TARGETS) hwlatdetect
>  -include $(sources:.c=.d)
>  
>  cyclictest: cyclictest.o librttest.a
> -	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS) $(NUMA_LIBS)
> +	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(NUMA_LIBS)
>  
>  signaltest: signaltest.o librttest.a
> -	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
> +	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
>  
>  pi_stress: pi_stress.o librttest.a
> -	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
> +	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
>  
>  hwlatdetect:  src/hwlatdetect/hwlatdetect.py
>  	chmod +x src/hwlatdetect/hwlatdetect.py
>  	ln -s src/hwlatdetect/hwlatdetect.py hwlatdetect
>  
>  rt-migrate-test: rt-migrate-test.o
> -	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
> +	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS)
>  
>  ptsematest: ptsematest.o librttest.a
> -	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS) $(EXTRA_LIBS)
> +	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(EXTRA_LIBS)
>  
>  sigwaittest: sigwaittest.o librttest.a
> -	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS) $(EXTRA_LIBS)
> +	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(EXTRA_LIBS)
>  
>  svsematest: svsematest.o librttest.a
> -	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS) $(EXTRA_LIBS)
> +	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(EXTRA_LIBS)
>  
>  pmqtest: pmqtest.o librttest.a
> -	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS) $(EXTRA_LIBS)
> +	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(EXTRA_LIBS)
>  
>  sendme: sendme.o librttest.a
> -	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS) $(EXTRA_LIBS)
> +	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(EXTRA_LIBS)
>  
>  pip_stress: pip_stress.o librttest.a
> -	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
> +	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
>  
>  hackbench: hackbench.o
> -	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
> +	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS)
>  
>  librttest.a: rt-utils.o error.o rt-get_cpu.o rt-sched.o
>  	$(AR) rcs librttest.a $^
> -- 
> 2.1.4
> 
> 

Thats better, thanks applied.
Signed-off-by: John Kacur <jkacur@redhat.com>
