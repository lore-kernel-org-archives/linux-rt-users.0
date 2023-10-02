Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B981BDDC
	for <linux-rt-users@vger.kernel.org>; Mon,  2 Oct 2023 15:20:25 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B543DD
	for <linux-rt-users@vger.kernel.org>; Mon,  2 Oct 2023 08:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1696260008; x=1696864808; i=efault@gmx.de;
 bh=WvFv/02aIRQRfW/WN5YGX90t8mwO4vULzSd8xWRLid8=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=PA8/IpoeObhhr80fE8e6WmdChHKyPHP2CMu0ADhS7+kdZsPcgPDmyGh1vkwKHXd4WQT90XHQ2iK
 gf4inMZiC8GfPMSWTf59SZ5ayOOwEEwOK701wURDB7hp7hE84tMJyi0CnK5xBrwX8CZJO0qaq6bu6
 ht+TPHnOas1GtAROAG6gi+hJDFheAhQAhtuQuwsR13s0eLsWkvZmJXCtRDSwdygsLeX3XROTe3A/k
 KtQFnlOPiBjSThuqVL1tV7g4qBUJp5NH4uY6shHIEPkLG6qslqjcLOL63NicVAwFIbZG5nqCjvbNb
 XA6VUqC/OuzH/C7kuIA3eYhfFZe56KRgf3wA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([212.114.172.11]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfYPY-1rFleC27dQ-00fwNs; Mon, 02
 Oct 2023 17:20:08 +0200
Message-ID: <ff0a3f22a6bc5719e474e9a2d0f7202df30f8323.camel@gmx.de>
Subject: Re: High latency of a system based on 5.19 rt
From: Mike Galbraith <efault@gmx.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Clark Williams <williams@redhat.com>, "g.medini" <g.medini@eurosoft.it>,
 RT <linux-rt-users@vger.kernel.org>
Date: Mon, 02 Oct 2023 17:20:07 +0200
In-Reply-To: <20231002141611.f1H8qyiR@linutronix.de>
References: <S1JV78$805284328FE38E68AC9E7D23F35846D8@eurosoft.it>
	 <f9fd60d19937c4e22407738f2d78b3ca4a7887d8.camel@gmx.de>
	 <CAMLffL8=zW0Bv47R=r3=Lh9==OjDrM=FTJZgmm6PYGOyTedeBA@mail.gmail.com>
	 <8eb75f2118086edf828ac059999fd52b64382576.camel@gmx.de>
	 <20231002100542.59fbxJ0f@linutronix.de>
	 <8586b9812dccc6248e0518efaf973c4467324b70.camel@gmx.de>
	 <20231002141611.f1H8qyiR@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y2BcSNpx8PQGt7/6QEDPvI017oAnxhNqfp/0pgqChWv8MR9RnI9
 CklnvW4n2VQYFyUw8rWxGlvAwNE3+UoWLk6TeQg+AI6PoF32INUzx7mEcOidyDOZWbr5r0+
 CBxTEacZ2fwYKA4S9c5BHJXlOM97iSM0Pv+Xjgu7sl4KepTtcbLOS9NbIQ8QYGoJD6nv/yg
 6rE55gdxX3hbgKitYe0TA==
UI-OutboundReport: notjunk:1;M01:P0:p5mzxco8UAk=;YF5d0UC8XH1vHHDIqHEF92AU4CS
 mvX3X6zODjxe2LXSvnMTaxYZNveYnnKQrKF0ca9aTtf/KJbjrKLSfgDR4DaEX+vQ+ttowM4g5
 v2/vLyf0PmTb3vuoZW0u/dquF0snE/OMXdesmot+yCl6Y6iRLdj/VFk0eFHHdFyfqCB39Ij9U
 GqoTVzowarF6VTjAfb4F64vob5hBhBKraf8PtQqnxT9+cVxTbojddtZA3E8XGvvRNW2vbTSF4
 ceUxgUBCbwg58tVCBwewErXMMN1QPUBXjeLbJFQ1nlHq5uTv3/CnY0zCq/Gi2mwTHWDqcRGjb
 Kit1WGYEXpCS24mZBHFnMOSjmqpFeqfS13G+ShBhmgsHCADChLoaVEqWZnMvmjq1nv5pbv5te
 DPQ8fGIS+r25TH1foKQ6OwS+efCkYImqQATGiYGYAZxxvh9uBIec1cBgvBd0xklz5YGckGeXY
 +Y5TBAOAVjnV2UBZ9rIJOme8Dtkt3DRt9w2tkbp9y4qZ+g1j618073sVdLuvrSsWbNnEXlplv
 Hkr+S3d3lmeXpUtj16yPJuUtp8R1gkSqfCcWrhYBmjj5fEZU5PRaozLMmmym+yWhZpojUasoT
 GoacQf0kBcrkaNydKxeAcUV0Zzy/dlTOcyUwmmKP7l86duz9PVg3jdN28HKYAKjboy9/XNzFG
 aWFZv99iXowipOdv5E+YDoerQCsj+GvY24t9PErNKRYDa1GawuFyhh98Fta7SrBw5vo6PbDRi
 tVJlilhcQN47iYcYwEKD9V0yEMsLBTigbxD2XGrIPn2kfyZZiZm6w/JMdtRavu7Ucn/lteEYI
 AgNhrH9c4q7WXYksMTk7Yqci3ToJbN3vYBYahO6UIls9nLhNJh2v8WPpUxZLufH+C97v9ABjU
 wchtisa0oZKeamRsgA2V4ckvGiYsQam63LRhuCXcm1F49XTUw9czs0UDarUqhe9eYa3V2S9ng
 Oh40vA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-10-02 at 16:16 +0200, Sebastian Andrzej Siewior wrote:
> On 2023-10-02 13:58:57 [+0200], Mike Galbraith wrote:
> > > Why not perform all wakes from hardirq then?
> >
> > Sounds good to me iff we're talking about a dinky irq width delta.
> >
> > Threads bundling up what are otherwise irq context cycles is loaded
> > with goodness, but static priority leaves you holding a bill and payin=
g
> > context switch fees on top.=C2=A0 Pick your poison carefully applies I
> > suppose.=C2=A0 A tiny swig of hemlock can't do _too_ much harm, right =
;-)
>
> A swarm of wake-ups for SCHED_OTHER at prio 50+ will delay your threaded
> interrupt handler and everything else that runs 50 and lower.
> Since SCHED_OTHER is less important than any RT task, the delay is
> usually of lower concern.

Sure, but you also have to weigh when to stop caring about inversion.=C2=
=A0
I'd personally prefer an ever so slightly wider IRQ, but yeah, there is
no free lunch, it's a trade.

(wrt SCHED_OTHER wakeup swarm, in an environment where it's a concern,
those perturbations are likely the least of your perturbation worries)

	-Mike
