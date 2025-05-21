Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702191E2606
	for <linux-rt-users@vger.kernel.org>; Wed, 21 May 2025 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841881; cv=none; b=F/Dj3Lka1vtnNVtQknBXf8GCMSyxDKd9+vyLNkA+CKuZTShdP3Yu1Hp4ydFaGf441AK/Es9rGQa19mAim4TYa2kGdFWb3LmtaBYzj/s++rUjJ8wU5zIPqBqlBSdWXZyhJBh6+ifIHlKeIjOp8OWqAkwj9tfTlw7ZT1Iplx7RQkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841881; c=relaxed/simple;
	bh=mOFwZi8uF/Vd7QR19RQnmQPwENX+UWRgxsy3kizbkWA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k2ODKSdx1wj/EKYZAff3O3cYIPDVhWMFUUvMzz06OAXYWkWubvNO6pXTmXMgP362y43l1ofiPSigEOeTeeCDVM5yMC+tSiqy1zLeTFaLFaqdQ0N0W7HYtNRJS8GdZu18E7qCUvGxt4MpWarDIiddkFNOYurC5t2yW1fpb3UyKw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CCNipJKN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CCNipJKN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747841878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4OYI585nduQE5fAKYci/xXzRDgiHeBkKRLTnL/6NwgA=;
	b=CCNipJKN/k89nGBdgOdnknhJqmjAbb19znfU7J5gycbbcHoCdB7M3AdQqb19hYxCrfp+s0
	QjMlb9CMTMqt2eot22VUOonI6eDEuJwZmjoVD8pEcKJ72paR3kCpFirjYTPgrxzzqFudgG
	G1wWXuQd5wNdK4MEDvq5FQzXj7E5c0c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-53g7MxNWMHyCcomn4aBpYw-1; Wed, 21 May 2025 11:37:57 -0400
X-MC-Unique: 53g7MxNWMHyCcomn4aBpYw-1
X-Mimecast-MFC-AGG-ID: 53g7MxNWMHyCcomn4aBpYw_1747841876
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-442fa43e018so31160695e9.0
        for <linux-rt-users@vger.kernel.org>; Wed, 21 May 2025 08:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747841876; x=1748446676;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4OYI585nduQE5fAKYci/xXzRDgiHeBkKRLTnL/6NwgA=;
        b=LZu0MSwUeCO4GrI7ns6/RK3AKi9xkuQmohHEo39mtL7Lx32TtziDJnh3DK2yZnhJ87
         NmPYov5BsXJ9RclvW9HeVUkt++D93QvfXXO7kQmgNkTee1cV0kkT9BE1hW5WWq7uDhx/
         FydmbXzCwYmc3VRGWn0GShGFhnU2udQEiaUx3Ek/a5QTUPEK3AkwOfqxuKbsHiiC1aMI
         ICZa1aHL/XX10Y8o5LTKjcP4plEN1tTMD5vkLWZmF0ZmTHb7eV9y4DjjhDA7TrVcYPl2
         f+Xi3YiFnHInBHuG38f097UQfkZKZDEc25Td4+d+UezWTF0Xrw6gU7eiSMuJ6WW8ufVB
         c+nQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1IqAeAA0wG/eNl9PZHrlVW8No9m6RLbuwAdKWGXm6iVgybu1lhK0zp7sBpCBaW6ytBeiwNR83BZhOZFtX1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhiJ94RiRWPwho+G8tsbl1awa/oIhPGHhrj6d/as24Pdb+OU0r
	3byw65x1nnP9ZkbZ3cjIPQdflnoLZip9eeeO+Sp6j0+T9+rhzRqYNFQtEpyMi2jkquUrqvlKtu/
	GYxRqMHl1AAF/jcguevTdkHA/oYhdV9AJ4+jAwtxhsOHOMAnDKe8weSbeZXxAN197cCvL
X-Gm-Gg: ASbGncvkM1AyctyQ4G8WUR7Ck5Lv38M9vw0yZ3+BE4IkLqNgqbTJDtBOMBZEBGREfhn
	0C9A4KchclbWJlAhu2Ewh8kH6jq8TVeMwpLHTMKvuFrCIlu8dJVIGfTMSTbSwTtEFQrq5eaxSTV
	3syECSIILmXw6WlG9njUHpyTmgdZuAgsWN49ulpRMdnYQ+6gcn1iIBxzY60/+3noxXuohNv6yiL
	rflWA5COYD/uNElnhpjSil9x+86zLVajzrMPcVm2MIUhj/Nlv+j3Qtb2fJhDut9y34WdJQy8k1E
	EmK8HBcFf5iUrhZfe8cqUql2IzqHg1M9fQSCHL5zlMaZV+Tl+b8aGdN4xga2EBqJx8Nn43CM
X-Received: by 2002:a05:600c:8889:10b0:442:f4a3:a2c0 with SMTP id 5b1f17b1804b1-443024b8820mr116363175e9.13.1747841875813;
        Wed, 21 May 2025 08:37:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcHFJCDU0kERgNNpbSG5LzwmKXYOVL8DXbNu1j1znxGmyPxiSylKOJBGAP3Ew47kasRlgLlA==
X-Received: by 2002:a05:600c:8889:10b0:442:f4a3:a2c0 with SMTP id 5b1f17b1804b1-443024b8820mr116362885e9.13.1747841875376;
        Wed, 21 May 2025 08:37:55 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f73d3defsm71546225e9.18.2025.05.21.08.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 08:37:54 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Clark
 Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-rt-users@vger.kernel.org, Joe Damato
 <jdamato@fastly.com>, Martin Karsten <mkarsten@uwaterloo.ca>, Jens Axboe
 <axboe@kernel.dk>, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] eventpoll: Fix priority inversion problem
In-Reply-To: <20250521145320.oqUIOaRG@linutronix.de>
References: <20250519074016.3337326-1-namcao@linutronix.de>
 <xhsmh8qmq9h37.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250521145320.oqUIOaRG@linutronix.de>
Date: Wed, 21 May 2025 17:37:54 +0200
Message-ID: <xhsmh5xhu9dpp.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 21/05/25 16:53, Nam Cao wrote:
> On Wed, May 21, 2025 at 04:25:00PM +0200, Valentin Schneider wrote:
>> > +	llist_for_each_entry_safe(epi, tmp, txlist.first, rdllink) {
>> > +		/*
>> > +		 * We are done iterating. Allow the items we took to be added back to the ready
>> > +		 * list.
>> > +		 */
>> > +		xchg(&epi->link_locked, false);
>> > +
>> > +		/*
>> > +		 * In the loop above, we may mark some items ready, and they should be added back.
>> > +		 *
>> > +		 * Additionally, someone else may also attempt to add the item to the ready list,
>> > +		 * but got blocked by us. Add those blocked items now.
>> > +		 */
>> > +		if (smp_load_acquire(&epi->ready)) {
>> >                       ep_pm_stay_awake(epi);
>> > +			epitem_ready(epi);
>> >               }
>>
>> Isn't this missing a:
>>
>>                 list_del_init(&epi->rdllink);
>>
>> AFAICT we're always going to overwrite that link when next marking the item
>> as ready, but I'd say it's best to exit this with a clean state. That would
>> have to be before the clearing of link_locked so it doesn't race with a
>> concurrent epitem_ready() call.
>
> To confirm I understand you: there is no functional problem, and your
> comment is more of a "just to be safe"?
>

Yup, even if they're not accessed it's good to not have stray references to
stack addresses.

> Thanks so much for the review,
> Nam

