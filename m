From: John Kacur <jkacur@redhat.com>
Subject: Re: Real time micro benchmark suite - thread priority fix
Date: Fri, 18 May 2012 14:54:01 +0200
Message-ID: <CAONaPpFi8M7tutcvyMaTeCk5gYk2UjVBKJkorssAKYSEAzJYPw@mail.gmail.com>
References: <4FB56A88.7050705@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: RT <linux-rt-users@vger.kernel.org>
To: Venkat Subbiah <vsubbiah@caviumnetworks.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:62593 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759720Ab2ERMyC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 May 2012 08:54:02 -0400
Received: by vbbff1 with SMTP id ff1so2490827vbb.19
        for <linux-rt-users@vger.kernel.org>; Fri, 18 May 2012 05:54:01 -0700 (PDT)
In-Reply-To: <4FB56A88.7050705@caviumnetworks.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, May 17, 2012 at 11:15 PM, Venkat Subbiah
<vsubbiah@caviumnetworks.com> wrote:
> Not sure whether Real time micro benchmark suite is still being maint=
ained
> at http://sourceforge.net/projects/rtmicrobench. The latest code from
> sourceforge has issues while running rtmb_c tests. It fails complaini=
ng
> about not being able to set thread priority. =A0Here's a fix for it.
>
> https://github.com/vsubbiah/rtmb/commit/2a6714030a4009b50b76e99a83bf4=
b042cc82780
>
> Thanks,
> Venkat

Are you on some kind of a quest to seek out obscure benchmarks? You
need to track down Mike Fulton and ask him if he is maintaining it,
no-one here is.

Thanks

John Kacur
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
