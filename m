From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: rt for newbie
Date: Fri, 28 Oct 2011 00:21:52 +0200
Message-ID: <4EA9D980.5080903@osadl.org>
References: <CADZpk3tRdH2uPw-Kq_qiowThtBicqP=0S-=knvgYCSNfUrY+kw@mail.gmail.com> <CAOcfFMyOZ5zu9NgS4tdw8eVm0fU88R6rtOmODNN5mRAAwuAHew@mail.gmail.com> <CADZpk3sbagk7nTfjuXpvwtoDd6U+4sY_W=eH9+jowuUqpjFvfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: sashka@mail.ru
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:36180 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755072Ab1J0WdK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 27 Oct 2011 18:33:10 -0400
In-Reply-To: <CADZpk3sbagk7nTfjuXpvwtoDd6U+4sY_W=eH9+jowuUqpjFvfQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sashka,

> [..]
> I've got it build several time. I'm confused with all those different
> guides telling me what to enable and disable. Most of them are
> outdated, as I can see.
The usual recommendation is:

1. Get the config of your distro
# cd /usr/src/kernels/linux-3.0.7-rt20
# cp /boot/config-`uname -r` .config

2. Configure the kernel for RT
# make menuconfig
Processor type and features  --->
       [ ] Tickless System (Dynamic Ticks)
       Preemption Model (Fully Preemptible Kernel (RT))  --->
Kernel hacking  --->
       [ ] Check for stack overflows

To check out the new kernel for its RT capabilities:
# cd /usr/src
# git clone https://github.com/clrkwllms/rt-tests
# cd rt-tests
# make rpm
# rpm -ivh RPMS/*/rt-tests*.rpm
# cyclictest -m -Sp99 -i100 -d0

Let us know what worst-case latency you got.

	-Carsten.
