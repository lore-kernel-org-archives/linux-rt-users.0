From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: [PATCH 2/3] cyclictest: Fix the same priority method of many
	threads with -h option.
Date: Thu, 2 Jul 2009 12:06:10 +0900
Message-ID: <49b7c2350907012006g6aa2cccet1f64393afc63b023@mail.gmail.com>
References: <1246030689.2153.32.camel@centos51>
	 <1246330564.8104.37.camel@sven.thebigcorporation.com>
	 <49b7c2350906300012x3a188622o3f15240199faf901@mail.gmail.com>
	 <1246354219.11056.36.camel@quadrophenia.thebigcorporation.com>
	 <49b7c2350907010642ga8c261p8c3a7c58937b7d0a@mail.gmail.com>
	 <1246491797.19116.212.camel@sven.thebigcorporation.com>
	 <49b7c2350907011956x1db068a9u71ad58612506b908@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: williams <williams@redhat.com>, tglx <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vw0-f202.google.com ([209.85.212.202]:38082 "EHLO
	mail-vw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094AbZGBDGH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Jul 2009 23:06:07 -0400
Received: by vwj40 with SMTP id 40so780260vwj.33
        for <linux-rt-users@vger.kernel.org>; Wed, 01 Jul 2009 20:06:10 -0700 (PDT)
In-Reply-To: <49b7c2350907011956x1db068a9u71ad58612506b908@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> =C2=A0I will send patch again with belows contents.
> ---------------------------------------------------------------------=
---
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.=
8
> index 48b2c5e..1bbdac0 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -91,7 +91,8 @@ event tracing (used with \-b)
> =C2=A0Enable function tracing using ftrace as tracer. This option is
> available only with \-b.
> =C2=A0.TP
> =C2=A0.B \-h, \-\-histogram=3DMAXLATENCYINUS
> -Dump latency histogram to stdout
> +Dump latency histogram to stdout. US means that the max time to be b=
e
>
> tracked in microseconds. When you use -h option to get histogram data=
,
> Cyclictest runs many threads with same priority without priority--.
>
> +
> =C2=A0.TP
> =C2=A0.B \-i, \-\-interval=3DINTV
> =C2=A0Set the base interval of the thread(s) in microseconds (default=
 is
>
> 1000us). This sets the interval of the first thread. See also \-d.
>
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.=
c
> index 3e2d500..8ebeb33 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -774,6 +774,7 @@ static void display_help(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0" =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
to modify value to minutes,
> hours or days\n"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"-h =C2=A0 =C2=A0 =C2=
=A0 --histogram=3DUS =C2=A0 =C2=A0dump a latency histogram to
> stdout after the run\n"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0" =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
US is the max time to be be
>
> tracked in microseconds\n"
> ---------------------------------------------------------------------=
-------

Sorry. I mistook. I attached patch contents again.
Sven, Can you tell me your opinion about below contents?
Thks,

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 48b2c5e..1bbdac0 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -91,7 +91,8 @@ event tracing (used with \-b)
 Enable function tracing using ftrace as tracer. This option is
available only with \-b.
 .TP
 .B \-h, \-\-histogram=3DMAXLATENCYINUS
-Dump latency histogram to stdout
+Dump latency histogram to stdout. US means that the max time to be be
tracked in microseconds. When you use -h option to get histogram data,
Cyclictest runs many threads with same priority without priority--.
+
 .TP
 .B \-i, \-\-interval=3DINTV
 Set the base interval of the thread(s) in microseconds (default is
1000us). This sets the interval of the first thread. See also \-d.
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 3e2d500..8ebeb33 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -774,6 +774,7 @@ static void display_help(void)
 	       "                           to modify value to minutes, hours
or days\n"
 	       "-h       --histogram=3DUS    dump a latency histogram to
stdout after the run\n"
 	       "                           US is the max time to be be
tracked in microseconds\n"
+	       "                           (with same priority about many thr=
eads)\n"
                "-w       --wakeup          task wakeup tracing (used
with -b)\n"
                "-W       --wakeuprt        rt task wakeup tracing
(used with -b)\n",
 	       tracers




--=20
Regards,
GeunSik Lim ( Samsung Electronics )
Blog : http://blog.naver.com/invain/
e-Mail: geunsik.lim@samsung.com
           leemgs@gmail.com , leemgs1@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
