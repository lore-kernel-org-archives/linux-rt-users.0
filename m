From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: [PATCH 2/3] cyclictest: Fix the same priority method of many
 threads with -h option.
Date: Thu, 02 Jul 2009 13:42:44 -0700
Message-ID: <1246567364.32598.76.camel@sven.thebigcorporation.com>
References: <1246030689.2153.32.camel@centos51>
	 <1246330564.8104.37.camel@sven.thebigcorporation.com>
	 <49b7c2350906300012x3a188622o3f15240199faf901@mail.gmail.com>
	 <1246354219.11056.36.camel@quadrophenia.thebigcorporation.com>
	 <49b7c2350907010642ga8c261p8c3a7c58937b7d0a@mail.gmail.com>
	 <1246491797.19116.212.camel@sven.thebigcorporation.com>
	 <49b7c2350907011956x1db068a9u71ad58612506b908@mail.gmail.com>
	 <49b7c2350907012006g6aa2cccet1f64393afc63b023@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: williams <williams@redhat.com>, tglx <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: GeunSik Lim <leemgs1@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f215.google.com ([209.85.219.215]:35531 "EHLO
	mail-ew0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754425AbZGBUmw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Jul 2009 16:42:52 -0400
Received: by ewy11 with SMTP id 11so531121ewy.37
        for <linux-rt-users@vger.kernel.org>; Thu, 02 Jul 2009 13:42:54 -0700 (PDT)
In-Reply-To: <49b7c2350907012006g6aa2cccet1f64393afc63b023@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2009-07-02 at 12:06 +0900, GeunSik Lim wrote:
> >  I will send patch again with belows contents.

I'm ok with that.

Ack.

> > ------------------------------------------------------------------------
> > diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> > index 48b2c5e..1bbdac0 100644
> > --- a/src/cyclictest/cyclictest.8
> > +++ b/src/cyclictest/cyclictest.8
> > @@ -91,7 +91,8 @@ event tracing (used with \-b)
> >  Enable function tracing using ftrace as tracer. This option is
> > available only with \-b.
> >  .TP
> >  .B \-h, \-\-histogram=MAXLATENCYINUS
> > -Dump latency histogram to stdout
> > +Dump latency histogram to stdout. US means that the max time to be be
> >
> > tracked in microseconds. When you use -h option to get histogram data,
> > Cyclictest runs many threads with same priority without priority--.
> >
> > +
> >  .TP
> >  .B \-i, \-\-interval=INTV
> >  Set the base interval of the thread(s) in microseconds (default is
> >
> > 1000us). This sets the interval of the first thread. See also \-d.
> >
> > diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> > index 3e2d500..8ebeb33 100644
> > --- a/src/cyclictest/cyclictest.c
> > +++ b/src/cyclictest/cyclictest.c
> > @@ -774,6 +774,7 @@ static void display_help(void)
> >              "                           to modify value to minutes,
> > hours or days\n"
> >              "-h       --histogram=US    dump a latency histogram to
> > stdout after the run\n"
> >              "                           US is the max time to be be
> >
> > tracked in microseconds\n"
> > ----------------------------------------------------------------------------
> 
> Sorry. I mistook. I attached patch contents again.
> Sven, Can you tell me your opinion about below contents?
> Thks,
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index 48b2c5e..1bbdac0 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -91,7 +91,8 @@ event tracing (used with \-b)
>  Enable function tracing using ftrace as tracer. This option is
> available only with \-b.
>  .TP
>  .B \-h, \-\-histogram=MAXLATENCYINUS
> -Dump latency histogram to stdout
> +Dump latency histogram to stdout. US means that the max time to be be
> tracked in microseconds. When you use -h option to get histogram data,
> Cyclictest runs many threads with same priority without priority--.
> +
>  .TP
>  .B \-i, \-\-interval=INTV
>  Set the base interval of the thread(s) in microseconds (default is
> 1000us). This sets the interval of the first thread. See also \-d.
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 3e2d500..8ebeb33 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -774,6 +774,7 @@ static void display_help(void)
>  	       "                           to modify value to minutes, hours
> or days\n"
>  	       "-h       --histogram=US    dump a latency histogram to
> stdout after the run\n"
>  	       "                           US is the max time to be be
> tracked in microseconds\n"
> +	       "                           (with same priority about many threads)\n"
>                 "-w       --wakeup          task wakeup tracing (used
> with -b)\n"
>                 "-W       --wakeuprt        rt task wakeup tracing
> (used with -b)\n",
>  	       tracers
> 
> 
> 
> 

