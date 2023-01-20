Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AD5C25B4E
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Jan 2023 08:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjATIoX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 20 Jan 2023 03:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjATIoW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Jan 2023 03:44:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79D479E9E
        for <linux-rt-users@vger.kernel.org>; Fri, 20 Jan 2023 00:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674204215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2ieVgb0wdTbUDgdUwiBcUCrz7AjasaHhJqwRtTkIp84=;
        b=ViGyrr9r9RuIq3OK2pb8ZkVSoTmzKFGBFv7Brluoaq/8+C8aKF4XoOEAJB5NEJYqOzP2y1
        0/f2Q9IHbHbyQrJIotWwMfNLvWdIvuSsRpNVsPigjA0f+oYOwkzpmayM/7L6rWDLU2tho1
        p0OB4rq3Mbfpk4wf5eMu4mdJSeXoKa0=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-413-iTsEZgZAOMCkskQHiMfYhA-1; Fri, 20 Jan 2023 03:43:33 -0500
X-MC-Unique: iTsEZgZAOMCkskQHiMfYhA-1
Received: by mail-il1-f198.google.com with SMTP id j11-20020a056e02218b00b0030f3e7a27a8so2945815ila.2
        for <linux-rt-users@vger.kernel.org>; Fri, 20 Jan 2023 00:43:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ieVgb0wdTbUDgdUwiBcUCrz7AjasaHhJqwRtTkIp84=;
        b=OosBDvweBg8A2v+h8f3rZZK1FlNKFxu6cVTLEgf70IYyTnfHGojvOhWiAD40hbnWBg
         ahxoXdaQOPWHVAclWlO+MBEdlG98mkoDOoxgtCdvi3JdjRV2pzDeF3i9VPhn8zF6nFCK
         c8jScXz/D769PBRtMSKRaCXkM4DHL5ImA+F4hwg4p65QIKHGpCHbBFip6gCvrH/L77AY
         2ZaGb5vFs3yfntloMqPQT+qGcFZMLUPM3G+WwRZjxe8T3WZ4VVoamy+ZMKeR+MNLU+/X
         7fzK0kBjZDaKtU/Lswbi51iJ5ZgW28T6a9Q6aGVb7xrnwAmB+dsP5qEb6OHPW1mJ73Xr
         o2zw==
X-Gm-Message-State: AFqh2kopNGV6pqGwmMHdigEK/kaUu5rMK2QqjYUNjCNqPHNT4LWVdpfI
        n4j9G5MywDBTFycb+7DTNenAA04kw4M9jZXxmDz9eZoQNMoETdPuz7QIeWQ8S3jQvFRIF7hhyWn
        k0rjzbxKMx4E0yezLk2R73YMrYWd1vYLnyC/lvJXOT1w=
X-Received: by 2002:a5d:884b:0:b0:704:d851:64ba with SMTP id t11-20020a5d884b000000b00704d85164bamr818297ios.135.1674204212931;
        Fri, 20 Jan 2023 00:43:32 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuqWj7kT7WAI3DeIVj9rztUM3R8UUxuRsEPXeV6XWDqUb5Yxgs99M9gWUoAq8V02mWEWfIaFyr9o0FeQ5PeRM0=
X-Received: by 2002:a5d:884b:0:b0:704:d851:64ba with SMTP id
 t11-20020a5d884b000000b00704d85164bamr818292ios.135.1674204212712; Fri, 20
 Jan 2023 00:43:32 -0800 (PST)
MIME-Version: 1.0
References: <20230119211455.498968-1-echanude@redhat.com> <20230119211455.498968-2-echanude@redhat.com>
 <Y8m/ljQUJOefsD6O@ZenIV>
In-Reply-To: <Y8m/ljQUJOefsD6O@ZenIV>
From:   Alexander Larsson <alexl@redhat.com>
Date:   Fri, 20 Jan 2023 09:43:21 +0100
Message-ID: <CAL7ro1EESqanEQnGnLqd_WvoxL0ybn0XJwtMAFxap=w-a=-Vig@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND 1/1] fs/namespace: defer free_mount from namespace_unlock
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Eric Chanudet <echanude@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Andrew Halaney <ahalaney@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Jan 19, 2023 at 11:09 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Jan 19, 2023 at 04:14:55PM -0500, Eric Chanudet wrote:
> > From: Alexander Larsson <alexl@redhat.com>
> >
> > Use call_rcu to defer releasing the umount'ed or detached filesystem
> > when calling namepsace_unlock().
> >
> > Calling synchronize_rcu_expedited() has a significant cost on RT kernel
> > that default to rcupdate.rcu_normal_after_boot=1.
> >
> > For example, on a 6.2-rt1 kernel:
> > perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
> >            0.07464 +- 0.00396 seconds time elapsed  ( +-  5.31% )
> >
> > With this change applied:
> > perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
> >         0.00162604 +- 0.00000637 seconds time elapsed  ( +-  0.39% )
> >
> > Waiting for the grace period before completing the syscall does not seem
> > mandatory. The struct mount umount'ed are queued up for release in a
> > separate list and no longer accessible to following syscalls.
>
> Again, NAK.  If a filesystem is expected to be shut down by umount(2),
> userland expects it to have been already shut down by the time the
> syscall returns.
>
> It's not just visibility in namespace; it's "can I pull the disk out?".
> Or "can the shutdown get to taking the network down?", for that matter.

In the usecase we're worrying about, all the unmounts are lazy (i.e.
MNT_DETACH). What about delaying the destroy in that case? That seems
in line with the expected behaviour of lazy shutdown. I.e. you can't
rely on it to be settled anyway.


-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

