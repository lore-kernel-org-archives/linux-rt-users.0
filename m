Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C01C433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Jun 2022 12:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236423AbiF0Mmg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 27 Jun 2022 08:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236409AbiF0Mma (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 27 Jun 2022 08:42:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D4DBB7EB
        for <linux-rt-users@vger.kernel.org>; Mon, 27 Jun 2022 05:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656333746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E+n3Y/O+OmufE7x8Fqncdr2+EU4ZYCNX0XlR2Xu4Dqo=;
        b=O8Tp3GSZCmspWr/f4S7n9Aoy7hd8k7pjwe8ryfxc3D2wpDfPFom8PedzQcJNYKeu4Qx+OJ
        aHmwdvbeY72yp1wlmT4qffXVO288TvHCNsv7HaOCeEU1ffFdhr4ceAENg6IhKjVpRj+EPE
        s0WEzfY4KNSu4es26AdyJJOCDqWZbZg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-35hIXdLLM5yxa6kHxaUUnQ-1; Mon, 27 Jun 2022 08:42:25 -0400
X-MC-Unique: 35hIXdLLM5yxa6kHxaUUnQ-1
Received: by mail-wm1-f71.google.com with SMTP id j31-20020a05600c1c1f00b0039c481c4664so3510498wms.7
        for <linux-rt-users@vger.kernel.org>; Mon, 27 Jun 2022 05:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=E+n3Y/O+OmufE7x8Fqncdr2+EU4ZYCNX0XlR2Xu4Dqo=;
        b=XLxG+6kjZIShTTk+XKoCFpbN4hvRx1Jtvu4/50Ev85t3ubp78DzeA/a9mJ1mkHkNPo
         rNWGyPoinQUhaVZUSlkUBz3RMzP2TScHSArnexFX0lV0bVq23rvFsL2fTwffH4kVmUh6
         ylE+Yy+9AmuRyjdOzyQp3jzuHOcgvlxqORM8UoZTYMH21B+Rb7RgVIcbgdFb/nAlRpg/
         du/34Vi7NyYbZDaxjFN1yAHGq/67Vk9eKhDFDb2vhsmH0jks06wozY8kGThAcx5J7udy
         MqT10DFcWXrM9qKQ8dTbzBAbfBBPHQ7496AkViLv6vU5ygpD0QN1h+OjPC8SFMBUKwXy
         zwiw==
X-Gm-Message-State: AJIora8oxdOUQdQGiglB1KkLU6hm9xg4Olo4MRxigz/TJX7xrwmmhSMz
        voWjrSH6lwX0me4K2MTzEZGM2pTryLcpcAXSP18pYGrtcLakaT/FBdeioxxdOy8OnlU3Thn6mH2
        GVCncKq1oF2346229T7KJknuTrf4=
X-Received: by 2002:a05:6000:69c:b0:21b:9280:9b2d with SMTP id bo28-20020a056000069c00b0021b92809b2dmr11433062wrb.203.1656333744229;
        Mon, 27 Jun 2022 05:42:24 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sJQ27sm+aJCjHu6xlQQhyYlKZ+HBejyIkW+SlC/p31t1lmrQbyAqnkqUNfQtUZa+j6nj85CQ==
X-Received: by 2002:a05:6000:69c:b0:21b:9280:9b2d with SMTP id bo28-20020a056000069c00b0021b92809b2dmr11433043wrb.203.1656333743939;
        Mon, 27 Jun 2022 05:42:23 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id bk20-20020a0560001d9400b0021b8b998ca5sm9882182wrb.107.2022.06.27.05.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 05:42:23 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-rt-users@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2] panic, kexec: Make __crash_kexec() NMI safe
In-Reply-To: <87r13c7jyp.fsf@email.froward.int.ebiederm.org>
References: <20220620111520.1039685-1-vschneid@redhat.com>
 <87r13c7jyp.fsf@email.froward.int.ebiederm.org>
Date:   Mon, 27 Jun 2022 13:42:22 +0100
Message-ID: <xhsmhpmiu5lch.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 25/06/22 12:04, Eric W. Biederman wrote:
> I am not particularly fond of this patch as it adds more complexity than
> is necessary to solve the problem.
>
> Calling a spade a spade PREEMPT_RT's mutex_trylock implementation is
> broken as it can not support the use cases of an ordinary mutex_trylock.
> I have not seen (possibly I skimmed too quickly) anywhere in the
> discussion why PREEMPT_RT is not being fixed.  Looking at the code
> there is enough going on in try_to_take_rt_mutex that I can imagine
> that some part of that code is not nmi safe.  So I can believe
> PREEMPT_RT may be unfix-ably broken.
>

AFAICT same goes for !PREEMPT_RT given the mutex_unlock(); it's a bit
convoluted but you can craft scenarios where the NMI ends up spinning on
mutex->wait_lock that is owned by the interrupted task, e.g.

  CPU0                    CPU1

                          crash_shrink_memory()
                            mutex_lock();
  crash_get_memory_size()
    mutex_lock()
      raw_spin_lock(&lock->wait_lock);
      // Lock acquired
  <NMI>
                            mutex_unlock()
                              <Release lock->owner>;

  // Owner is free at this point so this succeeds
  mutex_trylock();
  // No kexec_crash_image
  mutex_unlock()
    raw_spin_lock(&lock->wait_lock);

>
> At this point I recommend going back to being ``unconventional'' with
> the kexec locking and effectively reverting commit 8c5a1cf0ad3a ("kexec:
> use a mutex for locking rather than xchg()").
>
> That would also mean that we don't have to worry about the lockdep code
> doing something weird in the future and breaking kexec.
>
> Your change starting to is atomic_cmpxchng is most halfway to a revert
> of commit 8c5a1cf0ad3a ("kexec: use a mutex for locking rather than
> xchg()").  So we might as well go the whole way and just document that
> the kexec on panic code can not use conventional kernel locking
> primitives and has to dig deep and build it's own.  At which point it
> makes no sense for the rest of the kexec code to use anything different.
>

Hm, I'm a bit torn about that one, ideally I'd prefer to keep "homegrown"
locking primitives to just where they are needed (loading & kexec'ing), but
I'm also not immensely fond of the "hybrid" mutex+cmpxchg approach.

> Eric

