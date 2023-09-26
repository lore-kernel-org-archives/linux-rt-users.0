Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8A55394
	for <linux-rt-users@vger.kernel.org>; Tue, 26 Sep 2023 13:16:02 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAE8101
	for <linux-rt-users@vger.kernel.org>; Tue, 26 Sep 2023 06:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695734147; x=1696338947; i=efault@gmx.de;
 bh=uKp0BeHfT40Orzb6pYaeknAmouoCQ+p1W0JIJQ6kP0U=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=pqzfD4Y1f7lcjXXhYfGpbVuvhxvbL++EKCSwuNIRm0m/UX2TyWUEJXPuolRXXa8oOfFlc7353PZ
 k5osJ2Y77NXO7gDPafMoZ0ctSx4h+t/gcAgnzQnlNYgIoy85Q29WpsO3TX3ACZBQyIWUCkT1rl1CY
 3KdTb7thGifHN6JBmqf3fr5S4xScfOphW9clg2UyI/DQFjG1aliQysHbFDaZR45GlMwlHPeVuKguE
 0X4d7svlnZSSE5P52rS+FVraQgDBuadZCBq7XWrZy/wHxNhB6ppjQgOk0zItBVdtQC6LRCrqkRMeh
 XycVSIE8GRgIHj+97xTobGVJNd6H+vptTTlA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.221.150.19]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5wPh-1qicwq1y95-007WhX; Tue, 26
 Sep 2023 15:15:47 +0200
Message-ID: <8eb75f2118086edf828ac059999fd52b64382576.camel@gmx.de>
Subject: Re: High latency of a system based on 5.19 rt
From: Mike Galbraith <efault@gmx.de>
To: Clark Williams <williams@redhat.com>
Cc: "g.medini" <g.medini@eurosoft.it>, RT <linux-rt-users@vger.kernel.org>
Date: Tue, 26 Sep 2023 15:15:46 +0200
In-Reply-To: <CAMLffL8=zW0Bv47R=r3=Lh9==OjDrM=FTJZgmm6PYGOyTedeBA@mail.gmail.com>
References: <S1JV78$805284328FE38E68AC9E7D23F35846D8@eurosoft.it>
	 <f9fd60d19937c4e22407738f2d78b3ca4a7887d8.camel@gmx.de>
	 <CAMLffL8=zW0Bv47R=r3=Lh9==OjDrM=FTJZgmm6PYGOyTedeBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3HeWyF+nNgR2ZhXE4gRW42vs7J9+T1N8bX2lvKKb1uZBnhk9fp8
 OrCcs4AD0s+Kg+f/HnBWG12QenUIvyQ06agoJwLSNTVmafikb88Mt64JWbG4hSAy+lC8+/7
 bicFlXowzmytIqmFNhi9Pu6RJtVb+rTCS9w9YtaD+uc+IeYbCzzapCoJjiMYfqUX3P60FbK
 6baztY4u+6dbG18TYSGHQ==
UI-OutboundReport: notjunk:1;M01:P0:lmS/hLEWePM=;DYocrEV97CULYkl9+ahh3tNGG+T
 zCm2L3H10IgjDAlAVJRbeo+wgmfMmsMbt7Rhm7AXAi1TVlXWgey0gtVtklWNxEIW1oL9qFVki
 ABjV7klFPnU/DRdh+FUsuIeVETgQSCosj59RfTe7KS29XIkEOH7967OownWvNQelzIUNaaAIH
 8+crsSpUq5wLJ/MJ3Ha9WuKk7FAC/yRYlNB9R7kxjjaS1a28pLhuTmZkPz5hH2j4PTlnqKT3G
 lsw0KuhFTfHReKPMyx0kcPLaqMvHohTgAsKrpfZI68VW3uLrO+eDXz05eKi68l2ZvmQJEUvgF
 rze8wx4xDf1tFP3CRCXS0uVflpsY+s+ogwWpRq9fVaT0qRN3OQnG+IerCgvQD69zivPnD0Gyo
 BS1+jAmOw1WgU9lySJ3laoMuC3qFsC0Sk2YY5ZOO6ub1Re0rWiRiSyiScrPCUfuGMboRnvZll
 K8uuwWCZOJkojSwNqnkTgeuhs+jWy5nu49UTQ3A7ZSi05sgIcyUdqXb5LmtacDwLbXP9c7ung
 uoY5rBXv+/7vy6AVIGZlX//mwwCW0hSFmeKOVxVSg6mtbmqQoFDp31wC4igHeBJl/ZCuLy2Hn
 oRikhIGL60XaIYX5OY/rRYwfIT07ix6vNwmY2LN7ETKVNMt4FXcGNjdX+9/B1fML/iAO0hWde
 6h4LLvC2tFFy9FWTAcLJq0VFgE9joqJc88s9BRXlMPH4VeUNNH6oFlaMuw4GboX2zVewgI2WO
 M5NnppRJXqoKjgf8BNseirtHilWCH3obOQMb5f+CmSFZlL3Z8AZSxniU7xj94iXviPLQhiH10
 XNvZTPjNj72FOqi1ETXnD23WmTyFAWWhYkVuRpBGSi+7qLTSTIFXB+l/EM0kqaRIkRm2HqHN9
 MzG/CwVUPcBCnZAKajDxF8KKfkHV1Zt/IHTU4iBG1a5Y8SU/Z2mu34paeNOxyn/KJOoRErfvJ
 LwYTgv5+AuBIM0aa7lgzjKyukFM=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-09-26 at 12:30 +0000, Clark Williams wrote:
> On Tue, Sep 26, 2023 at 7:05=E2=80=AFAM Mike Galbraith <efault@gmx.de> w=
rote:
> > On Mon, 2023-09-25 at 18:30 +0200, g.medini@eurosoft.it wrote:
> > > # tracer: wakeup_rt
> > > #
> > > # wakeup_rt latency trace v1.1.5 on 5.19.0-rt10
> > > # ------------------------------------------------------------------=
--
> > > # latency: 357 us, #401/401, CPU#0 | (M:preempt_rt VP:0, KP:0, SP:0 =
HP:0 #P:2)
> > > #=C2=A0=C2=A0=C2=A0 -----------------
> > > #=C2=A0=C2=A0=C2=A0 | task: ktimers/0-15 (uid:0 nice:0 policy:1 rt_p=
rio:1)
> > > #=C2=A0=C2=A0=C2=A0 -----------------
> >
> > The first thing that pokes me in the eye is that priority. I'd bump
> > that a lot.=C2=A0 As it sits, anything high priority ktimers may wake =
when
> > it finally gets the CPU gets to enjoy all the latency ktimers is eatin=
g
> > in this trace due to it having been deemed relatively unimportant.
>
> Hmmm, IRQs are running at FIFO:50 by default. Do we want the ktimer
> running above the IRQ service thread?=C2=A0

I think so yeah, quick like bunny wakeup resource should punch through.

	-Mike
