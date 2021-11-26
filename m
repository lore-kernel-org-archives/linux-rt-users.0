Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DF9C433F5
	for <linux-rt-users@archiver.kernel.org>; Fri, 26 Nov 2021 12:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347215AbhKZMOy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 26 Nov 2021 07:14:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25178 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377262AbhKZMMy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 26 Nov 2021 07:12:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637928580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B3qoSHi2aieMmEJEF4bALkGTzfqcLKhwWiVxpAph1YQ=;
        b=RJygFrPVcrbXNcACWUpSH2PwFBsnZ+kcr3sH+6SgopQQ++qY1YArsKSbB2jrTfE8eaBu0h
        jJ+082QvQ/uBfhYxJyVGZX0bLu9HYYaXcD1MjBFVTgrZ4Y77Y123UAvxDSGk/2nqYMraiz
        mK9zbrUiTbh/sszDXkbfXc+SK1nhbjM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-xhMsQpASNVWkeAruDSPHlg-1; Fri, 26 Nov 2021 07:09:39 -0500
X-MC-Unique: xhMsQpASNVWkeAruDSPHlg-1
Received: by mail-lj1-f198.google.com with SMTP id p1-20020a2e7401000000b00218d0d11e91so3124680ljc.15
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Nov 2021 04:09:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B3qoSHi2aieMmEJEF4bALkGTzfqcLKhwWiVxpAph1YQ=;
        b=jOXH3Y7A4uSVFJktgK/iKI216pL/lFubW1xB70TgqP2ArCx4EM2Gzl6MJP76hRmVlf
         IsYE1QjBxU4o+0t8kj9QefgUFaqEImcQXU1tmQpF5nVZqt81PpyEv1Xw8C8k/ZtQ2OYI
         kVUSUId2ggsNma3FPAu5xKW3VheotudaSJ8yiNpvvshCuOrASrc7f0IYJBbd/Uw8cjDN
         94SqMgShfdVptlFbRIh72ntsRbxt8lQOoI4EMbuT4F0Pughet7z7qzunh19OJfUrG6SH
         /cq2vH6maRBBXVqPs8UE1WR0rTIMUBaUsuDz5FjYxrZvh4hrOdVr4hh7ZOs195R/lwAn
         wfHA==
X-Gm-Message-State: AOAM533FwEfg2K/HMTaSoxHPtv5YQG+ocprCVGKGWQD079S5raRfbx0u
        d7+lBXL5YJ/SnACxMRFHMbeE3BFZDBYlydhqnSZyAGIe0/zwb8qgWk5eLWPvQ9Ifdg4WkNfIOFN
        b7e3cd4JseR2ZaqM89423qYs0EMxAjpPEXiR3Q3jbf+Y=
X-Received: by 2002:a05:6512:33d1:: with SMTP id d17mr29956365lfg.623.1637928577901;
        Fri, 26 Nov 2021 04:09:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxCKrG5Bl3h1LX7HXWp49UBvjM8XE6kJzKfIZ4atvGDfsjo1cHFMwzRG2wV45HqukUFCPL8fYPQAs14x8MlRnU=
X-Received: by 2002:a05:6512:33d1:: with SMTP id d17mr29956350lfg.623.1637928577711;
 Fri, 26 Nov 2021 04:09:37 -0800 (PST)
MIME-Version: 1.0
References: <YVuviZ3F7MbPvleo@uudg.org> <20211011135609.22y7hkycbqm52w6d@linutronix.de>
 <20211011163601.m6j3ibb7ydeevpiz@linutronix.de> <CAD8J--8CjZym2afG3iSdztz51nOt9gmy747KPDxdmr1_WzwxcA@mail.gmail.com>
 <CAD8J---uJXqKeYR_3_8O5WPr9pVH8HX1DmGfE+7MdHDmaK4-Mw@mail.gmail.com>
 <CAD8J---a6X1u7SvKs5mR=EzxJ1uUxYZ0OGqM3PPq_LowBgY-Gw@mail.gmail.com>
 <20211125100109.qxc6k4a46s6ndv4e@linutronix.de> <20211125111124.sv7spgy2lm7qtxxc@linutronix.de>
In-Reply-To: <20211125111124.sv7spgy2lm7qtxxc@linutronix.de>
From:   Luis Goncalves <lgoncalv@redhat.com>
Date:   Fri, 26 Nov 2021 09:09:26 -0300
Message-ID: <CAD8J--91g575wynXdhOtcfCQ8wMiPzceWJx5sQrLscKdpZeeTg@mail.gmail.com>
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

