From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: [PATCH ]cyclictest: fix invalid comment of debugfs mount
	directory.
Date: Tue, 2 Jun 2009 07:17:21 +0900
Message-ID: <49b7c2350906011517t7c725e38n5e2a3135ffc4b9a4@mail.gmail.com>
References: <1243821987.20635.42.camel@centos51>
	 <20090601120141.GQ21851@unix.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gx0-f214.google.com ([209.85.217.214]:62169 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbZFAWRV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Jun 2009 18:17:21 -0400
Received: by gxk10 with SMTP id 10so13508718gxk.13
        for <linux-rt-users@vger.kernel.org>; Mon, 01 Jun 2009 15:17:22 -0700 (PDT)
In-Reply-To: <20090601120141.GQ21851@unix.sh>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Jun 1, 2009 at 9:01 PM, Luis Claudio R. Goncalves
<lclaudio@uudg.org> wrote:

> GeunSik,
> I would suggest changing your comment in the patch to something like:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* finds the path to the tracing dir insid=
e debugfs mountpoint */
>
> Because it is not written in the stone where debugfs should be mounte=
d.
> There is a suggested place, that already changed at least twice. So, =
the
> function locates the debugfs mountpoint, wherever it is and looks for=
 the
> tracing directory.
Thanks your opinion. It's right.
I will modify  ftrace directory name from "debug/tracing" to " tracing"=
=2E

--=20
Regards,
GeunSik Lim ( SAMSUNG ELECTRONICS)
Blog : http://blog.naver.com/invain/
e-Mail: geunsik.lim@samsung.com
           leemgs@gmail.com , leemgs1@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
