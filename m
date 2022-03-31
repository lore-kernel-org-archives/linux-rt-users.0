Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D54C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 31 Mar 2022 22:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242379AbiCaWWB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 31 Mar 2022 18:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242368AbiCaWWA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 31 Mar 2022 18:22:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6AF56173F5B
        for <linux-rt-users@vger.kernel.org>; Thu, 31 Mar 2022 15:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648765211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lcacMdqd3bf9RhdWBIFn3jh9EYGsuLJ5EDgnlxHe6hY=;
        b=V7GjAglvSMSC6Tbc5GTFLZ5OVuoPCjrDy/fCoK8jYKAJNn0SRoX+WMFHF6p0HyYIAMbe/S
        GNKrvk19aJAxvywobbU0dLCOKW52meqSr13UAg6ih6pUIS5E0iGj0i8I403I9Q6Bgccm/o
        IPbggj/T8CsIY4OvTrvhslWk5+NJVBc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-306-Ih2eyiq2Omq2pSQvyOyXRA-1; Thu, 31 Mar 2022 18:20:10 -0400
X-MC-Unique: Ih2eyiq2Omq2pSQvyOyXRA-1
Received: by mail-ej1-f72.google.com with SMTP id hg13-20020a1709072ccd00b006dfa484ec23so512643ejc.8
        for <linux-rt-users@vger.kernel.org>; Thu, 31 Mar 2022 15:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lcacMdqd3bf9RhdWBIFn3jh9EYGsuLJ5EDgnlxHe6hY=;
        b=6CNPYHVlgXvux9gCY8Bty0k1YZyN0Fd5AyxQT27pyUJ8edWKc2Bz3uf6idZu4oDrku
         pNTC++/9sJ8A35c5I0e0SnmLTmv3dzziAzLDHur77U+FI1EH7bH7xqlWw77bjYglNknM
         WaBrmJCLXRU5kiqH37ZVyLbiMILmk6wQJLzvBUcDHfke0OeL7R+u+h8IxEuUJspWX5u9
         VWYQHiol3S3NaSnaNWbVPhhf2CtG/CGDjwpfS6ZffalniDcR7TPE828OgIKkjRoXIhZR
         ENW9qGA8dtMhcF0+vA1EKFav4KmosE641ZNlk3HlMqRkyaxsrz8U0GhgUcTHw5kIs1DJ
         noKQ==
X-Gm-Message-State: AOAM533sskIQU7Zbtqj05FBvQB6yzhJTxRTbAFSCXDpFIzyuDju3SdOD
        uEktocIeBM0aNXGpeNgMdYsQofSykcEalQrt6V/qdgNXB1nwJCV/AvlGWF3JjZQd4beIO+lD1kO
        DYHGfmDtLHrFgXfDNyKnb/3LcQbgetU4h91JNzPFazNI=
X-Received: by 2002:aa7:c789:0:b0:413:605d:8d17 with SMTP id n9-20020aa7c789000000b00413605d8d17mr18443757eds.100.1648765208977;
        Thu, 31 Mar 2022 15:20:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJS+G0lRPGKhUebBKREDAXsEcg0UrX4NCWqjao2fTUSk/VCXDWb6txzdyF194RLS6KRUjV8UwtsdLq0U1h44U=
X-Received: by 2002:aa7:c789:0:b0:413:605d:8d17 with SMTP id
 n9-20020aa7c789000000b00413605d8d17mr18443736eds.100.1648765208701; Thu, 31
 Mar 2022 15:20:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220331151654.184433-1-javierm@redhat.com> <CAMj1kXHgyjB_BVzXx+CK0tBuJpZ3h=8XKus7nWiyovECjVQ0gw@mail.gmail.com>
 <YkYA/Wpqa/PMczkp@lx-t490>
In-Reply-To: <YkYA/Wpqa/PMczkp@lx-t490>
From:   Javier Martinez Canillas <javierm@redhat.com>
Date:   Fri, 1 Apr 2022 00:19:57 +0200
Message-ID: <CAFOAJEeKNy0HW82W6HV_49d5sc5L0m62QDfY9qA1906_ZzGRYg@mail.gmail.com>
Subject: Re: [PATCH v2] efi: Allow to enable EFI runtime services by default
 on RT
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Brian Masney <bmasney@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Al Stone <ahs3@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello Ahmed,

On Thu, Mar 31, 2022 at 9:36 PM Ahmed S. Darwish
<a.darwish@linutronix.de> wrote:
>
> Hi Ard, Javier,
>
> Am Do, Mar 31, 2022, schrieb Ard Biesheuvel:
> > On Thu, 31 Mar 2022 at 17:17, Javier Martinez Canillas
> > <javierm@redhat.com> wrote:
>

[snip]

> In case of (CONFIG_PREEMPT_RT=y && CONFIG_EFI_DISABLE_RUNTIME=n),
> shouldn't we add a small message in the kernel log warning that EFI
> runtime services are enabled for the RT kernel?
>
> In almost all HW, except custom ones with "verified" firmware, such a
> warning would be useful... This is especially true since in the embedded

I considered that as well but was not sure about what that message should be.

Since it will be printed even on systems whose EFI firmwares do not
have such long call times as the ones described in the commit that
disabled the runtime services for RT.

And in that case the warning may be misleading and make users believe
that a problem exists, which might not be accurate.

> domain, manually-configured RT kernels are almost always the norm.
>

Agreed. That is why the default for CONFIG_EFI_DISABLE_RUNTIME=y, if
CONFIG_PREEMPT_RT=y. So users will need to explicitly disable the
option if they want the EFI runtime services to be enabled with
CONFIG_PREEMPT_RT.

Best regards,
Javier

