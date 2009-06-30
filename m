From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: [PATCH 2/3] cyclictest: Fix the same priority method of many
	threads with -h option.
Date: Tue, 30 Jun 2009 16:12:10 +0900
Message-ID: <49b7c2350906300012x3a188622o3f15240199faf901@mail.gmail.com>
References: <1246030689.2153.32.camel@centos51>
	 <1246330564.8104.37.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: williams <williams@redhat.com>, tglx <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:50323 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbZF3HMI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Jun 2009 03:12:08 -0400
Received: by qw-out-2122.google.com with SMTP id 9so2020404qwb.37
        for <linux-rt-users@vger.kernel.org>; Tue, 30 Jun 2009 00:12:11 -0700 (PDT)
In-Reply-To: <1246330564.8104.37.camel@sven.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Jun 30, 2009 at 11:56 AM, Sven-Thorsten
Dietrich<sven@thebigcorporation.com> wrote:
> When generating a histogram on multiple cores, the priority of
> cyclictest threads should be the same on each CPU.
Of course, But original cyclictest is different  test scenario using
many threads.

> This change would make the priority lower on higher CPU ids, resulting
> in apparent performance skew in favor of CPU0.
Um. I don't agree with your opinions because we can try  cyclictest
commands like belows
using "-h" option.

In other words,
If cyclictest user want to same priority about many threads ,
They can assign same priority  with belows method or additional  bash scripts.

For example,

case )  before remove your some patches
#> cyclictest -t 3    -p 90 -h -D 100 &[enter]

case )  after remove your some patches
#> cyclictest -t 1    -p 90 -h -D 100 &[enter]
#> cyclictest -t 1    -p 90 -h -D 100 &[enter]
#> cyclictest -t 1    -p 90 -h -D 100 &[enter]

or
#> define i=3; while ($i) do  cyclictest -t 1   -p 90 -h -D 100 & ;
$i-- ; done

I think that many users will confuse  output  results  because of the
differnece output style
between  "without -h" option and "with -h" option.
If I mistake , Pleasse correct me.

Thks.

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
