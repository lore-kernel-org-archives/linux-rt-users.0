From: =?ISO-8859-1?Q?Max_M=FCller?= <mxmr@gmx.net>
Subject: Re: Tweak Latency on Intel ATOM
Date: Wed, 17 Feb 2010 07:26:59 +0100
Message-ID: <4B7B8C33.60800@gmx.net>
References: <loom.20100209T081421-234@post.gmane.org> <20100210163818.7f54ec3a@torg> <4B73B7B5.4070509@gmx.net> <20100211093447.3c0a97cd@torg> <4B7914C6.8080005@gmx.net> <20100215083847.1a4a7ef0@torg> <4B7A401A.70902@gmx.net> <20100216121858.GI9762@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:46711 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933769Ab0BQG07 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Feb 2010 01:26:59 -0500
In-Reply-To: <20100216121858.GI9762@uudg.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Luis Claudio R. Goncalves schrieb:
> On Tue, Feb 16, 2010 at 07:50:02AM +0100, Max M=FCller wrote:
> | Clark Williams schrieb:
> | >On Mon, 15 Feb 2010 10:32:54 +0100
> | >Max M=FCller <mxmr@gmx.net> wrote:
> | >>>I'd say you're doing pretty good keeping under 50us. You might w=
ant to
> | >>>try it under a heavier load than the shell script you've been ru=
nning.
> | >>>If you don't want to fool with rteval, try kicking off a kernel =
compile
> | >>>in another window like this:
> | >>>
> | >>>$ while true; do make -j4 clean bzImage modules; done
> | >>>
> | >>>and then run cyclictest. A kernel compile with parallel jobs (-j=
) is a
> | >>>good overall load of computation and I/O.
> | >>>
> | >>I tested now like you told me with irqbalance and cpuspeed
> | >>services disabled. I hope i made the right for disabling
> | >>irqbalance, i used the kernel parameter acpi_no_irqbalance. Is
> | >>this correct? Unfortunately the results were nearly equal as
> | >>before.
> | >
> | >I don't think you're going to get much better results on the Atom.=
 I
> | >have an MSI Nettop box with the dual-core version and I saw about =
the
> | >same results as you.
> | >
> | >What sort of scheduling deadlines are you trying to meet?
> | >
> | >Clark
> | Shorter it is better it would be :-)
> | I can also live with this results, but i wanted to make sure to get
> | the best out of this hardware.
> |=20
> | Are you running both cores on the MSI box (maybe also with
> | hyperthreading enabled) with this results?
>
> Oops, I have overlooked that "more than one core" detail. In this cas=
e, you
> have two cyclictest threads (from different executions) clashing at
> priority FIFO:94. That can eventually create the latencies you see.
>
> I would also suggest running the test without Hyperthreading (adjusti=
ng the
> number of cyclictest threads) just to see if the latencies are there =
in
> this case.
> =20
> Luis
>
> | In the meantime i thought also if the SMI (system management mode)
> | could have a bad influence. I wrote a little userspace  programm
> | which disables global SMI bit of the ICH7 southbridge. But also no
> | better results.
> | After that i was told (thanks to Luis Claudio!) to check latency
> | with the kernel module hwlat_detector. The results of this module
> | was 0. I interpreted this that there is no SMI that causes the
> | latency on my ATOM system.
> |=20
> | Regards,
> | Max
>
>  =20
I have only the single core ATOM. Clark has the dual core box.=20
Hyperthreading must be disabled, else the maximum latency rises from=20
about 50=B5s (Hypertrhreading disabled) to about 100=B5s (Hypertrhreadi=
ng=20
enabled).
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
