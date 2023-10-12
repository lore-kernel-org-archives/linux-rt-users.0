Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFCEBA3C
	for <linux-rt-users@vger.kernel.org>; Thu, 12 Oct 2023 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvpxT2Dl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832A990
	for <linux-rt-users@vger.kernel.org>; Thu, 12 Oct 2023 08:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697123228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=AdocvBnwENUXMzlvOyYLpJBblaZ0RtqfbE/1hQKJm4Q=;
	b=dvpxT2DlMCPPDcOG9iJI5DnUjQk8xfgRckdJ9T1WUeXV5Eiw7ZPp7DBnso3ttZHDqa2WaL
	cH/g2y0PIzEwT4rGL8n9KN0Y7RDsUlt2R7s8Rm6AABnCWc+NL2+LoMo0wDGxjjos9sWDyl
	cT5P8tqQIuENB8vVyAEL5wTJMjkOIQg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-ZQ9SwhvxOLuBDcPQyZ7vkg-1; Thu, 12 Oct 2023 11:07:07 -0400
X-MC-Unique: ZQ9SwhvxOLuBDcPQyZ7vkg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-41975c9e66fso15897191cf.0
        for <linux-rt-users@vger.kernel.org>; Thu, 12 Oct 2023 08:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697123227; x=1697728027;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AdocvBnwENUXMzlvOyYLpJBblaZ0RtqfbE/1hQKJm4Q=;
        b=E/hrSCZ/op7s9btRPApu+5F2TzqsigSifk+t3Q235PsyRRNEEWVaKCz0Iz0XcnHBbi
         HSDV0YLnVYAmq1S6VdPI5dmrVHLgkBPKyZGiaX4lp5MrX2hfriLZtrxhqwm/ZDV1+DwY
         7OixxhsaJ/OZZFPMxQDR5h6FnBziBq5utmdd66OOx8bfjZ9ak4PCam9KTJedMcBRHwGf
         bagqAUTynqw7Tw2lc1A5gmbQ24st8dNxGOPtZBfFWvC72YzW9EfnGjoftL0QbqK02kU1
         rpRcX9/7OGtO9SKTBjzm34GIvckUxAQyG6Jc0fHA9iSaRHIf5iGRDIbAsbFEGAMVQsQC
         73tw==
X-Gm-Message-State: AOJu0Yw/K7wihYVR8ByCfhHM5/NWgSeiI2BzivAM1Vu5B6W5w4Y7t5kY
	czg25HcKpVoWKc9b6Q4a05iTlv9Q2XdsIDXERj83VJWjy/js9bgp8NiMN6AIXhRL60+LI/f6owK
	m6lUlx7vE6nPNgIMeMVEgCeWYch0=
X-Received: by 2002:a05:622a:1314:b0:417:f666:b780 with SMTP id v20-20020a05622a131400b00417f666b780mr29182455qtk.19.1697123226650;
        Thu, 12 Oct 2023 08:07:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2W5XeSdbMAJzjnuK+bdFbeQDOAB0v0iC3WXSCOitfTUVdPVDW8Jq+jzh6zIGTCDZ8F3BC0A==
X-Received: by 2002:a05:622a:1314:b0:417:f666:b780 with SMTP id v20-20020a05622a131400b00417f666b780mr29182415qtk.19.1697123226226;
        Thu, 12 Oct 2023 08:07:06 -0700 (PDT)
Received: from vschneid.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id fy11-20020a05622a5a0b00b004198d026be6sm6279054qtb.35.2023.10.12.08.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 08:07:05 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
 <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, Clark Williams
 <williams@redhat.com>, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: [RT BUG] Stall caused by eventpoll, rwlocks and CFS bandwidth
 controller
Date: Thu, 12 Oct 2023 17:07:02 +0200
Message-ID: <xhsmhttqvnall.mognet@vschneid.remote.csb>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi folks,

We've had reports of stalls happening on our v6.0-ish frankenkernels, and while
we haven't been able to come out with a reproducer (yet), I don't see anything
upstream that would prevent them from happening. 

The setup involves eventpoll, CFS bandwidth controller and timer
expiry, and the sequence looks as follows (time-ordered):

p_read (on CPUn, CFS with bandwidth controller active)
======

ep_poll_callback()
  read_lock_irqsave()
  ...
  try_to_wake_up() <- enqueue causes an update_curr() + sets need_resched
                      due to having no more runtime
    preempt_enable()
      preempt_schedule() <- switch out due to p_read being now throttled

p_write
=======

ep_poll()
  write_lock_irq() <- blocks due to having active readers (p_read)

ktimers/n
=========

timerfd_tmrproc()
`\
  ep_poll_callback()
  `\
    read_lock_irqsave() <- blocks due to having active writer (p_write)


From this point we have a circular dependency:

  p_read -> ktimers/n (to replenish runtime of p_read)
  ktimers/n -> p_write (to let ktimers/n acquire the readlock)
  p_write -> p_read (to let p_write acquire the writelock)

IIUC reverting
  286deb7ec03d ("locking/rwbase: Mitigate indefinite writer starvation")
should unblock this as the ktimers/n thread wouldn't block, but then we're back
to having the indefinite starvation so I wouldn't necessarily call this a win.

Two options I'm seeing:
- Prevent p_read from being preempted when it's doing the wakeups under the
  readlock (icky)
- Prevent ktimers / ksoftirqd (*) from running the wakeups that have
  ep_poll_callback() as a wait_queue_entry callback. Punting that to e.g. a
  kworker /should/ do.

(*) It's not just timerfd, I've also seen it via net::sock_def_readable -
it should be anything that's pollable.

I'm still scratching my head on this, so any suggestions/comments welcome!

Cheers,
Valentin

