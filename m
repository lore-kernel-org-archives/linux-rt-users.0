Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ADB15C140
	for <linux-rt-users@vger.kernel.org>; Wed, 21 May 2025 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747837509; cv=none; b=Gw1PgTIOW4OZGbaX96L6bNganp7OVDDIuomY0DpwLw8QTV8D6aWMFQC5cwMVnxb9yP5nx+HCJrhNfOW4anmv7Oe1Qd7tNaTkuaSpT/K6NbGJdrA1eh7SsfK74XmK5oVGSFQnkMClj55C8FMr9jJKBrEMpauurkTN2Y28ua06PVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747837509; c=relaxed/simple;
	bh=dGwumfjerIdNUT+ZWre17rwws9aXIHeRWCUz04oVeYs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P89Jykj/c0jjWL9FoBHXfcS424vUEfMmCVH1VTFCAdzf1imNti7ptptnMMq6B7OFONNQpxDIcnonmdZGE45COOQ0ZSn5wzydsROBY69pHwdoESO/KaUnNrgCsUkNk4QET/V1N3C5Gbp8fySKS0tWMBAau+jxBqfQ5vldCugW1j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OqMwCyTJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OqMwCyTJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747837505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zgFUH6Mk2Tk3iZDN9fsX7d3b+mQtNEFvHxIiCpWP5nk=;
	b=OqMwCyTJjkDSp9GPYkPHvXHUFhfhni4dsK1EYsaE6C5Aqjf4NFXZuAEbvHAS7oeRcKqIpc
	Iw3jCngXlM8pDVc+3IR0U8dsG/oqMzlRSJ2reShGq5NWgFz4/+yb2J8TSC5HRYE0Cuhr8e
	DoxrOe1Uq6mJ1is9/7mVur9JW1Rn6gI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-407kRwsHOhKiqwYSmhCUrw-1; Wed, 21 May 2025 10:25:04 -0400
X-MC-Unique: 407kRwsHOhKiqwYSmhCUrw-1
X-Mimecast-MFC-AGG-ID: 407kRwsHOhKiqwYSmhCUrw_1747837503
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a375938404so2089074f8f.0
        for <linux-rt-users@vger.kernel.org>; Wed, 21 May 2025 07:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747837503; x=1748442303;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zgFUH6Mk2Tk3iZDN9fsX7d3b+mQtNEFvHxIiCpWP5nk=;
        b=jijmcfrczKAv2qITAtaFfmdTiO6YvUPA0HgByTLmnOItCAgOdHV3hdtIGUgtyGEp2q
         6+Mxk3xqynRAxZovA/tXhG0mdpUWjImUFiAyuBlq/0hTHHWoRmqDk45eJ+Hfh1EfKq+6
         48xQEAmQMorKjhpb/8OmNQYHyTowJbrX2RHZhVa4eYesjVZEB4DxZVqQQW5Z/d1Pek/s
         WJb8sr5GwyYQh/lYQxn5up2H4uB8IoylwZMG54RD6erk5u4o7lUieCegyObhh1KOfjZB
         0VhaQJop7tZ6chtGdB8KsVYrssf9gIdposRvHvyHfbs/P4JsznFwkwPjPudqdKMiOqtL
         Colg==
X-Forwarded-Encrypted: i=1; AJvYcCW+QB8FTMSTjLM1GgzOpLWlbk0wJdWwfwGx1VOAv8tF73P6OxH5rf3I8b+iMcWDJvuHjEhED9E/nCAlpfCY+w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7J26aJKYduBzkY/cZVTUrwNzwd7/7lI7dlqD59Yp7Im6DdlCU
	O9wKPCcbqGnBiHFY8BV9G1xlra+OQNX93qhyg1K2b5tpd+oO9EjgJxHyWz8p1/Prt4dFKJa527r
	8vzCynuGFADY9yIZb0LzxKN+bFWCnSNNTTp/n5iwdi3b+PUjvgrn+YvvNuZQKPvM/Gc0i
