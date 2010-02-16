From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: Tweak Latency on Intel ATOM
Date: Tue, 16 Feb 2010 10:18:58 -0200
Message-ID: <20100216121858.GI9762@uudg.org>
References: <loom.20100209T081421-234@post.gmane.org>
 <20100210163818.7f54ec3a@torg>
 <4B73B7B5.4070509@gmx.net>
 <20100211093447.3c0a97cd@torg>
 <4B7914C6.8080005@gmx.net>
 <20100215083847.1a4a7ef0@torg>
 <4B7A401A.70902@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org
To: Max =?iso-8859-1?Q?M=FCller?= <mxmr@gmx.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:64370 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755452Ab0BPMTG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Feb 2010 07:19:06 -0500
Received: by ywh6 with SMTP id 6so4394628ywh.4
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Feb 2010 04:19:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B7A401A.70902@gmx.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Feb 16, 2010 at 07:50:02AM +0100, Max M=FCller wrote:
| Clark Williams schrieb:
| >On Mon, 15 Feb 2010 10:32:54 +0100
| >Max M=FCller <mxmr@gmx.net> wrote:
| >>>I'd say you're doing pretty good keeping under 50us. You might wan=
t to
| >>>try it under a heavier load than the shell script you've been runn=
ing.
| >>>If you don't want to fool with rteval, try kicking off a kernel co=
mpile
| >>>in another window like this:
| >>>
| >>>$ while true; do make -j4 clean bzImage modules; done
| >>>
| >>>and then run cyclictest. A kernel compile with parallel jobs (-j) =
is a
| >>>good overall load of computation and I/O.
| >>>
| >>I tested now like you told me with irqbalance and cpuspeed
| >>services disabled. I hope i made the right for disabling
| >>irqbalance, i used the kernel parameter acpi_no_irqbalance. Is
| >>this correct? Unfortunately the results were nearly equal as
| >>before.
| >
| >I don't think you're going to get much better results on the Atom. I
| >have an MSI Nettop box with the dual-core version and I saw about th=
e
| >same results as you.
| >
| >What sort of scheduling deadlines are you trying to meet?
| >
| >Clark
| Shorter it is better it would be :-)
| I can also live with this results, but i wanted to make sure to get
| the best out of this hardware.
|=20
| Are you running both cores on the MSI box (maybe also with
| hyperthreading enabled) with this results?

Oops, I have overlooked that "more than one core" detail. In this case,=
 you
have two cyclictest threads (from different executions) clashing at
priority FIFO:94. That can eventually create the latencies you see.

I would also suggest running the test without Hyperthreading (adjusting=
 the
number of cyclictest threads) just to see if the latencies are there in
this case.
=20
Luis

| In the meantime i thought also if the SMI (system management mode)
| could have a bad influence. I wrote a little userspace  programm
| which disables global SMI bit of the ICH7 southbridge. But also no
| better results.
| After that i was told (thanks to Luis Claudio!) to check latency
| with the kernel module hwlat_detector. The results of this module
| was 0. I interpreted this that there is no SMI that causes the
| latency on my ATOM system.
|=20
| Regards,
| Max

--=20
[ Luis Claudio R. Goncalves             Red Hat  -  Realtime Team ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
