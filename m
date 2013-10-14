From: Aaron Fabbri <ajfabbri@gmail.com>
Subject: Re: Non-Preempt Test v1.01
Date: Mon, 14 Oct 2013 15:04:09 -0700
Message-ID: <CAF+KLxtaqEg9Z+cEwcALEHQ-D6kkKXbj0E100pTz5PxQKwd+0g@mail.gmail.com>
References: <525C406A.5050000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, lttng-dev@lists.lttng.org,
	lwn@lwn.net
To: =?ISO-8859-1?Q?Rapha=EBl_Beamonte?= <raphael.beamonte@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:55478 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932139Ab3JNWEJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Oct 2013 18:04:09 -0400
Received: by mail-pb0-f44.google.com with SMTP id xa7so7882905pbc.3
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Oct 2013 15:04:09 -0700 (PDT)
In-Reply-To: <525C406A.5050000@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thanks for sharing this, will check it out if I get a chance.  Do you
have a http git url that I can clone?  I'm behind a firewall.

On Mon, Oct 14, 2013 at 12:05 PM, Rapha=EBl Beamonte
<raphael.beamonte@gmail.com> wrote:
> Hi all !
>
> I just released the Non-Preempt Test (npt) version 1.01 which is
> available here: http://git.dorsal.polymtl.ca/?p=3Dnpt.git
>
> The purpose of this tool is to simulate a small real-time system that
> runs with a high priority without being stopped or preempted. To do s=
o,
> it first sets its environment (cpu affinity, RT scheduler, memory loc=
ked
> into RAM with mlockall) and can optionally disable the local IRQs if
> compiled with the right options (not defined by default).
>
> The core of the application is a loop that calculates the time gap
> between the start of two consecutive loops using the rdtsc asm
> instruction, thus a similarity with the hwlat_detector kernel module =
for
> kernel analysis. At the end of its execution, npt computes latencies
> statistics for each loop and generates a histogram showing the differ=
ent
> latencies reached and the number of time it reached each one.
>
> This tool can be used to analyse and identify overhead of different
> realtime applications as we can compare the latencies in each loops a=
nd
> thus identify the added latency from a "blank" run. It is released
> LTTng-ready and can thus be easily traced. Next versions could includ=
e
> other userspace tracers ability.
>
> Feedback, collaborations and contributions are welcome!
>
> Regards,
> Rapha=EBl Beamonte
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