On Thu, Nov 25, 2021 at 8:11 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2021-11-25 11:01:10 [+0100], To Luis Goncalves wrote:
> >
> > It makes sense to only change that one invocation. Let me form a patch.
>
> So I made dis:
>
> | From aaef7596167b3b38a81567af81aaa2f9559c91df Mon Sep 17 00:00:00 2001
> | From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
> | Date: Thu, 25 Nov 2021 11:05:17 +0100
> | Subject: [PATCH] net-sysfs: Acquire dev_base_lock disabled BH in
> |  netstat_show()
> |
> | The writer acquires dev_base_lock with disabled bottom halves.
> | The reader can acquire dev_base_lock without disabling bottom halves
> | because there is no writer in softirq context. Also readers can acquire
> | the lock in task and softirq context and multiple readers are allowed.
> |
> | On PREEMPT_RT the softirqs are preemptible and local_bh_disable() acts
> | as a lock to ensure that resources, that are protected by disabling
> | bottom halves, remain protected.
> | This leads to a circular locking dependency if the lock acquired with
> | disabled bottom halves (as in write_lock_bh()) and somewhere else with
> | enabled bottom halves (as by read_lock() in netstat_show()) followed by
> | disabling bottom halves (cxgb_get_stats() -> t4_wr_mbox_meat_timeout()
> | -> spin_lock_bh()). This is the reverse locking order.
> |
> | In order to avoid the reverse locking order, acquire the dev_base_lock
> | with disabled bottom halves.
> |
> | Reported-by: Pei Zhang <pezhang@redhat.com>
> | Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> | Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
> and then I started locking for in-softirq reader or writer. I can't find
> any. Therefore I made this for testing:
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -371,12 +371,12 @@ static void list_netdevice(struct net_device *dev)
>
>         ASSERT_RTNL();
>
> -       write_lock_bh(&dev_base_lock);
> +       write_lock(&dev_base_lock);
>         list_add_tail_rcu(&dev->dev_list, &net->dev_base_head);
>         netdev_name_node_add(net, dev->name_node);
>         hlist_add_head_rcu(&dev->index_hlist,
>                            dev_index_hash(net, dev->ifindex));
> -       write_unlock_bh(&dev_base_lock);
> +       write_unlock(&dev_base_lock);
>
>         dev_base_seq_inc(net);
>  }
> @@ -389,11 +389,11 @@ static void unlist_netdevice(struct net_device *dev)
>         ASSERT_RTNL();
>
>         /* Unlink dev from the device chain */
> -       write_lock_bh(&dev_base_lock);
> +       write_lock(&dev_base_lock);
>         list_del_rcu(&dev->dev_list);
>         netdev_name_node_del(dev->name_node);
>         hlist_del_rcu(&dev->index_hlist);
> -       write_unlock_bh(&dev_base_lock);
> +       write_unlock(&dev_base_lock);
>
>         dev_base_seq_inc(dev_net(dev));
>  }
> @@ -1272,15 +1272,15 @@ int dev_change_name(struct net_device *dev, const char *newname)
>
>         netdev_adjacent_rename_links(dev, oldname);
>
> -       write_lock_bh(&dev_base_lock);
> +       write_lock(&dev_base_lock);
>         netdev_name_node_del(dev->name_node);
> -       write_unlock_bh(&dev_base_lock);
> +       write_unlock(&dev_base_lock);
>
>         synchronize_rcu();
>
> -       write_lock_bh(&dev_base_lock);
> +       write_lock(&dev_base_lock);
>         netdev_name_node_add(net, dev->name_node);
> -       write_unlock_bh(&dev_base_lock);
> +       write_unlock(&dev_base_lock);
>
>         ret = call_netdevice_notifiers(NETDEV_CHANGENAME, dev);
>         ret = notifier_to_errno(ret);
> diff --git a/net/core/link_watch.c b/net/core/link_watch.c
> --- a/net/core/link_watch.c
> +++ b/net/core/link_watch.c
> @@ -55,7 +55,7 @@ static void rfc2863_policy(struct net_device *dev)
>         if (operstate == dev->operstate)
>                 return;
>
> -       write_lock_bh(&dev_base_lock);
> +       write_lock(&dev_base_lock);
>
>         switch(dev->link_mode) {
>         case IF_LINK_MODE_TESTING:
> @@ -74,7 +74,7 @@ static void rfc2863_policy(struct net_device *dev)
>
>         dev->operstate = operstate;
>
> -       write_unlock_bh(&dev_base_lock);
> +       write_unlock(&dev_base_lock);
>  }
>
>
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -842,9 +842,9 @@ static void set_operstate(struct net_device *dev, unsigned char transition)
>         }
>
>         if (dev->operstate != operstate) {
> -               write_lock_bh(&dev_base_lock);
> +               write_lock(&dev_base_lock);
>                 dev->operstate = operstate;
> -               write_unlock_bh(&dev_base_lock);
> +               write_unlock(&dev_base_lock);
>                 netdev_state_change(dev);
>         }
>  }
> @@ -2779,11 +2779,11 @@ static int do_setlink(const struct sk_buff *skb,
>         if (tb[IFLA_LINKMODE]) {
>                 unsigned char value = nla_get_u8(tb[IFLA_LINKMODE]);
>
> -               write_lock_bh(&dev_base_lock);
> +               write_lock(&dev_base_lock);
>                 if (dev->link_mode ^ value)
>                         status |= DO_SETLINK_NOTIFY;
>                 dev->link_mode = value;
> -               write_unlock_bh(&dev_base_lock);
> +               write_unlock(&dev_base_lock);
>         }
>
>         if (tb[IFLA_VFINFO_LIST]) {
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -30,13 +30,13 @@ static bool is_slave_up(struct net_device *dev)
>
>  static void __hsr_set_operstate(struct net_device *dev, int transition)
>  {
> -       write_lock_bh(&dev_base_lock);
> +       write_lock(&dev_base_lock);
>         if (dev->operstate != transition) {
>                 dev->operstate = transition;
> -               write_unlock_bh(&dev_base_lock);
> +               write_unlock(&dev_base_lock);
>                 netdev_state_change(dev);
>         } else {
> -               write_unlock_bh(&dev_base_lock);
> +               write_unlock(&dev_base_lock);
>         }
>  }
>
>
> If this does not create any warnings (with or without RT) then I would
> suggest to remove that _bh suffix since there is no need for it. This
> should also fix the RT warning you see now.
> Agreed?

Sounds like a plan!

I will start testing within the hour and report soon.

Thanks,
Luis

> Sebastian
>

