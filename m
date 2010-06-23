From: Alessio Igor Bogani <abogani@texware.it>
Subject: Re: Realtime linux kernel on multicore processor
Date: Wed, 23 Jun 2010 10:36:16 +0200
Message-ID: <AANLkTimZ43lDi5dZ469a7DeZY5kmDNIxpoBvf2HqgQSL@mail.gmail.com>
References: <AANLkTilTcAaRj49CiPgWmPkhWkDkz1CR5sHZygsHRyNA@mail.gmail.com>
	<4C1A82AC.1000804@us.ibm.com>
	<AANLkTilzoBIjBM4sd4hjTcQhCmW4OUZpAD-oHqos7RPK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nivedita Singhvi <niv@us.ibm.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Neel Mehta <neelmehta89@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39114 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766Ab0FWIgT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Jun 2010 04:36:19 -0400
Received: by fxm10 with SMTP id 10so2896656fxm.19
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Jun 2010 01:36:17 -0700 (PDT)
In-Reply-To: <AANLkTilzoBIjBM4sd4hjTcQhCmW4OUZpAD-oHqos7RPK@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

2010/6/23 Neel Mehta <neelmehta89@gmail.com>:
[...]
> the kernel 2.6.31-9-rt (It is an RT_PREEMPT kernel) in the ubuntu
> repositories (for ubuntu 9.10). I installed the kernel, and booted
[...]

I suggest you to update your Ubuntu installation or try with a more
recent kernel.
In Lucid 10.04 there is 2.6.31-11-rt and (at the moment) it is in
-proposed archive: https://launchpad.net/ubuntu/+source/linux-rt
Otherwise you can install the latest kernel at my PPA:
https://launchpad.net/~abogani/+archive/ppa

Hope this helps.

Ciao,
Alessio
