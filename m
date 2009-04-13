From: Tim Sander <tstone@vlsi.informatik.tu-darmstadt.de>
Subject: Re: Measuring timer interrupt latency
Date: Mon, 13 Apr 2009 18:22:01 +0200
Message-ID: <200904131822.02125.tstone@vlsi.informatik.tu-darmstadt.de>
References: <alpine.LFD.2.00.0904110003370.21577@localhost.localdomain> <002901c9bc03$54aa23d0$3f52c70a@dlh.st.com> <20090413091405.380e42f8@torg>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "'rt-users'" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lnx503.hrz.tu-darmstadt.de ([130.83.156.232]:53653 "EHLO
	lnx503.hrz.tu-darmstadt.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751863AbZDMQWJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Apr 2009 12:22:09 -0400
Received: from mailserver3.hrz.tu-darmstadt.de (lnx504.hrz.tu-darmstadt.de [130.83.156.233])
	by lnx503.hrz.tu-darmstadt.de (8.14.2/8.13.8/HRZ/PMX) with ESMTP id n3DGM7pq002641
	for <linux-rt-users@vger.kernel.org>; Mon, 13 Apr 2009 18:22:07 +0200
	(envelope-from tstone@vlsi.informatik.tu-darmstadt.de)
Received: from [213.157.27.17] (helo=IP-213157027017.dialin.heagmedianet.de)
	by mailserver3.hrz.tu-darmstadt.de with esmtpsa (TLS-1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tstone@vlsi.informatik.tu-darmstadt.de>)
	id 1LtOv9-00087B-Jn
	for linux-rt-users@vger.kernel.org; Mon, 13 Apr 2009 18:22:07 +0200
In-Reply-To: <20090413091405.380e42f8@torg>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi
> Have you tried cyclictest? It's part of the rt-tests package that
> Thomas Gleixner wrote and that I now maintain.
I think cyclictest is nice to get some first impressions and i really l=
ike=20
it... but it only give the aggregate.

> The thing is, I'm not sure how useful measuring the interval between
> interrupt and ISR. It's such a small component of the total latency
> value that it usually gets lost in the noise.=20
I don't think that you can neglect these numbers in a hard rt environme=
nt.
As far as i understand, the irq-tasklet has to be scheduled by the kern=
el.
> If you are wanting to decompose the latency into it's components on R=
T,
> I think you'd have:
> 	1. ISR latency
> 	2. Scheduler latency for IRQ thread
> 	3. IRQ handler time
> 	4. Scheduler latency for user-space thread
> Cyclictest measures the aggregate of all these.
One good aproach to minimize user mode latency are probably user mode d=
rivers.=20
This approach has been presented at the Embedded in N=C3=BCrnberg this =
year by=20
linutronix. So you can shave off #2 of the above list. Which means only=
 one=20
rescheduling runs instead of two. Usermode has of course to be run with=
 rt=20
priority.

Tim
--=20
''=3D~('(?{'.('._@@[~'^'^-)./^').'"'.('}@@~-]@_^__'^'))-^~<.;;-}').',$/=
})')
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
