From: jordan <triplesquarednine@gmail.com>
Subject: Re: "yum install ...." based instruction on building a RT kernel.
Date: Sat, 18 Sep 2010 16:06:45 -0400
Message-ID: <AANLkTi==4a5VpUszHC23WOGkM-fdos3x2M0P-ygRdttx@mail.gmail.com>
References: <4C92A00C.6050401@atl.lmco.com>
	<AANLkTi=eaPvCZmecBKT_d0C8YunJr7L6M8A7Y9pEiQK_@mail.gmail.com>
	<AANLkTi=GbDU7fKh9LvCEpjhSSMFF0syCqJVuqUERVBEJ@mail.gmail.com>
	<AANLkTikv7cmA_F==TKa1m0o_N1OHxp3RgXXMErhcgGM0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Gautam Thaker <gautam.h.thaker@lmco.com>,
	linux-rt-users@vger.kernel.org
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50189 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263Ab0IRUGq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 18 Sep 2010 16:06:46 -0400
Received: by eyb6 with SMTP id 6so1300938eyb.19
        for <linux-rt-users@vger.kernel.org>; Sat, 18 Sep 2010 13:06:45 -0700 (PDT)
In-Reply-To: <AANLkTikv7cmA_F==TKa1m0o_N1OHxp3RgXXMErhcgGM0@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi John,

I forgot number 5....

Once, you have a working rt-kernel, read up the linux schedulers (ie:
CFS and CFQ). Then, tune those as well.
As you would know working for redhat, these can be tuned after the
kernel is compiled. There are methods to do this littered all over the
internet.  You can use all sorts of tools (cyclictest/signaltest/etc)
to accurately see what effect your changes are making...then you test
with your applications for "real-world" tests/performance.

So, there is a learning curve. I would be lying, if i didn't
acknowledge this, But once you have done it a few times, it is
knowledge that you have, and won't have to re-learn.  Then, it becomes
very simple to do. (this applies to everything i wrote about)

jordan
