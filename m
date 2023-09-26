Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7665224
	for <linux-rt-users@vger.kernel.org>; Tue, 26 Sep 2023 07:05:04 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2AC10A
	for <linux-rt-users@vger.kernel.org>; Tue, 26 Sep 2023 00:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695711900; x=1696316700; i=efault@gmx.de;
 bh=dELpIer4B2Ktt1OMCXM3MU11k6av2ouwgy1mgx8z9As=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=UIw0q88eWyjuBsPqk4ltCac/LO8msvd2Fv3HSNH0NFqGBdYHLSOSnCXdXlaqMAemXIAPOoOxVae
 nNSBJOB7geKAJaDB8pGCXHYaokfz3qMlgCV7OqomQiwwJfUoXYQ9/Y1i51OatDy5721d1I9S7Gw1E
 DZedm6YYrAVY1xnjuJOATRNPOHRA7zc8+3uuWM13GZvp++6znDHdCA24bJvae6Ehd275yuao4IN7G
 SOV/sONr2hX/3N4Zjnu+S5rcw4rGFng/ooVUnFCqD186b1mpqnJ8Ht1iOSubKusBGy3Nba32anqUw
 GmOF8Qtgk7p9nEeXqY+2flLJAlyDwGljD8EQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.221.150.19]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLiCo-1r2hXH3beK-00HgIZ; Tue, 26
 Sep 2023 09:04:59 +0200
Message-ID: <f9fd60d19937c4e22407738f2d78b3ca4a7887d8.camel@gmx.de>
Subject: Re: High latency of a system based on 5.19 rt
From: Mike Galbraith <efault@gmx.de>
To: "g.medini" <g.medini@eurosoft.it>
Cc: RT <linux-rt-users@vger.kernel.org>
Date: Tue, 26 Sep 2023 09:04:59 +0200
In-Reply-To: <S1JV78$805284328FE38E68AC9E7D23F35846D8@eurosoft.it>
References: <S1JV78$805284328FE38E68AC9E7D23F35846D8@eurosoft.it>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FYdW+XomwN9VuIhE+Gt+OUaw1mTs42KMH+KP7BOnadCwi/NHraj
 EwP/3OmZ2SQT8JFo36Vb/vX9EEdTESzBaU3IJSE2AZiIshmGIKGZAGCbvSpdAIR5bQzrzrx
 YeWBkVHN4cOTBYajnoJXVZic4Ykxst6rM9mzrq/TQxNbHq7PhER1KjB58ZunOs5HZ8RtHuM
 T7SyOCtlzrtxVUhmThiQQ==
UI-OutboundReport: notjunk:1;M01:P0:Uu6JpTgwo/k=;UX89XQ/G6RTwOHBth0Yne3cIUlY
 T7G7UH7ArhRb8Vqi9R9J6ulTy1eW4OGfolC8kAFToa3KhCJ1TIzS5Vv9DV/CfzaFejSgZmnk8
 sVaZT53z2Mp+cgd/1rZfprFJqEV6eoQUVjYxLgpI4OB/UhV3XMQBVaSYR5mQLEQIXakCMCEsY
 Cp5KxOI3VG4Ix3+I4CnGmKnfzCOSpnI8G6WsJcEut5hFhbAyKgZ9IL12/+nPCV1DC4SWRUDNK
 J16Ni7QS0pgVKhnLSdmkX/PV7mGz1h19PgTyYGYAlTtbJaKGQwDi35vmc5FCdxYbMEbejnCt3
 ILkjHN+hJ4dBk2XeTk8RcsAaezUaeSx4+ck8okxEAkXTq1phy63fCIRYxvyElbiMsYL9kIsH9
 u8pnUomfyeJUVAVtErnaC8owEdqwKdOZCi2fZ2yun1mFf1czUqwodv7Qx17jwS7/MnIiXfH0T
 nl1zk77gdnoN8+jzP1vjZekrGwhjyCYjnT/42g71Cmdh8N06LNsR7tMpy133sutGk3jhRUYAS
 djIgEfRtM2Uv5i9xdGYo5m5A7/KccWYq7PX0wn6lQI94qlMzTLFlWWapJXk+iGfsLPPWa6I3e
 fpJ4Z8brobviKP176CPcVwzPaw+n2DMbv/k3ZKG4aPuDWWAW/f7FdjWs6RykQFEwCcCQTPBI9
 AfPoX4nYaQ9A0BMFSUb9Dj7oJcbc1snTt7Y+eKrvYOCLohOs5ZtjkmjGsSqreSiV4JBwN5PX0
 AxTS96hOhoQccUEoqp5VuRSnXC7u3hbCGJ9Jt21KLIPibeHrD8KFV8UVdoC26CRI2oRjtZcDw
 xFQurcXiURU9pw96TRDIjWtlT1hyF1xDiIW0KIJmd1twqtnkiN7vM/hymH/8IAS84ZvLYcUAG
 OMFROhCY0wZJ7gyW2YbTUxsvBywa4n+pXgiTTouy23eviYeCdvmULKn+HeG5bPCc93INttwaZ
 xoELN/Dutxs8ecOempjyjuoGG9w=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-09-25 at 18:30 +0200, g.medini@eurosoft.it wrote:
> # tracer: wakeup_rt
> #
> # wakeup_rt latency trace v1.1.5 on 5.19.0-rt10
> # --------------------------------------------------------------------
> # latency: 357 us, #401/401, CPU#0 | (M:preempt_rt VP:0, KP:0, SP:0 HP:0=
 #P:2)
> #=C2=A0=C2=A0=C2=A0 -----------------
> #=C2=A0=C2=A0=C2=A0 | task: ktimers/0-15 (uid:0 nice:0 policy:1 rt_prio:=
1)
> #=C2=A0=C2=A0=C2=A0 -----------------

The first thing that pokes me in the eye is that priority. I'd bump
that a lot.  As it sits, anything high priority ktimers may wake when
it finally gets the CPU gets to enjoy all the latency ktimers is eating
in this trace due to it having been deemed relatively unimportant.

Trace starting at 37us vs 0 makes me suspect box wasn't being all it
can be at the time.  Dunno if that's the case, but I'd suggest taking
cpufreq out of the picture when latency source hunting in general.

	-Mike
