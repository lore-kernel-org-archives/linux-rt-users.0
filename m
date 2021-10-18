Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6094EC433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Oct 2021 15:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40E4D60F36
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Oct 2021 15:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbhJRPp1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 18 Oct 2021 11:45:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33988 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232019AbhJRPpY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 18 Oct 2021 11:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634571793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sTA0D5HeAbYmGSkL9Gss+oCqKldVl7oZQVEmhCCnEjk=;
        b=Rnht/LexTo81dKzVDlFrnarbwXJs3joftuqY7CMXASqYuwWplUjiagt8AvOygIiD9IBMVl
        9Kmyf+3wVNaBJ0Uq9uH+6U5hyu0OmkPQBCXDnWOn/C/P+xothvTECpexeP++L6iTAkM10O
        QsyqRmHFesg+AtRka7jC3SF0AVCfZBU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-MFoN0NucNHaxOMA5fjXRcQ-1; Mon, 18 Oct 2021 11:43:11 -0400
X-MC-Unique: MFoN0NucNHaxOMA5fjXRcQ-1
Received: by mail-lf1-f72.google.com with SMTP id b29-20020a0565120b9d00b003fdc9b2546dso82965lfv.14
        for <linux-rt-users@vger.kernel.org>; Mon, 18 Oct 2021 08:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sTA0D5HeAbYmGSkL9Gss+oCqKldVl7oZQVEmhCCnEjk=;
        b=LZbCejhPLyu3ib3yBAcerStWCK0iYzSt4OJwXPM7ECbB47g8Lck7uHwE1rRCbQSMTZ
         H0De6GbP5ELkdinh4ffRvvhNOPp7E1QcwGTNvkdJlxd1FOQZIEU83lTTLZynKB3naJRV
         lejXNHrJ2l6BqQS12Cky6zsbYXhgHJkQas7x/IWKhMmR2Q1J7KhboVlMTYCcZwIhdLo5
         afeYnE3W9+Ob65jIliQznFD5L0bzaFo8wsYOC10sDMAz0NfjPKuA30CtHIUnLyAmTkeI
         uj3aJd+8J2GwRAT+UqvCaLgjW3M4dtYomS1NxhxUMlKnRxwY7Mr7llUa5ZLJibpzqX7w
         zi/Q==
X-Gm-Message-State: AOAM530yKAKbR2dqf594nflxzMM2FcEM5+s6jsoZquPZXdONK6CbR4uC
        HHIRi3EZ9fWwn1z9rz719nucPRQcvvRWZOZgl84Xq0rSy/B8sqU/tFfe9RMqMYh74t9oNUGW7kS
        +roX5ghK6x/24oLROMBPSpmmPhfJlzbqm+BHhurEtI5s=
X-Received: by 2002:a05:6512:22d2:: with SMTP id g18mr491906lfu.456.1634571789564;
        Mon, 18 Oct 2021 08:43:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3/0HpCdr5bN8bKDefBe09nmgq922TkvKfwMPbX48hzs13Z7WWgh9oHM6kSG1ue5lBXpBrm1s9j2krv/9Oxmo=
X-Received: by 2002:a05:6512:22d2:: with SMTP id g18mr491881lfu.456.1634571789294;
 Mon, 18 Oct 2021 08:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <YVuviZ3F7MbPvleo@uudg.org> <20211011135609.22y7hkycbqm52w6d@linutronix.de>
 <20211011163601.m6j3ibb7ydeevpiz@linutronix.de>
In-Reply-To: <20211011163601.m6j3ibb7ydeevpiz@linutronix.de>
From:   Luis Goncalves <lgoncalv@redhat.com>
Date:   Mon, 18 Oct 2021 12:42:57 -0300
Message-ID: <CAD8J--8CjZym2afG3iSdztz51nOt9gmy747KPDxdmr1_WzwxcA@mail.gmail.com>
Subject: Re: [RFC RT v5.10] [rt] repair usage of dev_base_lock in netstat_show()
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        stable-rt@vger.kernel.org, Nitesh Narayan Lal <nilal@redhat.com>,
        Pei Zhang <pezhang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Oct 11, 2021 at 1:36 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2021-10-11 15:56:09 [+0200], To Luis Claudio R. Goncalves wrote:
> > So my guess is that the _bh isn't needed.
>
> Correction: If there is at least _one_ reader in softirq all, writer
> need to disable BH which _might_ be the case here.
> The splat is probably because on read_lock holder disables BH later on
> which I don't see yet.
>
> Sebastian

The way I was able to reproduce the problem in 5.10 (and in 5.14 before -rt11)
was:

    1. systemctl disable tuned.service
    2. Reboot to a kernel-rt with lockdep support
    3. systemctl start tuned.service

I used a few tuned profiles, but stuck with 'realtime' for obvious reasons.

If that helps in the process I can investigate which specific
action/configuration
performed by tuned is triggering the lockdep splat.

Luis

