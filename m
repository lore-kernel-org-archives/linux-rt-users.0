From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH]cyclictest: CFLAGS to support static compiliation with
 ARM  Crosscompiler
Date: Thu, 21 Jan 2010 12:40:29 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1001211201340.3873@localhost.localdomain>
References: <1246593855.2153.55.camel@centos51>  <1264032570.2121.4.camel@centos51>  <520f0cf11001201640r4f1cf00ew3b4a4e9424c28602@mail.gmail.com> <49b7c2351001201737l403a20cduf3c32072e8e4f8d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	tglx <tglx@linutronix.de>
To: GeunSik Lim <leemgs1@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51145 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710Ab0AULkk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Jan 2010 06:40:40 -0500
In-Reply-To: <49b7c2351001201737l403a20cduf3c32072e8e4f8d1@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Thu, 21 Jan 2010, GeunSik Lim wrote:

> On Thu, Jan 21, 2010 at 9:40 AM, John Kacur <jkacur@redhat.com> wrote:
> >
> > Did you leave something out?
> Not at all.
> I summary, We have to  change  CFLAGS from "-lpthread -lrt" to "-lrt
> -lpthread" to compile
> rt-tests source successfully  for static linking with GCC based arm
> cross compiler.
> 
> This is testcase.
> Fedora11#> git clone
> git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git
> Fedora11#> cd rt-tests
> Fedora11#> vi Makefile ( for static linking)
>   CFLAGS  += -O2 -static <--- Edit this line.
> Fedora11#> make CC=arm-linux-eabi-gcc
>    We will meet some errors like  "undefined reference to . . . . . .
> " messages.

Okay, I tested that change on normal x86_64 with the static flag, and it 
does seem to work, so I have no problem with your change.

Are you sure you need a -static link flag for embedded? I was talking to 
another arm developer who also cross compiles but doesn't need it.

Also, the reason I asked whether something was missing, is that the text 
to your patch contains "Subject: [PATCH 2/2] bugfix: Support static 
linking(-static) with"

so I was wondering where Patch 1/2 was.

Thanks.
