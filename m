From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: [PATCH 2/3] cyclictest: Fix the same priority method of many
	threads with -h option.
Date: Thu, 2 Jul 2009 11:56:57 +0900
Message-ID: <49b7c2350907011956x1db068a9u71ad58612506b908@mail.gmail.com>
References: <1246030689.2153.32.camel@centos51>
	 <1246330564.8104.37.camel@sven.thebigcorporation.com>
	 <49b7c2350906300012x3a188622o3f15240199faf901@mail.gmail.com>
	 <1246354219.11056.36.camel@quadrophenia.thebigcorporation.com>
	 <49b7c2350907010642ga8c261p8c3a7c58937b7d0a@mail.gmail.com>
	 <1246491797.19116.212.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: williams <williams@redhat.com>, tglx <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vw0-f202.google.com ([209.85.212.202]:46494 "EHLO
	mail-vw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480AbZGBC4z (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Jul 2009 22:56:55 -0400
Received: by vwj40 with SMTP id 40so776027vwj.33
        for <linux-rt-users@vger.kernel.org>; Wed, 01 Jul 2009 19:56:57 -0700 (PDT)
In-Reply-To: <1246491797.19116.212.camel@sven.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Jul 2, 2009 at 8:43 AM, Sven-Thorsten
Dietrich<sven@thebigcorporation.com> wrote:
>> But,
>> If you and others don't  agree with my opinions,
>> I think that  We have to append  additional explanation in the "#>
>> cyclictest --help" to
>> understand output  using -h option at least like belows.
>>
>>  before) "-h       --histogram=US    dump a latency histogram to
>> stdout after the run\n"
>>  after   ) "-h       --histogram=US    dump a latency histogram to
>> stdout after the run (with same priority about threads)\n"
>>
>> How about you think  this my opinions?
>>
>
> Sounds good. So you want to document this?
Yes. It's right.

> You can get that now. But if you run cyclictest on SMP at PRIO < 99, you
> will get preempted by the migration thread, which is exactly why it
> doesn't make sense to stagger the priorities.
>
> In summary, I don't see the benefit of a 3-D histogram to log multiple
> cyclic threads per-cpu, but if you want to send a patch to make this
> happen, be my guest.
I agree with your explanation.
> Otherwise, send a patch to add to the man pages to document the output
> format.
 I will send patch again with belows contents.
------------------------------------------------------------------------
diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 48b2c5e..1bbdac0 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -91,7 +91,8 @@ event tracing (used with \-b)
 Enable function tracing using ftrace as tracer. This option is
available only with \-b.
 .TP
 .B \-h, \-\-histogram=MAXLATENCYINUS
-Dump latency histogram to stdout
+Dump latency histogram to stdout. US means that the max time to be be

tracked in microseconds. When you use -h option to get histogram data,
Cyclictest runs many threads with same priority without priority--.

+
 .TP
 .B \-i, \-\-interval=INTV
 Set the base interval of the thread(s) in microseconds (default is

1000us). This sets the interval of the first thread. See also \-d.

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 3e2d500..8ebeb33 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -774,6 +774,7 @@ static void display_help(void)
              "                           to modify value to minutes,
hours or days\n"
              "-h       --histogram=US    dump a latency histogram to
stdout after the run\n"
              "                           US is the max time to be be

tracked in microseconds\n"
----------------------------------------------------------------------------

>
> Or send a patch to add parameters to control the interval and prio
> staggering individually.
>
> But the patch you sent doesn't make any sense and won't produce correct
> results on SMP, which you should have verified yourself by now.





-- 
Regards,
GeunSik Lim ( Samsung Electronics )
Blog : http://blog.naver.com/invain/
e-Mail: geunsik.lim@samsung.com
           leemgs@gmail.com , leemgs1@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
