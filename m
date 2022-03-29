Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26230C433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 29 Mar 2022 08:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbiC2IfI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 29 Mar 2022 04:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbiC2IfH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 29 Mar 2022 04:35:07 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1794714FFCC
        for <linux-rt-users@vger.kernel.org>; Tue, 29 Mar 2022 01:33:23 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 17so22487878lji.1
        for <linux-rt-users@vger.kernel.org>; Tue, 29 Mar 2022 01:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bAkBU3aYq3LSXumpeOX3hngnomWzXyt6QHgjxSMBGcs=;
        b=JGoJpZ8nwm+dBwKRA6e0NefYl+OlHRKr+aFiRvhfKkPGkGCtPqPLPwMxl3beyBsODF
         515O0/8ny/2dOKQQw/CWbiBmNXh3QQesV/Su9xVMRKsFaO4LyNfqfPq4qvFpyc+lsOw3
         FrXQ7klQgW8DGHISCmJUpDi/7uKfodbrJ7f9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bAkBU3aYq3LSXumpeOX3hngnomWzXyt6QHgjxSMBGcs=;
        b=0sy6xQii9yjVieRKav9yHudifCEiRRYxaV7LwvgqvnPjw0dhyG+49c5MYUXk2h+Bbt
         UH3lN7kmoC4UXPoIMN4S1zUlKgjwj+p3A5wailJVbGnzxbNGbZLjDdC5hCyxrGtuo8s8
         KY3TF+XrpYL3OLFhuXLBfEl5BZTjyS6yG/w7mHyof7SB3GqN4yBdLZM355DDU8xu+GMo
         Rx3bTMZBLrSxkZp8tUlIt8YD7dBanXx7HsZAZFs1OQjPfRmjAE9iRPEwJtE7v5KCO7I/
         mEtnmZVL7NaKiCMqB8Q2JvKNlkdyPi0PsRjz7F1qXzhb9xsf4NUphs1XLW1b93ffp3Ki
         Cd8A==
X-Gm-Message-State: AOAM533iUEL8pka8Jx8rwL10Nvp/RcyP2cck5LBhoVzg4jlUPHy2jFAb
        nJ+1RDe1daO+4BqelMIE1bJi+A==
X-Google-Smtp-Source: ABdhPJxL4KVmZxiDZcWgih3gAupqX66Yspz5bziP8SpKJOtW5gcl8vinEkV5RB5os49X25PGUyifCQ==
X-Received: by 2002:a2e:a796:0:b0:249:86ac:f836 with SMTP id c22-20020a2ea796000000b0024986acf836mr1634809ljf.104.1648542802048;
        Tue, 29 Mar 2022 01:33:22 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id h5-20020a056512054500b0044a36e91a90sm1913269lfl.197.2022.03.29.01.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 01:33:21 -0700 (PDT)
Message-ID: <8b21ad64-ea9c-84f2-c798-222c9383e3de@rasmusvillemoes.dk>
Date:   Tue, 29 Mar 2022 10:33:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 0/2] RT scheduling policies for workqueues
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tejun Heo <tj@kernel.org>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Peter Hurley <peter@hurleysoftware.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Esben Haabendal <esben@geanix.com>,
        Steven Walter <stevenrwalter@gmail.com>,
        linux-kernel@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?UTF-8?Q?Andr=c3=a9_Pribil?= <a.pribil@beck-ipc.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-rt-users@vger.kernel.org
References: <20220323145600.2156689-1-linux@rasmusvillemoes.dk>
 <YkGIhYKJG+w4L7ge@linutronix.de>
 <20220328100927.5ax34nea7sp7jdsy@pengutronix.de>
 <YkHyzcfiyjLfIVOo@slm.duckdns.org> <YkKnlUUsufZPiZxM@linutronix.de>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <YkKnlUUsufZPiZxM@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 29/03/2022 08.30, Sebastian Andrzej Siewior wrote:
> On 2022-03-28 07:39:25 [-1000], Tejun Heo wrote:
>> Hello,
> Hi,
> 
>> I wonder whether it'd be useful to provide a set of wrappers which can make
>> switching between workqueue and kworker easy. Semantics-wise, they're
>> already mostly aligned and it shouldn't be too difficult to e.g. make an
>> unbounded workqueue be backed by a dedicated kthread_worker instead of
>> shared pool depending on a flag, or even allow switching dynamically.

Well, that would certainly not make it any easier for userspace to
discover the thread it needs to chrt().

> This could work. For the tty layer it could use 'lowlatency' attribute
> to decide which implementation makes sense.

I have patches that merely touch the tty layer, but tying it to the
lowlatency attribute is quite painful (which has also come up in
previous discussions on this) - because the lowlatency flag can be
flipped from userspace, but synchronizing which variant is used and
switching dynamically is at least beyond my skills to make work
robustly. So in my patches, the choice is made at open() time. However,
I'm still not convinced code like

 struct tty_bufhead {
        struct tty_buffer *head;        /* Queue head */
        struct work_struct work;
+       struct kthread_work kwork;
+       struct kthread_worker *kworker;


 bool tty_buffer_restart_work(struct tty_port *port)
 {
-       return queue_work(system_unbound_wq, &port->buf.work);
+       struct tty_bufhead *buf = &port->buf;
+
+       if (buf->kworker)
+               return kthread_queue_work(buf->kworker, &buf->kwork);
+       else
+               return queue_work(system_unbound_wq, &buf->work);
 }

etc. is the way to go.

===

Here's another idea: In an ideal world, the irq thread itself [people
caring about latency use threaded interrupts] could just do the work
immediately - then the admin only has one kernel thread to properly
configure. However, as Sebastian pointed out, doing that leads to a
lockdep splat [1], and it also means that there's no work item involved,
so some other thread calling tty_buffer_flush_work() might not actually
wait for a concurrent flush_to_ldisc() to finish. So could we create a
struct hybrid_work { } which, when enqueued, does something like

  bool current_is_irqthread(void) { return in_task() &&
kthread_func(current) == irq_thread; }

hwork_queue(struct hybrid_work *hwork, struct workqueue_struct *wq)
  if (current_is_irqthread()) {
    task_work_add(current, &hwork->twork)
  } else {
    queue_work(wq, &hwork->work);
  }

(with extra bookkeeping so _flush  and _cancel_sync methods can also be
created). It would require irqthread to learn to run its queued
task_works in its main loop, which in turn would require finding some
other way to do the irq_thread_dtor() cleanup, but that should be doable.

While the implementation of hybrid_work might be a bit complex, I think
this would have potential for being used in other situations, and for
the users, the API would be as simple as the current workqueue/struct
kwork APIs. By letting the irq thread do more/all of the work, we'd
probably also win some latency due to fewer threads involved and better
cache locality. And the admin/BSP is already setting the rt priorities
of the [irq/...] threads.

Rasmus

[1]
https://lore.kernel.org/linux-rt-users/20180711080957.f6txdmzrrrrdm7ig@linutronix.de/

