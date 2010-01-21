From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: [PATCH]cyclictest: CFLAGS to support static compiliation with ARM
	Crosscompiler
Date: Thu, 21 Jan 2010 10:37:39 +0900
Message-ID: <49b7c2351001201737l403a20cduf3c32072e8e4f8d1@mail.gmail.com>
References: <1246593855.2153.55.camel@centos51>
	 <1264032570.2121.4.camel@centos51>
	 <520f0cf11001201640r4f1cf00ew3b4a4e9424c28602@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	tglx <tglx@linutronix.de>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:48005 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785Ab0AUBhj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Jan 2010 20:37:39 -0500
Received: by pxi12 with SMTP id 12so6141713pxi.33
        for <linux-rt-users@vger.kernel.org>; Wed, 20 Jan 2010 17:37:39 -0800 (PST)
In-Reply-To: <520f0cf11001201640r4f1cf00ew3b4a4e9424c28602@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Jan 21, 2010 at 9:40 AM, John Kacur <jkacur@redhat.com> wrote:
>
> Did you leave something out?
Not at all.
I summary, We have to  change  CFLAGS from "-lpthread -lrt" to "-lrt
-lpthread" to compile
rt-tests source successfully  for static linking with GCC based arm
cross compiler.

This is testcase.
Fedora11#> git clone
git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git
Fedora11#> cd rt-tests
Fedora11#> vi Makefile ( for static linking)
  CFLAGS  += -O2 -static <--- Edit this line.
Fedora11#> make CC=arm-linux-eabi-gcc
   We will meet some errors like  "undefined reference to . . . . . .
" messages.

Thanks reading.
Geunsik Lim.

> Thanks
> John
>



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
