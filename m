From: Sankara Muthukrishnan <sankara.m@gmail.com>
Subject: Re: 3.04-rt14 patch applies against which version?
Date: Tue, 20 Sep 2011 19:16:47 -0500
Message-ID: <CAFQPvXcEjWod1k-UWjJ1AKwUtD+oGfXtqDd7xOVRGvKtfVpUrQ@mail.gmail.com>
References: <4E791F5D.8000105@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Venkat Subbiah <vsubbiah@caviumnetworks.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vw0-f42.google.com ([209.85.212.42]:48965 "EHLO
	mail-vw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107Ab1IUAQs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 Sep 2011 20:16:48 -0400
Received: by vwl1 with SMTP id 1so1786742vwl.1
        for <linux-rt-users@vger.kernel.org>; Tue, 20 Sep 2011 17:16:47 -0700 (PDT)
In-Reply-To: <4E791F5D.8000105@caviumnetworks.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I think v3.0-rc4 is different from v3.0.4. You should use v3.0.4. As
kernel.org is down, I can't point you to the git tree details. For
instance, you can use the following mirror:
http://mirror.yandex.ru/kernel.org/linux/kernel/v3.0/linux-3.0.4.tar.bz=
2

Thanks,
Sankara

On Tue, Sep 20, 2011 at 6:18 PM, Venkat Subbiah
<vsubbiah@caviumnetworks.com> wrote:
>
> Hello RT
>
> Got the 3.0.4-rt14 patch =A0from the link in the message below and tr=
ied to apply this to the v3.0-rc4 tag from the linux mainline git repo.=
 It didn't apply cleanly and I got a couple of rejects. So was wonderin=
g whether I am applying it against the correct version of the kernel? A=
gainst which tag in the repo does this apply against?
>
> http://www.spinics.net/lists/linux-rt-users/msg06997.html
>
> Thanks,
> Venkat
>
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
