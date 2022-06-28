Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A602AC43334
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Jun 2022 17:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbiF1RdS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Jun 2022 13:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiF1RdP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Jun 2022 13:33:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 574601F2FB
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Jun 2022 10:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656437593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a7VE0tuK7nWwEOYtUcFLI6mabEeaSx3vxPSmkSS0cDM=;
        b=cH0snIUcPURQ1eGOZtA8e7U5+giPGpTtd4RvkH5Xfks92ZcAnw/0agPayutmT5CzAWoGgG
        hNtvhW7DTrKzZ2n9W+IUu/REa0hWuCU3tQi+i+Fmtlzvarqn6vOJJLQvg560j2YTx4nuy1
        E2Ny7q2eyg1P1qZPf7Tf3E278Ammoa0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-393-OuIuMm_wOxGJFNMDqMEjuA-1; Tue, 28 Jun 2022 13:33:12 -0400
X-MC-Unique: OuIuMm_wOxGJFNMDqMEjuA-1
Received: by mail-wr1-f69.google.com with SMTP id q15-20020a5d61cf000000b0021bc2461141so1348920wrv.5
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Jun 2022 10:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=a7VE0tuK7nWwEOYtUcFLI6mabEeaSx3vxPSmkSS0cDM=;
        b=WuT9StAZyWgfDpRoG9W/ZNyREok810TfHAJBRjem2Y9aQfAXSH6XHVbMYYdTGiJc/e
         j5tCOcspov5nly7CabajVLwEXxa7a/QrA/RnAOslEqUzERoEfI7mjrBLu1SL2OVe/8XZ
         6J/KipFpXVkG9zoRF41uYloKhmh3LPdmKkjXo+HP2rY8q0EJGa/br6qbsMbCTDOgFvYx
         vJV493nj7nZodOtvxhi43ycXT+Pr5h/WfKy1YDBYlvucfZPqAGbL4Sgr57Wnx2JeI88t
         n9kxiq25eVl1VVuRPwt5wUk8lw/HOIRrnZaLeilFsyBgSTDiNdDq+j7KuV/BcFivK4Fp
         ORoQ==
X-Gm-Message-State: AJIora/akaJn0qdtWTjP7W53WyfahDZ10W06mKpO/u2ajEp0WVoEdsP7
        YArQIwcOpYvuoWgkFQFtjTgEHIbtj6z+P24svQx310RVbZLdavc1Y1ZV66/tuaAkkn1Cyjbge5H
        lGCUZvW+Ibj3PD+3v1CWcKnapIus=
X-Received: by 2002:adf:e5cc:0:b0:21b:8bab:8e95 with SMTP id a12-20020adfe5cc000000b0021b8bab8e95mr19211060wrn.454.1656437590820;
        Tue, 28 Jun 2022 10:33:10 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uNa1HHSsL0XcWy6n2rjIDIIsOFT4WH5URrvmgY8hvsAi2gczAwVJVbvUfAU+CLisMd3Ks0BA==
X-Received: by 2002:adf:e5cc:0:b0:21b:8bab:8e95 with SMTP id a12-20020adfe5cc000000b0021b8bab8e95mr19211039wrn.454.1656437590549;
        Tue, 28 Jun 2022 10:33:10 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id u3-20020a05600c210300b003a044fe7fe7sm156300wml.9.2022.06.28.10.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 10:33:09 -0700 (PDT)
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
In-Reply-To: <xhsmhpmiu5lch.mognet@vschneid.remote.csb>
References: <20220620111520.1039685-1-vschneid@redhat.com>
 <87r13c7jyp.fsf@email.froward.int.ebiederm.org>
 <xhsmhpmiu5lch.mognet@vschneid.remote.csb>
Date:   Tue, 28 Jun 2022 18:33:08 +0100
Message-ID: <xhsmhmtdw66cr.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 27/06/22 13:42, Valentin Schneider wrote:
> On 25/06/22 12:04, Eric W. Biederman wrote:
>> At this point I recommend going back to being ``unconventional'' with
>> the kexec locking and effectively reverting commit 8c5a1cf0ad3a ("kexec:
>> use a mutex for locking rather than xchg()").
>>
>> That would also mean that we don't have to worry about the lockdep code
>> doing something weird in the future and breaking kexec.
>>
>> Your change starting to is atomic_cmpxchng is most halfway to a revert
>> of commit 8c5a1cf0ad3a ("kexec: use a mutex for locking rather than
>> xchg()").  So we might as well go the whole way and just document that
>> the kexec on panic code can not use conventional kernel locking
>> primitives and has to dig deep and build it's own.  At which point it
>> makes no sense for the rest of the kexec code to use anything different.
>>
>
> Hm, I'm a bit torn about that one, ideally I'd prefer to keep "homegrown"
> locking primitives to just where they are needed (loading & kexec'ing), but
> I'm also not immensely fond of the "hybrid" mutex+cmpxchg approach.
>

8c5a1cf0ad3a ("kexec: use a mutex for locking rather than xchg()") was
straightforward enough because it turned

        if (xchg(&lock, 1))
                return -EBUSY;

into

        if (!mutex_trylock(&lock))
                return -EBUSY;

Now, most of the kexec_mutex uses are trylocks, except for:
- crash_get_memory_size()
- crash_shrink_memory()

I really don't want to go down the route of turning those into cmpxchg
try-loops, would it be acceptable to make those use trylocks (i.e. return
-EBUSY if the cmpxchg fails)?

Otherwise, we keep the mutexes for functions like those which go nowhere
near an NMI.

