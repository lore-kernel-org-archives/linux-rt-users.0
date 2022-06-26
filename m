Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001A9C433EF
	for <linux-rt-users@archiver.kernel.org>; Sun, 26 Jun 2022 10:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbiFZKhf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 26 Jun 2022 06:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbiFZKhe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 26 Jun 2022 06:37:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0D2712774
        for <linux-rt-users@vger.kernel.org>; Sun, 26 Jun 2022 03:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656239852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H7HVasmdGjZh7uUQx0GtaFkNCVtXnNgnA6arKmEYZtk=;
        b=C10FZpIggvBDkY+csufSflNRtk6PthcQP2R7DLVC8EIVORgViUU6FO1yqArjZyALJjF6+f
        dcILNEai5WNlSmVRVI68W1iZTCXJZEODvqOQv/xYnJTvYp+YWBTaMQiN4yKL/wK+oBunoI
        3SNk+v/JH/fTkpN7qKvhc/Cpg32RmYo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-PCA8g8ZAN6aS5k01qunvYg-1; Sun, 26 Jun 2022 06:37:29 -0400
X-MC-Unique: PCA8g8ZAN6aS5k01qunvYg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF35D381079B;
        Sun, 26 Jun 2022 10:37:28 +0000 (UTC)
Received: from localhost (ovpn-12-101.pek2.redhat.com [10.72.12.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B09D841616B;
        Sun, 26 Jun 2022 10:37:27 +0000 (UTC)
Date:   Sun, 26 Jun 2022 18:37:24 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-rt-users@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH v2] panic, kexec: Make __crash_kexec() NMI safe
Message-ID: <Yrg25MZNqt+h1FCB@MiWiFi-R3L-srv>
References: <20220620111520.1039685-1-vschneid@redhat.com>
 <YrUTsJiIQb583fKy@MiWiFi-R3L-srv>
 <xhsmhsfnu5giq.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhsfnu5giq.mognet@vschneid.remote.csb>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 06/24/22 at 02:37pm, Valentin Schneider wrote:
> On 24/06/22 09:30, Baoquan He wrote:
> > On 06/20/22 at 12:15pm, Valentin Schneider wrote:
> >> @@ -94,14 +94,20 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> >>  	/*
> >>  	 * Because we write directly to the reserved memory region when loading
> >>  	 * crash kernels we need a mutex here to prevent multiple crash kernels
> >> -	 * from attempting to load simultaneously, and to prevent a crash kernel
> >> -	 * from loading over the top of a in use crash kernel.
> >> -	 *
> >> -	 * KISS: always take the mutex.
> >> +	 * from attempting to load simultaneously.
> >>  	 */
> >>  	if (!mutex_trylock(&kexec_mutex))
> >>  		return -EBUSY;
> >
> > So kexec_mutex is degenerated to only avoid simultaneous loading,
> > should we rename to reflect that?, e.g kexec_load_mutex.
> >
> 
> It's also serializing crash_get_memory_size() and crash_shrink_memory();
> more generally it should still be the preferred serialization mechanism as
> it's a "proper" lock visible by instrumentation, the atomic variable is a
> side character for the NMI case.

You are right. I only checked the code comment in this place. Then this
patch looks good to me, thx.

Acked-by: Baoquan He <bhe@redhat.com>

