From: Minchan Kim <minchan.kim@gmail.com>
Subject: Re: [PATCH]append prompt in /debug/tracing/README file.
Date: Thu, 14 May 2009 17:28:29 +0900
Message-ID: <28c262360905140128q3458e39fu62def873f2d95ae0@mail.gmail.com>
References: <1242289418.31161.45.camel@centos51>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	williams <williams@redhat.com>, tglx <tglx@linutronix.de>,
	Jiri Kosina <trivial@kernel.org>
To: leemgs1@gmail.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:3725 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753859AbZENI22 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 May 2009 04:28:28 -0400
In-Reply-To: <1242289418.31161.45.camel@centos51>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi, GeunkSik.

=46or fixing trivial typo, Let Cced trivial patch maintainer.

TRIVIAL PATCHES
P:  Jiri Kosina
M:  trivial@kernel.org
L:  linux-kernel@vger.kernel.org
T:  git kernel.org:/pub/scm/linux/kernel/git/jikos/trivial.git
S:  Maintained


2009/5/14 GeunSik Lim <leemgs1@gmail.com>:
>
> Dear Steven Rostedt,
>
> =C2=A0 =C2=A0Please, Append prompt in /debug/tracing/README file.
>
> =C2=A0 =C2=A0This is trivial issue. Fix typo Mini Howto file(README) =
for ftrace.
>
> =C2=A0 =C2=A0Signed-off-by: GeunSik Lim <geunsik.lim@samsung.com>
>
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 1ce5dc6..a4726f5 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2380,7 +2380,7 @@ static const char readme_msg[] =3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"# echo print-parent > /debug/tracing/trac=
e_options\n"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"# echo 1 > /debug/tracing/tracing_enabled=
\n"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"# cat /debug/tracing/trace > /tmp/trace.t=
xt\n"
> - =C2=A0 =C2=A0 =C2=A0 "echo 0 > /debug/tracing/tracing_enabled\n"
> + =C2=A0 =C2=A0 =C2=A0 "# echo 0 > /debug/tracing/tracing_enabled\n"
> =C2=A0;
>
> =C2=A0static ssize_t
>
>
>
> -----------------------------------------------
> To unsubscribe from this list: send the line "unsubscribe linux-***"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>
> GeunSik Lim (ELS - OS Group - S/W Lab - SAIT - SAMSUNG)
> e-Mail =C2=A0:1) geunsik.lim@samsung.com
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 2) leemgs@gmail.com , leemgs1@gmail.com
> HomePage: http://intomail.dnip.net/invain/me/
> -----------------------------------------------
>



--=20
Kinds regards,
Minchan Kim
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