X-Gm-Gg: ASbGncuHsy0tV8DOqDB9iCNe2IlD4Nukoj/CjzkHu4sVq7wH0P/zgFut3Q6VWa5wJmf
	/KmLPEdMQY8vRGagcNuZ1RMKUNv+grpzcoweGfHX5Z/hUOgo06tMSmHnzBml17+xuSKnkfFTiVp
	iitQLGcdyIpzwKR9RzRd/XvTasNPtQ6VVohywVL9HDkliL1EBB48cwPCUBj1Gjt58xlymDfwKyY
	cl0uaApSiuSJGql4hZaBQf65oZ+RCOO4xuPq0etmHuTRf24GMVcvFcsd+h8ickjsGfrRtdAvYJr
	G5pyxA48+uQaXkklZtVLOM6MZ2Ny9FsUS4s3CVYC0LeEBTkaGiCJGRqMVfA/H04a67kqUpHB
X-Received: by 2002:a5d:6702:0:b0:3a3:62c0:ff2 with SMTP id ffacd0b85a97d-3a362c010eemr15257842f8f.55.1747837503052;
        Wed, 21 May 2025 07:25:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/QB/m/PaAE/NQF15UKfuoxKAy6eEZT5rwMLl3Ovj5Sqrsob4y4T/qN2qBBMxZXcSFJxkoRA==
X-Received: by 2002:a5d:6702:0:b0:3a3:62c0:ff2 with SMTP id ffacd0b85a97d-3a362c010eemr15257810f8f.55.1747837502559;
        Wed, 21 May 2025 07:25:02 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca88978sm20266010f8f.65.2025.05.21.07.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 07:25:01 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 John Ogness <john.ogness@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-rt-users@vger.kernel.org, Joe Damato
 <jdamato@fastly.com>, Martin Karsten <mkarsten@uwaterloo.ca>, Jens Axboe
 <axboe@kernel.dk>
Cc: Nam Cao <namcao@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] eventpoll: Fix priority inversion problem
In-Reply-To: <20250519074016.3337326-1-namcao@linutronix.de>
References: <20250519074016.3337326-1-namcao@linutronix.de>
Date: Wed, 21 May 2025 16:25:00 +0200
Message-ID: <xhsmh8qmq9h37.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 19/05/25 09:40, Nam Cao wrote:
> @@ -136,14 +136,28 @@ struct epitem {
>               struct rcu_head rcu;
>       };
>
> -	/* List header used to link this structure to the eventpoll ready list */
> -	struct list_head rdllink;
> +	/*
> +	 * Whether this item can be added to the eventpoll ready list. Adding to the list can be
> +	 * blocked for two reasons:
> +	 *
> +	 *  1. This item is already on the list.
> +	 *  2. A waiter is consuming the ready list and has consumed this item. The waiter therefore
> +	 *     is blocking this item from being added again, preventing seeing the same item twice.
> +	 *     If adding is blocked due to this reason, the waiter will add this item to the list
> +	 *     once consuming is done.
> +	 */
> +	bool link_locked;

Nit: IIUC it's not just the readylist, it's anytime the link is used
(e.g. to punt it on a txlist), so how about:

        /*
         * Whether epitem.rdllink is currently used in a list. When used, it
         * cannot be detached or inserted elsewhere.
         *
         * It may be in use for two reasons:
         *
         * 1. This item is on the eventpoll ready list
         * 2. This item is being consumed by a waiter and stashed on a temporary
         *    list. If adding is blocked due to this reason, the waiter will add
         *    this item to the list once consuming is done.
         */
         bool link_used;

>
>       /*
> -	 * Works together "struct eventpoll"->ovflist in keeping the
> -	 * single linked chain of items.
> +	 * Indicate whether this item is ready for consumption. All items on the ready list has this
> +	 * flag set. Item that should be on the ready list, but cannot be added because of
> +	 * link_locked (in other words, a waiter is consuming the ready list), also has this flag
> +	 * set. When a waiter is done consuming, the waiter will add ready items to the ready list.
>        */
> -	struct epitem *next;
> +	bool ready;
> +
> +	/* List header used to link this structure to the eventpoll ready list */
> +	struct llist_node rdllink;
>
>       /* The file descriptor information this item refers to */
>       struct epoll_filefd ffd;

