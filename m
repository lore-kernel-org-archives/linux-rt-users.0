From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH][RT] tracing: Show padding as unsigned short
Date: Sat, 19 Nov 2011 14:09:22 +0100
Message-ID: <CAONaPpF_urAKGRLy2Xv4ZXfDd7gT11jhdeOHpT2rjG42KW8Pcw@mail.gmail.com>
References: <1321467575.4181.36.camel@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48952 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536Ab1KSNJX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 19 Nov 2011 08:09:23 -0500
In-Reply-To: <1321467575.4181.36.camel@frodo>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Nov 16, 2011 at 7:19 PM, Steven Rostedt <rostedt@goodmis.org> w=
rote:
> RT added two bytes to trace migrate disable counting to the trace eve=
nts
> and used two bytes of the padding to make the change. The structures =
and
> all were updated correctly, but the display in the event formats was
> not:
>
> cat /debug/tracing/events/sched/sched_switch/format
>
> name: sched_switch
> ID: 51
> format:
> =A0 =A0 =A0 =A0field:unsigned short common_type; =A0 =A0 =A0 offset:0=
; =A0 =A0 =A0 size:2; signed:0;
> =A0 =A0 =A0 =A0field:unsigned char common_flags; =A0 =A0 =A0 offset:2=
; =A0 =A0 =A0 size:1; signed:0;
> =A0 =A0 =A0 =A0field:unsigned char common_preempt_count; =A0 =A0 =A0 =
offset:3; =A0 =A0 =A0 size:1; signed:0;
> =A0 =A0 =A0 =A0field:int common_pid; =A0 offset:4; =A0 =A0 =A0 size:4=
; signed:1;
> =A0 =A0 =A0 =A0field:unsigned short common_migrate_disable; =A0 =A0of=
fset:8; =A0 =A0 =A0 size:2; signed:0;
> =A0 =A0 =A0 =A0field:int common_padding; =A0 =A0 =A0 offset:10; =A0 =A0=
 =A0size:2; signed:0;
>
>
> The field for common_padding has the correct size and offset, but the
> use of "int" might confuse some parsers (and people that are reading
> it). This needs to be changed to "unsigned short".
>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
>
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.=
c
> index 37d3ffb..c71844c 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -117,7 +117,7 @@ static int trace_define_common_fields(void)
> =A0 =A0 =A0 =A0__common_field(unsigned char, preempt_count);
> =A0 =A0 =A0 =A0__common_field(int, pid);
> =A0 =A0 =A0 =A0__common_field(unsigned short, migrate_disable);
> - =A0 =A0 =A0 __common_field(int, padding);
> + =A0 =A0 =A0 __common_field(unsigned short, padding);
>
> =A0 =A0 =A0 =A0return ret;
> =A0}
>

This one should also be included in 3.0.9-rt26
Thanks

John Kacur
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
