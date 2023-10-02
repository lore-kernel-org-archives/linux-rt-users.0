Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE73715E8F
	for <linux-rt-users@vger.kernel.org>; Mon,  2 Oct 2023 11:59:13 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5459EC6
	for <linux-rt-users@vger.kernel.org>; Mon,  2 Oct 2023 04:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1696247937; x=1696852737; i=efault@gmx.de;
 bh=qnxiMRt0CkTFMGwMdqutJEhBRYflM/ED2dxxzy+lB38=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=ROO1VGZdYaOQFqDiLMU7LwhuZtX81Sxeep6KJc3OUxORuERUq4mvRSSKJrShmRhzyEKJApo/za1
 pmYVirMl3ipe5uoIKNt9knt7UBn699VfvkHbUIWSKwS4/bFDTCUZLrljK4F3SJH78clEJ7P5DOdA3
 OFBZyHDf1n0cQa4y7MZOlKSaGxTqXLCaVvORR4Q3hISyyqFrUC4Z3ayiXnlHm3ue7zoUp0wc69m26
 SQ3aAJOh9Z4blIFdvuXQT2cYHxvudCErAFWLdxjb4FsoP8X55u2NE1rmXVe0q/J03N/YMFwyWvEkI
 rw/h1rGMebmPpDxxpxaRRPX2H+fVFSuvJwsA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([212.114.172.11]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7QxB-1rhY0S3789-017o63; Mon, 02
 Oct 2023 13:58:57 +0200
Message-ID: <8586b9812dccc6248e0518efaf973c4467324b70.camel@gmx.de>
Subject: Re: High latency of a system based on 5.19 rt
From: Mike Galbraith <efault@gmx.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Clark Williams <williams@redhat.com>, "g.medini" <g.medini@eurosoft.it>,
 RT <linux-rt-users@vger.kernel.org>
Date: Mon, 02 Oct 2023 13:58:57 +0200
In-Reply-To: <20231002100542.59fbxJ0f@linutronix.de>
References: <S1JV78$805284328FE38E68AC9E7D23F35846D8@eurosoft.it>
	 <f9fd60d19937c4e22407738f2d78b3ca4a7887d8.camel@gmx.de>
	 <CAMLffL8=zW0Bv47R=r3=Lh9==OjDrM=FTJZgmm6PYGOyTedeBA@mail.gmail.com>
	 <8eb75f2118086edf828ac059999fd52b64382576.camel@gmx.de>
	 <20231002100542.59fbxJ0f@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QqTIKDagIOTBh6W5xDqDAAWV+HXDCWutb8UiQLfPnBMV3dSRX+v
 NubK7Zq4SjhcdJyqGOZ2p/bAaNhQ013GL+hyUL2DfuF/1jTNKnbiahGp8rKyNQik5ExiRVl
 MITudGbP/a3iiNtda0/tPSELTpPfni5Is+L2JwnHGg3bXNsCWf7HhWiZbuN1CbD6Y0nCBPa
 dpcsLxK36+zpc4f+6JXzw==
UI-OutboundReport: notjunk:1;M01:P0:rquNtRMlWE8=;YltqookZy+ErzbC19/s891lw0mY
 0d7K9lRxACCVxeJLs8z0ZLMHJE64VkzFTRnFf46mmP8yGkaHDywDXKfl51R2TK7qk0JqvgPnd
 haKS3uJpyeix8o//mYfaMh65DmTA3Y0xJu2PaT98Jtfiv52wFmPeSHmXUwi2Y7/SGeSclWquH
 NAsCEH50U4ZHKIcpWkN1uR9L8ueanXC1N8PvyYxv/h4JW8u82ufemAmWkCVZe5DeiskRKYz1m
 dzZZYugeC5nlp1btppMwm/kBejSOrp3SUtlie/SzJK5zQlsVzjfU9iVrEYNL18Jb0ybB3C7pf
 ZPRuf8Y651Vz5A3N2S8X+sic1LF/a13l6C6FnySPkFNFUP0xt9D39ldPb2ydVqVL1L+9dnk/q
 3gy9R2WBRF1AwN+shR0AJ78U8IY0zrV620UvNhSVlU31CK4Vem1IBgW4YJKW26wFR8K4G5241
 d+Un1Jc+4jdYnOOLkyifraw0RTnsgCbUjIBv7Depv3OOkhBntTseKpTGkSR/GlSSkhPGUnPCB
 5/tOhoDfftiW97lkFKL9j/vGhyY4XdU0sxTMaD3ZxWs3XzWDj3WjjNjc33BssK+xCjZ1wKMvJ
 cOHnFfKB88d4ahJHCO8yBH2Bs5dnsnjTNiamRLqFoLVwHAyZCQO7AVp0OP+cUE9BWdyHdJGjj
 Lss5i0slO6NvCbxsEptGOPvFqbYf0L7HXSKVRol8BVwKv11kat6lzpASTKY7/6LsKMjyqe7Q1
 N7AFEMk512h8EFQ9OA+5WXfiZJYvk8LgpzPtauGO2Jr2AdMN2WP5aclYU/yAinOrH68uaq50V
 HePwJgLW3qf9gUgECSBZCLMnJ6NqEbVinxMMooPNORA6VZL22sRcqv/QtQafwTIbW2HNh6SRr
 Hh8J21JJSk+3Fy9cWl59DaKuPQBCL8AdYaslyBGaWVyXgswWP87TebZvQ4zY9jkGgRnCyLX0a
 0c5Hrr8SWGMDDjIUlSVDMvyQcbc=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-10-02 at 12:05 +0200, Sebastian Andrzej Siewior wrote:
> On 2023-09-26 15:15:46 [+0200], Mike Galbraith wrote:
> > On Tue, 2023-09-26 at 12:30 +0000, Clark Williams wrote:
> > > On Tue, Sep 26, 2023 at 7:05=E2=80=AFAM Mike Galbraith <efault@gmx.d=
e> wrote:
> > > > On Mon, 2023-09-25 at 18:30 +0200, g.medini@eurosoft.it=C2=A0wrote=
:
> > > > > # tracer: wakeup_rt
> > > > > #
> > > > > # wakeup_rt latency trace v1.1.5 on 5.19.0-rt10
> > > > > # --------------------------------------------------------------=
------
> > > > > # latency: 357 us, #401/401, CPU#0 | (M:preempt_rt VP:0, KP:0, S=
P:0 HP:0 #P:2)
> > > > > #=C2=A0=C2=A0=C2=A0 -----------------
> > > > > #=C2=A0=C2=A0=C2=A0 | task: ktimers/0-15 (uid:0 nice:0 policy:1 =
rt_prio:1)
> > > > > #=C2=A0=C2=A0=C2=A0 -----------------
> > > >
> > > > The first thing that pokes me in the eye is that priority. I'd bum=
p
> > > > that a lot.=C2=A0 As it sits, anything high priority ktimers may w=
ake when
> > > > it finally gets the CPU gets to enjoy all the latency ktimers is e=
ating
> > > > in this trace due to it having been deemed relatively unimportant.
> > >
> > > Hmmm, IRQs are running at FIFO:50 by default. Do we want the ktimer
> > > running above the IRQ service thread?=C2=A0
> >
> > I think so yeah, quick like bunny wakeup resource should punch through=
.
>
> Why not perform all wakes from hardirq then?

Sounds good to me iff we're talking about a dinky irq width delta.

Threads bundling up what are otherwise irq context cycles is loaded
with goodness, but static priority leaves you holding a bill and paying
context switch fees on top.  Pick your poison carefully applies I
suppose.  A tiny swig of hemlock can't do _too_ much harm, right ;-)

	-Mike
