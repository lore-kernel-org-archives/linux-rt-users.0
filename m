Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79DBC433EF
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Dec 2021 15:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbhLHP4J (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 8 Dec 2021 10:56:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59006 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236369AbhLHP4I (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Dec 2021 10:56:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638978756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HHyQW9fF0kEKk/z33xdysmis1ED0dsGeVvo9lIxViIQ=;
        b=K6rqk7fqqQbSGfr+UQYonjqoReECHGf2VyO+NVrRSZtcBemQe/rdYaDJc0h9D8COj+vZZF
        4yHAbMPTil6eDhPT+kpjdYtgTO3TxdsPiw3ntanOq5fBNCR8IhEASMMZKlOzZpJiXeftON
        oW+0Yn8UnwezsK7OPIvalfwN223hbDQ=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-vGntFxhbMuGl_kllJDQkqw-1; Wed, 08 Dec 2021 10:52:34 -0500
X-MC-Unique: vGntFxhbMuGl_kllJDQkqw-1
Received: by mail-io1-f71.google.com with SMTP id z21-20020a5e8615000000b005e22e531c8aso3708805ioj.13
        for <linux-rt-users@vger.kernel.org>; Wed, 08 Dec 2021 07:52:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HHyQW9fF0kEKk/z33xdysmis1ED0dsGeVvo9lIxViIQ=;
        b=EXrjUPHgGb+qR/MoevxoJzr7cCE0kRU8hSlCAmJcoFnnaDfin4x6cGNTk8PVjRSUYX
         Heo84yZZ+MhUQoBgwpHgx44WGntfIhJ/9sT/kz6aJn2XftzzjNvK7TKKo2wcMr/CQ8Gq
         ScDRJCsMnlOfukkVTLJ5FSA66zxLXJLiRa9a5CIFwuolxe8f8VUSz0ETGhO8xrRYjJhg
         jB2lWmnww3rgXoMc5smQ4dU/cfIlnMciKq6fAn2Fpq0W70Mi7Jv6QElRQyzJ1vo3xSdF
         l0oAojasqwOR+idN384VpYfJad4FOiQyFH7drEls1+tY+G0Q95aMBFVfeOg8WVb/lSWW
         BMrA==
X-Gm-Message-State: AOAM533Wb+1zdcJIwxr2UTAdguBE5PMGnofAFkBUhQv2BAaX5nvMM/gO
        l5gOJXSn8PUkhbsQIecEOIeOoeuikfmoWN/RxwkTd7/I+WHDMq4LkuqeUy3EE36ocLHCkcf+9UG
        HXTFMHskezthHgJimIhxMGMAfbVASc5rRvyBTN16A728=
X-Received: by 2002:a6b:6802:: with SMTP id d2mr7823068ioc.187.1638978753210;
        Wed, 08 Dec 2021 07:52:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJykGm0Ikl+9jlmjalE/ELVobVinAkM7BeoKHqD0RG+eohMy/yAukz4KADVlumMo0/DJXhlnEaJJglS8IKXOOPw=
X-Received: by 2002:a6b:6802:: with SMTP id d2mr7823008ioc.187.1638978752682;
 Wed, 08 Dec 2021 07:52:32 -0800 (PST)
MIME-Version: 1.0
References: <YalDQe/lyXqAxB0K@uudg.org> <20211207201712.7yqbksbba3zgu7u3@linutronix.de>
 <20211207152049.1013e1ce@gandalf.local.home> <20211207205628.auc54rwl4duuisah@linutronix.de>
 <20211207160203.30206456@gandalf.local.home> <CAD8J--9V7KxJrT==vnoawWXpp9Ur_-o2Fhm_ebNd4-hH8ncfPg@mail.gmail.com>
 <20211208144828.y2e2d4h3yincjyqg@linutronix.de>
In-Reply-To: <20211208144828.y2e2d4h3yincjyqg@linutronix.de>
From:   Luis Goncalves <lgoncalv@redhat.com>
Date:   Wed, 8 Dec 2021 12:52:21 -0300
Message-ID: <CAD8J---yWGx46DmVUGzvpx5bQTEyYN6aie2HRPkzB71qNp5mLg@mail.gmail.com>
Subject: Re: [ANNOUNCE] 5.10.83-rt58
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>, carnil@debian.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Dec 8, 2021 at 11:48 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2021-12-08 10:14:41 [-0300], Luis Goncalves wrote:
> > Yes, I am really sorry that escaped my review. I focused on testing
> > the code and missed something that obvious.
> >
> > Sorry for the confusion I caused.
> >
> > Steven, Sebastian, would it be worth a v5.10.83-rt59 with the patch
> > subjects fixed?
>
> No, I don't think that it is worth it. Please correct it for the next
> release.
> I'm not sure if there is a need for the base version in the patch tag.

Thank you! I will fix that for the next release.

Luis

