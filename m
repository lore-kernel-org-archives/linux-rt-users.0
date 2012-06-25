From: Tom Cook <tom.k.cook@gmail.com>
Subject: Re: Debugging kernel lockups
Date: Mon, 25 Jun 2012 23:10:32 +0100
Message-ID: <CAFSh4UxuQRbjxGmZKo-G2ufEqpB7D6PfKXS7k5vYOsvu5ZHqSA@mail.gmail.com>
References: <CAFSh4UyHVU8Su47mRf9cCEZiUywBB4D2qeN0bNYfKvuAHO1uvA@mail.gmail.com>
	<20120625154825.GA17960@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35570 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082Ab2FYWKd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Jun 2012 18:10:33 -0400
Received: by pbbrp8 with SMTP id rp8so7139931pbb.19
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jun 2012 15:10:32 -0700 (PDT)
In-Reply-To: <20120625154825.GA17960@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Jun 25, 2012 at 4:48 PM, Nicholas Mc Guire <der.herr@hofr.at> wrote:
> On Mon, 25 Jun 2012, Tom Cook wrote:
[snip]
> I would start out with putting the rootfs into a ramdisk or on nfs and then
> you have the freedom to check in more detail what is going wrong with the
> SD/MMC/FS there as its then just a module to debug. In a system that halts
> at this point I doubt that kgdb or the like would be of much use.
>
> hofrat
>

A good suggestion, thanks.  I'll try that when I get back to my desk tomorrow.

Cheers,
Tom
