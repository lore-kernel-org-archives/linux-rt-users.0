From: Pavan Kandepet <pavankp@gmail.com>
Subject: Re: Kernel start code
Date: Wed, 6 Oct 2010 16:19:07 -0700
Message-ID: <AANLkTinGu9MU-_ZRTr3Y5Om=GeG4pkNUwtcD6=iaO_M+@mail.gmail.com>
References: <AANLkTimxFvKiG6F8WHCe2Q+Ov5BaQ1ZVC3rr+rufVWE0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kernel-newbies <kernelnewbies@nl.linux.org>,
	Linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sri Ram Vemulpali <sri.ram.gmu06@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:47066 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab0JFXTu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 6 Oct 2010 19:19:50 -0400
Received: by qyk10 with SMTP id 10so123404qyk.19
        for <linux-rt-users@vger.kernel.org>; Wed, 06 Oct 2010 16:19:49 -0700 (PDT)
In-Reply-To: <AANLkTimxFvKiG6F8WHCe2Q+Ov5BaQ1ZVC3rr+rufVWE0@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Embedded Linux primer has a good introduction to
kernel bootup (chapter 5, kernel initialization). You can
try that.
Regards,
Pavan


On Wed, Oct 6, 2010 at 3:58 PM, Sri Ram Vemulpali
<sri.ram.gmu06@gmail.com> wrote:
> Hi all,
>
> =A0Can anyone, please help me on pointing to kernel boot code after
> grubs loads the kernel and transfers control to it.
> =A0I want in which files this resides, location. Any explanation on t=
he
> code or any link would be helpful to me.
> =A0I know this is kind of lousy question, but entry.S is where I look=
ed
> at. It is overwhelming for me where to start in that file.
> =A0Thanks in advance.
>
> --
> Regards,
> Sri.
>
> --
> To unsubscribe from this list: send an email with
> "unsubscribe kernelnewbies" to ecartis@nl.linux.org
> Please read the FAQ at http://kernelnewbies.org/FAQ
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
