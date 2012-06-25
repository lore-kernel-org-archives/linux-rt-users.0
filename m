From: richard -rw- weinberger <richard.weinberger@gmail.com>
Subject: Re: Debugging kernel lockups
Date: Mon, 25 Jun 2012 23:15:07 +0200
Message-ID: <CAFLxGvzmZ0-fKV9FwRoFaFgSXJb3KqwCYegree1OntOkJFPBYw@mail.gmail.com>
References: <CAFSh4UyHVU8Su47mRf9cCEZiUywBB4D2qeN0bNYfKvuAHO1uvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: RT <linux-rt-users@vger.kernel.org>
To: Tom Cook <tom.k.cook@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:64191 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756594Ab2FYVPJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Jun 2012 17:15:09 -0400
Received: by lbbgm6 with SMTP id gm6so7057376lbb.19
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jun 2012 14:15:07 -0700 (PDT)
In-Reply-To: <CAFSh4UyHVU8Su47mRf9cCEZiUywBB4D2qeN0bNYfKvuAHO1uvA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Jun 25, 2012 at 5:17 PM, Tom Cook <tom.k.cook@gmail.com> wrote:
> Hi,
>
> Sorry for asking newbie questions here, but I'm, well, a newbie at
> this. =A0I'm trying to get the 3.2.20-rt32 patch to boot on a Raspber=
ry
> Pi, but it seems the patch breaks the SD/MMC card driver and so the
> root filesystem can't be mounted. =A0I've built a 3.2.20 source tree =
and
> it boots fine, then I apply 3.2.20-rt32 patch and the boot halts
> trying to find the SD card for the root FS.

You can try the "rootwait" kernel parameter.
But as Sven said, the boot log would be nice to have.

--=20
Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
