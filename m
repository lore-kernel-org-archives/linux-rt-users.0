Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DD12F2A
	for <linux-rt-users@vger.kernel.org>; Tue, 26 Sep 2023 12:35:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125CFFC
	for <linux-rt-users@vger.kernel.org>; Tue, 26 Sep 2023 05:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695731699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PMBYrmeYagmLKB1j3eOUZLM4JtgnhgN/D3eQANI764Q=;
	b=P3iJ12DjJv9lXKxWEd9BNV4stHro/GpPK5qvzcYiThCGqjLwyZ4MTANLY6rvuowDvyIphf
	KczfSg8r9X1iMob9l5COMnYXBFyfTUEQhrRk2GmQzh6hRZBSgLGD7viHB+jitnEl9k5gsH
	CJzrr0NGN+Zpv3Or+nmMjCTx3boc6R8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-XW3stxCaMBeOCkn2_BGsrQ-1; Tue, 26 Sep 2023 08:34:57 -0400
X-MC-Unique: XW3stxCaMBeOCkn2_BGsrQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-32329974dbdso3254445f8f.0
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Sep 2023 05:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695731696; x=1696336496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMBYrmeYagmLKB1j3eOUZLM4JtgnhgN/D3eQANI764Q=;
        b=rnAETClGK5OFhRVznpJP2PUF5mLIcn1wtLX3cSAeL1awzmgwDdo98f6cx+5x4KTATN
         KzwWXBh72dF0ZzMNAnGaoIRd/iXQYg1W40Ac7e3jmopINEov4p3ImeE+mht4daRRzIGv
         G/qSVTHShgvvk3N5milhXH9gxbHSHwmDVBaZYGopadvz7kN954QNxqZEJb/vsamaEM48
         EmjN7F2Mm+2HxNijxn8Vf2PVChxYCtvlEB1VZGiCo21lMY02qQrUTDl0an7GmmXEPRzO
         IjQglO/RI2HNLuhQm2TkuYpbn8ACIaRn0ZfoCt70A3zubJ+5kR1Lh2wVN8P/PgRfrkNN
         ki5g==
X-Gm-Message-State: AOJu0YxDRdexB+PUotyiApjkDc33uLR8wRhq4/LzzXLBb/yUykUPuBsC
	mJeUakeBBbsE3yEoNYQGiTC3o8xHFurDYDhbi5M5itS2anh//Pq2MTNza7lJNnvIKfPqdyFCRfN
	y9/41sKfKTMyyDREHum9ze5sReED6MQnTQqFVyrQ3Q/k=
X-Received: by 2002:a5d:408c:0:b0:31f:f753:5897 with SMTP id o12-20020a5d408c000000b0031ff7535897mr9060657wrp.59.1695731696748;
        Tue, 26 Sep 2023 05:34:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELDIV5OYLluYg6CCX5XE3GZft3U+5d7DGd3gqIjZzMqg9j0YONyo25yVTA9FaLob29WUwIO444iNLqHlCke/c=
X-Received: by 2002:a5d:408c:0:b0:31f:f753:5897 with SMTP id
 o12-20020a5d408c000000b0031ff7535897mr9060635wrp.59.1695731696415; Tue, 26
 Sep 2023 05:34:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <S1JV78$805284328FE38E68AC9E7D23F35846D8@eurosoft.it> <f9fd60d19937c4e22407738f2d78b3ca4a7887d8.camel@gmx.de>
In-Reply-To: <f9fd60d19937c4e22407738f2d78b3ca4a7887d8.camel@gmx.de>
From: Clark Williams <williams@redhat.com>
Date: Tue, 26 Sep 2023 12:34:45 +0000
Message-ID: <CAMLffL8+PxkR-VyE-Y+b26Fyj5QZzryzGPjJTd-WcZTd8SGqog@mail.gmail.com>
Subject: Re: High latency of a system based on 5.19 rt
To: Mike Galbraith <efault@gmx.de>
Cc: "g.medini" <g.medini@eurosoft.it>, RT <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 7:05=E2=80=AFAM Mike Galbraith <efault@gmx.de> wrot=
e:
>
> On Mon, 2023-09-25 at 18:30 +0200, g.medini@eurosoft.it wrote:
> > # tracer: wakeup_rt
> > #
> > # wakeup_rt latency trace v1.1.5 on 5.19.0-rt10
> > # --------------------------------------------------------------------
> > # latency: 357 us, #401/401, CPU#0 | (M:preempt_rt VP:0, KP:0, SP:0 HP:=
0 #P:2)
> > #    -----------------
> > #    | task: ktimers/0-15 (uid:0 nice:0 policy:1 rt_prio:1)
> > #    -----------------
>
> The first thing that pokes me in the eye is that priority. I'd bump
> that a lot.  As it sits, anything high priority ktimers may wake when
> it finally gets the CPU gets to enjoy all the latency ktimers is eating
> in this trace due to it having been deemed relatively unimportant.
>

Hmmm, IRQs are running at fifo:50. Do we want the ktimer thread(s)
running at higher prio than the IRQ thread?

Clark

