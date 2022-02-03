Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5861BC433F5
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Feb 2022 21:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352052AbiBCVnL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 3 Feb 2022 16:43:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49655 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355441AbiBCVnL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 3 Feb 2022 16:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643924590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nLi55D9ATw+W+qLwhaf4fFv/bYa7va7wAOnCPaBxxhc=;
        b=OyMf61aZbi6y5QeMmLMfo0CbyZlL5hnI2VrHuStW5PgF0DMeiUjMMiZD7KofiRaS/rcbNq
        tkZZN7SJfA6oajeJ0Q01SnWRX2669Rwy9WaVL/UrjFIy4Cu6PNehw1dXxTCmYqXnYqau+/
        vLN4PliOeAg43LozXU6uqIwqBSNLtRg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-531-1Spbe39xMKyjrI531x_C8Q-1; Thu, 03 Feb 2022 16:43:09 -0500
X-MC-Unique: 1Spbe39xMKyjrI531x_C8Q-1
Received: by mail-lf1-f69.google.com with SMTP id d1-20020ac244c1000000b0043626a5df76so2061488lfm.7
        for <linux-rt-users@vger.kernel.org>; Thu, 03 Feb 2022 13:43:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nLi55D9ATw+W+qLwhaf4fFv/bYa7va7wAOnCPaBxxhc=;
        b=j/ul+Q/CHbqSJWKv0G/k3C7rD+JF+VFPT4AtFPC72wGX+kLR8TdNp2ff8UoDFrX1Ug
         2DNXueFKiDiukgZSQmJ34Y5Djd1Ew92A9g38KFXefLdUDz0s8aSWNzXi8V4zPAyd/mXl
         P5vM3YdZf0EP2hxdlaGQajAebLrmFYWwx/sPP4R6+Pwnw+H7uGKrM9yqk3WKflCGXvzC
         EEDhG6Og0T2Y3HGbDUx1FatJRAwQlAX40YTgc1IVW23S46zopyrtu5oQEPiuJm4WHyY6
         jTKcd2uMvfRKFmkQKdXf1i/EMtq7fsCZeSukTmPWJoCK7hfvO2wdfuiq7nZrn8vbgdcv
         UNxA==
X-Gm-Message-State: AOAM530BnOD9uVoEWt0q8R5TQ1+Qs0aWEL5HM4Q6OWbOWHquGQlx/5mz
        B+EL1lgbWKSQropyqqCVq8jzWLZ2I/xdMQmlXXlmjvgkURq+5Ir39dNwrzm/f4XD4IqK8zcxVG+
        jjnsFSAg3EsWP525YrDpa2j+5WXbpgV8imaTPe9p6lVc=
X-Received: by 2002:a2e:9f4a:: with SMTP id v10mr23163130ljk.79.1643924588293;
        Thu, 03 Feb 2022 13:43:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwOXzU/0KThTKyWzYwEHyqt374d4ITZjpCW6M2kDhKLyxJZhLpRAhB2+mAlN+cMBLiEJ6WqRJBWS3efU91r4Vg=
X-Received: by 2002:a2e:9f4a:: with SMTP id v10mr23163121ljk.79.1643924588098;
 Thu, 03 Feb 2022 13:43:08 -0800 (PST)
MIME-Version: 1.0
References: <20220107021502.1121597-1-lgoncalv@redhat.com> <20220107021502.1121597-2-lgoncalv@redhat.com>
 <CAA7rmPFkHO=2AA3hfsoeB4KSYqj4+GMFu7+AuqLObGvfCngVFw@mail.gmail.com> <CAA7rmPGuz7p6B81t6Q1LFRT+cXXQoEN05M8pKo4EraR-JgOdUw@mail.gmail.com>
In-Reply-To: <CAA7rmPGuz7p6B81t6Q1LFRT+cXXQoEN05M8pKo4EraR-JgOdUw@mail.gmail.com>
From:   Luis Goncalves <lgoncalv@redhat.com>
Date:   Thu, 3 Feb 2022 18:42:56 -0300
Message-ID: <CAD8J---5bmtF=RwPBFwBGeiifPuOhXhaBvTyioj8qu9yMde4kQ@mail.gmail.com>
Subject: Re: [PATCH RT 1/3] eventfd: Make signal recursion protection a task bit
To:     Daniel Vacek <neelx.g@gmail.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jeff Brady <jeffreyjbrady@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Feb 3, 2022 at 6:17 AM Daniel Vacek <neelx.g@gmail.com> wrote:
>
> Actually I see it was fixed later with
> 4b3749865374899e115aa8c48681709b086fe6d3 so I guess it should be
> included as well.

Thank you for the feedback!
I will proceed with the changes and testing to release the kernel
probably on Monday.

Also, thank you for the note about the wrong email address!

Best regards,
Luis