> @@ -361,10 +368,27 @@ static inline int ep_cmp_ffd(struct epoll_filefd *p1,
>               (p1->file < p2->file ? -1 : p1->fd - p2->fd));
>  }
>
> -/* Tells us if the item is currently linked */
> -static inline int ep_is_linked(struct epitem *epi)
> +static void epitem_ready(struct epitem *epi)
>  {
> -	return !list_empty(&epi->rdllink);
> +	/*
> +	 * Mark it ready, just in case a waiter is blocking this item from going into the ready
> +	 * list. This will tell the waiter to add this item to the ready list, after the waiter is
> +	 * finished.
> +	 */
> +	xchg(&epi->ready, true);

Perhaps a stupid question, why use an xchg() for .ready and .link_locked
(excepted for that epitem_ready() cmpxchg()) writes when the return value
is always discarded? Wouldn't e.g. smp_store_release() suffice, considering
the reads are smp_load_acquire()?

> +
> +	/*
> +	 * If this item is not blocked, add it to the ready list. This item could be blocked for two
> +	 * reasons:
> +	 *
> +	 * 1. It is already on the ready list. Then nothing further is required.
> +	 * 2. A waiter is consuming the ready list, and has consumed this item. The waiter is now
> +	 *    blocking this item, so that this item won't be seen twice. In this case, the waiter
> +	 *    will add this item to the ready list after the waiter is finished.
> +	 */
> +	if (!cmpxchg(&epi->link_locked, false, true))
> +		llist_add(&epi->rdllink, &epi->ep->rdllist);
> +
>  }
>
>  static inline struct eppoll_entry *ep_pwq_from_wait(wait_queue_entry_t *p)

> @@ -1924,19 +1874,39 @@ static int ep_send_events(struct eventpoll *ep,
>                        * Trigger mode, we need to insert back inside
>                        * the ready list, so that the next call to
>                        * epoll_wait() will check again the events
> -			 * availability. At this point, no one can insert
> -			 * into ep->rdllist besides us. The epoll_ctl()
> -			 * callers are locked out by
> -			 * ep_send_events() holding "mtx" and the
> -			 * poll callback will queue them in ep->ovflist.
> +			 * availability.
>                        */
> -			list_add_tail(&epi->rdllink, &ep->rdllist);
> +			xchg(&epi->ready, true);
> +		}
> +	}
> +
> +	llist_for_each_entry_safe(epi, tmp, txlist.first, rdllink) {
> +		/*
> +		 * We are done iterating. Allow the items we took to be added back to the ready
> +		 * list.
> +		 */
> +		xchg(&epi->link_locked, false);
> +
> +		/*
> +		 * In the loop above, we may mark some items ready, and they should be added back.
> +		 *
> +		 * Additionally, someone else may also attempt to add the item to the ready list,
> +		 * but got blocked by us. Add those blocked items now.
> +		 */
> +		if (smp_load_acquire(&epi->ready)) {
>                       ep_pm_stay_awake(epi);
> +			epitem_ready(epi);
>               }

Isn't this missing a:

                list_del_init(&epi->rdllink);

AFAICT we're always going to overwrite that link when next marking the item
as ready, but I'd say it's best to exit this with a clean state. That would
have to be before the clearing of link_locked so it doesn't race with a
concurrent epitem_ready() call.

>       }
> -	ep_done_scan(ep, &txlist);
> +
> +	__pm_relax(ep->ws);
>       mutex_unlock(&ep->mtx);
>
> +	if (!llist_empty(&ep->rdllist)) {
> +		if (waitqueue_active(&ep->wq))
> +			wake_up(&ep->wq);
> +	}
> +
>       return res;
>  }
>

