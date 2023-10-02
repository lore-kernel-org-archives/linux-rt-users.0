Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E631944C
	for <linux-rt-users@vger.kernel.org>; Mon,  2 Oct 2023 13:57:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8725D9
	for <linux-rt-users@vger.kernel.org>; Mon,  2 Oct 2023 06:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696255058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M8WYdzef3dhUYZw3DH0bBi+1f62S5ySyKU54RTq989w=;
	b=TOGQCjjkkzr5UntYDftf7RyCoD2WoWZ96I54es7YeU9e9bY2APPldTS+t7DcUMIsBl2eR0
	QgS5sAw/rxr/PS4vDJBLIvebpQ3ZgiaR/0wOD7QiPYDIIFfHHrdrX1e9RBW58EkUIdga2G
	JwyPdjaG/nvdPhPDrgs9cwjtRGULNKY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-Bndkv5YxOe63XXYfXqdc3g-1; Mon, 02 Oct 2023 09:57:36 -0400
X-MC-Unique: Bndkv5YxOe63XXYfXqdc3g-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4180de770f5so209487691cf.2
        for <linux-rt-users@vger.kernel.org>; Mon, 02 Oct 2023 06:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696255056; x=1696859856;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M8WYdzef3dhUYZw3DH0bBi+1f62S5ySyKU54RTq989w=;
        b=tTF/CPU2w+m81uTt7l7OeF2mpchQrX1OQEdJ7y0q1kxge9wizF3RcPoxLnfBK+qLKe
         hnHI9SnwuTry2bEJs/dyVrJYd2Nc/f1ztXmy6MfCV0kWZr5g7QTXWSMDq7H2uxFBVX1+
         eXZAAEALDTIOgDZBeDWePChc67M42gTg+gVS2er08EdFpHScilDLb4Iw3aIzmzprpNXZ
         q1Af1Yof7tGifH+++DGgAf+pJ51grOABbwepYo8ha4V2lAm+Uf9Yg1fCGwf6Itike9s4
         kbVLWA3SENVqMTr0Pd9cYlDZjz2vTlINd20H/TJ0+KYyZY3Gt1AXM2rjUw/iKhxrqLlE
         XwGg==
X-Gm-Message-State: AOJu0YxnaCpIsscYZnN/lraK/CESZuf312Ho5xs+G+TCvibj3ygmiRdj
	V36a8gtVquvcSJKXOPz68rZ22ZBqgmSOy0zrCuXYmrHLxkQhDqMHvKpTWjM6HjC7wZPQEGczjk5
	/J8ndhHza/NQJuHNzh3qXbcsMUzxifJPhcKQ=
X-Received: by 2002:ac8:58c5:0:b0:418:4e7:b82c with SMTP id u5-20020ac858c5000000b0041804e7b82cmr15356416qta.57.1696255056001;
        Mon, 02 Oct 2023 06:57:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFqqH2hLZLdUz2hZHgPn/1hd6wxw8eYP65VHIjQN4f059HcEmEoL26OMfQzDI+qIGKcMwU0g==
X-Received: by 2002:ac8:58c5:0:b0:418:4e7:b82c with SMTP id u5-20020ac858c5000000b0041804e7b82cmr15356401qta.57.1696255055721;
        Mon, 02 Oct 2023 06:57:35 -0700 (PDT)
Received: from thinkpad2021 ([64.99.149.73])
        by smtp.gmail.com with ESMTPSA id i6-20020ac813c6000000b0041817637873sm5831638qtj.9.2023.10.02.06.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 06:57:35 -0700 (PDT)
Date: Mon, 2 Oct 2023 09:57:33 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	kernel-rts-sst <kernel-rts-sst@redhat.com>, jlelli@redhat.com
Subject: Re: Crash with 6.6.0-rc1-rt1 and several i915 locking call traces
 with v6.5.2-rt8 and gnome-shell on Alder Lake laptop
Message-ID: <ZRrMTfZsM9bv4GiF@thinkpad2021>
References: <ZQttJ8W9UFP46E1b@thinkpad2021>
 <20230922110720.AZ03l3A9@linutronix.de>
 <ZRaONA0LSFumpyja@thinkpad2021>
 <F4pA9qG-zsUd2s-KZZ8oHrbd@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F4pA9qG-zsUd2s-KZZ8oHrbd@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 02, 2023 at 11:45:45AM +0200, Sebastian Andrzej Siewior wrote:
> I looked at the traces in this email and they originate from a
> might_sleep() in guc_context_set_prio(). The reason is that they check
> at the atomic/interrupt state to figure out if they can sleep or not.
> Both checks don't work on RT as intended and the former has a not to not
> be used in drivers…
> 
> The snippet below should cure this. Could you test, please.
> 
> Sebastian
>

I tested this at both boot and suspend/resume. No call traces reported.

Thank you Sebastian.

